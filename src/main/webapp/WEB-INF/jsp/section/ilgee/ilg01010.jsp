<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/ilgee/ilg_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-doc-text"></i><****>업무일지</div>
                <div class="section1_btn"> 
                    <button id="add_btn" onclick="">추가</button>
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
                <div>
                    <input type="date" id="today" name="today" value="<%= today %>"> 
                </div>
                <div>
                    <span id="">날씨 :&nbsp;   <!-- 선택에 따라 나오고 안나오고-->
                        <input type="" id="" class="search-txt100">
                    </span>
                    <span id="">온도 :&nbsp;    <!-- 선택에 따라 나오고 안나오고-->
                        <input type="" id="" class="search-txt50">&nbsp;℃
                    </span>
                </div>
            </div>
            <div id="" class="conf_line_right"  style="border: 1px solid #bcbcbc;">
                결재란
            </div> 
        </div>
        <div id=""  style="height: 546px; border: 1px solid #bcbcbc;">
            <div id="" name="">
                일지 그리드영역
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>