<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "min_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-phone-squared"></i>민원환경설정</span>
                <span class="section1_nav_mic">&emsp;
                    <i class="icon-mic"></i>[추가]로 그리드에 직접입력하고 사용폐기가 되었을 때에는 사용여부를 NO로 선택 후 [저장]합니다. 
                </span>
            </div>
            <div class="section2">
                <div class="section2_line0"></div>
            </div>
            <div class="gridcont_left_370">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>동외공용민원  장소설정</span>
                    <span class="section_middle_btn">
                        <button id="add_btn" onclick="">추가</button>
                        <button id="save_btn" onclick="">저장</button> 
                    </span>
                </div> 
                <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                        <div id="" name="">
                            그리드영역
                        </div>
                </div>
            </div> 
            <div class="gridcont_left_370">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>민원구분</span>
                    <span class="section_middle_btn">
                        <button id="change_btn" onclick="" class="admin_btn">타단지복사</button>
                        <button id="add_btn" onclick="">추가</button>
                        <button id="save_btn" onclick="">저장</button> 
                    </span>
                </div> 
                <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                        <div id="" name="">
                            그리드영역
                        </div>
                </div>
            </div> 

            <div class="gridcont_left_340">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>민원처리자</span>
                    <span class="section_middle_btn">
                        <button id="add_btn" onclick="">추가</button>
                        <button id="save_btn" onclick="">저장</button> 
                    </span>
                </div> 
                <div id=""  style="height: 280px; border: 1px solid #bcbcbc;">
                        <div id="" name="">
                            그리드영역
                        </div>
                </div>

                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>민원환경</span>
                    <span class="section_middle_btn">
                        <button id="save_btn" onclick="">저장</button> 
                    </span>
                </div> 
                <div id="" class="min_setting">
                    <div id="" name="">
                        &ensp;&#9726&nbsp;민원접수방법 :&emsp;&ensp;
                        <span id="">
                            <input type="radio" id="" name="" checked> 민원대장&emsp; 
                            <input type="radio" id="" name=""> 민원전표&emsp;                         
                        </span>
                    </div>
                    <div id="" name="">
                        &ensp;&#9726&nbsp;민원접수자 :&emsp;&ensp;
                        <span id="">
                            <input type="radio" id="" name=""> 민원접수자&emsp; 
                            <input type="radio" id="" name="" checked> 로그인사용자&emsp;                         
                        </span>
                    </div>
                    <div id="" name="">
                        &ensp;&#9726&nbsp;재고자산추가 :&emsp;&ensp; 
                        <input type="checkbox" id="check1"><label for="check1">소모품사용</label>&emsp;
                        <input type="checkbox" id="check2"><label for="check2">계량기사용</label>
                    </div>
                    <div id="" name="">
                        &ensp;&#9726&nbsp;기타추가 :&emsp;&ensp;
                        <input type="checkbox" id="check3"><label for="check3">메시지전송</label>&emsp;
                        <input type="checkbox" id="check4"><label for="check4">접수시간</label>
                    </div>
                </div>
            </div>                                                                
            
            
        </div>
    </div>





<%@ include file = "../../inc_footer.jsp" %>