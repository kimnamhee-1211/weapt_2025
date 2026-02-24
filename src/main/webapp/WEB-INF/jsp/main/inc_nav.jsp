<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<body>    
    <div id="header">
        <div class="header1"><h1>종합관리솔루션</h1></div>
        <div id="adminUser" class="header2"><****></div>
         <!-- #### : 관리자 다르고 사용자 다르고 아이디 입력값에 따라 변경 [10002]우리나라만세센트럴프르지오(031-905-6741)-->
        <div class="header3">
            <span id="change">
                <input type="checkbox" id="change_layer_popup" class="layer_popup">
                <label for="change_layer_popup" class="pop_labal">관리소변경</label>
                <!-- 팝업시작-->
                <div class="layer_bg">
                    <div class="popup" style="width: 600px;">
                        <div class="pop_title">&#10004; 관리소변경</div>                            
                        <span>&emsp;&#9726&nbsp;관리소명(코드 외) :&nbsp;</span>
                        <span><input type="text" id="office_name" name="" class="" style="width:250px;"></span>                         
                        <span class="section_middle_btn">
                            <button id="search_btn" onclick="">검색</button>&emsp;
                        </span>
                        <div id=""  style="height: 300px; border: 1px solid #bcbcbc;">
                            <div id="" name="">
                                단지코드 | 관리소명(전화번호) | 계약유형 
                            </div>
                        </div>
                        <div class="pop_btn">
                            <label for="change_layer_popup" class="popup_closs_btn">닫기</label>                    
                        </div>
                    </div>
                </div>
                <!-- 팝업끝-->
            </span>
            <span id="home" style="color: blue;"><a a href="../home/hom01010.jsp">&emsp;결재현황&HOME</a></span>
            <span id="support"><a href="https://6741.586.kr" target="blank">&emsp;원격지원</a></span>
            <span id="password">
                <input type="checkbox" id="pw_layer_popup" class="layer_popup">
                <label for="pw_layer_popup" class="pop_labal">&emsp;비밀번호 변경&emsp;</label>
                <!-- 팝업시작-->
                <div class="layer_bg">
                    <div class="popup" style="width: 400px;">
                        <div class="pop_title">&#10004; 비밀번호변경</div>                            
                        <div>
                            <span id=""> &#9726&nbsp;사용자ID : <****> </span>&emsp; 
                            <span id=""> &#9726&nbsp;사용자명 : <****> </span>
                        </div>
                        <form action="." method="post">
                            <table id="" style="line-height:40px;">
                            <tbody>
                                <tr>
                                    <th style="width: 200px;">변경전 비밀번호</th>
                                    <td style="width: 200px;"><input type="password" id="pw" name="" class=""></td>
                                </tr>
                                <tr>
                                    <th style="width: 200px;">변경후 비밀번호</th>
                                    <td style="width: 200px;"><input type="password" id="next_pw" name="" class=""></td>
                                </tr>
                                <tr>   
                                    <th style="width: 200px;">변경후 비밀번호 확인</th>
                                    <td style="width: 200px;"><input type="password" id="next_pw2" name="" class=""></td>
                                </tr>
                            </tbody>
                            </table>
                        </form>
                        <div class="pop_btn">
                            <button id="save_btn" onclick="">저장</button>
                            <label for="pw_layer_popup" class="popup_closs_btn">닫기</label>                    
                        </div>
                    </div>
                </div>
                <!-- 팝업끝-->
            </span>
        </div>
    </div>

    <div id="nav_resize">
        <div id="nav">
            <ul>
                <li id="topnav_iljung"><a href="../iljung/ilj01010.jsp">일정관리</a></li>
                <li id="topnav_minwon"><a href="../minwon/min01010.jsp">민원관리</a></li>
                <li id="topnav_ilban"><a href="../ilban/ilb01010.jsp">관리일반</a></li>
                <li id="topnav_haeng"><a href="../haeng/hae01010.jsp">행정관리</a></li>
                <li id="topnav_ilgee"><a href="../ilgee/ilg01010.jsp">일지결재</a></li>
                <li id="topnav_jaego"><a href="../jaego/jae01010.jsp">재고관리</a></li>
                <li id="topnav_jangbi"><a href="../jangbi/jan01010.jsp">장비관리</a></li>
                <li id="topnav_hwan"><a href="../hwan/hwa01010.jsp">환경보완</a></li>
                <li id="topnav_jangsoo"><a href="../jangsoo/soo01010.jsp">장기수선</a></li>
                <li id="topnav_danche"><a href="../danche/dan01010.jsp">회의단체</a></li>
                <li id="topnav_sojang"><a href="../sojang/soj01010.jsp">관리소장</a></li>
            </ul>
           
            <input type="checkbox" id="iconmenu_layer_popup" class="layer_popup" >
            <label for="iconmenu_layer_popup" class="pop_labal iconmenu"><i class="icon-menu-1"></i></label>
    
            <!-- 팝업시작-->
            <%@ include file = "../popup/pop_mymenu.jsp" %>
            <!-- 팝업끝-->
            
        </div>
    </div>


    