<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>

    <div id="section">
        <div class="section1">
            <div class="section1_nav">
                <i class="icon-recycle"></i>동별면적현황
            </div>
        </div>
        <div class="section2">
            <div class="section2_line0"></div>
        </div>
        <div id="we_grid" class="soo01020_grid">
            <div class="gridcont_left_450">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>관리대상</span>
                    <span class="section_middle_btn" id="section_middle_btn1"></span>
                </div>
                <div id="grid1">
                </div>
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>관리면적</span>
                    <span class="section_middle_btn" id="section_middle_btn2"></span>
                </div>
                <div id="grid2"></div>
            </div>
            <div class="gridcont_right_620">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>동별현황</span>
                    <span class="section_middle_btn" id="section_middle_btn3"></span>
                </div>
                <div id="grid3"></div>
            </div>
        </div>
    </div>

<script>
    /** 작성 순서
     *
     * 변수 선언 :  pgId, 컴포넌트, 컴포넌트 포커스
     * 그리드 설정
     * 그리드 생성
     * 그리드 이벤트 : 체크박스 클릭 시 셀렉트 이벤트(엑스트라 체크박스 있을 시) + 필요 시
     * 그리드 조회 함수
     * 그리드 추가 함수    (미사용시 생략)
     * 그리드 저장 함수    (미사용시 생략)
     * 그리드 삭제 함수    (미사용시 생략)
     * 컴포넌트 필수항목 입력 체크    (미사용시 생략)
     * crud 권한 처리 호출 함수
     * select option 조회 함수    (미사용시 생략)
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
    const sectionId = "${sectionId}";	//섹션ID
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let grid2;	// 그리드 컴포넌트
    let grid3;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    let focus2 = 0;	//그리드 컴포넌트 포커스
    let focus3 = 0;	//그리드 컴포넌트 포커스

    let DS_APT_TYPE = [
        {
            CD : "1",
            NAME : "계단식"
        },
        {
            CD : "2",
            NAME : "복도식"
        },
        {
            CD : "3",
            NAME : "혼합식"
        }
    ];
    let DS_MANAGE_NO;

    //그리드1 설정
    const grid1ColumnLayout = [
        { dataField: "MANAGE_NO",
            headerText: "관리번호",
            dataType: "text",
            width : "20%",
            enable: false
        },
        { dataField: "MANAGE_NM",
            headerText: "관리대상",
            dataType: "text",
            width : "60%",
        },
        { dataField: "USE_YN",
            headerText: "사용여부",
            width : "20%",
            renderer : we_cb_10_Renderer
        }
    ];

    //그리드1 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowNumColumn : false,
                height : 180
            })
    );

    //그리드2 설정
    const grid2ColumnLayout = [
        {
            dataField: "SEQ",
            headerText: "번호",
            dataType: "text",
            width: "15%",
            enable: false
        },
        { dataField: "AREAR",
            headerText: "면적",
            dataType: "text",
            formatString: "#,##0",
            width : "30%",
            editRenderer : {
                type : "InputEditRenderer",
                onlyNumeric : true, // 0~9 까지만 허용
                maxlength : 6,
            }
        },
        { dataField: "HOUSEHOLDS_NUMBER",
            headerText: "세대수",
            dataType: "text",
            width : "25%",
            editRenderer : {
                type : "InputEditRenderer",
                onlyNumeric : true, // 0~9 까지만 허용
                maxlength : 6,
            }
        },
        { dataField: "TOT_AREAR",
            headerText: "면적계",
            dataType: "text",
            formatString: "#,##0",
            width : "30%",
            editRenderer : {
                type : "InputEditRenderer",
                onlyNumeric : true, // 0~9 까지만 허용
                maxlength : 6,
            }
        },
    ];

    //그리드2 생성
    grid2 = AUIGrid.create("#grid2", grid2ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowNumColumn: false,
                height : 395
            })
    );

    //그리드3 설정
    const grid3ColumnLayout = [
        { dataField: "DONG",
            headerText: "동",
            dataType: "text",
            width : "15%",
        },
        { dataField: "HOUSEHOLDS_NUMBER",
            headerText: "세대수",
            dataType: "text",
            width : "10%",
            editRenderer : {
                type : "InputEditRenderer",
                onlyNumeric : true, // 0~9 까지만 허용
                maxlength : 6,
            }
        },
        { dataField: "APT_TYPE",
            headerText: "유형",
            dataType: "text",
            width : "15%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_APT_TYPE;
                },
                keyField: "CD", // key 에 해당되는 필드명
                valueField: "NAME", // value 에 해당되는 필드명
            }
        },
        { headerText: "층수",
            children : [{
                dataField : "FLOOR_CNT",
                headerText : "지상",
                width : "10%",
                editRenderer : {
                    type : "InputEditRenderer",
                    onlyNumeric : true, // 0~9 까지만 허용
                    maxlength : 6,
                }
            }, {
                dataField : "UNDER_FLOOR_CNT",
                headerText : "지하",
                width : "10%",
                editRenderer : {
                    type : "InputEditRenderer",
                    onlyNumeric : true, // 0~9 까지만 허용
                    maxlength : 6,
                }
            }]
        },
        { dataField: "ELEVATER_CNT",
            headerText: "승강기수",
            dataType: "text",
            width : "10%",
            editRenderer : {
                type : "InputEditRenderer",
                onlyNumeric : true, // 0~9 까지만 허용
                maxlength : 6,
            }
        },
        { dataField: "PASSAGE_CNT",
            headerText: "통로수",
            dataType: "text",
            width : "10%",
            editRenderer : {
                type : "InputEditRenderer",
                onlyNumeric : true, // 0~9 까지만 허용
                maxlength : 6,
            }
        },
        { dataField: "MANAGE_NO",
            headerText: "관리대상",
            dataType: "text",
            width : "20%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_MANAGE_NO;
                },
                keyField: "CD", // key 에 해당되는 필드명
                valueField: "NAME", // value 에 해당되는 필드명
            }
        }];

    const footerLayout3 = [{
        dataField: "HOUSEHOLDS_NUMBER",
        positionField: "HOUSEHOLDS_NUMBER",
        operation: "SUM",
        formatString: "##0"
    }, {
        dataField: "ELEVATER_CNT",
        positionField: "ELEVATER_CNT",
        operation: "SUM",
        formatString: "##0"
    }, {
        dataField: "PASSAGE_CNT",
        positionField: "PASSAGE_CNT",
        operation: "SUM",
        formatString: "##0"
    }];

    //그리드2 생성
    grid3 = AUIGrid.create("#grid3", grid3ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowCheckColumn: false,
                showFooter: true,
                height : 614
            })
    );
    AUIGrid.setFooter(grid3, footerLayout3);

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex);
    });
    AUIGrid.bind(grid2, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid2, event.rowIndex, 0);
    });
    AUIGrid.bind(grid3, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid3, event.rowIndex, 0);
    });

    AUIGrid.bind(grid2, "cellEditEnd", function(event) {
        if(event.columnIndex == 1|| event.columnIndex == 2){
            let num = AUIGrid.getSelectedRows(grid2)[event.rowIndex].AREAR;
            let num2 = AUIGrid.getSelectedRows(grid2)[event.rowIndex].HOUSEHOLDS_NUMBER;
            let num3 = num* num2
            AUIGrid.setCellValue(grid2, event.rowIndex, "TOT_AREAR", num3);
        }
    });
    AUIGrid.bind(grid3, "cellEditEnd", function(event) {
        if (event.columnIndex == 0) {
            let flag = AUIGrid.isUniqueValue(grid3, "DONG",  event.value);
            if(!flag){
                AUIGrid.setCellValue(grid2, event.rowIndex, "DONG", "");
                alert("동명은 중복하여 작성할 수 없습니다.")
            }
        }
    });

    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
        }

        //파라미터
        let selectData = {
            sectionId :  sectionId,
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
                AUIGrid.setSelectionByIndex(grid3, focus2, 0);
                focus3 = 0;
            }
        });
    }

    //그리드 추가 함수
    function add_grid1_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid1, null);
        //새행 만들기
        const item = {};
        AUIGrid.addRow(grid1, item, "last");
    }

    function add_grid2_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid2, null);
        const item = {};
        AUIGrid.addRow(grid2, item, "last");
    }

    function add_grid3_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid3, null);
        const item = {};
        AUIGrid.addRow(grid3, item, "last");
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
            key : {
                column : ["MANAGE_NO"],
                seq : [1]
            },
            before : {}
        }

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
                    getSelect_grid3_manageNo();
                    search_grid1_onclick();
                }else return;
            }
        });
    }

    function save_grid2_onclick(){
        // 추가된 행 아이템들(배열)
        let addedRowItems = AUIGrid.getAddedRowItems(grid2);
        // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
        let editedRowItems = AUIGrid.getEditedRowItems(grid2);

        //검증
        let itemCount = addedRowItems.length + editedRowItems.length;
        if(itemCount == 0){
            alert("변경된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)")
            return;
        }
        if(!confirm("총 " + itemCount + "건의 변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_GRID2")) return;

        //포커스 지정

        focus = AUIGrid.getSelectedIndex(grid1)[0];
        focus2 = gridFocus(grid2);

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : {
                column : ["SEQ"],
                seq : [1]
            },
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_grid2",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    search_grid2_onclick();
                }else return;
            }
        });
    }

    function save_grid3_onclick(){
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
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)")
            return;
        }
        if(!confirm("총 " + itemCount + "건의 변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_GRID3")) return;

        //포커스 지정

        focus = AUIGrid.getSelectedIndex(grid1)[0];
        focus2 = AUIGrid.getSelectedIndex(grid2)[0];
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
            successSave : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    search_grid3_onclick();
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

        let mn = AUIGrid.getColumnDistinctValues(grid3, "MANAGE_NO")
        let mnCheck = checkedItems.filter(row => ! mn.includes(row.MANAGE_NO))

        if(!mnCheck){
            alert("동별현황 정보에 관리대상이 존재하여 삭제할 수 없습니다.");
            return;
        }

        let delItemsName = checkedItems.map(row => row.item.MANAGE_NM).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1);

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
                    getSelect_grid3_manageNo();
                    search_grid1_onclick();
                }else return;
            }
        });
    }

    function delete_grid2_onclick(){
        //검증
        const checkedItems = AUIGrid.getCheckedRowItems(grid2);
        let itemCount = checkedItems.length;
        if (itemCount=== 0) {
            alert("체크된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("삭제는 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }

        if (!confirm("(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus2 = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1);

        // 체크된 행 삭제 처리
        AUIGrid.removeCheckedRows(grid2);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : AUIGrid.getRemovedItems(grid2),
            before : {}
        };

        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId :  sectionId,
            component : pgId + "_grid2",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    search_grid2_onclick();
                }else return;
            }
        });
    }

    function delete_grid3_onclick(){
        //검증
        const checkedItems = AUIGrid.getCheckedRowItems(grid3);
        let itemCount = checkedItems.length;
        if (itemCount=== 0) {
            alert("체크된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("삭제는 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.item.DONG).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus3 = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1);

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
            successDelete : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    search_grid3_onclick();
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
                    if(isNull(row.MANAGE_NM)){
                        alert("관리대상은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                }
                break;
            case "SAVE_GRID3":
                let addedRowItems3 = AUIGrid.getAddedRowItems(grid3);
                let editedRowItems3 = AUIGrid.getEditedRowItems(grid3);
                let items3 = [...addedRowItems3,...editedRowItems3];
                for(const row of items3){
                    if(isNull(row.DONG)){
                        alert("동은 반드시 입력해야 합니다.");
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

    async function getSelect_grid3_manageNo(){
        //검색데이터
        let param = {};
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_grid3_manageNo",
            param: param,
        }
        DS_MANAGE_NO = await we_getSelect(data);
    }


    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section_middle_btn1", grid:"grid1", search:true, add: true, save: true, del: true});
        btnMaker({ tag: "#section_middle_btn2", grid:"grid2", search:true, add: true, save: true, del: true});
        btnMaker({ tag: "#section_middle_btn3", grid:"grid3", search:true, add: true, save: true, del: true, print: true});
        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        Promise.all([
            getSelect_grid3_manageNo()
        ]).then(function (){
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
            search_grid2_onclick();
            search_grid3_onclick();
        })
    };

</script>


<%@ include file = "../../inc_footer.jsp" %>