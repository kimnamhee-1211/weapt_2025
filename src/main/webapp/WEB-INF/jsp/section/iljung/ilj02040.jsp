<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/iljung/ilj_nav.jsp" />

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-calendar-plus-o"></i>구분설정</span>
            </div>
            <div class="section2">
                <div class="section2_line0">
                </div> 
            </div>
            <div id="" class="gridcont_left_250">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>수립기준일</span>
                    <span class="section_middle_btn">
                        <button id="add_btn01" onclick="">추가</button>
                        <button id="save_btn01" onclick="">저장</button>                         
                    </span>                 
                </div>
                <div style="height: 612px; border: 1px solid #bcbcbc;">
                    <div id="" name="">
                        수립기준일 그리드영역
                    </div>
                </div>
            </div>
            <div id="" class="gridcont_right_820">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>구분설정</span>
                    <span class="section_middle_btn">
                        <button id="" onclick="" class="admin_btn">타단지복사</button>
                        <button id="add_btn02" onclick="">추가</button>
                        <button id="save_btn02" onclick="">저장</button>                         
                    </span>                 
                </div>
                <div>
                    <div id="" name="" style="height: 612px; border: 1px solid #bcbcbc;">
                        구분설정 그리드영역
                    </div>
                </div>
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>