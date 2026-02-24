<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "soo_nav.jsp" %>

        <div id="section">
        <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>동별면적현황
                </div>
            </div>
            <div class="section2">
                <div class="section2_line0"></div>
            </div>
            <div id="we_grid" class="soo01020_grid">
                <div class="gridcont_left_450">
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>관리대상</span>
                        <span class="section_middle_btn">
                            <button id="add_btn01" onclick="">추가</button>
                            <button id="save_btn01" onclick="">저장</button>
                            <button id="del_btn01" onclick="" class="del_btn">삭제</button>                            
                        </span>                 
                    </div>
                    <div style="height: 180px; border: 1px solid #bcbcbc;">
                        <div id="" name="" class="">
                            관리대상 그리드영역
                        </div>
                    </div>
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>관리면적</span>
                        <span class="section_middle_btn">
                            <button id="add_btn02" onclick="">추가</button>
                            <button id="save_btn02" onclick="">저장</button>
                            <button id="del_btn02" onclick="" class="del_btn">삭제</button>
                            <button id="print_btn02" onclick="" class="print_btn">인쇄</button>
                        </span>
                    </div>
                    <div style="height: 389px; border: 1px solid #bcbcbc;">
                        <div id="" name="" class="">
                            관리면적 그리드영역
                        </div>
                    </div>
                </div>
                <div class="gridcont_right_620">
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>동별현황</span>
                        <span class="section_middle_btn">
                            <button id="add_btn03" onclick="">추가</button>
                            <button id="save_btn03" onclick="">저장</button>
                            <button id="del_btn03" onclick="" class="del_btn">삭제</button>                
                            <button id="print_btn03" onclick="" class="print_btn">인쇄</button>
                        </span>
                    </div>
                    <div style="height: 611px; border: 1px solid #bcbcbc;">
                        <div id="" name="" class="">
                            동별현황 그리드영역
                        </div>
                    </div>
                </div>
            </div>            
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>