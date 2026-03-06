<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/iljung/ilj_nav.jsp" />

    <div id="section">
        <div class="section1">
            <span class="section1_nav"><i class="icon-calendar-plus-o"></i>월중관리계획</span>
            <div class="section1_btn" id="section1_btn"></div>
            <span class="search-box section1_btn">
                <button id="schedule_btn_grid1" class="del_btn" onclick="schedule_onclick()">일정등록</button>
            </span>
        </div>
        <div class="section2">
            <div class="section2_line1">
                <span>수립기준일 :&nbsp;
                    <select id="search_mstDate" name="" class="select_cont100"></select>
                </span>
                <span class="select-container">&emsp;해당월 :&nbsp;
                    <select name="month" id="search_mstMonth">
                      <option value="01">1</option>
                      <option value="02">2</option>
                      <option value="03">3</option>
                      <option value="04">4</option>
                      <option value="05">5</option>
                      <option value="06">6</option>
                      <option value="07">7</option>
                      <option value="08">8</option>
                      <option value="09">9</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                    </select>
                    월
                </span>
            </div>
        </div>
        <div id="grid1"></div>
        <div class="section1">
            <%-- 추가 팝업시작--%>
            <div class="layer_bg" id="grid1_popup">
                <div class="popup" style="width:500px;">
                    <div>
                        <span>&nbsp;&#9726 일정등록</span>
                        <span id="pop1_btn" style="float: right;">
                            <button id="schedule_btn_pop1" class="btn_left3" onclick="schedule_save_onclick()">등록</button>
                            <button id='close_btn1' class='btn_left3' onclick="close_popup_onclick()">닫기</button>
                        </span>
                    </div>
                    <div>
                        <table>
                            <tbody>
                                <tr>
                                    <th style="width: 90px;">등록일</th>
                                    <td style="width: 150px;"><input type="date" id="input_scDate" name="SC_DATE" data-format="date"></td>
                                    <th style="width: 90px;">반복</th>
                                    <td style="width: 150px;"><input type="checkbox" id="input_reWorkYn" name="RE_WORK_YN"></td>
                                </tr>
                                <tr id="inputTr_Re" style="display: none">
                                    <th style="width: 90px;">반복주기</th>
                                    <td style="width: 150px;">
                                        <select id="input_reWorkTime" name="RE_WORK_TIME">
                                            <option value="month" selected>매월</option>
                                            <option value="week" >매주</option>
                                            <option value="day" selected>매일</option>
                                        </select>
                                    </td>
                                    <th style="width: 90px;">종료일</th>
                                    <td style="width: 150px;"><input type="date" id="input_endDate" name="END_DATE" data-format="date"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script>
    /** 작성 순서
     *
     * 변수 선언 :  pgId, 컴포넌트, 컴포넌트 포커스
     * 그리드 설정
     * 그리드 생성
     * 그리드 이벤트 : 체크박스 클릭 시 셀렉트 이벤트(엑스트라 체크박스 있을 시) + 필요 시v
     * 그리드 조회 함수
     * 그리드 추가 함수    (미사용시 생략)
     * 그리드 저장 함수    (미사용시 생략)
     * 그리드 삭제 함수    (미사용시 생략)
     * 컴포넌트 필수항목 입력 체크    (미사용시 생략)
     * crud 권한 처리 호출 함수
     *
     * 기타
     * 로드 :
     * 		기본 crud 버튼 생성
     * 		crud 권한 처리 함수 호출
     * 		공통코드 가져오기		(미사용시 생략)
     * 		(필요 시)그리드 조회 함수 호출    (미사용시 생략)
     *
     */

        //변수 선언
    const pgId = "${pgId}";	//프로그램ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const popupId = "grid1_popup"; //팝업 컴포넌트
    const search_mstDate = document.querySelector("#search_mstDate")	//select 컴포넌트
    const search_mstMonth = document.querySelector("#search_mstMonth")	//select 컴포넌트
    const input_scDate = document.querySelector("#input_scDate")	//popup 컴포넌트
    const input_reWorkYn = document.querySelector("#input_reWorkYn")	//popup 컴포넌트
    const input_reWorkTime = document.querySelector("#input_reWorkTime")	//popup 컴포넌트
    const input_endDate = document.querySelector("#input_endDate")	//popup 컴포넌트
    const inputTr_Re = document.querySelector("#inputTr_Re")	//popup 컴포넌트
    let DS_SCH_GBN =[];
    let DS_DEPT_CD = [];

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "MST_NO",
            visible : false
        },
        { dataField: "MST_MONTH",
            visible : false
        },
        { dataField: "SCH_GBN",
            headerText: "구분",
            dataType: "text",
            width : "10%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_SCH_GBN;
                },
                keyField: "SCH_GBN", // key 에 해당되는 필드명
                valueField: "GBN_NAME", // value 에 해당되는 필드명
            }
        },
        { dataField: "TITLE",
            headerText: "일정제목",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "MAIN_DEPT_CD",
            headerText: "주무부서",
            dataType: "text",
            width : "15%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_DEPT_CD;
                },
                keyField: "DEPT_CD", // key 에 해당되는 필드명
                valueField: "DEPT_NAME", // value 에 해당되는 필드명
            }
        },
        { dataField: "MST_DATE",
            visible : false
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                rowCheckToRadio  : true
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });


    //팝업 이벤트
    //팝업 닫기 이벤트
    function close_popup_onclick(){
        popupClose(popupId);
        clearInput(popupId);
    }
    //반복 클릭 시 입력부 보이기
    input_reWorkYn.addEventListener("change", () => {
        input_reWorkYn.value = input_reWorkYn.checked ? "Y" : "N";
        if(input_reWorkYn.checked){
            inputTr_Re.style.display = "table-row"
        }else{
            inputTr_Re.style.display = "none"
        }
    })

    //반복 클릭 시 입력부 보이기
    function change_input_reWorkYn(){
        if(input_reWorkYn.value == "Y"){
            inputTr_Re.style.display = "table-row"
        }else{
            inputTr_Re.style.display = "none"
        }
    }


    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            MST_DATE : search_mstDate.value,
            MST_MONTH : search_mstMonth.value,
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (data) => {
                //그리드 데이터 세팅
                AUIGrid.setGridData(grid1, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(grid1, focus, 0);
                focus = 0;
            }
        });
    }

    //그리드 추가 함수
    function add_grid1_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid1, null);
        //새행 만들기
        let selectRowItem = AUIGrid.getSelectedRows(grid1)[0];
        const item = {};
        item.REG_DATE = getToday("yyyyMMdd");
        item.MST_DATE = search_mstDate.value.replace(/-/g, "");
        item.MST_MONTH = search_mstMonth.value;
        AUIGrid.addRow(grid1, item, "selectionDown");
    }

    //그리드 저장 함수
    function save_grid1_onclick(){
        // 추가된 행 아이템들(배열)
        let addedRowItems = AUIGrid.getAddedRowItems(grid1);
        // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
        let editedRowItems = AUIGrid.getEditedRowItems(grid1);

        //검증
        let itemCount = addedRowItems.length + editedRowItems.length;
        if(itemCount == 0){
            alert("변경된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        if(!confirm("총 " + itemCount + "건의 변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_GRID1")) return;

        //포커스 지정
        focus = gridFocus(grid1);

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : ["MST_NO"],
            before : {}
        };

        //파라미터
        let saveData  = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    search_grid1_onclick();
                }else return;
            }
        });
    }

    //그리드 삭제 함수
    function delete_grid1_onclick(){

        //검증
        const checkedItems = AUIGrid.getCheckedRowItems(grid1);
        let itemCount = checkedItems.length;
        if (itemCount=== 0) {
            alert("체크된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("삭제는 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.item.TITLE).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1)

        // 체크된 행 삭제 처리
        AUIGrid.removeCheckedRows(grid1);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : AUIGrid.getRemovedItems(grid1),
            before : {}
        };

        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    search_grid1_onclick();
                }else return;
            }
        });
    }


    //그리드 저장 함수
    function schedule_onclick(){

        const checkedItems = AUIGrid.getCheckedRowItemsAll(grid1);

        let itemCount = checkedItems.length;
        if (itemCount=== 0) {
            alert("체크된 항목이 없습니다");
            return;
        }

        //포커스 지정
        focus = gridFocus(grid1);

        popupOpen(popupId);
    }

    function schedule_save_onclick(){

        const checkedItems = AUIGrid.getCheckedRowItemsAll(grid1);

        if(!confirm(checkedItems[0].TITLE + "을 일정에 등록하시겠습니까?")) return;
        if(!requireCheck("SAVE_SCHEDULE")) return;

        if(input_reWorkYn.value == 'Y'){
            let scDate =  parseDate(input_scDate.value);
            let endDate = parseDate(input_endDate.value);
            let current = new Date(scDate);
            let type = input_reWorkTime.value
            let dates = []
            while (current <= endDate) {
                let strDate = formatDate(new Date(current))
                dates.push(strDate);
                if(type == "month"){
                    let day = current.getDate();
                    current.setMonth(current.getMonth() + 1);
                    // 말일 보정
                    if (current.getDate() < day) {
                        current.setDate(0); // 이전달 마지막날
                    }
                }
                else if(type == "week"){
                    current.setDate(current.getDate() + 7);
                }
                else if(type == "day"){
                    current.setDate(current.getDate() + 1);
                }else break;
            }

            let items = [];
            dates.forEach(strDate =>{
                let item =  {}
                item.SC_DATE = strDate;
                item.SCH_GBN = checkedItems[0].SCH_GBN;
                item.TITLE = checkedItems[0].TITLE;
                item.MAIN_DEPT_CD = checkedItems[0].MAIN_DEPT_CD;
                items.push(item);
            })
        }


        //저장 데이터
        let saveParam = {
            insertParam : items,
            updateParam : null,
            key : ["MST_NO"],
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_pop1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (data) => {
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
                    if(isNull(row.TITLE)){
                        alert("제목은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                }
                break;
            case "SAVE_SCHEDULE":
                let checkedRowItems = AUIGrid.getCheckedRowItems(grid1);
                let items2 = [...checkedRowItems];
                for(const row of items2){
                    if(isNull(input_scDate.value)){
                        alert("제목은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                }
                break;
        }
        return isValid;
    }

    //crud 권한 처리 함수
    function checkCrudPermission(pgId){
        we_checkCrudPermission(pgId,{
            successPer : (data) => {
                //권한에 따라 버튼 숨김
                btnPermission(data)
            }
        });
    }

    async function getSelectOption_search_mstDate(){

        search_mstDate.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_mstDate",
            param: param,
        }
        let list = await we_getSelectOption(data);

        if(list){
            list.forEach(row => {
                search_mstDate.insertAdjacentHTML("beforeend",
                    "<option value='" + row.MST_DATE + "'>" + row.MST_DATE_FORMAT + "</option>");
            })
        }
        search_mstDate.selectedIndex = 0;
    }

    async function getSelectOption_grid1_schGbn(){
        //검색데이터
        let param = {};
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_grid1_schGbn",
            param: param,
        }
        DS_SCH_GBN = await we_getSelectOption(data);
    }


    async function getSelectOption_grid1_deptCd(){
        //검색데이터
        let param = {};
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_grid1_deptCd",
            param: param,
        }
        DS_DEPT_CD = await we_getSelectOption(data);
    }


    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, add: true, del: true, save: true});
        search_mstMonth.value = getToday("MM")
        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        Promise.all([
            getSelectOption_search_mstDate(),
            getSelectOption_grid1_schGbn(),
            getSelectOption_grid1_deptCd(),
        ]).then(function (){
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        })
    };

</script>


<%@ include file = "../../inc_footer.jsp" %>