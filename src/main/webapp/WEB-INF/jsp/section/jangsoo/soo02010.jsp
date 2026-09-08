<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                <i class="icon-recycle"></i>수립기준
                </div>
                <div class="section1_btn" id="input">
                    최초설치년월 : <input type="month" id="input_firstYrMm">
                    <button id="init_btn" onclick="save_init_onclick()">저장</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line0" style="margin-bottom: 0px;"></div>
            </div>
            <div id="" class="soo020100_gridcontainer">
                <div class="gridcont_left_200">
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>수립조정상태</span>                
                    </div>
                    <div style="height: 612px;" id="grid1"></div>
                </div>
                <div class="gridcont_right_870">
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>수립조정기초</span>
                        <span class="section_middle_btn" id="section_middle_btn"></span>
                        <span class="search-box section_middle_btn">
                            <button id="change_btn" class="del_btn" onclick="popupOpen(popupId);">조정년월변경</button>
                             <!-- 변경 팝업시작--> 
                            <div class="layer_bg" id="change_popup">
                                <div class="popup" style="width:420px;">
                                    <div class="pop_title">&#10004;조정년월변경</div>
                                        <div style="height:100px; padding: 15px; border: 1px solid #bcbcbc;">
                                            <div id="">&#9726&nbsp;변경전 수립조정년월 :&nbsp;
                                                <input type="month" id="pop_planMonth" name="PLAN_MONTH" data-format="date"><!--변경전 수립조정년월 표시 2024년 03월-->
                                            </div>
                                            <span class="search-box">&#9726&nbsp;변경후 수립조정년월 :&nbsp;
                                                <input type="month" id="pop_changePlanMonth" name="CHANGE_PLAN_MONTH" data-format="date">
                                            </span>
                                        </div>
                                    <div class="pop_btn" id="pop_btn"></div>
                                </div>
                            </div>
                            <!-- 팝업끝-->
                            <button id="copy_btn" class="del_btn" onclick="popupOpen(popupId2);">복사</button>
                             <!-- 팝업시작--> 
                            <div class="layer_bg" id="copy_popup">
                                <div class="popup" style="width:420px;">
                                    <div class="pop_title">&#10004;수선계획복사</div>
                                    <div style="height:290px; padding: 15px; border: 1px solid #bcbcbc;">
                                        <div>&#9726&nbsp;복사원년 :&nbsp;
                                            <input type="month" id="pop2_copyPlanMonth" name="COPY_PLAN_MONTH" data-format="date" disabled>
                                        </div>  <!--복사대상 년월 2024년 03월-->
                                        <div class="select-container">&#9726&nbsp;구분 :&nbsp;
                                            <select id="pop2_planGbn" name="PLAN_GBN" class="select_cont100">
                                                <option value="2" selected>정기</option> <!-- 기존의 조정 -->
                                                <option value="3">수시</option>
                                                <option value="1">수립</option>
                                            </select>
                                        </div>
                                        <div class="search-box">&#9726&nbsp;수립조정년월 :&nbsp;
                                            <input type="month" id="pop2_planMonth" name="PLAN_MONTH" data-format="date">
                                        </div>
                                        <div class="search-box">&#9726&nbsp;총계획기간 :&nbsp;
                                            <select id="pop2_planStYear" name="PLAN_ST_YEAR" class="select_cont70"></select>&emsp;~&emsp;
                                            <select id="pop2_planEndYear" name="PLAN_END_YEAR" class="select_cont70"></select>
                                        </div>
                                        <div class="search-box">&#9726&nbsp;수립조정관계자 :&nbsp;
                                            <input type="text" id="pop2_planUser" name="PLAN_USER" style="width:200px;">
                                        </div>
                                        <div class="search-box">&#9726&nbsp;수립(조정)일 현재 충당금잔액 :&nbsp;
                                            <input type="text" id="pop2_readyAmt" name="READY_AMT" oninput="inputMoneyFormat(this)" style="width:150px;">
                                        </div>
                                        <div class="search-box">&#9726&nbsp;단가(금액)할증율 :&nbsp;
                                            <input type="text" id="pop2_" name="" oninput="inputNumFormat(this)" style="width:100px;">&nbsp;%
                                        </div>
                                    </div>
                                    <div class="pop_btn" id="pop2_btn"></div>
                                </div>
                            </div>
                            <!-- 팝업끝-->
                        </span>
                    </div>
                    <div class="section2">
                        <div id="grid1_input" class="section2_line2" onchange="inputToGrid(grid1, grid1_input)" >
                            <div>
                                <span class="select-container">구분 :&nbsp;
                                    <select  id="input_planGbn" name="PLAN_GBN" class="select_cont100">
                                        <option value="2" selected>정기</option> <!-- 기존의 조정 -->
                                        <option value="3">수시</option>
                                        <option value="1">수립</option>
                                    </select>
                                </span>
                                <span class="search-box">&emsp;&emsp;&emsp;&emsp;&emsp;수립조정년월 :&nbsp;
                                    <input type="month" id="input_planMonth" name="PLAN_MONTH" data-format="date" disabled>
                                </span>
                                <span class="search-box">&emsp;&emsp;&emsp;&emsp;&emsp;총계획기간 :&nbsp;
                                    <select id="input_planStYear" name="PLAN_ST_YEAR" class="select_cont70"></select>&emsp;~&emsp;
                                    <select id="input_planEndYear" name="PLAN_END_YEAR" class="select_cont70"></select>
                                </span>
                            </div>
                            <div>
                                <span class="search-box">수립조정관계자 :&nbsp;
                                    <input type="text" id="input_planUser" name="PLAN_USER" style="width:309px;">
                                </span>
                                <span class="search-box">&emsp;&emsp;&emsp;&emsp;수립(조정)일 현재 충당금잔액 :&nbsp;
                                    <input type="text" id="input_readyAmt" name="READY_AMT" oninput="inputMoneyFormat(this)" style="width:150px;">
                                </span>
                            </div>
                        </div> 
                    </div>
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>공사종별수립기준</span>
                        <span class="section_middle_btn">
                            <button id="add_btn" class="del_btn" onclick="popupOpen(popupId3);">공사종별추가</button>
                             <!-- 팝업시작--> 
                            <div class="layer_bg" id="add_popup">
                                <div class="popup" style="width:900px;">
                                    <div class="pop_title">&#10004; 공사종별추가</div>
                                    <div>
                                        <span>&emsp;&#9726&nbsp;검색조건 :&nbsp;</span>
                                        <span class="select-container">&emsp;
                                            <select id="jan_label_1" name="" class="select_cont150">
                                                <option value="jan_label_1"><****></option>
                                            </select>
                                        </span>
                                        <span class="select-container">&emsp;
                                            <select id="jan_label_2" name="" class="select_cont150">
                                                <option value="jan_label_2"><****></option>
                                            </select>
                                        </span>
                                        <span class="select-container">&emsp;
                                            <select id="jan_label_3" name="" class="select_cont150">
                                                <option value="jan_label_3"><****></option>
                                            </select>
                                        </span>
                                        <span class="select-container">&emsp;시행규칙 :&nbsp;
                                            <select id="rule" name="" class="select_cont70">
                                                <option value="all">전체</option>
                                                <option value="yes">Y</option>
                                                <option value="no">N</option>
                                            </select>
                                        </span>
                                        <span class="section_middle_btn">
                                            <button id="search_btn" onclick="">검색</button>&emsp;
                                        </span>
                                    </div>
                                    <div style="height: 600px;" id="pop3Grid1"></div>
                                    &emsp;&#9726&nbsp;이미 선택된 공사종별도 추가선택 저장이 가능합니다.
                                    <div class="pop_btn" id="pop3_btn"></div>
                                </div>
                            </div>
                            <!-- 팝업끝--> 
                        </span>
                    </div>
                    <div id="grid2"></div>
                </div>
            </div>            
        </div>

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
    const sectionId = "${sectionId}";	//섹션ID
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let grid2;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    let focus2 = 0;	//그리드 컴포넌트 포커스
    const popupId = "change_popup"; //팝업 컴포넌트
    const popupId2 = "copy_popup"; //팝업 컴포넌트
    const popupId3 = "add_popup"; //팝업 컴포넌트

    const pop_btn = document.querySelector("#pop_btn"); //팝업버튼 컴포넌트
    const pop2_btn = document.querySelector("#pop2_btn"); //팝업버튼 컴포넌트
    const pop3_btn = document.querySelector("#pop2_btn"); //팝업버튼 컴포넌트

    const change_btn = document.querySelector("#change_btn"); //팝업버튼 컴포넌트
    const copy_btn = document.querySelector("#copy_btn"); //팝업버튼 컴포넌트
    const add_btn = document.querySelector("#add_btn"); //팝업버튼 컴포넌트
    const init_btn = document.querySelector("#init_btn"); //팝업버튼 컴포넌트

    const input_firstYrMm = document.querySelector("#input_firstYrMm"); //input 컴포넌트

    const grid1_input = "grid1_input"; //input 컴포넌트
    const input_planGbn    = document.querySelector("#input_planGbn");
    const input_planStYear = document.querySelector("#input_planStYear");
    const input_planEndYear = document.querySelector("#input_planEndYear");
    const input_planUser   = document.querySelector("#input_planUser");
    const input_readyAmt   = document.querySelector("#input_readyAmt");
    const input_planMonth = document.querySelector("#input_planMonth"); //input 컴포넌트

    const change_popup   = document.querySelector("change_popup");
    const pop_planMonth   = document.querySelector("#pop_planMonth");
    const pop_changePlanMonth   = document.querySelector("#pop_changePlanMonth");

    const copy_popup        = document.querySelector("#copy_popup");
    const pop2_copyPlanMonth  = document.querySelector("#pop2_copyPlanMonth");
    const pop2_planGbn      = document.querySelector("#pop2_planGbn");
    const pop2_planMonth    = document.querySelector("#pop2_planMonth");
    const pop2_planStYear   = document.querySelector("#pop2_planStYear");
    const pop2_planEndYear  = document.querySelector("#pop2_planEndYear");
    const pop2_planUser     = document.querySelector("#pop2_planUser");
    const pop2_readyAmt     = document.querySelector("#pop2_readyAmt");


    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "PLAN_GBN",
            headerText: "구분",
            dataType: "text",
            width : "30%",
            editable : false,
        },
        { dataField: "PLAN_MONTH",
            headerText: "년월",
            dataType: "date",
            formatString: "yyyy-mm",
            width : "*%",
            editable : false,
        },
        { dataField: "CLOSE_NANE",
            headerText: "상태",
            dataType: "text",
            width : "30%",
        },
        { dataField: "PLAN_ST_YEAR",
            visible : false
        },
        { dataField: "PLAN_END_YEAR",
            visible : false
        },

    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
                showRowNumColumn : false,
                showRowCheckColumn : false,
                enabled : false
            })
    );

    const grid2ColumnLayout = [
        { dataField: "CODE_NAME",
            headerText: "공사종별",
            dataType: "text",
            width : "*%",
            editable : false,
        },
        { dataField: "REGUL_YN",
            headerText: "시행규칙",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { headerText: "전면",
            children : [{
                dataField : "ALL_PERIOD",
                headerText : "수선주기",
                width : "8%",
                editable : false,
            }]
        },
        { headerText: "부분",
            children : [{
                dataField : "SUB_PERIOD",
                headerText : "수선주기",
                width : "8%",
                editable : false,
            }, {
                dataField : "SUB_RATE",
                headerText : "수선율",
                width : "8%",
                editable : false,
            }]
        },
        { dataField: "REMARKS",
            headerText: "비고",
            dataType: "text",
            width : "20%",
        },
        { dataField: "END_YEAR",
            headerText: "만기년도",
            dataType: "text",
            width : "8%",
            editRenderer : {
                type : "InputEditRenderer",
                onlyNumeric : true, // 0~9 까지만 허용
                maxlength : 4,
            }
        },
    ];

    //그리드 생성
    grid2 = AUIGrid.create("#grid2", grid2ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                height: 490,
                showRowCheckColumn : false
            })
    );

    const pop3Grid1ColumnLayout = [
        { dataField: "SEQ",
            headerText: "",
            dataType: "text",
            width : "8%",
            renderer : {
                type : "CheckBoxEditRenderer",
                showLabel : true
            },
            disabledFunction :  function(rowIndex, columnIndex, value, isChecked, item, dataField ) {
                if(item.LEVEL != "3") {
                    return true;
                }
                return false;
            }
        },
        { dataField: "CODE_NAME",
            headerText: "공사종별",
            dataType: "text",
            width : "*%",
            editable : false,
        },
        { dataField: "REGUL_YN",
            headerText: "시행규칙",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { headerText: "전면",
            children : [{
                dataField : "ALL_PERIOD",
                headerText : "수선주기",
                width : "8%",
                editable : false,
            }]
        },
        { headerText: "부분",
            children : [{
                dataField : "SUB_PERIOD",
                headerText : "수선주기",
                width : "8%",
                editable : false,
            }, {
                dataField : "SUB_RATE",
                headerText : "수선율",
                width : "8%",
                editable : false,
            }]
        },
        { dataField: "REMARKS",
            headerText: "비고",
            dataType: "text",
            width : "20%",
            editable : false,
        },
    ];

    //그리드 생성
    pop3Grid1 = AUIGrid.create("#pop3Grid1", pop3Grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                height: 490,
                showRowNumColumn : false,
                displayTreeOpen: true,
                rowCheckDependingTree: true,
                treeIdField: "CD",
                treeIdRefField: "UP_CD",
                flat2tree: true,
            })
    );


    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });
    //셀 선택 변경 이벤트 바인딩
    AUIGrid.bind(grid1, "selectionChange", function(event) {
        gridToInput(grid1, grid1_input);
        pop_planMonth.value = AUIGrid.getSelectedRows(grid1)[0].PLAN_MONTH
        pop2_copyPlanMonth.value = AUIGrid.getSelectedRows(grid1)[0].PLAN_MONTH
        if(AUIGrid.isAddedById(grid1, event.rowIdValue)){
            change_btn.disable = true;
            copy_btn.disable = false;
            add_btn.disable = true;
            input_planMonth.disable = false;
            AUIGrid.clearGridData(grid2);
        }else{
            if(AUIGrid.getSelectedRows(grid1)[0].CLOSE_YN ==  "1"){
                btnEnable({ grid: "grid1", save : false});
                change_btn.disable = true;
                copy_btn.disable = true;
                add_btn.disable = true;
            }else{
                btnEnable({ grid: "grid1", save : true});
                change_btn.disable = false;
                copy_btn.disable = true;
                add_btn.disable = false;
            }
            input_planMonth.disable = true;
            search_grid2_onclick();
        }
    });


    //팝업 이벤트

    //팝업 닫기 이벤트
    function close_popup_onclick(){
        popupClose(popupId);
        clearInput(popupId);
    }
    function close_popup2_onclick(){
        popupClose(popupId2);
        clearInput(popupId2);
    }
    function close_popup3_onclick(){
        popupClose(popupId3);
        clearInput(popupId3);
    }

    function search_input1_onclick(){
        //검색데이터
        let selectParam = {
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_input1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                if(data.length > 0){
                    input_firstYrMm.value = data[0].FIRST_YR_MM;
                    input_firstYrMm.disable = true
                    init_btn.disable = true;

                }else{
                    input_firstYrMm.value = '';
                    input_firstYrMm.disable = false
                    init_btn.disable = false;
                }
            }
        });
    }

    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {

        }
        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                //그리드 데이터 세팅
                AUIGrid.setGridData(grid1, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(grid1, focus, 0);
                focus = 0;
            }
        });
    }

    function search_grid2_onclick(){

        //검색데이터
        let selectParam = {
            PLAN_MONTH : AUIGrid.getSelectedRows(grid1)[0].PLAN_MONTH,
            SEQ : AUIGrid.getSelectedRows(grid1)[0].SEQ
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_grid2",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                //그리드 데이터 세팅
                AUIGrid.setGridData(grid2, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(grid2, focus2, 0);
                focus2 = 0;
            }
        });
    }

    function search_add_onclick(){

        //검색데이터
        let selectParam = {
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_pop3Grid1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                //그리드 데이터 세팅
                AUIGrid.setGridData(pop3Grid1, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(pop3Grid1, 0, 0);
            }
        });
    }



    //그리드 추가 함수
    function add_grid1_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid1, null);
        //새행 만들기
        const item = {};
        AUIGrid.addRow(grid1, item, "first");
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
            key : {},
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    //팝업 닫기
                    search_grid1_onclick()
                }else return;
            }
        });
    }

    //수립년월 변경
    function save_change_onclick(){

        if(AUIGrid.getSelectedRows(grid1)[0].CLOSE_YN == "1"){
            alert("이미 마감된 수립조정은 조정년월을 변경할 수 없습니다.");
            return;
        }

        let param = {
            PLAN_MONTH : pop_planMonth.value,
            CHANGE_PLAN_MONTH : pop_changePlanMonth.value,
            SEQ : AUIGrid.getSelectedRows(grid1)[0].SEQ
        }

        if(!requireCheck("SAVE_CHANGE")) return;

        if(!confirm("수립조정년월을 " + pop_planMonth.value + "에서 "
            + pop_changePlanMonth.value + "로 변경하시겠습니까?")) return;

        //포커스 지정
        focus = gridFocus(grid1);

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_change",
            param: param,
        }

        we_update( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    //팝업 닫기
                    search_grid1_onclick()
                }else return;
            }
        });
    }

    //복사
    function save_copy_onclick(){

        if(AUIGrid.getSelectedRows(grid1)[0].CLOSE_YN != "1"){
            alert("마감된 수립조정만 복사할 수 있습니다.");
            return;
        }

        let param = inputToData(popupId2);

        if(!requireCheck("SAVE_COPY")) return;

        if(!confirm("수립조정년월(" + pop2_copyPlanMonth.value + ")을" + "수립조정년월(" + pop2_planMonth.value +
            ")로 복사하시겠습니까?")) return;

        //포커스 지정
        focus = gridFocus(grid1);

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_copy",
            param: param,
        }

        we_insert( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    //팝업 닫기
                    search_grid1_onclick()
                }else return;
            }
        });
    }

    function save_add_onclick(){

        if(AUIGrid.getSelectedRows(grid1)[0].CLOSE_YN == "1"){
            alert("이미 마감된 수립조정은 공사종별수립기준을 변경할 수 없습니다.");
            return;
        }

        let param = AUIGrid.getCheckedRowItemsAll(pop3Grid1);

        let itemCount = param.length;
        if (itemCount === 0) {
            alert("체크된 항목이 없습니다");
            return;
        }

        param.forEach(row => {
            row.PLAN_MONTH = AUIGrid.getSelectedRows(grid1)[0].PLAN_MONTH
            row.SEQ = AUIGrid.getSelectedRows(grid1)[0].SEQ
            row.CLOSE_YN = AUIGrid.getSelectedRows(grid1)[0].CLOSE_YN
        })

        if(!requireCheck("SAVE_COPY")) return;

        if(!confirm("공사종별수립기준을 저장하시겠습니까?")) return;

        //파라미터
        let saveData  = {
            sectionId :  sectionId,
            component : pgId + "_add",
            param: param,
        }

        we_insert( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    //팝업 닫기
                    search_grid1_onclick()
                }else return;
            }
        });
    }



    //그리드 삭제 함수
    function delete_grid1_onclick(){
        const param = AUIGrid.getSelectedRows(grid1)[0];

        //검증
        if(param.CLOSE_YN == "1"){
            alert("이미 마감된 수립조정은 삭제할 수 없습니다.");
            return;
        }
        if (!confirm(" 수립조정기준(" + checkedItem.PLAN_MONTH + ")을 삭제하시겠습니까?")) return;

        //포커스 지정
        focus = (param.rowIndex -1) < 1 ? 0 : (param.rowIndex -1);

        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
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
                    if(isNull(row.PLAN_MONTH)){
                        alert("관리년월은 반드시 입력해야 합니다.");
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


    async function getSelect_input_year(){
        input_planStYear.innerHTML = "";
        input_planEndYear.innerHTML = "";
        pop2_planStYear.innerHTML = "";
        pop2_planEndYear.innerHTML = "";
        let thisYear = getToday("yyyy");
        for(let year = thisYear - 50 ; year <= (thisYear + 20); year++){
            input_planStYear.insertAdjacentHTML("beforeend",
                "<option value='" + year + "'>" + year + "</option>");
            input_planEndYear.insertAdjacentHTML("beforeend",
                "<option value='" + year + "'>" + year + "</option>");
            pop2_planStYear.insertAdjacentHTML("beforeend",
                "<option value='" + year + "'>" + year + "</option>");
            pop2_planEndYear.insertAdjacentHTML("beforeend",
                "<option value='" + year + "'>" + year + "</option>");
        }
        input_planStYear.value = thisYear;
        input_planEndYear.value = thisYear;
        pop2_planStYear.value = thisYear;
        pop2_planEndYear.value = thisYear;
    }

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section_middle_btn", grid: "grid1", search : true, add : true, save:true, print : true});
        btnMaker({ tag: "#pop_btn", grid: "change", save : true});
        pop_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");
        btnMaker({ tag: "#pop2_btn", grid: "copy", save : true});
        pop2_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup2_onclick()'>닫기</button>");
        btnMaker({ tag: "#pop3_btn", grid: "add", search: true, save : true});
        pop3_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup3_onclick()'>닫기</button>");
        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        Promise.all([
            //그리드 DDL
            getSelect_input_year(),
        ]).then(function (){
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        })
    };

</script>

<%@ include file = "../../inc_footer.jsp" %>