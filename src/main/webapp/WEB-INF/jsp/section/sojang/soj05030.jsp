<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>


        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-star-filled"></i>휴무일등록
                </div>
                <div class="section1_btn">
                    <input type="checkbox" id="layer_popup" class="layer_popup">
                    <label for="layer_popup" class="pop_labal popup_btn">휴무일복사</label>
                    <!-- 변경 팝업시작--> 
                    <div class="layer_bg">
                        <div class="popup" style="width:220px;">
                            <div class="pop_title">&#10004;휴뮤일복사</div>
                            <form action="." method="post">
                                <div style="padding: 15px; border: 1px solid #bcbcbc;">
                                    <div id="">&#9726&nbsp;기준년도 :&nbsp;<****>  <!--검색조건 년도--> 
                                    </div>
                                    <div class="search-box">&#9726&nbsp;복사년도 :&nbsp;
                                        <select id="new_year" class="select_cont70">
                                            <option  value="new_year"><****></option> 
                                        </select>                        
                                    </div>
                                </div>
                            </form>
                            <div class="pop_btn">
                                <button id="save_btn" onclick="">복사</button>
                                <label for="layer_popup" class="popup_closs_btn">닫기</label>                    
                            </div>
                        </div>
                    </div>
                    <!-- 팝업끝-->
                    <button id="add_btn" onclick="">추가</button>
                    <button id="save_btn" onclick="">저장</button>
                    <button id="del_btn" onclick="">삭제</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="select-container">연도 : &nbsp;
                            <select id="year" class="select_cont100">
                                <option value="year"><****></option> <!-- 연도-->  
                            </select>
                        </span>               
                    </form>
                </div>
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    휴무일등록 그리드영역
                </div>
            </div>
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>