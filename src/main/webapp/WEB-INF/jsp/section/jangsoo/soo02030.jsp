<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "soo_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>장기수선계획조회
                </div>
                 <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                    <span class="section_middle_btn">&emsp;실시 및 계획&nbsp;
                        <button id="save_btn" onclick="">저장</button>
                    </span>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="search-box">수립조정년월 :&nbsp;
                            <select id="year_month" class="select_cont100">
                                <option value="year_month"><****></option>  <!-- ****-** -->  
                            </select>&emsp;                       
                        </span>
                        <span class="select-container">&emsp;
                            <input type="radio" id="" name="" class="">
                            <label for="option1">총괄</label>
                        </span>
                        <span class="select-container">&emsp;
                            <input type="radio" id="" name="" class="">
                            <label for="option2">총괄구분</label>
                        </span>
                        <span class="select-container">&emsp;
                            <input type="radio" id="" name="" class="" checked>
                            <label for="option3">공사종별</label>
                        </span>
                        <span class="select-container">&emsp;&emsp;수선예정년 :&nbsp;
                            <select id="" name="" class="select_cont70">
                                <option value="all">전체</option>
                                <option value=""><****></option>   <!-- 예정년 있는것만 -->  
                            </select>
                        </span>                                               
                    </form>
                </div>
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    그리드영역
                </div>
            </div>           
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>