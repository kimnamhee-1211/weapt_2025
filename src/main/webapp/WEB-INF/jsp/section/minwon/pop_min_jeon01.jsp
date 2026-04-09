<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div class="layer_bg" id="pop_min_jeon01">
        <div class="popup" style="width: 740px;">
            <div class="pop_title">&#10004; 세대민원전표</div>
            <div class="pop_btn" id="pop1_btn"></div>
            <div id="min_tb" class="gridcont_right_720">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>접&ensp;수</span>
                    <span class="section_middle_btn">
                        <button id="find_btn" onclick="">사진찾기</button>
                        <button id="mms_btn" onclick="" class="mms_btn">메시지전송</button>
                        <%-- mms_btn은 설정에서 선택해야 나옴 --%>
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
                            <th>동호</th>
                            <td>
                                <input type="text" id="input_dongName" name="DONG_NAME" class="box50">동
                                <input type="text" id="input_ho" name="HO" class="box50">호
                            </td>
                             <%-- 민원인과 연락처는 세대정보등록에서 가져오고 수정가능 --%>
                            <th>민원인</th>
                            <td ><input type="text" id="input_householder"></td>
                            <th>연락처</th>
                            <td><input type="text" id="input_hpNo"></td>
                        </tr>
                        <tr>
                            <th>접수일시</th>
                            <td colspan="3">
                                <span><input type="date" id="input_minwonDate" name="MINWON_DATE" data-format="date"></span>&emsp;&emsp;
                                <%-- 환경설정에 체크되어 있으면 서버 현재시간 가져오기 --%>
                                <span>
                                    <input type="checkbox" id="input_timeInput" name="TIME">
                                    <label for="input_timeInput">시간선택 :</label>
                                </span>
                                <%-- 체크되면 시,분 보여지기 --%>
                                <span>&ensp;<input type="time" id="input_time" name="SLIP_NO" class="box50"></span>
                            </td>
                            <th>전표번호</th>
                            <%-- 오늘날짜 순번으로 자동생성 --%>
                            <td><input type="text" id="input_slipNo" name="SLIP_NO"></td>
                        </tr>
                        <tr>
                            <th>접수자</th>
                            <td>
                                <select id="input_receiptUser" name="RECEIPT_USER">
                                    <option value="">직접입력</option>
                                </select>
                            </td>
                            <td colspan="4">
                                <input type="text" id="input_receiptUserName">
                            </td>
                        </tr>
                        <tr>
                            <th>접수내역</th>
                            <td colspan="5" class="min_memo">
                                <textarea id="input_descr" name="DESCR" class="min01020_textarea"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>사진파일</th>
                            <td colspan="5">
                                <div class="find_td">
                                <%-- 찾은 사진 리스트 (여러개 선택할 수 있게) 하나씩 삭제도 할 수 있게 --%>
                                예시) 찾은사진 1 [ 삭 제 ] <br>
                                찾은사진 2 [ 삭 제 ] <br>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>처&ensp;리</span>
                    <span class="section_middle_btn">
                        <button onclick="">사진찾기</button>
                        <button  onclick="" class="find_btn">소모품사용</button>
                        <%-- 설정에서 선택해야 나옴 --%>
                        <button  onclick="" class="find_btn">계량기사용</button>
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
                                <span><input type="date" id="input_workDate" name="WORK_DATE" data-format="date"></span>&emsp;&emsp;
                                <span>
                                    <input type="checkbox" id="input_workTimeInput" name="TIME_INPUT">
                                    <label for="input_workTimeInput">시간선택 :</label>
                                </span>
                                <span>&ensp;<input type="time" id="input_workTimeInputName"></span>
                            </td>
                            <th>구분</th>
                            <td>
                                <select id="gubun">
                                    <option value="gubun"></option>
                                </select>
                            </td>

                        </tr>
                        <tr>
                            <th>상태</th>
                            <td style="width:100px;">
                                <select id="input_statusCd" name="STATUS_CD">
                                    <option value="condition"></option>
                                </select>
                            </td>
                            <th>처리자</th>
                            <td>
                                <select id="input_workUser" name="WORK_USER">
                                    <option value="condition"></option>
                                </select>
                            </td>
                            <td colspan="2"><input type="text" id="input_workUserName"></td>
                        </tr>
                        <tr>
                            <th>처리내역</th>
                            <td colspan="5" class="min_memo">
                                <textarea id="input_workDesc" name="WORK_DESC" class="min01020_textarea"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>사진파일</th>
                            <td colspan="5" class="find_td">
                               <div class="find_td">
                                <%-- 찾은 사진 리스트 (여러개 선택할 수 있게) 하나씩 삭제도 할 수 있게 --%>
                                예시) 찾은사진 1 [ 삭 제 ] <br>
                                찾은사진 2 [ 삭 제 ] <br>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>



<script>
    const popupId1 = "pop_min_jeon01";
    let querySet1;
    let pop_data1;

    //팝업 컴포넌트
    const pop1_btn = document.querySelector("#pop1_btn");


    function search_pop1_onclick(){

        let selectParam = {
            SLIP_NO : pop_data1.slipNo,
            MINWON_DATE : pop_data1.minwonDate,
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : querySet + "_popGrid1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                dataToInput(data[0], popupId1)



            }
        });
    }

    function pop_onload1(pop_item){
        querySet1 = isNull(pop_item.querySet) ? pop_item.pgId : pop_item.querySet;
        pop_data1 =  pop_item.pop_data

        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#pop1_btn", grid: "pop1", search: true, save : true, del: true, print : true});
        pop1_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");

        if(!isNull(pop_item.btnHidden)){
            btnHidden(pop_item.btnHidden, pop_item.popupId);
        }

        if(!isNull(pop_item.disabled)){
            disableInput(pop_item.popupId);
        }

        if(!isNull(pop_data)){
            search_pop1_onclick();
        }


    }


</script>
