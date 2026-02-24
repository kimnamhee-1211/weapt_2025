<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/sojang/soj_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-star-filled"></i>Data Conversion
                </div>
                <div class="section1_btn">                 
                    <button id="search_btn" onclick="">검색</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span id="" class="search-box">관리소명 :&nbsp;
                            <****>                       
                        </span>&emsp;
                        <span class="select-container"> 업무 :&nbsp;
                            <select id="" name="" class="select_cont150">
                                <option value=""><****></option>
                            </select>
                        </span>&emsp;
                        <span class="search-box">CSV 파일 :&nbsp;
                            <input class="search-150" type="text" id="st_date">                        
                        </span>&emsp;
                    </form>
                </div> 
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    엑셀 업로드 할 수 있게 변경
                </div>
            </div>   
        </div>       
    </div>
    
<%@ include file = "../../inc_footer.jsp" %>