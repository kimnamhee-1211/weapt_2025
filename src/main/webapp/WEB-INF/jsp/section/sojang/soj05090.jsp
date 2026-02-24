<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/sojang/soj_nav.jsp" />

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-star-filled"></i>부서직책설정(공통)</span>
            </div>
            <div class="section2">
                <div class="section2_line0">
                </div> 
            </div>

            <div id="" class="gridcont_left_270">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>부서</span>
                    <span class="section_middle_btn">
                        <button id="add_btn01" onclick="">추가</button>
                        <button id="save_btn01" onclick="">저장</button>                         
                    </span>                 
                </div>
                <div style="height: 611px; border: 1px solid #bcbcbc;">
                    <div id="" name="">
                        부서 그리드영역
                    </div>
                </div>
            </div>
            <div id="" class="gridcont_left_410">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>직책</span>
                    <span class="section_middle_btn">
                        <button id="add_btn01" onclick="">추가</button>
                        <button id="save_btn01" onclick="">저장</button>                         
                    </span>                 
                </div>
                <div style="height: 611px; border: 1px solid #bcbcbc;">
                    <div id="" name="">
                        직책 그리드영역
                    </div>
                </div>
            </div>
            <div id="" class="gridcont_left_400">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>입주자대표회의</span>
                    <span class="section_middle_btn">
                        <button id="add_btn01" onclick="">추가</button>
                        <button id="save_btn01" onclick="">저장</button>                         
                    </span>                 
                </div>
                <div style="height: 611px; border: 1px solid #bcbcbc;">
                    <div id="" name="">
                        입주자대표회의 그리드영역
                    </div>
                </div>
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>