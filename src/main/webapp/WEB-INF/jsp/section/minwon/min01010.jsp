<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "min_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-phone-squared"></i>민원접수</span>
                <span class="section1_nav_mic">&emsp;
                    <i class="icon-mic"></i>동(또는 동외민원)을 클릭하면 해당 동이미지(설정된 동외민원)를 볼 수 있고 호(세대민원), 계단, 현관, E/L 을 클릭하여 민원접수, 처리 하십시오.
                </span>
            </div>
            <div class="section2">
                <div class="section2_line0"></div>
            </div>
            <div>
                <form action="." method="post">
                    <div id="" class="gridcont_left_100" style="height: 652px; border: 1px solid #bcbcbc;">
                        <div id="" name="" >
                            동 그리드
                        </div>
                    </div>
                    <div id="" class="gridcont_right_970" style="height: 652px; border: 1px solid #bcbcbc;">    
                        <div id="" name="" >  
                            <div>민원설정 아파트 이미지 클릭하면 나타나는 민원전표</div>
                           

                            <div id="min-jeon01">
                                <input type="checkbox" id="layer_popup" class="layer_popup">
                                <label for="layer_popup" class="pop_labal">클릭하면 나타나는 민원전표(세대)</label>
                                <%-- table 팝업시작--%>
                                <%@ include file = "../../popup/pop_min_jeon01.jsp" %>
                                <%-- table 팝업 끝--%>
                            </div>
                            <div id="min-jeon02">
                                <input type="checkbox" id="layer_popup2" class="layer_popup">
                                <label for="layer_popup2" class="pop_labal">클릭하면 나타나는 민원전표(공용민원)</label>
                                <%-- table 팝업시작--%>
                                <%@ include file = "../../popup/pop_min_jeon02.jsp" %>
                                <%-- table 팝업 끝--%>
                            </div>
                            <div id="min-jeon03">
                                <input type="checkbox" id="layer_popup3" class="layer_popup">
                                <label for="layer_popup3" class="pop_labal">클릭하면 나타나는 민원전표(동외민원)</label>
                                <%-- table 팝업시작--%>
                                <%@ include file = "../../popup/pop_min_jeon03.jsp" %>
                                <%-- table 팝업 끝--%>
                            </div>
                        </div>
                    </div> 
                </form>              
            </div>            
        </div>
    </div>



<%@ include file = "../../inc_footer.jsp" %>