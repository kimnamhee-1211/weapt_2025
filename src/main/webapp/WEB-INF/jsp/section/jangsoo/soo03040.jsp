<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "soo_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>총수선예정금액
                </div>
                 <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
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
                        <span id="" class="search-box">&emsp;총계획기간 :&nbsp;<****>                            
                            <!--해당 총계획기간 표시 예) 2000 ~ 2050 (50년간)   -->                   
                        </span>
                        <span id="" class="search-box">&emsp;잔여게획기간 :&nbsp;<****>                              
                            <!--전여 계획기간 표시 예) 2025 ~ 2050 (25년간)  -->                   
                        </span>
                    </form>
                </div>
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    총수선예정금액 그리드영역
                </div>
            </div>           
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>