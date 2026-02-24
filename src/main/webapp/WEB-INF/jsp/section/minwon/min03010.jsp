<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "min_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-phone-squared"></i>월별통계</div>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="search-box">민원접수월 :&nbsp;
                            <input type="month" id="" value="<%= yearMonth %>">&nbsp;~&nbsp;
                            <input type="month" id="" value="<%= yearMonth %>">                        
                        </span>
                    </form>
                </div> 
            </div>
            <div id="" style="height: 611px; border: 1px solid #bcbcbc;">
                <div>
                월별통계 그리드 입니다.
                </div>
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>