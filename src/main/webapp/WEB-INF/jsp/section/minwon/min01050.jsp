<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "min_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-phone-squared"></i>공용민원대장</div>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <div>
                            <span>기간 :&nbsp;
                                <input type="date" id="firstDayOfMonth" value="<%= firstDayOfMonth %>">&nbsp; ~ &nbsp;
                                <input type="date" id="today"  value="<%= today %>"> 
                            </span>&emsp;&emsp;
                            <span id="gongyong">
                                <input type="radio" id="" name="" checked> 전체공용&emsp; 
                                <input type="radio" id="" name=""> 동별공용&emsp;
                                <input type="radio" id="" name=""> 동외공용&emsp;                           
                            </span>                           
                        </div>                        
                    </form>                                               
                </div> 
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    공용민원대장 그리드영역
                </div>
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>