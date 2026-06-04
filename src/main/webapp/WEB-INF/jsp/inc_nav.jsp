<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div id="header">
        <div class="header1"><h1>종합관리솔루션</h1></div>
        <div id="userOffice" class="header2"></div>
        <div class="header3">

            <span id="change">
                <input type="checkbox" id="change_office" class="hidden_check">
                <label for="change_office" class="pop_labal">관리소변경</label>
                <!-- 팝업-->
                <jsp:include page="/WEB-INF/jsp/section/home/pop_changeOffice.jsp"/>
            </span>

            <span id="home" class="nav_top" style="color: blue;"><a id="home/hom01010">&emsp;결재현황&HOME</a></span>

            <span id="support"><a href="https://6741.586.kr" target="blank">&emsp;원격지원</a></span>

            <span id="password">
                <input type="checkbox" id="change_pass" class="hidden_check">
                <label for="change_pass" class="pop_labal">&emsp;비밀번호 변경&emsp;</label>
                <!-- 팝업-->
                <jsp:include page="/WEB-INF/jsp/section/home/pop_changePass.jsp"/>
            </span>
        </div>
    </div>

    <div id="nav_resize">
        <div id="nav">
            <ul id="nav_top">
                <li id="topnav_iljung"><a id="iljung/ilj01010">일정관리</a></li>
                <li id="topnav_minwon"><a id="minwon/min01010">민원관리</a></li>
                <li id="topnav_ilban"><a id="ilban/ilb01010">관리일반</a></li>
                <li id="topnav_haeng"><a id="haeng/hae01010">행정관리</a></li>
                <li id="topnav_ilgee"><a id="ilgee/ilg01010">일지결재</a></li>
                <li id="topnav_jaego"><a id="jaego/jae01010">재고관리</a></li>
                <li id="topnav_jangbi"><a id="jangbi/jan01010">장비관리</a></li>
                <li id="topnav_hwan"><a id="hwan/hwa01010">환경보완</a></li>
                <li id="topnav_jangsoo"><a id="jangsoo/soo01010">장기수선</a></li>
                <li id="topnav_danche"><a id="danche/dan01010">회의단체</a></li>
                <li id="topnav_sojang"><a id="sojang/110010020-soj01010">관리소장</a></li>
            </ul>
           
            <input type="checkbox" id="iconmenu_layer_popup" class="hidden_check" >
            <label for="iconmenu_layer_popup" class="pop_labal iconmenu"><i class="icon-menu-1"></i></label>
    
            <!-- 팝업시작-->
            <%@ include file = "popup/pop_mymenu.jsp" %>
            <!-- 팝업끝-->
            
        </div>
    </div>


    <script>

        const nav_top = document.querySelector("#nav_top");
        const userOffice = document.querySelector("#userOffice");
        const change_office = document.querySelector("#change_office");
        const change_pass = document.querySelector("#change_pass");


        change_office.addEventListener("change", () => {
            popupOpen(pop_changeOffice);
            changeOffice_onload();
        })

        change_pass.addEventListener("change", () => {
            popupOpen(pop_changePass);
            changePass_onload();
        })


        window.addEventListener("load", function () {
            if(!isNull(loginUser.userId)){
                userOffice.innerHTML = "[" + loginUser.officeCode + "] " + loginUser.officeName + " (" + loginUser.userName + ")";
            }
        })


        nav_top.addEventListener('click', (e) => {
            var pg = null;

            if(e.target.tagName == 'LI'){
                pg = e.target.querySelector('a').id;
            }
            else if(e.target.tagName == 'A'){
                 pg = e.target.id;
            }
            location.href = ctx + "/goMenu/" + pg
        });

    </script>


