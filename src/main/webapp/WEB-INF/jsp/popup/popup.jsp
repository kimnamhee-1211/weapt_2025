<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

            <span id="password">
                <input type="checkbox" id="pw_layer_popup" class="layer_popup">
                <label for="pw_layer_popup" class="pop_labal">&emsp;비밀번호 변경&emsp;</label>
                <!-- table 팝업시작-->
                <div class="layer_bg">
                    <div class="popup" style="width: 400px; line">
                        <div class="pop_title">&#10004; 비밀번호변경</div>                            
                        <div>
                            <span id=""> &#9726&nbsp;사용자ID : <****> </span>&emsp; 
                            <span id=""> &#9726&nbsp;사용자명 : <****> </span>
                        </div>
                        <form action="." method="post">
                            <table id="" style="line-height:40px;">
                            <tbody>
                                <tr>
                                    <th style="width: 200px;">변경전 비밀번호</th>
                                    <td style="width: 200px;"><input type="password" id="pw" name="" class=""></td>
                                </tr>
                                <tr>
                                    <th style="width: 200px;">변경후 비밀번호</th>
                                    <td style="width: 200px;"><input type="password" id="next_pw" name="" class=""></td>
                                </tr>
                                <tr>   
                                    <th style="width: 200px;">변경후 비밀번호 확인</th>
                                    <td style="width: 200px;"><input type="password" id="next_pw2" name="" class=""></td>
                                </tr>
                            </tbody>
                            </table>
                        </form>
                        <div class="pop_btn">
                            <button id="save_btn" onclick="">저장</button>
                            <label for="pw_layer_popup" class="popup_closs_btn">닫기</label>                    
                        </div>
                    </div>
                </div>
                <!-- 팝업끝-->
            </span>


                        <span><i class="icon-pause"></i>수선항목</span>
                        <span class="section_middle_btn">
                            <input type="checkbox" id="soo02020_layer_popup" class="layer_popup">
                            <label for="soo02020_layer_popup" class="pop_labal popup_btn">단가등록</label>
                             <!-- pop_edit_content , grid 팝업시작--> 
                            <div class="layer_bg">
                                <div class="popup" style="width:800px;">
                                    <div class="pop_title">&#10004; 단가등록
                                    </div>
                                    <div id="">
                                    &#9726&nbsp;<****> </span>&emsp;  <!-- 예) 1. 건물외부 > 지붕 > 고분자도막방수--> 
                                    </div>
                                    <div class="pop_edit_content" style="height:350px;">
                                    관리자 단가설정된 것 불러오는 edit 읽기 창
                                    </div>
                                    <div id=""  style="margin-top:10px; height: 250px; border: 1px solid #bcbcbc;">
                                        <div id="" name="">
                                            품목 규격 단위 수량 적용단가를 입력하는 그리드영역
                                        </div>
                                    </div>
                                    <div class="pop_btn">
                                        <button id="add_btn" onclick="">추가</button>
                                        <button id="del_btn" onclick="">삭제</button>
                                        <button id="save_btn" onclick="">저장</button>
                                        <label for="soo02020_layer_popup" class="popup_closs_btn">닫기</label>                    
                                    </div>
                                </div>
                            </div>
                            <!-- 팝업끝--> 
                        </span>


                <input type="checkbox" id="change_layer_popup" class="layer_popup">
                <label for="change_layer_popup" class="pop_labal">관리소변경</label>
                <!-- 검색버튼이 있는 팝업시작-->
                <div class="layer_bg">
                    <div class="popup" style="width: 600px;">
                        <div class="pop_title">&#10004; 관리소변경</div>                            
                        <span>&emsp;&#9726&nbsp;관리소명(코드 외) :&nbsp;</span>
                        <span><input type="text" id="office_name" name="" class="" style="width:250px;"></span>                         
                        <span class="section_middle_btn">
                            <button id="search_btn" onclick="">검색</button>&emsp;
                        </span>
                        <div id=""  style="height: 300px; border: 1px solid #bcbcbc;">
                            <div id="" name="">
                                단지코드 | 관리소명(전화번호) | 계약유형
                            </div>
                        </div>
                        <div class="pop_btn">
                            <button id="save_btn" onclick="">저장</button>
                            <label for="change_layer_popup" class="popup_closs_btn">닫기</label>                    
                        </div>
                    </div>
                </div>
