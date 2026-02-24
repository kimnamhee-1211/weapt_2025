<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/sojang/soj_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-star-filled"></i>공종별단가기준예시
                </div>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="save_btn" onclick="">저장</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="select-container">검색조건 : &nbsp;
                            <select id="jan_label_1" class="select_cont150">
                                <option value="jan_label_1"><****></option> <!-- 예) 건물외부  전체우선-->  
                            </select>
                        </span>
                        <span class="select-container">&emsp;
                            <select id="jan_label_2" class="select_cont150"> 
                                <option value="jan_label_2"><****></option> <!-- 예) 지붕 전체우선-->  
                            </select>
                        </span>                   
                    </form>
                </div>
            </div>
            <div class="gridcont_left_200">
                <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                    <div id="" name="">
                        공사종별 그리드영역
                    </div>
                </div>
            </div>
            <div class="gridcont_right_870">
                <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                    <div id="" name="">
                        에디터 영역
                    </div>
                </div>
            </div>
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>