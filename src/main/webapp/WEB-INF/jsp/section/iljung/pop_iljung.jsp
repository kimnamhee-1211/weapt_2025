<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 추가 팝업시작--%>
    <div class="layer_bg" id="pop_iljung" >
        <div class="popup" style="width:800px">
            <div class="pop_title">
                <span id="">&#10004;&nbsp;일정등록</span>
                <div class="section1_btn" id="pop1_btn"></div>
            </div>
            <div style="display:flex; padding:5px 0px 5px 0px; height:25px;">
                <span> &#9726&nbsp; 제 목 : &nbsp;&nbsp;</span>
                <span><input type="text" style="width:708px" id="input_title" name="TITLE" ></span>
            </div>
            <div class="pop_ilj01010_textarea">
                <textarea id="input_descr" name="DESCR" style="width: 770px; height:340px;"></textarea>
            </div>
            <div>
                <table>
                    <tbody>
                    <tr>
                        <input type="text" id="input_mstNo" name="MST_NO" hidden="hidden">
                        <input type="text" id="input_mstMonth" name="MST_MONTH" hidden="hidden">
                        <input type="text" id="input_seq" name="SEQ" hidden="hidden">
                        <th style="width: 90px;">일정일</th>
                        <td style="width: 150px;"><input type="date" id="input_scDate" name="SC_DATE" data-format="date"></td>
                        <th style="width: 90px;">일정구분</th>
                        <td style="width: 150px;"><select id="input_schGbn" name="SCH_GBN"></select></td>
                        <th style="width: 90px;">주무부서</th>
                        <td style="width: 150px;"><select id="input_mainDeptCd" name="MAIN_DEPT_CD"></select></td>
                    </tr>
                    <tr id="inputTr_reWork">
                        <th style="width: 90px;">반복&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                        <td style="width: 150px;"><input type="checkbox" id="input_reWorkYn" name="RE_WORK_YN"></td>
                        <td colspan="4" style="font-size:14px; visibility:hidden;" id="inputTd_reWork">
                            <span>반복주기</span>
                            <span>
                                <select style="width:70px;" id="input_reWorkGbn" name="RE_WORK_GBN">
                                    <option value="month" selected>매달</option>
                                    <option value="week">매주</option>
                                    <option value="day">매일</option>
                                </select>
                            </span>
                            <span>&nbsp;&nbsp;시작일자</span>
                            <span><input type="date" id="input_startDate" name="START_DATE" data-format="date"></span>
                            <span>&nbsp;&nbsp;종료일자&nbsp; </span>
                            <span><input type="date" id="input_endDate" name="END_DATE" data-format="date"></span>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 90px;">일정상태</th>
                        <td style="width: 150px;"><select id="input_statusCd" name="STATUS_CD"></select></td>
                        <th style="width: 90px;">처리자</th>
                        <td style="width: 150px;"><select id="input_workUserId" name="WORK_USER_ID"></select></td>
                        <td colspan="2"><input type="text" id="input_workerName" name="WORKER_NAME" disabled="disabled"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>  <%-- 팝업끝--%>


<script>
    /** 작성 순서
     *
     * 변수 선언 :
     *      pgId, 그리드 컴포넌트, 그리드 컴포넌트 포커스, 입력부 컴포넌트, 팝업 컴포넌트, select 컴포넌트
     * 그리드 설정
     * 그리드 생성
     * 그리드 이벤트 :
     *      체크박스 클릭 시 셀렉트 이벤트, 셀 선택 변경 이벤트, 더블 클릭 시 팝업 오픈 이벤트
     * 팝업 이벤트 : (미사용시 생략)
     * 그리드 조회 함수
     * 그리드 추가 함수    (미사용시 생략)
     * 그리드 저장 함수    (미사용시 생략)
     * 그리드 삭제 함수    (미사용시 생략)
     * 컴포넌트 필수항목 입력 체크    (미사용시 생략)
     * crud 권한 처리 호출 함수
     *
     * 기타
     * 로드 :
     *      기본 crud 버튼 생성
     *      crud 권한 처리 함수 호출
     *      공통코드 가져오기		(미사용시 생략)
     *      그리드 DDL 설정       (미사용시 생략)
     *      (필요 시)그리드 조회 함수 호출    (미사용시 생략)
     *
     */

    //변수 선언
    const popupId = "pop_iljung";
    const pop1_btn = document.querySelector("#pop1_btn"); //팝업버튼 컴포넌트
    const input_title = document.querySelector("#input_title"); //input 컴포넌트
    const input_descr = document.querySelector("#input_descr"); //input 컴포넌트
    const input_scDate = document.querySelector("#input_scDate"); //input 컴포넌트
    const input_schGbn = document.querySelector("#input_schGbn"); //input 컴포넌트
    const input_mainDeptCd = document.querySelector("#input_mainDeptCd"); //input 컴포넌트
    const input_startDate = document.querySelector("#input_startDate"); //input 컴포넌트
    const input_reWorkYn = document.querySelector("#input_reWorkYn"); //input 컴포넌트
    const input_reWorkGbn = document.querySelector("#input_reWorkGbn"); //input 컴포넌트
    const input_endDate = document.querySelector("#input_endDate"); //input 컴포넌트
    const input_statusCd = document.querySelector("#input_statusCd"); //input 컴포넌트
    const input_workUserId = document.querySelector("#input_workUserId"); //input 컴포넌트
    const input_workerName = document.querySelector("#input_workerName"); //input 컴포넌트
    const inputTd_reWork = document.querySelector("#inputTd_reWork"); //input 컴포넌트
    const inputTr_reWork = document.querySelector("#inputTr_reWork"); //input 컴포넌트

    let saveKey = "U";
    let searchItem;

    //팝업 이벤트
    //팝업 닫기 이벤트
    function close_popup_onclick(){
        popupClose(popupId);
        clearInput(popupId);
        input_statusCd.innerHTML = "";
        input_reWorkYn.checked = false;
        inputTd_reWork.style.visibility = "hidden";
    }

    //그리드 조회 함수
    function search_pop1_onclick(){
        //검색데이터
        let selectParam = searchItem

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : querySet + "_pop1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.data;
                if(isNull(data)){
                    alert("일정 정보가 존재하지 않습니다.")
                    close_popup_onclick();
                }else{
                    saveKey == "U";
                    dataToInput(data[0], popupId);
                }
            }
        });
    }


    //그리드 저장 함수
    function save_pop1_onclick(){

        //검증
        if(!confirm("일정을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_POP1")) return;

        //포커스 지정
        //focus = AUIGrid.getSelectedIndex(grid1)[0];

        let addItem = null;
        let editItem = null;
        let item = inputToData(popupId);
        item.REG_DATE = getToday("yyyyMMdd")
        if(saveKey == "I" && input_reWorkYn.value == "Y"){
            item.SC_DATE = setItemReWork();
        }else if(saveKey == "I" && input_reWorkYn.value != "Y"){
            item.SC_DATE = [item.SC_DATE];
        }

        if(saveKey == "U") editItem = [{ ...item }];
        else addItem  = [{ ...item }];

        //저장 데이터
        let saveParam = {
            insertParam : addItem,
            updateParam : editItem,
            key : ["MST_NO"],
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : querySet + "_pop1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    saveKey = "U";
                    if(pgId != "ilj01040"){
                        initializeCalendar();
                    }else{
                        search_grid1_onclick();
                    }
                }else return;
            }
        });
    }


    function setItemReWork(){
        let type = input_reWorkGbn.value
        let startDate = strToDate(input_startDate.value);
        let endDate = strToDate(input_endDate.value);
        let scDate = strToDate(input_scDate.value);
        let items = [];
        let inDate;

        if(scDate > startDate){
            inDate = new Date(scDate);
            if(type == "month") inDate.setMonth(inDate.getMonth() - 1);
            else if(type == "week") inDate.setDate(inDate.getDate() - 7);
            else if(type == "day") inDate.setDate(inDate.getDate() - 1);

            while (inDate >= startDate){
                items.push(dateToStr(new Date(inDate), "yyyyMMdd"));
                if(type == "month") inDate.setMonth(inDate.getMonth() - 1);
                else if(type == "week") inDate.setDate(inDate.getDate() - 7);
                else if(type == "day") inDate.setDate(inDate.getDate() - 1);
            }
        }
        if(scDate <= endDate){
            inDate = new Date(scDate);
            while (inDate <= endDate){
                items.push(dateToStr(new Date(inDate), "yyyyMMdd"));
                if(type == "month") inDate.setMonth(inDate.getMonth() + 1);
                else if(type == "week") inDate.setDate(inDate.getDate() + 7);
                else if(type == "day") inDate.setDate(inDate.getDate() + 1);
            }
        }
        return items;
    }


    //그리드 삭제 함수
    function delete_pop1_onclick(){

        let item = inputToData(popupId);
        let items =  [{ ...item }];

        //검증
        if(saveKey == 'I') alert("삭제할 일정이 없습니다.");
        if (!confirm("일정을 삭제하시겠습니까?")) return;

        //포커스 지정
        // let selctedRowIndex = AUIGrid.getSelectedIndex(grid1)[0];
        // focus = (selctedRowIndex -1) < 1 ? 0 : (selctedRowIndex -1);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : items,
            before : {}
        };
        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId : sectionId,
            component : querySet + "_pop1",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    //팝업 닫기
                    close_popup_onclick();
                    if(pgId != "ilj01040"){
                        initializeCalendar();
                    }else{
                        search_grid1_onclick();
                    }
                }else return;
            }
        });
    }

    //컴포넌트 필수항목 입력 체크
    function requireCheck(require){
        let isValid = true;
        switch(require){
            case "SAVE_POP1":
                if(isNull(input_title.value)){
                    alert("제목은 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
                }
                if(isNull(input_schGbn.value)){
                    alert("일정구분은 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
                }
                if(isNull(input_statusCd.value)){
                    alert("일정상태는 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
                }
                if(saveKey == "I" && input_reWorkYn == "Y"){
                    if(isNull(input_reWorkGbn.value)){
                        alert("반복주기는 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(input_startDate.value)){
                        alert("시작일자는 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(input_endDate.value)){
                        alert("종료일자는 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                }
                break;

        }
        return isValid;
    }

    async function getSelectOption_input_schGbn(){
        input_schGbn.innerHTML = "";
        //검색데이터
        let param = {
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : querySet + "_input_schGbn",
            param: param,
        }
        let list = await we_getSelectOption(data);

        if(list){
            list.forEach(row => {
                input_schGbn.insertAdjacentHTML("beforeend",
                    "<option value='" + row.SCH_GBN + "'>" + row.GBN_NAME + "</option>");
            })
        }
        input_schGbn.value = input_schGbn.options[0].value;
    }


    async function getSelectOption_input_mainDeptCd(){
        input_mainDeptCd.innerHTML = "";
        //검색데이터
        let param = {
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : querySet + "_input_mainDeptCd",
            param: param,
        }
        let list = await we_getSelectOption(data);

        if(list){
            input_mainDeptCd.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");  //필요시
            list.forEach(row => {
                input_mainDeptCd.insertAdjacentHTML("beforeend",
                    "<option value='" + row.DEPT_CD + "'>" + row.DEPT_NAME + "</option>");
            })
        }
        input_mainDeptCd.selectedIndex = 0;
    }

    async function getSelectOption_input_workUserId(){
        input_workUserId.innerHTML = "";
        //검색데이터
        let param = {
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : querySet + "_input_workUserId",
            param: param,
        }
        let list = await we_getSelectOption(data);

        if(list) {
            input_workUserId.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");  //필요시
            list.forEach(row => {
                input_workUserId.insertAdjacentHTML("beforeend",
                    "<option value='" + row.EMP_NO + "'>" + row.NAME + "</option>");
            })
            input_workUserId.insertAdjacentHTML("beforeend", "<option value ='999999'>직접입력</option>");  //필요시
        }
        input_workUserId.selectedIndex = 0;
    }

    input_workUserId.addEventListener("change", () =>{
        if(input_workUserId.value == '999999'){
            input_workerName.disabled = false;
            input_workerName.focus();
        }else{
            input_workerName.disabled = true;
        }
    });

    input_reWorkYn.addEventListener("change", () =>{
        input_reWorkYn.value = input_reWorkYn.checked ? "Y" : "N";
        if(input_reWorkYn.checked){
            inputTd_reWork.style.visibility = "visible"
            input_startDate.value =  input_scDate.value
        }else inputTd_reWork.style.visibility = "hidden"
    });


    //로드
    function pop_onload(pop_item){
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#pop1_btn", grid: "pop1", save : true, del: true});
        pop1_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");

        Promise.all([
            //공통코드 가져오기
            selectOptionMaker("120", input_statusCd, "", false),
            //그리드 DDL
            getSelectOption_input_schGbn(),
            getSelectOption_input_mainDeptCd(),
            getSelectOption_input_workUserId(),
            saveKey = pop_item.saveKey
        ]).then(function (){
            if(saveKey == "U"){
                //로드 시 그리드 바로 조회
                searchItem = pop_item.searchItem;
                search_pop1_onclick();
                inputTr_reWork.style.display = "none";
                input_scDate.disabled = true
            }else{
                dataToInput(pop_item.addItem, popupId);
                inputTr_reWork.style.display =  "table-row";
                input_scDate.disabled = false
            }
        })
    };

</script>
