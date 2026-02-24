<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/ilban/ilb_nav.jsp" />

<%@ include file = "pop_contract.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-chart-bar"></i>계약등록/조회</span>
                <div class="section1_btn" id="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <span>검색조건 :&nbsp;
                        <select id="search_contract" name="CONTRACT" class="select_cont100">
                            <option value="all" selected>전체</option>
                            <option value="contract">계약</option>
                            <option value="uncontract">미계약</option>
                        </select>
                        <select id="search_what" name="WHAT" class="select_cont100">
                            <option value="all" selected>전체</option>
                            <option value="contract">계약명</option>
                            <option value="office">업체명</option>
                        </select>
                    </span>
                    <span>&nbsp;
                        <input type="text" id="search_text" name="TEXT" class="box_width300">
                    </span>
                </div>
            </div>
            <div id="grid1"></div>
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
    const pgId = "ilb02020";	//프로그램ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const popupId = "pop_contract";
    const search_contract = document.querySelector("#search_contract"); //컨트롤 컴포넌트
    const search_what = document.querySelector("#search_what"); //컨트롤 컴포넌트
    const search_text = document.querySelector("#search_text"); //select 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "CONTRACT_NO",
            headerText: "계약코드",
            dataType: "text",
            width : "8%",
        },
        { dataField: "CONTRACT_DIV_NM",
            headerText: "계약구분",
            dataType: "text",
            width : "10%",
            style : "text-align-left",
        },
        { dataField: "CONTRACT_NAME",
            headerText: "계약명",
            dataType: "text",
            width : "20%",
            style : "text-align-left",
        },
        { dataField: "SUPPLIER_NAME",
            headerText: "업체명",
            dataType: "text",
            width : "20%",
            style : "text-align-left",
        },
        { dataField: "COMP_PHON_NO",
            headerText: "전화번호",
            dataType: "text",
            width : "12%",
        },
        { dataField: "STATE",
            headerText: "계약상태",
            width : "8%"
        },
        { dataField: "CONTRACT_TERM",
            headerText: "계약기간",
            dataType: "text",
            width : "8%",
        },
        { dataField: "STRAT_DATE",
            headerText: "시작일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
        },
        { dataField: "END_DATE",
            headerText: "만기일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
        },
        { dataField: "PAY_TYPE",
            headerText: "지불방법",
            dataType: "text",
            width : "10%",
        },
        { dataField: "CONTRACT_AMOUNT",
            headerText: "계약금액",
            dataType : "numeric",
            formatString : "#,###",
            width : "12%",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
                showRowNumColumn: false,
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });

    //행 클릭 시
    AUIGrid.bind(grid1, "cellDoubleClick", function(event) {
        //그리드-input 태그 바인딩
        gridToInput(grid1, popupId);
        //팝업 열기 이벤트
        popupOpen(popupId);
    });

    //팝업 이벤트

    //팝업 닫기 이벤트
    function close_popup_onclick(){
        popupClose(popupId);
        clearInput(popupId);
    }


    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
            CONTRACT : search_contract.value,
            WHAT : search_what.value,
            TEXT : search_text.value == null ? '' : search_text.value,
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
        const item = {};
        AUIGrid.addRow(grid1, item, "last");
        //그리드-input 태그 바인딩
        gridToInput(grid1, popupId);
        //팝업 열기 이벤트
        popupOpen(popupId);
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
            key : ["CONTRACT_NO"],
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
                    //팝업 닫기
                    close_popup_onclick();
                    search_grid1_onclick()
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
        let delItemsName = checkedItems.map(row => row.item.SUPPLIER_NAME).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1);

        // 체크된 행 삭제 처리
        AUIGrid.removeCheckedRows(grid1);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : AUIGrid.getRemovedItems(grid1),
            before : {}
        }

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
                    if(isNull(row.CONTRACT_NAME)){
                        alert("계약명은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.SUPPLIER_CD)){
                        alert("업체명은 반드시 입력해야 합니다.");
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

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid : "grid1", search : true, add : true, del : true, print : true});
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //공통코드 가져오기
        //그리드 DDL
        //로드 시 그리드 바로 조회
        search_grid1_onclick();

        let pop_item = {
            pgId : pgId,
        };
        pop_onload(pop_item);
    };

</script>



<%@ include file = "../../inc_footer.jsp" %>