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
document.addEventListener("DOMContentLoaded", () => {

    //변수 설정
    const wrap = document.querySelector(".nav_wrap");
    const aside = document.querySelector(".nav_aside");
    const tree = document.querySelector(".nav_tree"); //스크롤 요소

    if (!wrap || !aside || !tree) return;


    //메뉴 만들기
    if(!isNull(menu_group)){
        nav_aside_make(menu_group, tree);
    }

    let nav_focus = null;   //포커스
    let nav_focus_scroll = null; //포커스

    //폰트 스타일 제거
    let fontWeightTags = tree.querySelectorAll("li[id]");
    fontWeightTags.forEach(li => {
        li.style.fontWeight = "400";
    });

    //메뉴 이동
    tree.addEventListener('click', (e) => {
        let pg = "";
        if (e.target.tagName == 'LI' && !isNull(e.target.id)) {
            nav_focus = e.target.id;
            localStorage.setItem('nav_focus', nav_focus);
            localStorage.setItem('nav_focus_scroll', tree.scrollTop);

            pg = e.target;
            location.href = ctx + "/goMenu/" + sectionId + "/" + pg.id + "?title=" + encodeURIComponent(pg.textContent);
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
});



async function nav_aside_make(menu_group, tree, timeout = 10_000) {

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


    date.forEach((row, index) => {

        let ui;
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
           // li_3.id = row.MENU_ID + "/" +  row.PG_ID;
            li_3.id = row.PG_ID;
            li_3.textContent = row.MENU_NAME;

            ul.appendChild(li_3);

        }
    })
}


    	
    	


  