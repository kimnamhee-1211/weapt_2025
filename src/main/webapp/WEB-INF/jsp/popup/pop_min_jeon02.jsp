<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

                                <div class="layer_bg">
                                    <div class="popup" style="width: 740px;">
                                        <div class="pop_title">&#10004; 공용민원전표</div>   
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
                                                            <col style ="width:32%">
                                                            <col style ="width:12%">
                                                            <col style ="width:16%">
                                                            <col style ="width:12%">
                                                            <col style ="width:16%">
                                                    </colgroup>
                                                    <tbody id="min_tb_01">
                                                        <tr>
                                                            <th>장소</th>
                                                            <td>
                                                                <input type="" id="" class="box30">동
                                                                <input type="" id="" class="box20">열
                                                                <input type="" id="" class="box20">층
                                                                <input type="" id="" class="box50">
                                                            </td>
                                                             <%-- 민원인과 연락처는 세대정보등록에서 가져오고 수정가능 --%>
                                                            <th>민원인</th>
                                                            <td ><****></td>
                                                            <th>연락처</th>
                                                            <td ><****></td>

                                                        </tr>
                                                        <tr>
                                                            <th>접수일시</th>
                                                            <td colspan="3">
                                                                <span><input type="date" id="today" value="<%= today %>"></span>&emsp;&emsp;
                                                                <%-- 환경설정에 체크되어 있으면 서버 현재시간 가져오기 --%>
                                                                <span><input type="checkbox" id="check1">
                                                                <label for="check1">시간선택 :</label></span> 
                                                                <%-- 체크되면 시,분 보여지기 --%>                            
                                                                <span>&ensp;
                                                                <select id="time" class="box50">
                                                                    <option  value="time"><****></option>
                                                                </select>시&ensp;&nbsp;&nbsp;
                                                                <select id="minute" class="box50">&nbsp;
                                                                    <option value="minute"><****></option>
                                                                </select>분&ensp;                      
                                                                </span>                                                                                            
                                                            </td>
                                                            <th>전표번호</th>
                                                            <%-- 오늘날짜 순번으로 자동생성 --%> 
                                                            <td><****></td>
                                                        </tr>
                                                        <tr>
                                                            <th>접수자</th>
                                                            <td>
                                                                <select id="">
                                                                    <%-- 직원등록 민원 YES 선택할 수 있게 --%> 
                                                                    <option  value=""><****></option>
                                                                    <option  value="">직접입력</option>
                                                                </select>
                                                            </td>
                                                            <td colspan="4">
                                                                <input type="" id="" >
                                                            </td>
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
                                                            <td colspan="5">
                                                                <div class="find_td">
                                                                <%-- 찾은 사진 리스트 (여러개 선택할 수 있게) 하나씩 삭제도 할 수 있게 --%>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div>
                                                <i class="icon-mic"></i>사진첨부는 2개까지 가능합니다.
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
                                                                <span><input type="date" id="today" value="<%= today %>"></span>&emsp;&emsp;
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
                                                <label for="layer_popup2" class="popup_closs_btn">닫기</label>                       
                                            </div>
                                        </div>
                                    </div>
                                </div>
                               