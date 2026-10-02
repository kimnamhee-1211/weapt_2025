<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>


        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>장기수선계획등록
                </div>
                 <div class="section1_btn" id="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                        <span class="search-box">수립조정년월 :&nbsp;
                            <select id="search_planMonth" class="select_cont100"></select>&emsp;
                        </span>
                        <span class="select-container">&emsp;
                            <select id="search_code" class="select_cont150"></select>
                        </span>
                        <span class="select-container">&emsp;
                            <select id="search_subCode" class="select_cont150"></select>
                        </span>
                        <span class="select-container">&emsp;
                            <select id="search_kindCode" class="select_cont150"></select>
                        </span>
                        <span id="" class="search-box">&emsp;&emsp;&emsp;&#9726&nbsp;최초설치년월 :&nbsp; <!-- ****년 **월-->
                            <input type="month" id="input_firstYrMm" disabled>
                        </span>
                </div>
            </div>
            <div>
                <div class="gridcont_left_400">
                    <div>
                        <div id="grid1"></div>
                    </div>
                </div>
                <div class="gridcont_right_670">
                    <div class="section_middle_title" >
                        <div style="line-height:20px; padding-top:5px;"><i class="icon-pause"></i>공사종별 :&nbsp;
                            <input type="text" id="input_planGbnNm" name="PLAN_GBN_NM" disabled>
                        </div> <!--선택된 공사종별 표시-->                        
                        <div>
                            <span>&nbsp;&#9726 전면 <****>&nbsp;&#9726 부분 <****></span>
                            <!--선택된 공사종별이 시행규칙 YES 면 공사종별에 대한 수선주기 수선율 표시  예 * 전면 : 15년(100%) * 부분 : 5년(10%)-->
                            <span>&nbsp;&#9726 시행규칙 [별표1] 장기수선계획 수립기준에 없는 공사종별임.</span>
                        </div>
                    </div>
                    <div>
                        <table class="input_table" id="grid1_input">
                            <tbody>
                                <tr>
                                    <th style="width: 150px;">구분</th>
                                    <th style="width: 260px;">전면</th>
                                    <th style="width: 260px;">부분</th>
                                </tr>
                                <tr>
                                    <th>수선주기(년)등록</th>
                                    <td><input type="text" id="input_allPeriod" name="ALL_PERIOD" class="box50" oninput="inputNumFormat(this)" maxlength="3"></td>
                                    <td><input type="text" id="input_subPeriod" name="SUB_PERIOD" class="box50" oninput="inputNumFormat(this)" maxlength="3"></td>
                                </tr>
                                <tr>
                                    <th>수선율(%)등록</th>
                                    <td></td>
                                    <td><input type="text" id="input_subRate" name="SUB_RATE" class="box50"></td>
                                </tr>
                                <tr>
                                    <th>최종수선년도</th>
                                    <td><input type="text" id="input_reYearAll" name="RE_YEAR_ALL" class="box50" oninput="inputNumFormat(this)" maxlength="4"></td>
                                    <td><input type="text" id="input_reYearSub" name="RE_YEAR_SUB" class="box50" oninput="inputNumFormat(this)" maxlength="4"></td>
                                </tr>
                                <tr>
                                    <th>수선예정년도</th>   <!--최종이 있으면 최종 + 주기 , 없으면 최초년도 + 주기-->
                                    <td><input type="text" id="input_planYearAll" name="PLAN_YEAR_ALL" class="box50" oninput="inputNumFormat(this)" maxlength="4"></td>
                                    <td><input type="text" id="input_planYearSub" name="PLAN_YEAR_SUB" class="box50" oninput="inputNumFormat(this)" maxlength="4"></td>
                                </tr>
                                <tr>
                                    <th>수선계획금액</th>  <!--수정가능 저장-->
                                    <td><input type="text" id="input_planAmtAll" name="PLAN_AMT_ALL" class="box50" oninput="inputMoneyFormat(this)"></td>
                                    <td><input type="text" id="input_planAmtSub" name="PLAN_AMT_SUB" class="box50" oninput="inputMoneyFormat(this)"></td>
                                </tr>
                                <tr>
                                    <th>실시 및 계획 (전면)</th>
                                    <td colspan="2"><input type="text" id="input_planRemarks" name="PLAN_REMARKS" ></td>
                                </tr>
                                <tr>
                                    <th>실시 및 계획 (부분)</th>
                                    <td colspan="2"><input type="text" id="input_planRemarksSub" name="PLAN_REMARKS"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="section_middle_title">
                        <span><i class="icon-pause"></i>수선항목</span>
                        <span class="section_middle_btn">
                            <button id="price_btn" class="del_btn" onclick="popupOpen(popup);">단가등록</button>
                        </span>
                    </div>
                    <div>
                         <!-- 팝업시작-->
                        <div class="layer_bg" id="price_popup">
                            <div class="popup" style="width:800px;">
                                <div class="pop_title">&#10004; 단가등록</div>
                                <div id="code_title"></div>
                                <div class="pop_edit_content" style="height:300px; border: 1px solid #bcbcbc;">
                                에디터창
                                </div>
                                <div style="margin-top:10px;">
                                    <div id="grid3"></div>
                                </div>
                                <div class="pop_btn" id="pop_btn"></div>
                            </div>
                        </div>
                        <!-- 팝업끝-->
                    </div>
                    <div>
                        <div id="grid2"></div>
                    </div>
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
    let grid3;	// 팝업 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    let focus2 = 0;	//그리드 컴포넌트 포커스
    let focus3 = 0;	//그리드 컴포넌트 포커스
    const popupId = "price_popup"; //팝업 컴포넌트
    const popup = document.querySelector("#price_popup"); //팝업버튼 컴포넌트
    const pop_btn = document.querySelector("#pop_btn"); //팝업버튼 컴포넌트
    const price_btn = document.querySelector("#price_btn"); //팝업버튼 컴포넌트

    const search_planMonth = document.querySelector("#search_planMonth");
    const search_code = document.querySelector("#search_code");
    const search_subCode = document.querySelector("#search_subCode");
    const search_kindCode = document.querySelector("#search_kindCode");

    const input_firstYrMm = document.querySelector("#input_firstYrMm");
    const grid1_input = document.querySelector("#grid1_input");
    const input_allPeriod = document.querySelector("#input_allPeriod");
    const input_subPeriod = document.querySelector("#input_subPeriod");
    const input_subRate = document.querySelector("#input_subRate");
    const input_reYearAll = document.querySelector("#input_reYearAll");
    const input_reYearSub = document.querySelector("#input_reYearSub");
    const input_planYearAll = document.querySelector("#input_planYearAll");
    const input_planYearSub = document.querySelector("#input_planYearSub");
    const input_planAmtAll = document.querySelector("#input_planAmtAll");
    const input_planAmtSub = document.querySelector("#input_planAmtSub");
    const input_planRemarks = document.querySelector("#input_planRemarks");
    const input_planRemarksSub = document.querySelector("#input_planRemarksSub");

    let DS_UNIT = [];

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "CODE_NAME",
            headerText: "공사종별",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "REGUL_YN_NM",
            headerText: "시행규칙",
            dataType: "text",
            width : "20%",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                height: 611,
                editable : false,
                showRowNumColumn : false,
                displayTreeOpen: true,
                rowCheckDependingTree: true,
                treeIdField: "CD",
                treeIdRefField: "UP_CD",
                flat2tree: true,
            })
    );

    const grid2ColumnLayout = [
        { dataField: "ITEM_NAME",
            headerText: "품목/규격",
            dataType: "text",
            width : "*%",
        },
        { dataField: "UNIT_NM",
            headerText: "단위",
            dataType: "text",
            width : "10%",
        },
        { dataField: "CNT",
            headerText: "수량",
            dataType: "numeric",
            formatString : "#,###",
            width : "20%",
        },
        { dataField: "AMT",
            headerText: "금액",
            dataType: "numeric",
            formatString : "#,###",
            width : "25%",
        },
    ];

    const footerLayout2 = [{
        dataField: "CNT",
        positionField: "CNT",
        operation: "SUM",
        formatString: "#,###",
    }, {
        dataField: "AMT",
        positionField: "AMT",
        operation: "SUM",
        formatString: "#,###",
    }];

    //그리드 생성
    grid2 = AUIGrid.create("#grid2", grid2ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                height: 257,
                editable : false,
                showRowCheckColumn : false,
                enabled : false,
                showFooter: true,
            })
    );
    AUIGrid.setFooter(grid2, footerLayout2);

    const grid3ColumnLayout = [
        { dataField: "ITEM_NAME",
            headerText: "품목",
            dataType: "text",
            width : "*%",
        },
        { dataField: "ITEM",
            headerText: "규격",
            dataType: "text",
            width : "10%",
        },
        { dataField: "UNIT",
            headerText: "단위",
            dataType: "text",
            width : "10%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_UNIT;
                },
                keyField: "UNIT", // key 에 해당되는 필드명
                valueField: "UNIT_NAME", // value 에 해당되는 필드명
            }
        },
        { dataField: "CNT",
            headerText: "수량",
            dataType: "numeric",
            formatString :"#,###",
            width : "10%",
        },
        { dataField: "UNIT_PRICE",
            headerText: "적용단가",
            dataType: "numeric",
            formatString : "#,###",
            width : "15%",
        },
        { dataField: "AMT",
            headerText: "금액",
            dataType: "numeric",
            formatString : "#,###",
            width : "20%",
            expFunction : function(rowIndex, columnIndex, item, dataField) {
                return Number( item.CNT * item.UNIT_PRICE );
            }
        },
        { dataField: "REMARKS",
            headerText: "비고",
            dataType: "text",
            width : "15%",
        },
    ];

    const footerLayout3 = [{
        dataField: "CNT",
        positionField: "CNT",
        operation: "SUM",
        formatString: "#,###",
    }, {
        dataField: "UNIT_PRICE",
        positionField: "UNIT_PRICE",
        operation: "SUM",
        formatString: "#,###",
    }, {
        dataField: "AMT",
        positionField: "AMT",
        operation: "SUM",
        formatString: "#,###",
    }];

    //그리드 생성
    grid3 = AUIGrid.create("#grid3", grid3ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                height: 263,
                showFooter: true,
                width : 770
            })
    );
    AUIGrid.setFooter(grid3, footerLayout3);

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });
    AUIGrid.bind(grid3, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid3, event.rowIndex, 0);
    });
    //셀 선택 변경 이벤트 바인딩
    AUIGrid.bind(grid1, "selectionChange", function(event) {
        gridToInput(grid1, grid1_input);
        if(AUIGrid.getSelectedRows(grid1)[0].CLOSE_YN ==  "1"){
            btnEnable({  tag: "#section1_btn", grid: "grid1", save : false, del : false});
            grid1_input.disabled = true;
            price_btn.disabled = true;
            search_grid2_onclick();
        }
        if(AUIGrid.getSelectedRows(grid1)[0].LEVEL !=  "3"){
            btnEnable({  tag: "#section1_btn", grid: "grid1", save : false, del : false});
            grid1_input.disabled = true;
            price_btn.disabled = true;
            AUIGrid.clearGridData(grid2);
        }else{
            btnEnable({  tag: "#section1_btn", grid: "grid1", save : true, del : true});
            grid1_input.disabled = false;
            price_btn.disabled = false;
            search_grid2_onclick();
        }
    });


    //팝업 이벤트
    price_btn.addEventListener("click", function (){
        getSelect_grid3_unit();
        search_grid3_onclick();
    })


    //팝업 닫기 이벤트
    function close_popup_onclick(){
        popupClose(popup);
        clearInput(popup);
    }

    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
            PLAN_MONTH : search_planMonth.value,
            CODE : search_code.value,
            SUB_CODE : search_subCode.value,
            KIND_CODE : search_kindCode.value,
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
            SEQ : AUIGrid.getSelectedRows(grid1)[0].SEQ,
            CODE : AUIGrid.getSelectedRows(grid1)[0].CODE,
            SUB_CODE : AUIGrid.getSelectedRows(grid1)[0].SUB_CODE,
            KIND_CODE : AUIGrid.getSelectedRows(grid1)[0].KIND_CODE,
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

    function search_grid3_onclick(){

        //검색데이터
        let selectParam = {
            PLAN_MONTH : AUIGrid.getSelectedRows(grid1)[0].PLAN_MONTH,
            SEQ : AUIGrid.getSelectedRows(grid1)[0].SEQ,
            CODE : AUIGrid.getSelectedRows(grid1)[0].CODE,
            SUB_CODE : AUIGrid.getSelectedRows(grid1)[0].SUB_CODE,
            KIND_CODE : AUIGrid.getSelectedRows(grid1)[0].KIND_CODE,
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_grid3",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                //그리드 데이터 세팅
                AUIGrid.setGridData(grid3, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(grid3, focus3, 0);
                focus3 = 0;
            }
        });
    }

    //그리드 추가 함수
    function add_grid3_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid3, null);
        //새행 만들기
        const item = {};
        AUIGrid.addRow(grid3, item, "first");
    }

    //그리드 저장 함수
    function save_grid1_onclick(){

        if( AUIGrid.getSelectedRows(grid1)[0].CLOSE_YN == "1"){
            alert("이미 마감된 수립조정은 공사종별을 수정할 수 없습니다.");
            return;
        }

        // 추가된 행 아이템들(배열)
        // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
        let editedRowItems = AUIGrid.getEditedRowItems(grid1);

        //검증
        let itemCount = editedRowItems.length;
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
            insertParam : null,
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

    function save_grid3_onclick(){

        if( AUIGrid.getSelectedRows(grid1)[0].CLOSE_YN == "1"){
            alert("이미 마감된 수립조정은 수선항목을 저장할 수 없습니다.");
            return;
        }

        // 추가된 행 아이템들(배열)
        let addedRowItems = AUIGrid.getAddedRowItems(grid3);
        // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
        let editedRowItems = AUIGrid.getEditedRowItems(grid3);

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
        if(!requireCheck("SAVE_GRID3")) return;

        //포커스 지정
        focus3 = gridFocus(grid3);

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
            component : pgId + "_grid3",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    //팝업 닫기
                    search_grid3_onclick();
                    let amt = AUIGrid.getColumnValues(grid3, "AMT")
                    let amts = 0;
                    amt.forEach(row => amts += row)
                    input_planAmtAll.value = amts;
                    save_grid1_onclick();
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
        if (!confirm(" 공사종별(" + param.CODE_NAME + ")을 삭제하시겠습니까?")) return;

        //포커스 지정
        focus = AUIGrid.getSelectedIndex(grid1)[0] - 1 < 1 ? 0 : AUIGrid.getSelectedIndex(grid1)[0] - 1 ;

        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_grid1_onclick();
                    search_grid3_onclick();
                }else return;
            }
        });
    }

    function delete_grid3_onclick(){
        const grid1Item = AUIGrid.getSelectedRows(grid1)[0];
        //검증
        if(grid1Item.CLOSE_YN == "1"){
            alert("이미 마감된 수립조정은 삭제할 수 없습니다.");
            return;
        }
        const checkedItems = AUIGrid.getCheckedRowItems(grid3);
        let itemCount = checkedItems.length;
        if (itemCount=== 0) {
            alert("선택된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("삭제는 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.item.ITEM_NAME).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus3 = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1)

        // 체크된 행 삭제 처리
        AUIGrid.removeCheckedRows(grid3);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : AUIGrid.getRemovedItems(grid3),
            before : {}
        };

        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId :  sectionId,
            component : pgId + "_grid3",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_grid2_onclick();
                    search_grid3_onclick();
                }else return;
            }
        });
    }

    //컴포넌트 필수항목 입력 체크
    function requireCheck(require){
        let isValid = true;
        switch(require){
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

    async function getSelect_grid3_unit(){
        let  code = await we_getCode('118');
        code.forEach(row=>{
            let item = {};
            item.UNIT = row.CODE_NO;
            item.UNIT_NAME = row.CODEDTL_NM;
            DS_UNIT.push(item);
        });
    }

    async function getSelect_search_planMonth(){
        search_planMonth.innerHTML = "";
        //검색데이터
        let param = {
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_planMonth",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            list.forEach(row => {
                search_planMonth.insertAdjacentHTML("beforeend",
                    "<option value='" + row.PLAN_MONTH + "'>" + row.PLAN_MONTH_NM + "</option>");
            })
        }
        search_planMonth.selectedIndex = 0;
        input_firstYrMm.value = list[0].FIRST_YR_MM;
    }

    async function getSelect_search_code(){
        search_code.innerHTML = "";
        //검색데이터
        let param = {
            PLAN_MONTH : search_planMonth.value
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_code",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            search_code.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");
            list.forEach(row => {
                search_code.insertAdjacentHTML("beforeend",
                    "<option value='" + row.CODE + "'>" + row.CODE_NAME + "</option>");
            })
        }
        search_code.selectedIndex = 0;
    }
    async function getSelect_search_subCode(){
        search_subCode.innerHTML = "";
        //검색데이터
        let param = {
            PLAN_MONTH : search_planMonth.value,
            CODE : search_code.value
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_subCode",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            search_subCode.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");
            list.forEach(row => {
                search_subCode.insertAdjacentHTML("beforeend",
                    "<option value='" + row.SUB_CODE + "'>" + row.CODE_NAME + "</option>");
            })
        }
        search_subCode.selectedIndex = 0;
    }
    async function getSelect_search_kindCode(){
        search_kindCode.innerHTML = "";
        //검색데이터
        let param = {
            PLAN_MONTH : search_planMonth.value,
            CODE : search_code.value,
            SUB_CODE : search_subCode.value
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_kindCode",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            search_kindCode.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");
            list.forEach(row => {
                search_kindCode.insertAdjacentHTML("beforeend",
                    "<option value='" + row.KIND_CODE + "'>" + row.CODE_NAME + "</option>");
            })
        }
        search_kindCode.selectedIndex = 0;
    }

    search_planMonth.addEventListener("change", function (){
        getSelect_search_code();
        getSelect_search_subCode();
        getSelect_search_kindCode();
    })
    search_code.addEventListener("change", function (){
        getSelect_search_subCode();
        getSelect_search_kindCode();
    })
    search_subCode.addEventListener("change", function (){
        getSelect_search_kindCode();
    })
    input_allPeriod.addEventListener("input", function (){
        let yearAll = input_reYearAll.value ? input_reYearAll.value : input_firstYrMm.value.substring(0,4);
        input_planYearAll.value = Number(input_allPeriod.value) + Number(yearAll);
    })
    input_reYearAll.addEventListener("input", function (){
        let yearAll = input_reYearAll.value ? input_reYearAll.value : input_firstYrMm.value.substring(0,4);
        input_planYearAll.value = Number(input_allPeriod.value) + Number(yearAll);
    })
    input_subPeriod.addEventListener("chinputange", function (){
        let yearSub = input_reYearSub.value ? input_reYearSub.value : input_firstYrMm.value.substring(0,4);
        input_planYearSub.value = Number(input_subPeriod.value) +  Number(yearSub);
    })
    input_reYearSub.addEventListener("input", function (){
        let yearSub = input_reYearSub.value ? input_reYearSub.value : input_firstYrMm.value.substring(0,4);
        input_planYearSub.value = Number(input_subPeriod.value) +  Number(yearSub);
    })
    input_subRate.addEventListener("input", function (){
        let amt = AUIGrid.getColumnValues(grid2,"AMT")
        let amts = 0;
        amt.forEach(row => amts += row);
        input_planAmtSub.value = amts * (Number(input_subRate.value)/100);
    })

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid: "grid1", search : true, save:true, del: true});
        btnMaker({ tag: "#pop_btn", grid: "grid3", add: true, save : true, del : true});
        pop_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");

        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        Promise.all([
            getSelect_search_planMonth(),
            getSelect_search_code(),
            getSelect_search_subCode(),
            getSelect_search_kindCode(),
        ]).then(function(){
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        })

    };

</script>

<%@ include file = "../../inc_footer.jsp" %>