<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "soo_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>장기수선계획등록
                </div>
                 <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="search-box">수립조정년월 :&nbsp;
                            <select id="year_month" class="select_cont100">
                                <option value="year_month"><****></option>  <!-- ****-** -->  
                            </select>&emsp;                       
                        </span>
                        <span class="select-container">&emsp;
                            <select id="jan_label_1" class="select_cont150">
                                <option value="jan_label_1"><****></option> <!-- 예) 건물외부  전체우선-->  
                            </select>
                        </span>
                        <span class="select-container">&emsp;
                            <select id="jan_label_2" class="select_cont150"> 
                                <option value="jan_label_2"><****></option> <!-- 예) 지붕 전체우선-->  
                            </select>
                        </span>
                        <span class="select-container">&emsp;
                            <select id="jan_label_3" class="select_cont150"> 
                                <option value="jan_label_3"><****></option> <!-- 예) 방수 전체우선-->  
                            </select>
                        </span>
                        <span id="" class="search-box">&emsp;&emsp;&emsp;&#9726&nbsp;최초설치년월 :&nbsp;<****>  <!-- ****년 **월-->                     
                        </span>                       
                    </form>
                </div>
            </div>
            <div id="" class="">
                <div class="gridcont_left_400">
                    <div style="height: 611px; border: 1px solid #bcbcbc;">
                        <div id="" name="" class="">
                            공사종별선택 그리드영역
                        </div>
                    </div>
                </div>
                <div class="gridcont_right_670">
                    <div class="section_middle_title" >
                        <div style="line-height:20px; padding-top:5px;"><i class="icon-pause"></i>공사종별 :&nbsp;<****> 
                        </div> <!--선택된 공사종별 표시-->                        
                        <div>
                            <span id="">&nbsp;&#9726 전면 <****>&nbsp;&#9726 부분 <****> <span>            
                            <!--선택된 공사종별이 시행규칙 YES 면 공사종별에 대한 수선주기 수선율 표시  예 * 전면 : 15년(100%) * 부분 : 5년(10%)-->
                            <span id="">&nbsp;&#9726 시행규칙 [별표1] 장기수선계획 수립기준에 없는 공사종별임. <span> 
                            <!-- YES 아니면 이줄 표시--> 
                            <span class="section_middle_btn">
                                <button id="save_btn" onclick="">저장</button>
                                <button id="del_btn" onclick="" class="del_btn">삭제</button>                           
                            </span>
                        </div>
                    <div>
                        <form action="." method="post">
                            <table id="" >
                                <tbody class="soo02020_tb1" >
                                    <tr>
                                        <th style="width: 150px;">구분</th>
                                        <th style="width: 260px;">전면</th>
                                        <th style="width: 260px;">부분</th>
                                    </tr>
                                    <tr>
                                        <th>수선주기(년)등록</th>
                                        <td><input type="text" id="" name="" class="box50"></td>
                                        <td><input type="text" id="" name="" class="box50"></td>
                                    </tr>
                                    <tr>
                                        <th>수선율(%)등록</th>
                                        <td><input type="text" id="" name="" class="box50"></td>
                                        <td><input type="text" id="" name="" class="box50"></td>
                                    </tr>
                                    <tr>
                                        <th>최종수선년도</th>
                                        <td><select id="jeon_year" class="box70">
                                            <option  value="year"><****></option>
                                        </select>
                                        </td>
                                        <td><select id="boo_year" class="box70">
                                            <option  value="year"><****></option>
                                        </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>수선예정년도</th>   <!--최종이 있으면 최종 + 주기 , 없으면 최초년도 + 주기--> 
                                        <td><****></td>
                                        <td><****></td>
                                    </tr>
                                    <tr>
                                        <th>수선계획금액</th>  <!--수정가능 저장-->
                                        <td style=text-align:right;><****></td> 
                                        <td style=text-align:right;><****></td>
                                    </tr>
                                    <tr>
                                        <th>실시 및 계획 (전면)</th>
                                        <td colspan="2"><input type="text" id="" name="" ></td>
                                    </tr>
                                    <tr>
                                        <th>실시 및 계획 (부분)</th>
                                        <td colspan="2"><input type="text" id="" name=""></td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>수선항목</span>
                        <span class="section_middle_btn">
                            <input type="checkbox" id="layer_popup" class="layer_popup">
                            <label for="layer_popup" class="pop_labal popup_btn">단가등록</label>
                             <!-- 팝업시작--> 
                            <div class="layer_bg">
                                <div class="popup" style="width:800px;">
                                    <div class="pop_title">&#10004; 단가등록
                                    </div>
                                    <div id="">
                                    &#9726&nbsp;<****> </span>&emsp;  <!-- 예) 1. 건물외부 > 지붕 > 고분자도막방수--> 
                                    </div>
                                    <div id="" class="pop_edit_content" style="height:300px; border: 1px solid #bcbcbc;">
                                    관리자 단가설정된 것 불러오는 edit 읽기 창
                                    </div>
                                    <div id=""  style="margin-top:10px; height: 263px; border: 1px solid #bcbcbc;">
                                        <div id="" name="">
                                            품목 규격 단위 수량 적용단가를 입력하는 그리드영역
                                        </div>
                                    </div>
                                    <div class="pop_btn">
                                        <button id="add_btn" onclick="">추가</button>
                                        <button id="del_btn" onclick="">삭제</button>
                                        <button id="save_btn" onclick="">저장</button>
                                        <label for="layer_popup" class="popup_closs_btn">닫기</label>                    
                                    </div>
                                </div>
                            </div>
                            <!-- 팝업끝-->
                        </span> 
                    </div>
                    <div style="height: 257px; border: 1px solid #bcbcbc;">
                        <div id="" name="" class="">
                                수선항목 그리드영역
                        </div>
                    </div>
                </div>
            </div>            
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>