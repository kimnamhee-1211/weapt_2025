<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "min_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-phone-squared"></i>세대정보등록</span>
                <span class="section1_nav_mic">&emsp;
                    <i class="icon-mic"></i>동 호 면적을 제외하고 그리드에 직접 입력(수정)하여 저장합니다. 
                </span>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="save_btn" onclick="">저장</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <div>
                            <span id="sedae">동호:&nbsp;
                                <input type="" id="" name="" class="box50">동
                                <input type="" id="" name="" class="box50">호&emsp;~&emsp;</td> 
                                <input type="" id="" name="" class="box50">동
                                <input type="" id="" name="" class="box50">호&emsp;&emsp;&emsp;
                            </span>                            
                        </div>                        
                    </form>                                               
                </div> 
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    세대민원대장 그리드영역
                </div>
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>