<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "jan_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-calendar-plus-o"></i>고장처리내역조회</div>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="search-box">조회기간 :&nbsp;
                            <input type="date" id="firstDayOfMonth" value="<%= firstDayOfMonth %>">&nbsp; ~ &nbsp;
                            <input type="date" id="today" value="<%= today %>"> 
                        </span>
                        <span class="select-container">&emsp;구분 :&nbsp;
                            <select id="" class="select_cont100">
                                <option value="">전체</option>
                                <option value="">전기분야</option>
                                <option value="">설비영선</option>
                            </select>
                        </span>
                        <span class="select-container">&emsp;메뉴(장소)명 :&nbsp;
                            <select id="" class="select_cont100">
                                <option value=""><****></option>
                            </select>
                        </span>
                        <span class="select-container">&emsp;장비명 :&nbsp;
                            <select id="" class="select_cont200">
                                <option value=""><****></option>
                            </select>
                        </span>
                    </form>                                               
                </div> 
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    고장처리내역조회 그리드영역
                </div>
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>