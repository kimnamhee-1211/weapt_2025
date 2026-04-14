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
                <table style="width:720px;" id="minwon_table">
                    <colgroup>
                            <col style ="width:12%">
                            <col style ="width:32%">
                            <col style ="width:12%">
                            <col style ="width:16%">
                            <col style ="width:12%">
                            <col style ="width:16%">
                    </colgroup>
                    <tbody id="min_tb_01">
                        <tr id="info_table">
                            <th>동호</th>
                            <td>
                                <input type="text" id="input_dongName" name="DONG_NAME" class="box50" disabled>동
                                <input type="text" id="input_ho" name="HO" class="box50" disabled>호
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
                                    <input type="checkbox" id="input_timeInput" name="TIME_INPUT">
                                    <label for="input_timeInput">시간선택 :</label>
                                </span>
                                <%-- 체크되면 시,분 보여지기 --%>
                                <span>&ensp;<input type="time" id="input_time" name="TIME" class="box50"></span>
                            </td>
                            <th>전표번호</th>
                            <%-- 오늘날짜 순번으로 자동생성 --%>
                            <td><input type="text" id="input_slipNo" name="SLIP_NO"></td>
                        </tr>
                        <tr>
                            <th>접수자</th>
                            <td>
                                <select id="input_receiptUser" name="RECEIPT_USER"></select>
                            </td>
                            <td colspan="4">
                                <input type="text" id="input_receiptUserName" name="RECEIPT_USER_NAME">
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
                <table style="width:720px;" id="minwonWork_table">
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
                                    <input type="checkbox" id="input_workTimeInput" name="WORK_TIME_INPUT">
                                    <label for="input_workTimeInput">시간선택 :</label>
                                </span>
                                <span>&ensp;<input type="time" id="input_workTime" name="WORK_TIME"></span>
                            </td>
                            <th>구분</th>
                            <td>
                                <select id="input_minownGbn" name="MINOWN_GBN"></select>
                            </td>
                        </tr>
                        <tr>
                            <th>상태</th>
                            <td style="width:100px;">
                                <select id="input_statusCd" name="STATUS_CD">
                                    <option value="1">처리</option>
                                    <option value="2">보류</option>
                                    <option value="3">반려</option>
                                    <option value="4">처리중</option>
                                    <option value="" selected>미결</option>
                                </select>
                            </td>
                            <th>처리자</th>
                            <td>
                                <select id="input_workUser" name="WORK_USER">
                                    <option value="condition"></option>
                                </select>
                            </td>
                            <td colspan="2"><input type="text" id="input_workUserName" name="WORK_USER_NAME"></td>
                        </tr>
                        <tr>
                            <th>처리내역</th>
                            <td colspan="5" class="min_memo">
                                <textarea id="input_workDesc" name="WORK_DESC" class="min01020_textarea"></textarea>
                                <input type="text" id="input_workSeq" name="WORK_SEQ" hidden="hidden">
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
    const minwon_table = document.querySelector("#minwon_table");
    const minwonWork_table = document.querySelector("#minwonWork_table");
    const info_table = document.querySelector("#info_table");

    const input_minwonDate = document.querySelector("#input_minwonDate");
    const input_timeInput = document.querySelector("#input_timeInput");
    const input_time = document.querySelector("#input_time");
    const input_slipNo = document.querySelector("#input_slipNo");
    const input_receiptUser = document.querySelector("#input_receiptUser");
    const input_receiptUserName = document.querySelector("#input_receiptUserName");
    const input_descr = document.querySelector("#input_descr");

    const input_workDate = document.querySelector("#input_workDate");
    const input_workTimeInput = document.querySelector("#input_workTimeInput");
    const input_workTime = document.querySelector("#input_workTime");
    const input_minownGbn = document.querySelector("#input_minownGbn");
    const input_statusCd = document.querySelector("#input_statusCd");
    const input_workUser = document.querySelector("#input_workUser");
    const input_workUserName = document.querySelector("#input_workUserName");
    const input_workDesc = document.querySelector("#input_workDesc");
    const input_workSeq = document.querySelector("#input_workSeq");

    let input_user = []

    function search_input1_onclick(){

        let selectParam = {
            SLIP_NO : pop_data1.slipNo,
            MINWON_DATE : pop_data1.minwonDate,
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : querySet1 + "_input1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                dataToInput(data[0], "minwon_table")
                if (!input_user.some(row => row.NAME == data[0].RECEIPT_USER)) {
                    input_receiptUser.value = "write"
                    input_receiptUserName.value = data[0].RECEIPT_USER
                }
                if(!isNull(data[0].WORK_SEQ)){
                    search_input2_onclick();
                }
            }
        });
    }

    function search_input2_onclick(){

        let selectParam = {
            SLIP_NO : pop_data1.slipNo,
            MINWON_DATE : pop_data1.minwonDate,
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : querySet1 + "_input1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                dataToInput(data[0], "minwonWork_table");
                if (!input_user.some(row => row.NAME == data[0].RECEIPT_USER)) {
                    input_workUser.value = "write";
                    input_workUserName.value = data[0].RECEIPT_USER;
                }
            }
        });
    }


    async function getSelectOption_input_minownGbn() {
        input_minownGbn.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId: sectionId,
            component: querySet1 + "_input_minownGbn",
            param: param,
        }

        let list  = await we_getSelectOption(data);

        if (list) {
            list.forEach(row => {
                input_minownGbn.insertAdjacentHTML("beforeend",
                    "<option value='" + row.GBN_ID + "'>" + row.GBN_NAME + "</option>");
            })
        }
    }

    async function getSelectOption_input_user() {
        input_receiptUser.innerHTML = "";
        input_workUser.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId: sectionId,
            component: querySet1 + "_input_user",
            param: param,
        }

        let list  = await we_getSelectOption(data);
        input_user = list;

        if (list) {
            input_receiptUser.insertAdjacentHTML("beforeend", "<option value='write' selected>직접입력</option>");  //필요시
            input_workUser.insertAdjacentHTML("beforeend", "<option value='write' selected>직접입력</option>");  //필요시
            list.forEach(row => {
                input_receiptUser.insertAdjacentHTML("beforeend",
                    "<option value='" + row.NAME + "'>" + row.NAME + "</option>");
                input_workUser.insertAdjacentHTML("beforeend",
                    "<option value='" + row.NAME + "'>" + row.NAME + "</option>");
            })

        }
    }


    async function info_table_make() {
        info_table.innerHTML = "";

        //검색데이터
        let param = {
            SLIP_NO : pop_data1.slipNo,
            MINWON_DATE : pop_data1.minwonDate,
        }

        //파라미터
        let data = {
            sectionId: sectionId,
            component: querySet1 + "_info_table",
            param: param,
        }

        let list  = await we_getSelectOption(data);
        if(pop_data1.gbn == "0"){
            info_table.innerHTML = `
                            <th>동호</th>
                            <td>
                                <input type="text" id="input_dongName" name="DONG_NAME" class="box50" disabled>동
                                <input type="text" id="input_ho" name="HO" class="box50" disabled>호
                            </td>
                            <th>민원인</th>
                            <td ><input type="text" id="input_householder" name="MINWON_NAME"></td>
                            <th>연락처</th>
                            <td><input type="text" id="input_hpNo" name="HP_NO"></td>
            `
            document.querySelector("#input_dongName").value = list[0].HO_ID.split("-")[0] + "동"
            document.querySelector("#input_ho").value = list[0].HO_ID.split("-")[1] + "호"
            document.querySelector("#input_householder").value = list[0].HOUSEHOLDER;
            document.querySelector("#input_hpNo").value = list[0].HP_NO;
        }else if(pop_data1.gbn == "1"){
            info_table.innerHTML = `
                            <th>동호</th>
                            <td>
                                <input type="text" id="input_dongName" name="DONG_NAME" class="box50" disabled>동
                                <input type="text" id="input_lineNo" name="LINE_NO" class="box50" disabled>열
                            </td>
                            <th>민원인</th>
                            <td ><input type="text" id="input_householder" name="MINWON_NAME"></td>
                            <th>연락처</th>
                            <td><input type="text" id="input_hpNo" name="HP_NO" ></td>
            `
            document.querySelector("#input_dongName").value = list[0].HO_ID.split("-")[0] + "동"
            document.querySelector("#input_ho").value = list[0].LINE_NO.split("-")[1] + "호"
        }else{
            info_table.innerHTML = `
                            <th>장소</th>
                            <td>
                                <input type="input_minownName" id="MINWON_NAME" class="box200">
                            </td>
                            <th>민원인</th>
                            <td ><input type="text" id="input_householder" name="MINWON_NAME"></td>
                            <th>연락처</th>
                            <td><input type="text" id="input_hpNo" name="HP_NO" ></td>
            `
            document.querySelector("#input_dongName").value = list[0].HO_ID.split("-")[0] + "동"
            document.querySelector("#input_ho").value = list[0].LINE_NO.split("-")[1] + "호"
        }
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

        if(!isNull(pop_data1)){

            Promise.all([
                info_table_make(),
                //그리드 DDL
                getSelectOption_input_minownGbn(),
                getSelectOption_input_user(),
            ]).then(function (){
                if(!isNull(pop_data1.slipNo)){
                    search_input1_onclick();
                }else{
                    input_minwonDate.value = getToday("yyyy-MM-dd");
                    const now = new Date();
                    const hh = String(now.getHours()).padStart(2, '0');
                    const mm = String(now.getMinutes()).padStart(2, '0');
                    input_time.value = `${hh}:${mm}`;

                }
            })
        }


    }


</script>
