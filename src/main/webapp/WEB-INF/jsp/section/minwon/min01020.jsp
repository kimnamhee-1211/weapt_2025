<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "min_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-phone-squared"></i>민원처리</span>
                    <span class="section1_nav_mic">&emsp;
                        <i class="icon-mic"></i>검색 후 그리드 행을 클릭하면 해당 민원 접수 처리내역을 볼 수 있고 바로 수정 저장이 가능합니다.
                    </span>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span>조회기간 :&nbsp; <!-- 기간은 2일 어제 오늘-->
                            <input type="date" id="yesterday" value="<%= yesterday %>">&nbsp;~&nbsp;
                            <input type="date" value="<%= today %>">                         
                        </span>
                        <span class="">&emsp;
                            <input  type="checkbox" checked="checked" id="">&nbsp;최근일자순&emsp;
                        </span>
                    </form>                                               
                </div> 
            </div>
            <div id="" class="gridcont_left_350" style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="" >
                접수 그리드
                </div>
            </div>
            <div id="min_tb" class="gridcont_right_720">
                <form action="." method="post"> 
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>접&ensp;수</span>
                        <span class="section_middle_btn">
                            <button id="find_btn" onclick="" class="find_btn">메시지전송</button>  
                             <%-- 설정에서 선택해야 나옴 --%>
                        </span>
                    </div>
                    <table style="width:720px;">
                        <colgroup>
                            <col style ="width:12%">
                            <col style ="width:30%">
                            <col style ="width:12%">
                            <col style ="width:17%">
                            <col style ="width:12%">
                            <col style ="width:17%">
                        </colgroup>
                        <tbody id="min_tb_01">
                            <tr>
                                <th>동호(장소)</th>
                                <td><****></td>
                                <th>민원인</th>
                                <td ><****></td>
                                <th>연락처</th>
                                <td ><****></td>

                            </tr>
                            <tr>
                                <th>접수일시</th>
                                <td><****> <****></td>
                                <th>전표번호</th>
                                <td><****></td>
                                <th>접수자</th>
                                <td><****></td>
                            </tr>
                            <tr>
                                <th>접수내역</th>
                                <td colspan="5" class="min_memo">
                                    <textarea id="" class="min01020_textarea"><****></textarea>
                                </td>
                            </tr>
                            <tr>
                                <th><button id="find_btn01" onclick="" class="find_btn_m">사진찾기</button>
                                </th>
                                <td colspan="5" class="find_td">
                                    <div class="find_td">
                                    <%-- 찾은 사진 리스트 (여러개 선택할 수 있게) 하나씩 삭제도 할 수 있게 --%>
                                    예시) 찾은사진 1 [ 삭 제 ] <br>
                                    찾은사진 2 [ 삭 제 ] <br>
                                    찾은사진 2 [ 삭 제 ] <br>
                                    찾은사진 2 [ 삭 제 ] <br>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div>
                    <i class="icon-mic"></i>접수내역 수정 및 사진첨부는  할 수 있습니다.
                    </div>
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>처&ensp;리</span>
                        <span class="section_middle_btn">
                            <button id="find_btn" onclick="" class="find_btn">소모품사용</button>  
                            <%-- 설정에서 선택해야 나옴 --%>
                            <button id="find_btn" onclick="" class="find_btn">계량기사용</button>  
                            <%-- 설정에서 선택해야 나옴 --%>                        
                        </span>                    
                    </div> 
                    <table style="width:720px;">
                            <colgroup>
                                <col style ="width:12%">
                                <col style ="width:24%">
                                <col style ="width:12%">
                                <col style ="width:20%">
                                <col style ="width:12%">
                                <col style ="width:20%">
                            </colgroup>                        
                        <tbody id="min_tb_02">
                            <tr>
                                <th>처리일시</th>
                                <td colspan="3">
                                    <span><input type="date" id="" name=""></span>&emsp;&emsp;
                                    <span><input type="checkbox" id="check1">
                                    <label for="check1">시간선택 :</label></span>                               
                                    <span>&ensp;
                                    <select id="time" class="box50">
                                        <option  value="time"><****></option>
                                    </select>시&ensp;&nbsp;&nbsp;
                                    <select id="minute" class="box50">&nbsp;
                                        <option value="minute"><****></option>
                                    </select>분&ensp;                      
                                    </span>                            
                                    
                                </td>
                                <th>구분</th>
                                <td>  
                                    <select id="gubun">
                                        <option  value="gubun"><****></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>상태</th>
                                <td style="width: 100px;">
                                    <select id="condition" >&nbsp;
                                        <option value="condition"><****></option>
                                    </select>
                                </td>
                                <th>처리자</th>
                                <td>
                                    <select id="condition" >&nbsp;
                                        <option value="condition"><****></option>
                                    </select>                                
                                </td>
                                <td colspan="2"><input type="" id="" name="" ></td>
                            </tr>
                            <tr>
                                <th>처리내역</th>
                                <td colspan="5" class="min_memo">
                                    <textarea id="" class="min01020_textarea"><****></textarea>
                                </td>
                            </tr>
                            <tr>
                                <th><button id="find_btn01" onclick="" class="find_btn_m">사진찾기</button>
                                </th>
                                <td colspan="5" class="find_td">
                                    <div class="find_td">
                                    <%-- 찾은 사진 리스트 (여러개 선택할 수 있게) 하나씩 삭제도 할 수 있게 --%>
                                    예시) 찾은사진 1 [ 삭 제 ] <br>
                                    찾은사진 2 [ 삭 제 ] <br>
                                    찾은사진 2 [ 삭 제 ] <br>
                                    찾은사진 2 [ 삭 제 ] <br>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>                    
                </form>
                <div class="pop_btn">
                    <button id="save_btn" onclick="">저장</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                    <button id="del_btn" onclick="" class="del_btn">삭제</button>                     
                </div>
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>