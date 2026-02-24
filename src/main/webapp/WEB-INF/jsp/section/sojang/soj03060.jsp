<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/sojang/soj_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-star-filled"></i>마감해제
                </div>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="del_btn" onclick="" class="del_btn">삭제</button> 
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                     <form action="." method="post">
                        <span id="" class="search-box">관리소명 :&nbsp;
                            <****>                       
                        </span>&emsp;
                        <span class="select-container">&emsp; 마감연도 :&nbsp;
                            <select id="" name="" class="select_cont70">
                                <option value=""><****></option>
                            </select>
                        </span>
                    </form>
                </div> 
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    체크박스 마감일 마감자성명
                </div>
            </div>            
        </div>       
    </div>
    
<%@ include file = "../../inc_footer.jsp" %>