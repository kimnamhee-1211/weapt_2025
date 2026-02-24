<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "soo_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>적립및사용현황
                </div>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="add_btn" onclick="">추가</button>
                    <button id="save_btn" onclick="">저장</button>
                    <button id="del_btn" onclick="" class="admin_btn">삭제</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="search-box">기간 :&nbsp;
                            <input type="date" id="st_date">&nbsp; ~ &nbsp;<input type="date" id="end_date">                         
                        </span>
                        <span class="select-container">&emsp;구분 :&nbsp;
                            <select id="plus_minus" class="select_cont100">
                                 <!-- 달라짐 적립은 기초잔액 + 부과징수 + 잉여금처분 + 이자수입 + 기타--> 
                                <option value="all">전체</option>
                                <option value="minus">사용</option>
                                <option value="plus">적립</option>
                            </select>
                        </span>
                        <span>&emsp;&emsp;
                            <input type="checkbox" id="subsum"> &nbsp;세부구분별 소계 <!-- 사용 부과징수 잉여금처분  이자수입 기타 기초잔액 --> 
                        </span>                       
                    </form>
                </div>
            </div>
            <div id="we_grid" class="soo04010_gridcontainer">
                <div class="g_1076_611">
                    <div id="" name="" class="">
                        그리드에 직접입력 - 위버튼 추가(맨밑추가) 저장 (선택)삭제 이용<br>
                        선택 | 세부구분(사용/징수부과/잉여금처분/이자수입/기타/기초잔액 콤보박스) | 일자 | 적립금액 | 사용금액 | 잔액 (자동계산) <br>
                        행 편집기능, 정렬기능, 아래행 합계  
                    </div>
                </div>
            </div>            
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>