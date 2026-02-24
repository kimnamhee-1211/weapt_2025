<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "min_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-phone-squared"></i>세대평면도</span>
                <span class="section1_nav_mic">&emsp;
                    <i class="icon-mic"></i>먼저 타입을 추가 저장 후 타입선택 사진찾기로 행당 타입 사진 저장합니다.
                </span>
            </div>
            <div class="section2">
                <div class="section2_line0">
                </div> 
            </div>

            <div id="" class="gridcont_left_250">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>타입(평형)</span>
                    <span class="section_middle_btn">
                        <form action="." method="post">
                            <button id="add_btn01" onclick="">추가</button>   <!-- 그리드 행 추가-->
                            <button id="save_btn01" onclick="">저장</button>  <!-- 그리드에 입력 저장-->   
                        </form>                    
                    </span>                 
                </div>
                <div style="height: 611px; border: 1px solid #bcbcbc;">
                    <div id="" name="">
                        타입 그리드영역
                    </div>
                </div>
            </div>
            <div id="" class="gridcont_right_820">
                <form action="." method="post">
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>세대평면도</span>
                        <span class="section_middle_btn">
                            <form action="." method="post">
                                <button id="find_btn" onclick="">사진찾기</button>
                                <button id="save_btn" onclick="">저장</button>
                                <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                            </form>                                           
                        </span>
                    </div>
                    <div id="" name="" style="height: 611px; border: 1px solid #bcbcbc;">
                        사진
                    </div>
                </form>
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>