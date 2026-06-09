/**
 * 2026.01
 *
 * aside_nav js
 *  페이지 이동
 *  포커스
 *  체크박스 상태 유지
 *
 */


//aside_nav
window.addEventListener("load", function () {

    //변수 설정
    //top_nav
    const nav_top = document.querySelector("#nav_top");
    const userOffice = document.querySelector("#userOffice");
    const change_office = document.querySelector("#change_office");
    const change_pass = document.querySelector("#change_pass");
    //aside_nav
    const wrap = document.querySelector(".nav_wrap");
    const aside = document.querySelector(".nav_aside");
    const tree = document.querySelector(".nav_tree"); //스크롤 요소
    const nav_title = document.querySelector(".nav_title"); //스크롤 요소

    let menu_group =
        sessionStorage.getItem("menu_group") || "";
    let sectionId =
        sessionStorage.getItem("sectionId") || "";

    let nav_focus = null;   //포커스
    let nav_focus_scroll = null; //포커스

    if (!wrap || !aside || !tree) return;


    //aside_nav
    //메뉴 만들기
    if(!isNull(menu_group)){
        nav_title.innerText = sessionStorage.getItem("nav_title");

        nav_aside_make(menu_group, tree);
    }


    //메뉴 이동
    //top_nav
    nav_top.addEventListener('click', async (e) => {
        let target = null

        if(e.target.tagName == 'LI'){
            target = e.target.querySelector('a');
        }
        else if(e.target.tagName == 'A'){
            target = e.target;
        }
        sectionId = target.id.split("/")[0]
        menu_group = target.id.split("/")[1]
        if (isNull(menu_group)) return;

        sessionStorage.setItem("menu_group", menu_group);
        sessionStorage.setItem("sectionId", sectionId);
        sessionStorage.setItem("nav_title", target.innerText);
        sessionStorage.removeItem("nav_aside_" + menu_group);
        await nav_aside_make(menu_group, tree);

        const firstMenu = tree.querySelector(".menu_nav");
        if (firstMenu) {
            firstMenu.click();
        }

    });
    //aside_nav
    tree.addEventListener('click', (e) => {
        let pg = "";
        if (e.target.tagName == 'LI' && !isNull(e.target.id)) {
            nav_focus = e.target.id;
            localStorage.setItem('nav_focus', nav_focus);
            localStorage.setItem('nav_focus_scroll', tree.scrollTop);

            pg = e.target;
            let param = new URLSearchParams({...pg.dataset});
            location.href = ctx + "/goMenu/" + sectionId + "/" + pg.id + "?" + param.toString();
        }
    });

    //포커싱
    requestAnimationFrame(() => {
        nav_focus = localStorage.getItem('nav_focus');
        nav_focus_scroll = localStorage.getItem('nav_focus_scroll');

        if (nav_focus) {
            const focus_tag = document.getElementById(nav_focus);
            if (focus_tag) {
                focus_tag.classList.add("focus");
                tree.scrollTop = parseInt(nav_focus_scroll, 10);
            }
        } else {
            const focus_tag = tree.querySelector("li");
            if (focus_tag) {
                focus_tag.classList.add("focus");
            }
            tree.scrollTop = 0;
        }
    });



    //상단 메뉴
    //사용자 표기
    if(!isNull(loginUser.userId)){
        userOffice.innerHTML = "[" + loginUser.officeCode + "] " + loginUser.officeName + " (" + loginUser.userName + ")";
    }
    //관리소변경
    change_office.addEventListener("change", () => {
        popupOpen(pop_changeOffice);
        changeOffice_onload();
    })
    //비밀번호 변경
    change_pass.addEventListener("change", () => {
        popupOpen(pop_changePass);
        changePass_onload();
    })

});


async function nav_aside_make(menu_group, tree, timeout = 10_000) {

    const cacheKey = "nav_aside_" + menu_group;
    const cached = sessionStorage.getItem(cacheKey);

    if (cached) {
        successGetMenu(JSON.parse(cached), tree);
        return;
    }

    //로딩시작
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {

        let parm = { "menu_group" : menu_group }
        const query = new URLSearchParams(parm)
        let method = "/getNavAside";

        const res = await fetch(
            ctx + method + "?" + query,
            {
                method: "GET",
                headers: {
                    "Accept": "application/json",
                },
                credentials: "include",
                signal: controller.signal
            });
        if (!res.ok) {
            alert("요청이 실패하였습니다");
            return;
        }

        const json = await res.json();

        if (json.O_STATUS === "FAIL") {
            alert(json.O_MSG);
            return;
        }
        sessionStorage.setItem(cacheKey, JSON.stringify(json));
        successGetMenu(json, tree);


    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("조회 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("조회에 실패하였습니다");
            throw err;
        }

    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}


function successGetMenu(date,tree){
    tree.innerHTML = "";
    let ul = null;
    date.forEach((row, index) => {

        if(row.M_LEVEL == "2"){

            const li_2 = document.createElement('li');

            // 체크박스
            const checkbox = document.createElement("input");
            checkbox.type = "checkbox";
            checkbox.id = row.MENU_ID;
            checkbox.className = "tree_cb";

            // 라벨
            const label = document.createElement("label");
            label.htmlFor = row.MENU_ID;
            label.textContent = row.MENU_NAME;

            ul = document.createElement("ul");
            label.className = "tree_nav";

            li_2.appendChild(checkbox);
            li_2.appendChild(label);
            li_2.appendChild(ul);

            tree.appendChild(li_2);

        }else if(row.M_LEVEL == "3") {

            const li_3 = document.createElement("li");
            li_3.id = row.MENU_ID + "-" +  row.PG_ID;
            li_3.textContent = row.MENU_NAME;
            li_3.className = "menu_nav";
            li_3.dataset.menuName = row.MENU_NAME;
            li_3.dataset.div = row.DIV;
            li_3.dataset.menuGroup = row.MENU_GROUP;

            ul.appendChild(li_3);

        }
    })
    // 체크박스 상태 복원
    const checkboxes = document.querySelectorAll(".tree_cb");
    checkboxes.forEach(checkbox => {
        const id = checkbox.id;
        if (localStorage.getItem(id) === 'true') {
            checkbox.checked = true;
        } else {
            checkbox.checked = false;
        }

        // 체크박스 상태 저장
        checkbox.addEventListener('change', function () {
            localStorage.setItem(id, checkbox.checked);
        });
    });

    //폰트 스타일 제거
    let fontWeightTags = tree.querySelectorAll("li[id]");
    fontWeightTags.forEach(li => {
        li.style.fontWeight = "400";
    });

}


    	
    	


  