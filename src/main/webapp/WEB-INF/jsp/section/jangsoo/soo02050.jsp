<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "soo_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>장기수선계획 비교조회
                </div>
                 <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="search-box">기준수립조정년월(B) :&nbsp;
                            <select id="year_month" class="select_cont100">
                                <option value="year_month"><****></option>  <!-- ****-** -->  
                            </select>&emsp;                       
                        </span>
                        <span class="select-container">&emsp;전면 / 부분 :&nbsp;
                            <select id="bangbub" name="" class="select_cont70">
                                <option value="all">전체</option>
                                <option value="jeon">전면</option>
                                <option value="boo">부분</option>
                            </select>
                        </span>                       
                    </form>
                </div>
            </div>
            <div id="" style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    수선게획비교조회 그리드영역
                </div>
            </div>  
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>