<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "soo_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                <i class="icon-recycle"></i>수립기준
                </div>
                <div class="section1_btn">
                    최초설치년월 : <input type="month">
                    <button id="ymsave_btn" onclick="">저장</button>                  
                </div>
            </div>
            <div class="section2">
                <div class="section2_line0" style="margin-bottom: 0px;"></div>
            </div>
            <div id="" class="soo020100_gridcontainer">
                <div class="gridcont_left_200">
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>수립조정상태</span>                
                    </div>
                    <div style="height: 611px; border: 1px solid #bcbcbc;">
                        <div id="" name="" class="">
                            수립조정상태 그리드영역
                        </div>
                    </div>
                </div>
                <div class="gridcont_right_870">
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>수립조정기초</span>
                        <span class="section_middle_btn">
                            <input type="checkbox" id="layer_popup" class="layer_popup">
                            <label for="layer_popup" class="pop_labal popup_btn" class="admin_btn">변경</label>
                             <!-- 변경 팝업시작--> 
                            <div class="layer_bg">
                                <div class="popup" style="width:420px;">
                                    <div class="pop_title">&#10004;조정년월변경</div>
                                    <form action="." method="post">
                                        <div style="height:100px; padding: 15px; border: 1px solid #bcbcbc;">
                                            <div id="">&#9726&nbsp;변경전 수립조정년월 :&nbsp;<****>  <!--변경전 수립조정년월 표시 2024년 03월--> 
                                            </div>
                                            <span class="search-box">&#9726&nbsp;변경후 수립조정년월 :&nbsp;
                                                <select id="new_year" class="select_cont70">
                                                    <option  value="new_year"><****></option> 
                                                </select>년&emsp;
                                                <select id="new_month" class="select_cont70">&nbsp;
                                                    <option value="new_month"><****></option>
                                                </select>월&nbsp;                        
                                            </span>
                                        </div>
                                    </form>
                                    <div class="pop_btn">
                                        <button id="new_save_btn" onclick="">저장</button>
                                        <label for="layer_popup" class="popup_closs_btn">닫기</label>                    
                                    </div>
                                </div>
                            </div>
                            <!-- 팝업끝-->
                            
                            <button id="del_btn" onclick="" class="admin_btn">삭제</button>

                            <input type="checkbox" id="layer_popup2" class="layer_popup">
                            <label for="layer_popup2" class="pop_labal popup_btn">복사</label>
                             <!-- 팝업시작--> 
                            <div class="layer_bg">
                                <div class="popup" style="width:420px;">
                                    <div class="pop_title">&#10004;수선계획복사</div>
                                    <form action="." method="post">
                                        <div style="height:290px; padding: 15px; border: 1px solid #bcbcbc;">
                                            <div id="">&#9726&nbsp;복사원년 :&nbsp;<****>  <!--복사대상 년월 2024년 03월--> 
                                            </div>
                                            <div class="select-container">&#9726&nbsp;구분 :&nbsp;
                                                <select id="gubun" class="select_cont100">
                                                    <option value="junggi">정기</option> <!-- 조정이 정기와 수시로 나누어 짐 현재 조정은 정기로 표시--> 
                                                    <option value="soosi">수시</option>
                                                </select>
                                            </div>
                                            <div class="search-box">&#9726&nbsp;수립조정년월 :&nbsp;
                                                <select id="copy_year" class="select_cont70"> 
                                                    <option  value="copy_year"><****></option> 
                                                </select>년&emsp;
                                                <select id="copy_month" class="select_cont70">&nbsp;
                                                    <option value="copy_month"><****></option>
                                                </select>월&nbsp;                        
                                            </div>
                                            <div class="search-box">&#9726&nbsp;수립조정년월 :&nbsp;
                                                <select id="copy_st_year" class="select_cont70"> 
                                                    <option  value="copy_st_year"><****></option> 
                                                </select>년부터&emsp;
                                                <select id="copy_st_month" class="select_cont70">&nbsp;
                                                    <option value="copy_st_month"><****></option>
                                                </select>월까지&nbsp;                        
                                            </div>
                                            <div class="search-box">&#9726&nbsp;수립조정관계자 :&nbsp;
                                                <input type="text" id="copy_person" name="" class="" style="width:200px;">                                                
                                            </div>
                                            <div class="search-box">&#9726&nbsp;수립(조정)일 현재 충당금잔액 :&nbsp;                             
                                                <input type="text" id="copy_balance" name="" class="" style="width:150px;">                   
                                            </div>
                                            <div class="search-box">&#9726&nbsp;단가(금액)할증율 :&nbsp;                             
                                                <input type="text" id="copy_add" name="" class="" style="width:100px;">&nbsp;%                   
                                            </div>
                                        </div>
                                    </form>
                                    <div class="pop_btn">
                                        <button id="copy_save_btn" onclick="">저장</button>
                                        <label for="layer_popup2" class="popup_closs_btn">닫기</label>                    
                                    </div>
                                </div>
                            </div>
                            <!-- 팝업끝-->
                            <button id="add-btn" onclick="">추가</button>
                            <button id="save_btn" onclick="">저장</button>
                        </span>
                    </div>
                    <div class="section2">
                        <div id="" class="section2_line2">
                            <form action="." method="post">
                                <div>   
                                    <span class="select-container">구분 :&nbsp;
                                        <select id="gubun" class="select_cont100">
                                            <option value="junggi">정기</option> <!-- 조정이 정기와 수시로 나누어 짐 현재 조정은 정기로 표시--> 
                                            <option value="soosi">수시</option>
                                            <option value="soolib">수립</option>
                                        </select>
                                    </span>
                                    <span class="search-box">&emsp;&emsp;&emsp;&emsp;&emsp;수립조정년월 :&nbsp;
                                        <select id="year" class="select_cont70">
                                            <option  value="year"><****></option>
                                        </select>년&emsp;
                                        <select id="month" class="select_cont70">&nbsp;
                                            <option value="month"><****></option>
                                        </select>월&nbsp;                        
                                    </span>
                                    <span class="search-box">&emsp;&emsp;&emsp;&emsp;&emsp;총계획기간 :&nbsp;
                                        <select id="st_year" class="select_cont70">
                                            <option value="st_year"><****></option>
                                        </select>&emsp;~&emsp;
                                        <select id="end_year" class="select_cont70">&nbsp;
                                            <option value="end_year"><****></option>
                                        </select>                         
                                    </span>
                                </div>
                                <div>
                                    <span class="search-box">수립조정관계자 :&nbsp;                             
                                        <input type="text" id="person" name="" class="" style="width:309px;">                   
                                    </span>                                    
                                    <span class="search-box">&emsp;&emsp;&emsp;&emsp;수립(조정)일 현재 충당금잔액 :&nbsp;                             
                                        <input type="text" id="balance" name="" class="" style="width:150px;">                   
                                    </span>
                                </div>
                            </form>                                               
                        </div> 
                    </div>
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>공사종별수립기준</span>
                        <span class="section_middle_btn">
                            <input type="checkbox" id="layer_popup3" class="layer_popup">
                            <label for="layer_popup3" class="pop_labal popup_btn">공사종별추가</label>
                             <!-- 팝업시작--> 
                            <div class="layer_bg">
                                <div class="popup" style="width:900px;">
                                    <div class="pop_title">&#10004; 공사종별추가</div>
                                    <form action="." method="post">
                                        <span>&emsp;&#9726&nbsp;검색조건 :&nbsp;</span>

                                        <span class="select-container">&emsp;
                                            <select id="jan_label_1" name="" class="select_cont150">
                                                <option value="jan_label_1"><****></option>
                                            </select>
                                        </span>
                                        <span class="select-container">&emsp;
                                            <select id="jan_label_2" name="" class="select_cont150">
                                                <option value="jan_label_2"><****></option>
                                            </select>
                                        </span>
                                        <span class="select-container">&emsp;
                                            <select id="jan_label_3" name="" class="select_cont150">
                                                <option value="jan_label_3"><****></option>
                                            </select>
                                        </span>
                                        <span class="select-container">&emsp;시행규칙 :&nbsp;
                                            <select id="rule" name="" class="select_cont70">
                                                <option value="all">전체</option>
                                                <option value="yes">Y</option>
                                                <option value="no">N</option>
                                            </select>
                                        </span>                                                                 
                                        <span class="section_middle_btn">
                                            <button id="search_btn" onclick="">검색</button>&emsp;
                                        </span>
                                    </form>                                   
                                    <div id=""  style="height: 600px; border: 1px solid #bcbcbc;">
                                        <div id="" name="">
                                            선택 code 공사종별 ... 그리드
                                        </div>
                                    </div>&emsp;&#9726&nbsp;이미 선택된 공사종별도 추가선택 저장이 가능합니다.
                                    <div>
                                    </div>
                                    <div class="pop_btn">
                                        <button id="save_btn" onclick="">저장</button>
                                        <label for="layer_popup3" class="popup_closs_btn">닫기</label>                    
                                    </div>
                                </div>
                            </div>
                            <!-- 팝업끝--> 
                        </span>
                    </div>
                    <div style="height: 489px; border: 1px solid #bcbcbc;">
                        <div id="gongchu" class="">
                            선택된 공사종별을 나타내는 그리드영역
                        </div>
                    </div>
                </div>
            </div>            
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>