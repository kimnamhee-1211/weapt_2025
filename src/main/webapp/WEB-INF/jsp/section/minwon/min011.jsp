<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="layer_bg" id="min011">
    <div class="popup" style="width: 740px;">
        <div class="pop_title">&#10004; 세대민원전표</div>
        <div class="pop_btn" id="pop1_btn"></div>
        <div id="min_tb" class="gridcont_right_720">
            <div id="input1">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>접&ensp;수</span>
                    <span class="section_middle_btn" id="section_middle_btn1"></span>
                    <div class="search-box section1_btn">
                        <button id="input1_btn_photo" class="find_btn" onclick="">사진첨부</button>
                        <button id="input1_btn_mms" class="mms_btn" onclick="">메시지전송</button>
                    </div>
                </div>
                <table style="width:720px;" id="minwon_table">
                    <colgroup>
                        <col style="width:12%">
                        <col style="width:32%">
                        <col style="width:12%">
                        <col style="width:16%">
                        <col style="width:12%">
                        <col style="width:16%">
                    </colgroup>
                    <tbody>
                    <tr id="info_tr"></tr>
                    <tr>
                        <th>접수일시</th>
                        <td colspan="3">
                            <div style="display: flex">
                                <span>
                                    <input type="date" id="input_minwonDate" name="MINWON_DATE" data-format="date">
                                </span>&emsp;&emsp;
                                <%-- 환경설정에 체크되어 있으면 서버 현재시간 가져오기 --%>
                                <span class="span_time">
                                    <span>
                                        <input type="checkbox" id="input_timeInput" name="TIME_INPUT" >
                                        <label for="input_minwonDate">시간선택</label>
                                    </span>
                                    <%-- 체크되면 시,분 보여지기 --%>
                                    <span id="span_time" style="display: none">&ensp;:
                                        <input type="time" id="input_time" name="TIME">
                                    </span>
                                </span>
                            </div>
                        </td>
                        <th>전표번호</th>
                        <%-- 오늘날짜 순번으로 자동생성 --%>
                        <td><input type="text" id="input_slipNo" name="SLIP_NO" disabled></td>
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
            </div>
            <div id="input2">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>처&ensp;리</span>
                    <span class="section_middle_btn" id="section_middle_btn2"></span>
                    <div class="search-box section1_btn">
                        <button id="input2_btn_photo" class="find_btn" onclick="">사진첨부</button>
                        <button id="input2_btn_stock" class="find_btn">소모품사용</button>
                        <button id="input2_btn_gauge" onclick="" class="find_btn">계량기사용</button>
                    </div>
                    </span>
                </div>
                <table style="width:720px;" id="minwonWork_table">
                    <colgroup>
                        <col style="width:12%">
                        <col style="width:24%">
                        <col style="width:12%">
                        <col style="width:20%">
                        <col style="width:12%">
                        <col style="width:20%">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>처리일시</th>
                        <td colspan="3">
                            <input type="text" id="input_workSeq" name="WORK_SEQ" hidden="hidden">
                            <div style="display: flex">
                                <span>
                                    <input type="date" id="input_workDate" name="WORK_DATE" data-format="date">
                                </span>
                                <span class="span_time">&emsp;&emsp;
                                    <span>
                                        <input type="checkbox" id="input_workTimeInput" name="WORK_TIME_INPUT">
                                        <label for="input_workTimeInput">시간선택</label>
                                    </span>
                                    <span id="span_workTime" style="display: none">&ensp;:
                                        <input type="time" id="input_workTime" name="WORK_TIME" >
                                    </span>
                                </span>
                            </div>
                        </td>
                        <th>구분</th>
                        <td>
                            <select id="input_minwonGbn" name="MINWON_GBN"></select>
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
                            <select id="input_workUser" name="WORK_USER"></select>
                        </td>
                        <td colspan="2"><input type="text" id="input_workUserName" name="WORK_USER_NAME"></td>
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
</div>


<script>
    const popupId1 = "min011";
    let querySet1;
    let pop_data1;
    let pop_popId;
    let saveKey1 = "I";
    let saveKey2 = "I";
    let focusGrid;
    let setting = [];

    //팝업 컴포넌트
    const section_middle_btn1 = document.querySelector("#section_middle_btn1");
    const minwon_table = document.querySelector("#minwon_table");
    const minwonWork_table = document.querySelector("#minwonWork_table");
    const info_tr = document.querySelector("#info_tr");

    const input_minwonDate = document.querySelector("#input_minwonDate");
    const input_timeInput = document.querySelector("#input_timeInput");
    const input_time = document.querySelector("#input_time");
    const input_slipNo = document.querySelector("#input_slipNo");
    const input_receiptUser = document.querySelector("#input_receiptUser");
    const input_receiptUserName = document.querySelector("#input_receiptUserName");
    const input_descr = document.querySelector("#input_descr");

    const input_workSeq = document.querySelector("#input_workSeq");
    const input_workDate = document.querySelector("#input_workDate");
    const input_workTimeInput = document.querySelector("#input_workTimeInput");
    const input_workTime = document.querySelector("#input_workTime");
    const input_minwonGbn = document.querySelector("#input_minwonGbn");
    const input_statusCd = document.querySelector("#input_statusCd");
    const input_workUser = document.querySelector("#input_workUser");
    const input_workUserName = document.querySelector("#input_workUserName");
    const input_workDesc = document.querySelector("#input_workDesc");

    const span_time = document.querySelector(".span_time");

    const input1_btn_mms = document.querySelector("#input1_btn_mms");
    const input2_btn_stock = document.querySelector("#input2_btn_stock");
    const input2_btn_gauge = document.querySelector("#input2_btn_gauge");


    let input_user = []
    let input_user2 = []

    function search_input1_onclick() {

        let selectParam = {
            SLIP_NO: input_slipNo.value,
            MINWON_DATE: input_minwonDate.value.replace(/-/g,""),
        }

        //파라미터
        let selectData = {
            sectionId: sectionId,
            component: querySet1 + "_input1",
            param: selectParam,
        }

        we_select(selectData, {
            successSelect: (json) => {
                let data = json.DATA;
                dataToInput(data[0], "minwon_table");
                if (!input_user.some(row => row.NAME == data[0].RECEIPT_USER)) {
                    input_receiptUser.value = "write"
                    input_receiptUserName.value = data[0].RECEIPT_USER
                }
                if (!isNull(data[0].WORK_SEQ)) {
                    saveKey2 = "U"
                    search_input2_onclick();
                }
            }
        });
    }

    function search_input2_onclick() {

        let selectParam = {
            SLIP_NO: input_slipNo.value,
            MINWON_DATE: input_minwonDate.value.replace(/-/g,""),
            WORK_SEQ: input_workSeq.value
        }

        //파라미터
        let selectData = {
            sectionId: sectionId,
            component: querySet1 + "_input2",
            param: selectParam,
        }

        we_select(selectData, {
            successSelect: (json) => {
                let data = json.DATA;
                dataToInput(data[0], "minwonWork_table");
                if (!input_user2.some(row => row.NAME == data[0].WORK_USER)) {
                    input_workUser.value = "write";
                    input_workUserName.value = data[0].WORK_USER;
                }
            }
        });
    }

    async function search_focuse(data){

        let selectParam = {
            GBN : pop_data1.gbn,
            LINE_GBN : (pop_data1.gbn == "0" || pop_data1.gbn == "1" ) ? pop_data1.lineGbn : "",
            DONG_ID : pop_data1.dongId,
            HO_ID : pop_data1.hoId,
            MINWON_AREAR_SEQ : (pop_data1.gbn == "0" || pop_data1.gbn == "1" ) ? "" : pop_data1.minwonArearSeq,
            MINWON_DATE : input_minwonDate.value.replace(/-/g,""),
            LINE_NO : pop_data1.lineNo
        }

        //파라미터
        let selectData = {
            sectionId: sectionId,
            component: querySet1 + "_focuse",
            param: selectParam,
        }

        return we_select(selectData, {
            successSelect: (json) => {
                let data = json.DATA;
                focus = gridFocusFromKey(data[0], focusGrid);
            }
        });
    }


    //그리드 저장 함수
    function save_input1_onclick() {

        //검증
        if (!confirm("변경사항을 저장하시겠습니까?")) return;
        if (!requireCheck1("SAVE_INPUT1")) return;

        let item = inputToData("minwon_table");
        item.MINWON_DATE = input_minwonDate.value.replace(/-/g,"");
        item.REG_DATE = getToday("yyyyMMdd")
        item.TIME_INPUT = input_timeInput.checked ? "1" : "0";
        if (!isNull(input_time.value)) {
            item.TIME = input_time.value.split(":")[0]
            item.MINUTE = input_time.value.split(":")[1]
        }
        if (input_receiptUser.value == "write") {
            item.RECEIPT_USER = item.RECEIPT_USER_NAME
        }
        item.GBN = pop_data1.gbn;
        item.DONG_ID = pop_data1.dongId;
        item.HO_ID = pop_data1.hoId;
        item.LINE_NO = pop_data1.lineNo;
        item.LINE_GBN = pop_data1.lineGbn;
        item.MINWON_AREAR_SEQ = pop_data1.minwonArearSeq;

        let addedRowItems = [];
        let editedRowItems = [];

        if (saveKey1 == "I") {
            addedRowItems = [{...item}];
        } else {
            editedRowItems = [{...item}];
        }

        //저장 데이터
        let saveParam = {
            insertParam: addedRowItems,
            updateParam: editedRowItems,
            key: ["SLIP_NO"],
            before: {}
        };

        //파라미터
        let saveData = {
            sectionId: sectionId,
            component: querySet1 + "_input1",
            param: saveParam,
        }

        we_save(saveData, {
            successSave: (json) => {
                alert(json.O_MSG);
                if (json.O_RESULT > 0) {
                    after_save(json.DATA[0]);
                } else return;
            }
        });
    }

    //그리드 저장 함수
    function save_input2_onclick() {

        //검증
        if(isNull(input_slipNo.value)){
            alert("접수된 민원 내역이 없습니다");
            return;
        }

        if(!confirm("변경사항을 저장하시겠습니까?")) return;
        if (!requireCheck1("SAVE_INPUT2")) return;


        let item = inputToData("minwonWork_table");
        item.REG_DATE = getToday("yyyyMMdd");
        item.SLIP_NO = input_slipNo.value;
        item.MINWON_DATE = input_minwonDate.value.replace(/-/g,"");
        item.WORK_DATE = input_workDate.value.replace(/-/g,"");
        item.TIME_INPUT = input_workTimeInput.checked ? "1" : "0";
        if (!isNull(input_workTime.value)) {
            item.TIME = input_workTime.value.split(":")[0]
            item.MINUTE = input_workTime.value.split(":")[1]
        }
        if (input_workUser.value == "write") {
            item.WORK_USER = item.WORK_USER_NAME
        }

        let addedRowItems = [];
        let editedRowItems = [];


        if (saveKey2 == "I") {
            addedRowItems = [{...item}];
        } else {
            editedRowItems = [{...item}];
        }

        focus = gridFocus(focusGrid);

        //저장 데이터
        let saveParam = {
            insertParam: addedRowItems,
            updateParam: editedRowItems,
            key: ["WORK_SEQ"],
            before: {
                action: "all",
                saveMode: "U",
                beforeParam: [{...item}]
            }
        };

        //파라미터
        let saveData = {
            sectionId: sectionId,
            component: querySet1 + "_input2",
            param: saveParam,
        }

        we_save(saveData, {
            successSave: (json) => {
                alert(json.O_MSG);
                if (json.O_RESULT > 0) {
                    saveKey2 == "U";
                    if(!isNull(pop_popId)){
                        search_popGrid1_onclick();
                    }else{
                        search_grid1_onclick();
                    }
                    search_input1_onclick();
                } else return;
            }
        });
    }
    function after_save(data){
        if(!isNull(pop_popId)){
            if(saveKey1 == "I" ){
                Promise.all([
                    focus = gridFocusFromKey(data, focusGrid),
                    search_cntTable(),
                    search_popGrid1_onclick()
                ]).then(function () {
                    open_popup1_onclick();
                })
            }else {
                focus = AUIGrid.getSelectedIndex(focusGrid)[0];
                search_popGrid1_onclick();
            }
        }else {
            if(saveKey1 == "I" ){
                input_slipNo.value = data.SLIP_NO;
                search_input1_onclick();
            }else{
                focus = AUIGrid.getSelectedIndex(focusGrid)[0];
                search_grid1_onclick();
            }
        }
    }

    //그리드 삭제 함수
    function delete_input1_onclick() {

        //검증
        if (isNull(input_slipNo.value)) {
            alert("삭제할 항목이 없습니다");
            return;
        }

        if (!confirm("민원접수 내역을 삭제하시겠습니까?")) return;

        if (!isNull(input_workSeq.value)) {
            if (!confirm("등록된 민원 처리 내역이 있습니다.\n모두 삭제하시겠습니까?")) return;
        }

        let item = {}
        item.SLIP_NO = input_slipNo.value
        item.MINWON_DATE = input_minwonDate.value.replace(/-/g,"");

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam: [{...item}],
            before: {}
        };

        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId: sectionId,
            component: querySet1 + "_input1",
            param: param,
        }

        we_delete(deleteData, {
            successDelete: (data) => {
                alert(data.O_MSG);
                if (data.O_RESULT > 0) {
                    focus = AUIGrid.getSelectedIndex(focusGrid)[0] < 1 ? 0 : AUIGrid.getSelectedIndex(focusGrid)[0]-1;
                    if(!isNull(pop_popId)){
                        search_popGrid1_onclick();
                    }else{
                        search_grid1_onclick();
                    }
                    close_popup1_onclick();
                } else return;
            }
        });
    }

    function delete_input2_onclick() {

        //검증
        if (isNull(input_workSeq.value)) {
            alert("삭제할 항목이 없습니다");
            return;
        }

        if (!confirm("민원처리 내역을 삭제하시겠습니까?")) return;

        let item = {}
        item.SLIP_NO = input_slipNo.value
        item.MINWON_DATE = input_minwonDate.value.replace(/-/g,"");

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam: [{...item}],
            before: {}
        };

        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId: sectionId,
            component: querySet1 + "_input2",
            param: param,
        }

        we_delete(deleteData, {
            successDelete: (data) => {
                alert(data.O_MSG);
                if (data.O_RESULT > 0) {
                    focus = AUIGrid.getSelectedIndex(focusGrid)[0];
                    if(!isNull(pop_popId)){
                        saveKey2 == "I";
                        search_popGrid1_onclick();
                    }else{
                        search_grid1_onclick();
                    }
                    search_input1_onclick();
                } else return;
            }
        });
    }

    async function getSelect_input_minwonGbn() {
        input_minwonGbn.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId: sectionId,
            component: querySet1 + "_input_minwonGbn",
            param: param,
        }

        let list = await we_getSelect(data);

        if (list) {
            input_minwonGbn.insertAdjacentHTML("beforeend", "<option value='' selected>미선택</option>");  //필요시
            list.forEach(row => {
                input_minwonGbn.insertAdjacentHTML("beforeend",
                    "<option value='" + row.GBN_ID + "'>" + row.GBN_NAME + "</option>");
            })
        }
    }

    async function getSelect_input_user() {
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
        let list = await we_getSelect(data);

        let data2 = {
            sectionId: sectionId,
            component: querySet1 + "_input_workUser",
            param: param,
        }
        let list2 = await we_getSelect(data2);

        input_user = list;
        input_user2 = [...list, ...list2].sort((a, b) =>
            a.NAME.localeCompare(b.NAME, 'ko')
        );

        if (input_user) {
            input_receiptUser.insertAdjacentHTML("beforeend", "<option value='write' selected>직접입력</option>");  //필요시
            input_user.forEach(row => {
                input_receiptUser.insertAdjacentHTML("beforeend",
                    "<option value='" + row.NAME + "'>" + row.NAME + "</option>");
            })
        }
        if (input_user2) {
            input_workUser.insertAdjacentHTML("beforeend", "<option value='write' selected>직접입력</option>");  //필요시
            input_user2.forEach(row => {
                input_workUser.insertAdjacentHTML("beforeend",
                    "<option value='" + row.NAME + "'>" + row.NAME + "</option>");
            })
        }
    }

    async function info_tr_make() {
        info_tr.innerHTML = "";
        if (pop_data1.gbn == "0") {
            info_tr.innerHTML = `
                            <th>동호</th>
                            <td><input type="text" id="input_dongHo" disabled></td>
                            <th>민원인</th>
                            <td ><input type="text" id="input_minwonName" name="MINWON_NAME"></td>
                            <th>연락처</th>
                            <td><input type="text" id="input_hpNo" name="HP_NO" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
            `
            document.querySelector("#input_dongHo").value = make_place(pop_data1)

        } else if (pop_data1.gbn == "1") {
            info_tr.innerHTML = `
                            <th>동열</th>
                            <td><input type="text" id="input_dongLine" disabled></td>
                            <th>민원인</th>
                            <td ><input type="text" id="input_minwonName" name="MINWON_NAME"></td>
                            <th>연락처</th>
                            <td><input type="text" id="input_hpNo" name="HP_NO" ></td>
            `
            document.querySelector("#input_dongLine").value = make_place(pop_data1);
        } else {
            info_tr.innerHTML = `
                            <th>장소</th>
                            <td><input type="text" id="input_arearName" disabled></td>
                            <th>민원인</th>
                            <td ><input type="text" id="input_minwonName" name="MINWON_NAME"></td>
                            <th>연락처</th>
                            <td><input type="text" id="input_hpNo" name="HP_NO" ></td>
            `
            document.querySelector("#input_arearName").value = make_place(pop_data1);
        }
    }

    async function info_tr_make_add() {
        if (pop_data1.gbn == "0") {
            let list = await getSelect_info_tr();
            document.querySelector("#input_minwonName").value = list[0].HOUSEHOLDER ? list[0].HOUSEHOLDER : "";
            document.querySelector("#input_hpNo").value = list[0].HP_NO ? list[0].HP_NO : "";
        }
        input_minwonDate.value = getToday("yyyy-MM-dd");
        input_minwonDate.disabled = false;
    }

    async function getSelect_info_tr() {
        let param = {
            DONG_ID: pop_data1.dongId,
            HO_ID: pop_data1.hoId,

        }

        //파라미터
        let data = {
            sectionId: sectionId,
            component: querySet1 + "_info_tr",
            param: param,
        }

        return await we_getSelect(data);
    }

    input_receiptUser.addEventListener("change", () => {
        if(input_receiptUser.value != 'write'){
            input_receiptUserName.value = '';
        }
    });

    input_workUser.addEventListener("change", () => {
        if(input_workUser.value != 'write'){
            input_workUserName.value = '';
        }
    });



    input_timeInput.addEventListener("change", () => {
        const el = document.querySelector("#span_time");
        if (input_timeInput.checked) {
            el.style.display = "inline";
            const now = new Date();
            const hh = String(now.getHours()).padStart(2, '0');
            const mm = String(now.getMinutes()).padStart(2, '0');
            input_time.value = `${hh}:${mm}`;
        } else {
            el.style.display = "none";
            input_time.value = "";
        }
    });

    input_workTimeInput.addEventListener("change", () => {
        const el = document.querySelector("#span_workTime");
        if (input_workTimeInput.checked) {
            el.style.display = "inline";
            const now = new Date();
            const hh = String(now.getHours()).padStart(2, '0');
            const mm = String(now.getMinutes()).padStart(2, '0');
            input_workTime.value = `${hh}:${mm}`;
        } else {
            el.style.display = "none";
            input_workTime.value = "";
        }
    });

    //컴포넌트 필수항목 입력 체크
    function requireCheck1(require) {
        let isValid = true;
        switch (require) {
            case "SAVE_INPUT1":
                if (input_receiptUser.value == "write") {
                    if (isNull(input_receiptUserName.value)) {
                        alert("접수자는 반드시 입력해야 합니다.");
                        isValid = false;
                    }
                }
                if (isNull(input_minwonDate.value)) {
                    alert("접수일은 반드시 입력해야 합니다.");
                    isValid = false;
                }
                if (isNull(input_minwonName.value)) {
                    alert("민원인은 반드시 입력해야 합니다.");
                    isValid = false;
                }
                break;
            case "SAVE_INPUT2":
                if (input_workUser.value == "write") {
                    if (isNull(input_workUserName.value)) {
                        alert("처리자는 반드시 입력해야 합니다.");
                        isValid = false;
                    }
                }
                if (isNull(input_workDate.value)) {
                    alert("처리일은 반드시 입력해야 합니다.");
                    isValid = false;
                }
                break;
        }
        return isValid;
    }

    async function getSelect_min_setting() {
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId: sectionId,
            component: "min_setting",
            param: param,
        }
        setting = await we_getSelect(data);

        if(setting[0].MESSAGE_GBN != "1"){
            input1_btn_mms.style.display = "hidden"
        }
        if(setting[0].STOCK_GBN != "1"){
            input2_btn_stock.style.display = "hidden"
        }
        if(setting[0].GAUGE_GBN != "1"){
            input2_btn_gauge.style.display = "hidden"
        }
        if(setting[0].TIME_GBN != "1"){
            span_time.style.display = "hidden"
        }

    }

    function pop_onload1(pop_item) {
        querySet1 = isNull(pop_item.querySet) ? pop_item.pgId : pop_item.querySet;
        pop_data1 = pop_item.pop_data
        pop_popId = isNull(pop_item.popId) ? "" : pop_item.popId;
        if(isNull(pop_popId)){
            focusGrid = grid1;
        }else{
            focusGrid = popGrid1;
        }

        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({tag: "#section_middle_btn1", grid: "input1", save: true, del: true});
        btnMaker({tag: "#section_middle_btn2", grid: "input2", save: true, del: true});
        section_middle_btn1.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup1_onclick()'>닫기</button>");


        if (!isNull(pop_item.btnHidden)) {
            btnHidden(pop_item.btnHidden, pop_item.popupId);
        }

        if (!isNull(pop_item.disabled)) {
            disableInput(pop_item.popupId);
        }

        if (!isNull(pop_data1)) {
            saveKey1 = isNull(pop_data1.saveKey) ? "I" : pop_data1.saveKey;

            Promise.all([
                info_tr_make(),
                //그리드 DDL
                getSelect_input_minwonGbn(),
                getSelect_input_user(),
            ]).then(function () {
                if (saveKey1 == "U") {
                    input_slipNo.value = pop_data1.slipNo;
                    input_minwonDate.value = dateFormat(pop_data1.minwonDate);
                    input_minwonDate.disabled = true;
                    search_input1_onclick();
                } else {
                    if(setting[0].VIEW_USER == "1"){
                        input_receiptUser.value = loginUser.userName;
                    }
                    info_tr_make_add();
                }
            })
        }
    }


</script>
