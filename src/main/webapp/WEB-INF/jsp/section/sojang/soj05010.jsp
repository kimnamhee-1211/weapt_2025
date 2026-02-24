<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/sojang/soj_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-star-filled"></i>장기수선공사종별등록
                </div>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <input type="checkbox" id="layer_popup" class="layer_popup">
                    <label for="layer_popup" class="pop_labal popup_btn">구분추가</label> <!-- 선택 또는 안하고-->
                    <!-- 변경 팝업시작--> 
                    <div class="layer_bg">
                        <div class="popup" style="width:520px;">
                            <div class="pop_title">&#10004;장기수선구분등록</div> 
                            <form action="." method="post">
                                <table id="" >
                                    <tbody>
                                    <tr>
                                        <th style="width: 100px;">사용</th>
                                        <td style="width: 400px;">
                                            <select id="" name="" class="select_cont70">
                                                <option value="">사용</option>
                                                <option value="">미사용</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>코드</th>
                                        <td><****></td>
                                    </tr>
                                    <tr>
                                        <th>정렬순서</th>
                                        <td><****></td>
                                    </tr>
                                    <tr>
                                        <th>구분</th>
                                        <td><input type="text" id="text" name="" class=""></td>
                                    </tr>
                                    <tr>
                                        <th>비고</th>
                                        <td><input type="text" id="text" name="" class=""></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </form>
                            <div class="pop_btn">
                                <button id="save_btn" onclick="">저장</button>
                                <label for="layer_popup" class="popup_closs_btn">닫기</label>                    
                            </div>
                        </div>
                    </div>
                    <!-- 팝업끝--> 


                    <input type="checkbox" id="layer_popup2" class="layer_popup">
                    <label for="layer_popup2" class="pop_labal popup_btn">종별추가</label><!-- 선택 또는 안하고-->
                    <!-- 변경 팝업시작--> 
                    <div class="layer_bg">
                        <div class="popup" style="width:520px;">
                            <div class="pop_title">&#10004;장기수선공사종별등록</div>
                            <form action="." method="post">
                                <table id="" >
                                    <tbody>
                                    <tr>
                                        <th style="width: 100px;">사용</th>
                                        <td style="width: 400px;">
                                            <select id="" name="" class="select_cont70">
                                                <option value="">사용</option>
                                                <option value="">미사용</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>코드</th>
                                        <td><****></td>
                                    </tr>
                                    <tr>
                                        <th>정렬순서</th>
                                        <td><****></td>
                                    </tr>
                                    <tr>
                                        <th>공사종별</th>
                                        <td><input type="text" id="code" name="" class=""></td>
                                    </tr>
                                    <tr>
                                        <th>간단명칭</th>
                                        <td><input type="text" id="code" name="" class=""></td>
                                    </tr>
                                    <tr>
                                        <th>시행규칙</th>
                                        <td><select id="" name="" class="select_cont70">
                                                <option value="">YES</option>
                                                <option value="">NO</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>전면명칭</th>
                                        <td><input type="text" id="code" name="" class=""></td>
                                    </tr>
                                    <tr>
                                        <th>전면주기(년)</th>
                                        <td><input type="text" id="code" name="" class=""></td>
                                    </tr>
                                    <tr>
                                        <th>부분해당</th>
                                        <td><select id="" name="" class="select_cont70">
                                                <option value="">YES</option>
                                                <option value="">NO</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>부분명칭</th>
                                        <td><input type="text" id="code" name="" class=""></td>
                                    </tr>
                                    <tr>
                                        <th>부분주기(년)</th>
                                        <td><input type="text" id="code" name="" class=""></td>
                                    </tr>
                                    <tr>
                                        <th>부분율(%)</th>
                                        <td><input type="text" id="code" name="" class=""></td>
                                    </tr>
                                    <tr>
                                        <th>비고</th>
                                        <td><input type="text" id="code" name="" class=""></td>
                                    </tr>

                                    </tbody>
                                </table>
                            </form>
                            <div class="pop_btn">
                                <button id="new_save_btn" onclick="">저장</button>
                                <label for="layer_popup2" class="popup_closs_btn">닫기</label>                    
                            </div>
                        </div>
                    </div>
                    <!-- 팝업끝--> 
                    <button id="del_btn" onclick="">삭제</button>  
                    <button id="save_btn" onclick="">저장</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="select-container">검색조건 : &nbsp;
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
                    </form>
                </div>
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    장기수선항목등록 그리드영역
                </div>
            </div>           
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>