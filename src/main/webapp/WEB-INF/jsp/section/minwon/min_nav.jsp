<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrap">
    <div class="aside">
        <div id="aside_minwon">
            <div class="nav">민원관리</div>
            <ul class="tree">
                <li id="min01">
                    <input type="checkbox" id="root">
                    <label for="root">민원관리</label>
                    <ul class="tree_nav">
                        <li id="min01010"><a href="min01010.jsp">민원접수</a></li>
                        <li id="min01020"><a href="min01020.jsp">민원처리</a></li>
                        <li id="min01030"><a href="min01030.jsp">민원조회</a></li>
                        <li id="min01040"><a href="min01040.jsp">세대민원대장</a></li>
                        <li id="min01050"><a href="min01050.jsp">공용민원대장</a></li>
                        <li id="min01060"><a href="min01060.jsp">민원일지결재</a></li>
                        <li id="min01070"><a href="min01070.jsp">세대정보등록</a></li>
                        <li id="min01080"><a href="min01080.jsp">민원환경설정</a></li>
                        <li id="min01090"><a href="min01090.jsp">삭제민원조회(관리자)</a></li> 
                    </ul>
                </li>
                <li id="min02">
                    <input type="checkbox" id="root2">
                    <label for="root2">단지현황</label>
                    <ul class="tree_nav">
                        <li id="min02010"><a href="min02010.jsp">단지배치도</a></li>
                        <li id="min02020"><a href="min02020.jsp">세대평면도</a></li>
                    </ul>
                </li>
                <li id="min03">
                    <input type="checkbox" id="root3">
                    <label for="root3">민원통계</label>
                    <ul class="tree_nav">
                        <li id="min03010"><a href="min03010.jsp">월별통계</a></li>
                        <li id="min03020"><a href="min03020.jsp">처리자별통계</a></li>
                        <li id="min03030"><a href="min03030.jsp">구분통계</a></li>
                        <li id="min03040"><a href="min03040.jsp">동별통계</a></li>
                        <li id="min03050"><a href="min03050.jsp">분야별통계</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>