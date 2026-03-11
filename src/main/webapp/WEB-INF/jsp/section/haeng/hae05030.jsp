<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/haeng/hae_nav.jsp" />

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-edit"></i>생산문서환경설정</span>
            </div>
            <div class="section2">
                <div class="section2_line0">
                </div> 
            </div>
            <div class="gridcont_left_535">
                <div class="section_middle_title">
                    <span>&#9726&nbsp;분류설정 :&nbsp;</span>
                    <span class="section_middle_btn" id="section1_btn1" ></span>
                </div>
                <div id="grid1"> </div>
            </div>
            <div id="" class="gridcont_right_535">
                <div class="section_middle_title">
                    <span>&#9726&nbsp;문서보관함 :&nbsp;</span>
                    <span class="section_middle_btn" id="section1_btn2"></span>
                </div>
                <div  id="grid2"></div>
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
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let grid2;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    let focus2 = 0;	//그리드 컴포넌트 포커스

    //그리드1 설정
    const grid1ColumnLayout = [
        { dataField: "DOC_GBN",
            headerText: "분류코드",
            dataType: "text",
            width : "15%",
            editable : false
        },
        { dataField: "DOC_GBN_NAME",
            headerText: "분류명",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "REG_DATE",
            headerText: "등록일",
            width : "18%",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            editable : false
        },
        { dataField: "USE_YN",
            headerText: "사용유무",
            width : "15%",
            renderer : we_cb_10_Renderer
        },
        { dataField: "ORDER_SEQ",
            headerText: "정렬순서",
            width : "15%",
            dataType: "text",
        },
    ];

    //그리드1 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
            })
    );

    //그리드2 설정
    const grid2ColumnLayout = [
        { dataField: "STORAGE_CD",
            headerText: "보관함코드",
            dataType: "text",
            width : "15%",
            editable : false
        },
        { dataField: "STORAGE_NAME",
            headerText: "보관함명",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "REG_DATE",
            headerText: "등록일",
            width : "18%",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            editable : false
        },
        { dataField: "USE_YN",
            headerText: "사용유무",
            width : "15%",
            renderer : we_cb_10_Renderer
        },
        { dataField: "ORDER_SEQ",
            headerText: "정렬순서",
            width : "15%",
            dataType: "text",
        },
    ];

    //그리드2 생성
    grid2 = AUIGrid.create("#grid2", grid2ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
            })
    );

    //그리드 이벤트

    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {};

        //파라미터
        let selectData = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
            param: selectParam,
        };

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

    function search_grid2_onclick(){

        //검색데이터
        let selectParam = {};

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_grid2",
            param: selectParam,
        };

        we_select( selectData,{
            successSelect : (data) => {
                //그리드 데이터 세팅
                AUIGrid.setGridData(grid2, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(grid2, focus2, 0);
                focus2 = 0;
            }
        });
    }

    //그리드 추가 함수
    function add_grid1_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid1, null);
        //새행 만들기
        const item = {};
        item.REG_DATE = getToday("yyyyMMdd");
        AUIGrid.addRow(grid1, item, "last");
    }
    function add_grid2_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid2, null);
        //새행 만들기
        const item = {};
        item.REG_DATE = getToday("yyyyMMdd");
        AUIGrid.addRow(grid2, item, "last");
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
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)")
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
            key : ["DOC_GBN"],
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
                    search_grid1_onclick()
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

        focus2 = gridFocus(grid2);

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : ["STORAGE_CD"],
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

        let delItemsName = checkedItems.map(row => row.item.DOC_GBN_NAME).join(", ");
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
        let delItemsName = checkedItems.map(row => row.item.STORAGE_NAME).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

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

    function registGbn_onclick(){

        if (!confirm("기본 분류 목록을 불러오시겠습니까?(기존 목록은 모두 삭제됩니다.)")) return;
        let checkedItems = AUIGrid.getColumnValues(grid1, "DOC_GBN");

        //저장 데이터
        let saveParam = {
            insertParam : checkedItems,
            updateParam : null,
            key : [],
            before : {
                action : "insert",
                saveMode : "D",
                beforeParam : checkedItems
            }
        };

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_registGbn",
            param: saveParam,
        };

        we_save( saveData ,{
            successSave : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    search_grid1_onclick();
                }else return;
            }
        });
    }

    function registStorage_onclick(){

        if (!confirm("기본 문서보관함 목록을 불러오시겠습니까?(기존 목록은 모두 삭제됩니다.)")) return;
        let checkedItems = AUIGrid.getColumnValues(grid2, "STORAGE_CD");

        //저장 데이터
        let saveParam = {
            insertParam : checkedItems,
            updateParam : null,
            key : [],
            before : {
                action : "insert",
                saveMode : "D",
                beforeParam : checkedItems
            }
        };

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_registStorage",
            param: saveParam,
        };

        we_save( saveData ,{
            successSave : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    search_grid2_onclick();
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
                    if(isNull(row.DOC_GBN_NAME)){
                        alert("분류명은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                }
                break;
            case "SAVE_GRID2":
                let addedRowItems2 = AUIGrid.getAddedRowItems(grid2);
                let editedRowItems2 = AUIGrid.getEditedRowItems(grid2);
                let items2 = [...addedRowItems2,...editedRowItems2];
                for(const row of items2){
                    if(isNull(row.STORAGE_NAME)){
                        alert("보관함명은 반드시 입력해야 합니다.");
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
        btnMaker({ tag: "#section1_btn1", grid:"grid1", search: true, add:true, save: true, del:true});
        btnMaker({ tag: "#section1_btn2", grid:"grid2", search: true, add:true, save: true, del:true});
        document.querySelector("#section1_btn1").insertAdjacentHTML("afterbegin", "<button id='registGbn_btn1' onclick='registGbn_onclick()' class='admin_btn'>기본 등록</button>");
        document.querySelector("#section1_btn2").insertAdjacentHTML("afterbegin", "<button id='registStorage_btn' onclick='registStorage_onclick()' class='admin_btn'>기본 등록</button>");


        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //로드 시 그리드 바로 조회
        search_grid1_onclick();
        search_grid2_onclick();
    };

</script>


<%@ include file = "../../inc_footer.jsp" %>