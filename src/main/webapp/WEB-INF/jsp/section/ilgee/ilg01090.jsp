<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/ilgee/ilg_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-doc-text"></i>업무일지조회</div>
                <div class="section1_btn">
                    <button id="">검색</button>
                    <button class="print_btn">인쇄</button>
                </div>
            </div>
            <div class="section2">
                 <div class="section2_line1">
                    <form action="." method="post">
                        <div>
                            <span class="search-box">기간 :&nbsp;
                                <input type="date" id="firstDayOfMonth" value="<%= firstDayOfMonth %>">&nbsp; ~ &nbsp;
                                <input type="date" id="today" value="<%= today %>"> 
                            </span>
                            <span class="select-container">&emsp;메뉴명 :&nbsp;
                                <select class="select_cont150">
                                    <option value=""><****></option>
                                </select>
                            </span>
                            <span class="search-box">&emsp;내용 :&nbsp;                             
                                <input type="text" id="" class="search-txt400">
                            </span>
                        </div>
                    </form>                                               
                </div> 
            </div>
            <div id="we_grid">
                여기부터 그리드 입니다.
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>