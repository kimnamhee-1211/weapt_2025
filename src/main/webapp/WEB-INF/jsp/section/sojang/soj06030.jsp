<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>


        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-star-filled"></i>메시지전송관리
                </div>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                     <form action="." method="post">
                        <span class="search-box">기준일 :&nbsp;
                            <input class="search-txt100" type="date" id="date">                      
                        </span> &emsp;
                        <span> &#9726 (SMS기준)
                        </span>
                    </form>
                </div> 
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    메시지전송관리 그리드
                </div>
            </div>            
        </div>       
    </div>
    
<%@ include file = "../../inc_footer.jsp" %>