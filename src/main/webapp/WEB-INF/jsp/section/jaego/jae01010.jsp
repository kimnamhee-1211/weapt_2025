<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "jae_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-cubes"></i>구입업체등록</div>
                <div class="section1_btn">
                    <button id="">검색</button>
                    <button id="">추가</button>                   
                    <button id="" class="print_btn">인쇄</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="select-container">&emsp;검색조건 :&nbsp;
                            <select class="select_cont150">
                                <option value="normal">정상구입업체</option>
                                <option value="close">해지구입업체</option>
                                <option value="all">전체</option>
                                <option value="company">업체명</option>
                            </select>
                        </span>
                        <span class="search-box">&nbsp;                             
                            <input style="width:150px; height:20px;" type="text" placeholder=" 업체명 입력">                   
                        </span>
                    </form>
                </div> 
            </div>
            <div id="we_grid">
                여기부터 그리드 입니다.
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>