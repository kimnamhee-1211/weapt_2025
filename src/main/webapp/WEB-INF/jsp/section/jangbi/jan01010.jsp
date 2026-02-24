<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "jan_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-cog-alt"></i><****></span> <!--장비관리설정에서 설정된메뉴-->
                <span class="section1_nav_mic">&emsp;<i class="icon-mic"></i>
                    장비명 행을 더블 클릭하면 해당 장비이력카드메뉴로 이동됩니다.
                </span>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="add_btn" onclick=""><a href="jan01090.jsp">추가</a></button> 
                    <!-- 해당 관리번호 장비명 장비이력카드 메뉴로-->               
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                </div>
            </div>

            <div id=""  style="height: 658px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    그리드영역
                </div>
            </div>           
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>