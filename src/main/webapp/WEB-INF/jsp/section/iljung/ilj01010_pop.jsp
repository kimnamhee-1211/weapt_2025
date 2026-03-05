
    <%-- 추가 팝업시작--%>
    <div class="layer_bg" id="pop_iljung" onchange="inputToGrid(grid1, popupId)" >
        <div class="popup" style="width:800px">
            <div class="pop_title">&#10004;일정등록</div>
            <div class="section1_btn" id="pop1_btn"></div>
            <div>
                <span> &#9726&nbsp; 제 목 : &nbsp;&nbsp;</span>
                <span><input type="text" style="width:708px" id="input_title" name="TITLE" ></span>
            </div>
            <div class="pop_ilj01010_textarea">
                <textarea id="input_descr" name=DESCR"></textarea>
            </div>
            <div>
                <table>
                    <tbody>
                    <tr>
                        <th style="width: 90px;">일정일</th>
                        <td style="width: 150px;"><input type="date" id="input_scDate" name="SC_DATE" data-format="date"></td>
                        <th style="width: 90px;">일정구분</th>
                        <td style="width: 150px;"><select id="input_schGbn" name="SCH_GBN"></select></td>
                        <th style="width: 90px;">주무부서</th>
                        <td style="width: 150px;"><select id="input_mainDeptCd" name="MAIN_DEPT_CD"></select></td>
                    </tr>
                    <tr>
                        <th style="width: 90px;">시작일자</th>
                        <td style="width: 150px;"><input type="date" id="input_startDate" name="START_DATE" data-format="date"></td>
                        <td colspan="4" style="font-size: 14px">
                            <span><input type="checkbox" id="input_reWorkYn" name="RE_WORK_YN"></span>
                            <span>&nbsp;&nbsp; 반복 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <span>
                                <select style="width:80px;" id="input_reWorkGbn" name="RE_WORK_GBN">
                                    <option value="month"></option>
                                    <option value="week"></option>
                                    <option value="day"></option>
                                </select>
                            </span>
                            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;종료일자&nbsp; </span>
                            <span><input type="date" id="input_endDate" name="END_DATE" data-format="date"></span>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 90px;">일정상태</th>
                        <td style="width: 150px;"><select id="input_statusCd" name="STATUS_CD"></select></td>
                        <th style="width: 90px;">처리자</th>
                        <td style="width: 150px;"><select id="input_workUserId" name="WORK_USER_ID"></select></td>
                        <td colspan="2"><input type="text" id="" name="OFFICE_AREAR" ></td>
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
    const input_title = document.querySelector("#input_title"); //select 컴포넌트
    const input_descr = document.querySelector("#input_descr"); //select 컴포넌트
    const input_scDate = document.querySelector("#input_scDate"); //select 컴포넌트
    const input_schGbn = document.querySelector("#input_schGbn"); //select 컴포넌트
    const input_mainDeptCd = document.querySelector("#input_mainDeptCd"); //select 컴포넌트
    const input_startDate = document.querySelector("#input_startDate"); //select 컴포넌트
    const input_reWorkYn = document.querySelector("#input_reWorkYn"); //select 컴포넌트
    const input_reWorkGbn = document.querySelector("#input_reWorkGbn"); //select 컴포넌트
    const input_endDate = document.querySelector("#input_endDate"); //select 컴포넌트
    const input_statusCd = document.querySelector("#input_statusCd"); //select 컴포넌트
    const input_workUserId = document.querySelector("#input_workUserId"); //select 컴포넌트
    let saveKey = "U";
    let searchItem;

    //팝업 이벤트
    //팝업 닫기 이벤트
    function close_popup_onclick(){
        popupClose(popupId);
        clearInput(popupId);
    }

    //그리드 조회 함수
    function search_pop1_onclick(){
        //검색데이터
        let selectParam = searchItem

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_pop1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (data) => {
                saveKey == "U"
                dataToInput(data, popupId);
            }
        });
    }

    //그리드 저장 함수
    function save_grid1_onclick(){

        //검증
        if(!confirm("일정을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_GRID1")) return;

        let addItem = null;
        let editItem = null;
        let item = inputToData(popupId);

        if(saveKey == "U") {
            editItem = [...item];
        }else{
            addItem  = [...item];
        }

        //포커스 지정
        focus = AUIGrid.getSelectedIndex(grid1)[0];

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
            component : pgId + "_grid1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    saveKey = "U";
                    //팝업 닫기
                    search_grid1_onclick();
                }else return;
            }
        });
    }

    //그리드 삭제 함수
    function delete_grid1_onclick(){

        let item = inputToData(popupId);
        let items = [...item];

        //검증
        if (!confirm("일정을 삭제하시겠습니까?")) return;

        //포커스 지정
        let selctedRowIndex = AUIGrid.getSelectedIndex(grid1)[0];
        focus = (selctedRowIndex -1) < 1 ? 0 : (selctedRowIndex -1);

        // 체크된 행 삭제 처리
        AUIGrid.removeCheckedRows(grid1);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : items,
            before : {}
        };
        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    //팝업 닫기
                    close_popup_onclick();
                    search_grid1_onclick();
                }else return;
            }
        });
    }

    //컴포넌트 필수항목 입력 체크
    function requireCheck(require){
        let isValid = true;
        switch(require){
            case "SAVE_GRID1":
                let addedRowItems = AUIGrid.getAddedRowItems(grid1);
                let editedRowItems = AUIGrid.getEditedRowItems(grid1);
                let items = [...addedRowItems,...editedRowItems];
                for(const row of items){
                    if(isNull(row.OFFICE_NAME)){
                        alert("관리소명은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                }
                break;

        }
        return isValid;
    }


    async function getSelectOption_input_mainDeptCd(){
        input_mainDeptCd.innerHTML = "";
        //검색데이터
        let param = {
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_input_mainDeptCd",
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
            component : pgId + "_input_workUserId",
            param: param,
        }
        let list = await we_getSelectOption(data);

        if(list) {
            input_workUserId.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");  //필요시
            list.forEach(row => {
                input_workUserId.insertAdjacentHTML("beforeend",
                    "<option value='" + row.EMP_NO + "'>" + row.NAME + "</option>");
            })
        }
        input_workUserId.selectedIndex = 0;
    }



    //로드
    function pop_onload(pop_item){
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#pop1_btn", grid: "grid1", save : true, del: true});
        pop1_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");

        Promise.all([
            //그리드 DDL
            getSelectOption_input_mainDeptCd(),
            getSelectOption_input_workUserId()
        ]).then(function (){
            if(pop_item.saveKey == "U"){
                //로드 시 그리드 바로 조회
                searchItem = pop_item.searchItem;
                search_pop1_onclick();
            }else{
                dataToInput(pop_item.addItem, popupId);
            }
        })
    };

</script>

<%@ include file = "../../inc_footer.jsp" %>