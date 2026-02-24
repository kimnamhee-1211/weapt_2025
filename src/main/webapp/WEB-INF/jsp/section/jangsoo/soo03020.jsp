<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "soo_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>연도별수선일정
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
                        <span class="search-box">&emsp;년도 :&nbsp;
                            <select id="st_year" name="" class=""  class="select_cont70">
                                <option value="st_year"><****></option> 
                                <!--해당 총계획기간 전체년도 선택할 수 있게 value 첫 년도  -->
                            </select>&emsp;~&emsp;
                            <select id="end_year" name="" class=""  class="select_cont70">&nbsp;
                                <option value="end_year"><****></option>
                                <!--해당 총계획기간 전체년도 선택할 수 있게 value 마지막 년도  -->
                            </select>                         
                        </span>                      
                    </form>
                </div>
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    연도별수선일정 그리드영역
                </div>
            </div>           
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>