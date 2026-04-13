<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/minwon/min_nav.jsp" />

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-phone-squared"></i>민원환경설정</span>
                <span class="section1_nav_mic">&emsp;
                    <i class="icon-mic"></i>[추가]로 그리드에 직접입력하고 사용폐기가 되었을 때에는 사용여부를 NO로 선택 후 [저장]합니다. 
                </span>
            </div>
            <div class="section2">
                <div class="section2_line0"></div>
            </div>
            <div class="gridcont_left_370">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>동외공용민원 장소설정</span>
                    <span class="section_middle_btn" id="section_middle_btn1"></span>
                </div> 
                <div id="grid1"  style="height: 611px;"></div>
            </div> 
            <div class="gridcont_left_370">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>민원구분</span>
                    <span class="section_middle_btn" id="section_middle_btn2"></span>
                </div> 
                <div id="grid2"  style="height: 611px;"></div>
            </div> 

            <div class="gridcont_left_340">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>민원처리자</span>
                    <span class="section_middle_btn" id="section_middle_btn3"></span>
                </div> 
                <div id="grid3"  style="height: 280px;"></div>

                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>민원환경</span>
                    <span class="section_middle_btn" id="section_middle_btn4"> </span>
                </div> 
                <div class="min_setting" id="input_setting">
                    <div>
                        &ensp;&#9726&nbsp;민원접수방법 :&emsp;&ensp;
                        <span>
                            <input type="radio" id="input_viewGbnA" name="VIEW_GBN" value="A" checked> 민원대장&emsp;
                            <input type="radio" id="input_viewGbnB" name="VIEW_GBN" value="B"> 민원전표&emsp;
                        </span>
                    </div>
                    <div>
                        &ensp;&#9726&nbsp;민원접수자 :&emsp;&ensp;
                        <span>
                            <input type="radio" id="input_viewUserA" name="VIEW_USER" value="A" checked> 로그인사용자&emsp;
                            <input type="radio" id="input_viewUserB" name="VIEW_USER" value="B"> 민원접수자&emsp;
                        </span>
                    </div>
                    <div>
                        &ensp;&#9726&nbsp;재고자산추가 :&emsp;&ensp; 
                        <input type="checkbox" id="input_stockGbn" name="STOCK_GBN"><label for="input_stockGbn">소모품사용</label>&emsp;
                        <input type="checkbox" id="input_gaugeGbn" name="GAUGE_GBN"><label for="input_gaugeGbn">계량기사용</label>
                    </div>
                    <div>
                        &ensp;&#9726&nbsp;기타추가 :&emsp;&ensp;
                        <input type="checkbox" id="input_messageGbn" name="MESSAGE_GBN"><label for="input_messageGbn">메시지전송</label>&emsp;
                        <input type="checkbox" id="input_timeGbn" name="TIME_GBN"><label for="input_timeGbn">접수시간</label>
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
     * 그리드 이벤트 : 체크박스 클릭 시 셀렉트 이벤트(엑스트라 체크박스 있을 시) + 필요 시
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
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let grid2;	// 그리드 컴포넌트
    let grid3;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    let focus1 = 0;	//그리드 컴포넌트 포커스
    let focus2 = 0;	//그리드 컴포넌트 포커스

    const input_setting = document.querySelector("#input_setting");

    const input_viewGbnA = document.querySelector("#input_viewGbnA"); // 민원대장
    const input_viewGbnB = document.querySelector("#input_viewGbnB"); // 민원전표

    const input_viewUserA = document.querySelector("#input_viewUserA"); // 로그인사용자
    const input_viewUserB = document.querySelector("#input_viewUserB"); // 민원접수자

    const input_stockGbn = document.querySelector("#input_stockGbn"); // 소모품사용
    const input_gaugeGbn = document.querySelector("#input_gaugeGbn"); // 계량기사용

    const input_messageGbn = document.querySelector("#input_messageGbn"); // 메시지전송
    const input_timeGbn = document.querySelector("#input_timeGbn"); // 접수시간


    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "MINWON_AREAR_SEQ",
            headerText: "코드",
            dataType: "text",
            width : "15%",
        },
        { dataField: "AREAR_NAME",
            headerText: "민원장소명",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "ORDER_SEQ",
            headerText: "정렬순서",
            dataType: "numeric",
            width : "10%",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
            })
    )

    const grid2ColumnLayout = [
        { dataField: "GBN_ID",
            headerText: "코드",
            dataType: "text",
            width : "15%",
        },
        { dataField: "GBN_NAME",
            headerText: "민원구분",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "USE_YN",
            headerText: "사용여부",
            width : "8%",
            renderer : we_cb_10_Renderer
        },
        { dataField: "ORDER_SEQ",
            headerText: "정렬순서",
            dataType: "numeric",
            width : "10%",
        },
    ];

    //그리드 생성
    grid2 = AUIGrid.create("#grid2", grid2ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
            })
    );

    const grid3ColumnLayout = [
        { dataField: "COM_GBN",
            headerText: "코드",
            dataType: "text",
            width : "15%",
        },
        { dataField: "COM_NAME",
            headerText: "민원처리자",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "USE_YN",
            headerText: "사용여부",
            width : "8%",
            renderer : we_cb_10_Renderer
        },
        { dataField: "ORDER_SEQ",
            headerText: "정렬순서",
            dataType: "numeric",
            width : "10%",
        },
    ];

    //그리드 생성
    grid3 = AUIGrid.create("#grid3", grid3ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });
    //체크박스 클릭 시
    AUIGrid.bind(grid2, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid2, event.rowIndex, 0);
    });
    //체크박스 클릭 시
    AUIGrid.bind(grid3, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid3, event.rowIndex, 0);
    });

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
                AUIGrid.setSelectionByIndex(grid2, focus, 0);
                focus1 = 0;
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
                AUIGrid.setSelectionByIndex(grid3, focus, 0);
                focus2= 0;
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
        AUIGrid.addRow(grid1, item, "selectionDown");
    }
    
    function add_grid2_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid2, null);
        //새행 만들기
        let selectRowItem = AUIGrid.getSelectedRows(grid2)[0];
        const item = {};
        item.REG_DATE = getToday("yyyyMMdd");
        AUIGrid.addRow(grid2, item, "selectionDown");
    }

    function add_grid3_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid3, null);
        //새행 만들기
        let selectRowItem = AUIGrid.getSelectedRows(grid3)[0];
        const item = {};
        item.REG_DATE = getToday("yyyyMMdd");
        AUIGrid.addRow(grid3, item, "selectionDown");
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
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
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
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        if(!confirm("총 " + itemCount + "건의 변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_GRID2")) return;

        //포커스 지정
        focus1 = gridFocus(grid2);

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
            component : pgId + "_grid2",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
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
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        if(!confirm("총 " + itemCount + "건의 변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_GRID3")) return;

        //포커스 지정
        focus2 = gridFocus(grid3);

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
            component : pgId + "_grid3",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_grid3_onclick();
                }else return;
            }
        });
    }

    //그리드 저장 함수
    function save_input1_onclick(){

        let item = {}
        inputToData("input_setting",item)
        let items = [...item]

        //검증
        if(!confirm("변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_INPUT1")) return;

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : items,
            key : [],
            before : {}
        };

        //파라미터
        let saveData  = {
            sectionId :  sectionId,
            component : pgId + "_input1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_input1_onclick();
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
            successDelete : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
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
        if(itemCount > 200){
            alert("삭제는 최대 200건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.item.TITLE).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus1 = (checkedItems[0].rowIndex -2) < 2 ? 0 : (checkedItems[0].rowIndex -2)

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
            successDelete : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
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
        if(itemCount > 300){
            alert("삭제는 최대 300건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.item.TITLE).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus2 = (checkedItems[0].rowIndex -3) < 3 ? 0 : (checkedItems[0].rowIndex -3)

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
                    if(isNull(row.TITLE)){
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

    async function getSelectOption_search_select(){

        search_select.innerHTML = "";
        //검색데이터
        let param = {};

        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_select",
            param: param,
        }
        let list = await we_getSelectOption(data);

        if(list){
            list.forEach(row => {
                search_mstDate.insertAdjacentHTML("beforeend",
                    "<option value='" + row.CD + "'>" + row.NAME + "</option>");
            })
        }
        search_select.selectedIndex = 0;
    }

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section_middle_btn1", grid:"grid1", search: true, add: true, del: true, save: true});
        btnMaker({ tag: "#section_middle_btn2", grid:"grid2", search: true, add: true, del: true, save: true});
        document.querySelector("#section_middle_btn2").insertAdjacentHTML("afterbegin", "<button id='regist_btn' onclick='regist_onclick()' class='admin_btn'>기본 등록</button>");
        btnMaker({ tag: "#section_middle_btn3", grid:"grid3", search: true, add: true, del: true, save: true});
        btnMaker({ tag: "#section_middle_btn3", grid:"input1", save: true});
        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        search_grid1_onclick();
        search_grid2_onclick();
        search_grid3_onclick();
        search_input1_onclick();

    };

</script>



<%@ include file = "../../inc_footer.jsp" %>