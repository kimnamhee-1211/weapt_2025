<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "jan_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-cog-alt"></i>장비이력카드</div>
                <div class="section1_btn">
                    <button id="find_btn" onclick="">사진찾기</button>
                    <button id="save_btn" onclick="">저장</button>
                    <button id="add_btn" onclick="">추가</button>
                    <button id="closs_btn" onclick="" class="closs_btn">폐기</button>                                
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                    <button id="list_btn" onclick=""><a href="jan01010.jsp">목록</a></button>
                    <!--전기실이면 전기실목록 방재실이면 방재실목록 찾아가기 -->  
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="search-box">장비명선택 :&nbsp;
                            <select id="year_month" class="select_cont300">
                                <option value="year_month"><****></option>  <!--no 장비명(규격) -->  
                            </select>
                        </span>                    
                    </form>
                </div> 
            </div>
            <div style=height:282px;>
                <div id="sajin" class="gridcont_left_535">
                    <div class="jangbi_sajin" style="height: 280px; border: 1px solid #bcbcbc;">
                    사진
                    </div>
                </div>
                <div id="jangbi_note" class="gridcont_right_535">
                    <form action="." method="post">
                        <table class="jan01015_table">
                            <tbody>
                                <tr>
                                    <th style="width:100px;">관리번호</th>
                                    <td style="width:433px;"><input type="text"></td>
                                </tr>
                                <tr>
                                    <th>장비명</th>
                                    <td><input type="text"></td>
                                </tr>
                                <tr>
                                    <th>규격</th>
                                    <td><input type="text"></td>
                                </tr>
                                <tr>
                                    <th>형식</th>
                                    <td><input type="text"></td>
                                </tr>
                                <tr>
                                    <th>제원</th>
                                    <td><input type="text"></td>
                                </tr>
                                <tr>
                                    <th>제조사</th>
                                    <td><input type="text"></td>
                                </tr>
                                <tr>
                                    <th>설치일</th>
                                    <td><input type="date"></td>
                                </tr>
                                <tr>
                                    <th style="height:62px;">비고</th>
                                    <td> <textarea class="jan01015_textarea"></textarea></td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>            
            <div>
                <div class="section_middle_title">                
                    <span> <i class="icon-edit"></i>고장발생 및 처리내역 기록사항</span>

                    <span class="section1_nav_mic">&emsp;
                        <i class="icon-mic"></i>처리금액이 발생된 정비내역 만 기록합니다. 
                    </span>                
                
                    <span class="section_middle_btn" >
                        <button id="">추가</button>
                    </span>                 
                </div>                            
                <div id="">
                    <div style="height: 289px; border: 1px solid #bcbcbc;">
                        그리드 구역입니다
                    </div>
                </div>
            </div>           
        </div>                     
    </div>

<%@ include file = "../../inc_footer.jsp" %>