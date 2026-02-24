<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "hom_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-home"></i>결재현황</div>
                <div class="section1_btn">
                    기준일 이전 7일간&nbsp; <button id="search_btn" onclick="">검색</button>&emsp;
                    순번 및 결재주기&nbsp; <button id="save_btn" onclick="">저장</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span>결재기준일 :&nbsp;
                            <input type="date" id="today" value="<%= today %>">                        
                        </span>                            
                        <span class="section1_btn">  
                        결재 : &#9679; &ensp;미결 : &#9675; &ensp;보류 : &#9651; &ensp;휴가/결원 : &#9633; &ensp;
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