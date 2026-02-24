<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "min_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-phone-squared"></i>민원일지결재</span>
                <div class="section1_btn">
                    <input type="checkbox" id="layer_popup" class="layer_popup">
                    <label for="layer_popup" class="pop_labal popup_btn_print" >인쇄</label>
                    <!-- 인쇄 팝업시작--> 
                    <%@ include file = "../../popup/pop_print.jsp" %>
                    <!-- 팝업끝-->
                </div>
            </div>
            <div class="section2">
                <div class="section2_line0"></div>
            </div>
            <div id="conf_line"> 
                <div class="conf_line_left">
                    <input type="date" id="today" name="today" value="<%= today %>">                      
                </div>
                <div></div>
                <div id="" class="conf_line_right" style="border: 1px solid #bcbcbc;">
                    결재란
                </div> 
            </div>                                                             
            
            <div id=""  style="height: 546px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    민원일지결재 그리드영역
                </div>
            </div>
        </div>
    </div>





<%@ include file = "../../inc_footer.jsp" %>