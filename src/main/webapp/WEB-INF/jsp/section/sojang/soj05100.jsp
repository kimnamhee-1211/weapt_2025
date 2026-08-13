<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>


        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-star-filled"></i>하드용량관리</span>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>                    
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>    
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="select-container">관리소상태 :&nbsp;
                            <select id="" name="" class="select_cont100">
                                <option value="">전체</option>
                                <option value=""><***></option>   <!--공통코드 104 -->
                            </select>
                        </span>
                        <span class="select-container">&emsp;계약유형 :&nbsp;
                            <select id="" name="" class="select_cont100">
                                <option value="">전체</option>
                                <option value=""><****></option> <!--구분코드 129관리소계약구분-->
                            </select>
                        </span>
                    </form>
                </div>
            </div>
            
            <div style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    하드용량관리 그리드영역 -- 캡션(정렬 )
                </div>
            </div>
            
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>