<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="nav_wrap">
    <div class="nav_aside">
        <div id="aside_jangbi">
            <div class="nav">장비관리</div>
            <ul class="nav_tree">
                <li id="jan01">
                    <input type="checkbox" id="root">
                    <label for="root">전기분야</label>
                    <ul class="tree_nav">
                        <li id="jan01010"><a href="jan01010.jsp"><****></a></li>
                        <!-- 추가되는 메뉴-->
                        <li id="jan01092"><a href="jan01092.jsp">고장처리내역조회</a></li>
                        <li id="jan01094"><a href="jan01094.jsp">폐기장비조회</a></li>

                    </ul>
                </li>
                <li id="jan02">
                    <input type="checkbox" id="root2">
                    <label for="root2">설비영선</label>
                    <ul class="tree_nav">
                        <li id="jan02010"><a href="jan02010.jsp"><****></a></li>
                        <!-- 추가되는 메뉴-->
                        <!-- 고장처리내역조회 메뉴와 폐기장비조회 메뉴 같다.-->
                        <li id="jan02092"><a href="jan02092.jsp">고장처리내역조회</a></li>
                        <li id="jan02094"><a href="jan02094.jsp">폐기장비조회</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>