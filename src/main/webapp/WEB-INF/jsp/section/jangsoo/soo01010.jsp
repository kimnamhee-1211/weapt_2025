<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "soo_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>단지개요
                </div>
                <div class="section1_btn">
                    <button id="save_btn" onclick="">저장</button>                  
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>  
                </div>
            </div>
            <div class="section2">
                <div class="section2_line0"></div>
            </div>
            <div id="" class="soo01010_tb">
                <form action="." method="post">
                    <div>
                        <i class="icon-th-large"></i>단지개요
                    </div>
                    <table id="soo01010_tb01">
                        <tbody>
                            <tr>
                                <th style="width: 150px;">명칭</th>
                                <td style="width: 387px;"><input type="text" id="house_name" name="house_name" class="" maxlength = "100"></td>
                                <th style="width: 150px;">사용승인일</th>
                                <td style="width: 387px;"><input type="date" id="sooSayong" name="" class=""></td>
                            </tr>
                            <tr>
                                <th>도로명주소</th>
                                <td><input type="text" id="sooDoro" name="" class=""></td>
                                <th>법정동주소</th>
                                <td><input type="text" id="sooBeopjong" name="" class=""></td>
                            </tr>
                            <tr>
                                <th>시공사/시행사</th>
                                <td><input type="text" id="sooSigong" name="" class=""></td>
                                <th>분양형태</th>
                                <td><input type="text" id="soobunyang" name="" class=""></td>
                            </tr>
                            <tr>
                                <th>대지면적</th>
                                <td><input type="text" id="soodaeji" name="" class=""></td>
                                <th>동수/세대수</th>
                                <td><input type="text" id="soodongsoo" name="" class=""></td>
                            </tr>
                            <tr>
                                <th>연면적/용적율</th>
                                <td><input type="text" id="sooyenmyen" name="" class=""></td>
                                <th>건축면적/건페율</th>
                                <td><input type="text" id="soogeonmyen" name="" class=""></td>
                            </tr>
                            <tr>
                                <th>건물구조</th>
                                <td><input type="text" id="soogeonmul" name="" class=""></td>
                                <th>복도유형</th>
                                <td><input type="text" id="soobugdo" name="" class=""></td>
                            </tr>
                            <tr>
                                <th>급수방식</th>
                                <td><input type="text" id="soogeupsoo" name="" class=""></td>
                                <th>난방방식</th>
                                <td><input type="text" id="soonanbang" name="" class=""></td>
                            </tr>
                        </tbody>
                    </table>
                    <div>
                        <i class="icon-th-large"></i>부대시설 및 설비
                    </div>    
                    <table id="soo01010_tb02">
                        <tbody>
                            <tr>
                                <th style="width: 150px;">관리사무소면적</th>
                                <td style="width: 387px;"><input type="text" id="soogwansa" name="" class=""></td>
                                <th style="width: 150px;">경로당면적</th>
                                <td style="width: 387px;"><input type="text" id="soogyoungro" name="" class=""></td>
                            </tr>
                            <tr>
                                <th>어린이놀이시설</th>
                                <td><input type="text" id="sooeorin" name="" class=""></td>
                                <th>주민운동시설</th>
                                <td><input type="text" id="soojoomin" name="" class=""></td>
                            </tr>
                            <tr>
                                <th>주차대수(지상/지하)</th>
                                <td><input type="text" id="soojoocha" name="" class=""></td>
                                <th>저수조용량</th>
                                <td><input type="text" id="soojeosoojo" name="" class=""></td>
                            </tr>
                            <tr>
                                <th>승강기(제조사/대수)</th>
                                <td><input type="text" id="sooseunggang" name="" class=""></td>
                                <th>화재수신반방식</th>
                                <td><input type="text" id="soohwajae" name="" class=""></td>
                            </tr>
                            <tr>
                                <th>수전용량</th>
                                <td><input type="text" id="soosoojeon" name="" class=""></td>
                                <th>발전기용량</th>
                                <td><input type="text" id="soobaljeon" name="" class=""></td>
                            </tr>
                        </tbody>
                    </table>
                    <div>
                        <i class="icon-th-large"></i>기타
                    </div>
                    <div class="custom_textarea">
                        <textarea  id="soogita" name="" class="soo01010_textarea"></textarea>
                    </div>
                </form>
            </div>            
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>