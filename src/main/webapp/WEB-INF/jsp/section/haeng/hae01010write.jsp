<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

        <div id="section">
            <div class="section1">    <%--처음 작성 페이지 그리고 그리드 클릭으로 써진 것 나올때 사용--%> 
                <span class="section1_nav"><i class="icon-home"></i>기안용지</span>
                <div class="section1_btn">
                    <button id="save_btn" onclick="">저장</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                    <input type="checkbox" id="layer_popup" class="layer_popup">
                    <label for="layer_popup" class="pop_labal popup_btn" >복사</label>
                    <!-- 복사 팝업시작--> 
                    <%@ include file = "../../popup/pop_print.jsp" %>
                    <!-- 팝업끝-->
                    <button id="del_btn" onclick="" class="del_btn">삭제</button>
                    <button id="list_btn" onclick=""><a href="hae01010.jsp">목록</a></button>                                          
                </div>
            </div>
            <div class="section2">
                <div class="section2_line0">
                </div>
            </div>
            <div class="gridcont_left_870">
                <div class="">
                    <form action="." method="post">  
                        <table>
                            <colgroup>
                                    <col style ="width:104px;">
                                    <col style ="width:191px;">
                                    <col style ="width:35px;">
                                    <col style ="width:540px;">
                                    
                            </colgroup>
                            <tbody>
                                
                                <tr>
                                    <th>문서번호</th>
                                    <td>
                                        <input type="text" id="" name="no_1" value="" class="box70">-
                                        <input type="text" id="" name="no_2" value="" class="box70">
                                    </td>
                                    <th rowspan="3">결<br>재</th>
                                    <td colspan="3" rowspan="3">결재란</td>
                                </tr>
                                <tr>
                                    <th>기안일자</th>
                                    <td><input type="date" id="today" value="<%= today %>"></td>
                                </tr>
                                    <th>시행기간</th>
                                    <td><input type="text" id="" value=""></td>
                                </tr>
                            </tbody>
                        </table>
                        <table>
                            <colgroup>
                                <col style ="width:12%;">
                                <col style ="width:22%;">
                                <col style ="width:12%;">
                                <col style ="width:21%;">
                                <col style ="width:12%;">
                                <col style ="width:21%;">
                            </colgroup>
                            <tbody >
                                <tr>
                                    <th style="border-top: none;">보존년한</th>
                                    <td style="border-top: none;">
                                        <input type="text" id="" name="" value="" class="">
                                    </td>
                                    <th style="border-top: none;">협 &emsp;  조</th>
                                    <td style="border-top: none;">
                                        <input type="text" id="" name="" value="" class="">
                                    <th style="border-top: none;">공 &emsp;  람</th>
                                    <td style="border-top: none;">
                                        <input type="text" id="" name="" value="" class="">
                                    </td>
                                </tr>
                                <tr>
                                    <th rowspan="2">기안자</th>
                                    <td rowspan="2">
                                        <input type="text" id="" name="" value="" class="">
                                    </td>
                                    <th rowspan="2">수 &emsp; 신<br>경 &emsp; 유<br>참 &emsp; 조</th>
                                    <td rowspan="2">
                                        <input type="text" id="" name="" value="" class="">
                                    <th>발 &emsp; 신</th>
                                    <td>
                                        <input type="text" id="" name="" value="" class="">
                                    </td>
                                </tr>
                                    <th>통 &emsp; 제</th>
                                    <td>
                                        <input type="text" id="" name="" value="" class="">
                                    </td>
                                </tr>
                                </tr>
                                    <th>제목</th>
                                    <td colspan="5">
                                        <input type="text" id="" name="" value="" class="">
                                    </td>
                                </tr>
                            </tbody>
                        </table>                        
                    </form>
                </div>
                <div style="height: 434px; border: 1px solid #bcbcbc;">
                    <div id="" name="">
                        줄있는 그리드 ( 한페이지 그리드 - 우측 스크롤바 보임)
                    </div>
                </div>
            </div>
            <div class="gridcont_right_200">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>파일</span>
                    <div class="section_middle_btn" style="height:28px;">
                        <%--<form action="/upload" method="post" enctype="multipart/form-data">--%>

                        <input type="file" id="fileInput" multipart />
                        <button class="find_btn" id="selectFileBtn">파일찾기</button>

                            <span class="file-list" id="fileList"></span>

                        <%--</form>--%> 
                        <button id="del_btn" onclick="" >삭제</button>
                    </div>
                </div>
                <div id=""  style="height: 250px; border: 1px solid #bcbcbc;">
                    선택 | 파일명 (그리드)
                </div>
                <i class="icon-mic"></i>첨부파일 - 최대 7개<br><br>


                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>지시사항</span>
                    <div class="section_middle_btn" style="height:28px;">
                        <button id="save_btn" onclick="">등록</button>
                    </div>
                </div>
                <div id=""  style="height: 250px; border: 1px solid #bcbcbc;">
                    <textarea calss=""> </textarea>
                </div>
            </div>
        </div>
    </div>
