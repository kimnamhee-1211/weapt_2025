<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>


    <div id="section">
        <div class="section1">
            <div class="section1_nav"><i class="icon-edit"></i>생산문서</div>
            <div class="section1_btn" id="section1_btn">
            </div>
        </div>
        <div class="section2_line0"></div>
        <div class="section2"> <%-- 검색조건 없이--%>
            <div class = "section2_block">
                <span class="search-box section1_btn">
                    폐기일 :
                    <input type="date" id="input_resignDate" class="box_width100">
                     &nbsp; 폐기사유 :
                    <input type="text" id="input_resignReason" class="box_width100">
                    <button id="resign_btn_grid1" class="del_btn" onclick="resign_onclick()">폐기</button>&nbsp;
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
const sectionId = "${sectionId}";	//섹션ID
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    let DS_DOC_GBN = [];
    let DS_DOC_STORAGE = [];
    let DS_DEPT_CD = [];
    const input_resignDate = document.querySelector("#input_resignDate"); //input 컴포넌트
    const input_resignReason = document.querySelector("#input_resignReason"); //input 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "DOC_SEQ",
            visible : false
        },
        { dataField: "DOC_GBN",
            headerText: "분류",
            dataType: "text",
            width : "12%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_DOC_GBN;
                },
                keyField: "DOC_GBN", // key 에 해당되는 필드명
                valueField: "DOC_GBN_NAME", // value 에 해당되는 필드명
            }
        },
        { dataField: "MAKE_DATE",
            headerText: "생산일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
            editRenderer : we_calendar_Renderer
        },
        { dataField: "DOC_FOLDER",
            headerText: "서류철",
            dataType: "text",
            width : "12%",
            style : "text-align-left",
        },
        { dataField: "DOC_STORAGE",
            headerText: "문서보관함",
            dataType: "text",
            width : "12%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_DOC_STORAGE;
                },
                keyField: "STORAGE_CD", // key 에 해당되는 필드명
                valueField: "STORAGE_NAME", // value 에 해당되는 필드명
            }
        },
        { dataField: "STORAGE_MAX_YEAR",
            headerText: "보존기한",
            dataType: "text",
            width : "10%",
        },
        { dataField: "DISUSE_PLAN_DATE",
            headerText: "폐기예정일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
            editRenderer : we_calendar_Renderer
        },
        { dataField: "MGM_DEPT_CD",
            headerText: "관리부서",
            dataType: "text",
            width : "12%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_DEPT_CD;
                },
                keyField: "DEPT_CD", // key 에 해당되는 필드명
                valueField: "DEPT_NAME", // value 에 해당되는 필드명
            }
        },
        { dataField: "USE_YN",
            headerText: "사용여부",
            dataType: "text",
            width : "8%",
            renderer : we_cb_10_Renderer
        },
        { dataField: "REMARKS",
            headerText: "비고",
            dataType: "text",
            width : "15%",
            style : "text-align-left",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
            })
    );

    //그리드 이벤트
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
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

    //그리드 추가 함수
    function add_grid1_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid1, null);
        //새행 만들기
        const item = {};
        AUIGrid.addRow(grid1, item, "last");
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
                column : ["DOC_SEQ"],
                seq : [1]
            },
            before : {}
        };

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param: saveParam,
        };

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
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
        let delItemsName = checkedItems.map(row => row.item.NAME).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus1 = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1);

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
            component : querySet + "_grid1",
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

    //그리드 저장 함수
    function resign_onclick(){
        const checkedItems = AUIGrid.getCheckedRowItemsAll(grid1);

        let itemCount = checkedItems.length;
        if (itemCount=== 0) {
            alert("체크된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("폐기처리는 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.DOC_FOLDER).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 폐기처리하시겠습니까?")) return;

        if(!requireCheck("DISUSE_GRID1")) return;

        //포커스 지정
        focus = gridFocus(grid1);

        checkedItems.forEach(row =>{
            row.DISUSE_DATE = input_resignDate.value.replace(/-/g, "");
            row.DISUSE_REASON = input_resignReason.value;
        })

        //저장 데이터
        let saveParam = {
            insertParam : null,
            updateParam : checkedItems,
            key : {},
            before : {}
        };

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_resign",
            param: saveParam,
        };

        we_save( saveData ,{
            successSave : (json) => {
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

    async function getSelect_grid1_docGbn(){
        //검색데이터
        let param = {};
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_grid1_docGbn",
            param: param,
        }
        DS_DOC_GBN = await we_getSelect(data);
    }

    async function getSelect_grid1_docStorage(){
        //검색데이터
        let param = {};
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_grid1_docStorage",
            param: param,
        }
        DS_DOC_STORAGE = await we_getSelect(data);
    }


    async function getSelect_grid1_deptCd(){
        //검색데이터
        let param = {};
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_grid1_deptCd",
            param: param,
        }
        DS_DEPT_CD = await we_getSelect(data);
    }


    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid : "grid1", search : true, add : true, save: true, del: true, print : true});
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //공통코드 가져오기
        //그리드 DDL
        Promise.all([
            getSelect_grid1_docGbn(),
            getSelect_grid1_docStorage(),
            getSelect_grid1_deptCd()
        ]).then(function () {
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        });
    };

</script>



<%@ include file = "../../inc_footer.jsp" %>