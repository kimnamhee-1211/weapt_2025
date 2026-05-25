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



async function nav_aside_make(menu_group, {successSelect} = {}, timeout = 60_000) {

    //로딩시작
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {

        const query = new URLSearchParams(menu_group)
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
        if (typeof successGetMenu === "function") await successGetMenu(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("조회 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("조회에 실패하였습니다");
        }
        throw err;

    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}


async function successGetMenu(date){









}


    	
    	


  