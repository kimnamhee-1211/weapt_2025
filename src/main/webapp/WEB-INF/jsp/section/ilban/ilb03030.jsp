<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/ilban/ilb_nav.jsp" />

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-chart-bar"></i>관리직원자격증관리</span>
                <div class="section1_btn" id="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <span class="select-container">검색조건 :&nbsp;
                        <select id="search_what" name="WHAT" class="select_cont100">
                            <option value="all">전체</option>
                            <option value="position">직책</option>
                            <option value="name">성명</option>
                        </select>
                    </span>
                    <span class="search-box">&nbsp;
                        <input type="text" id="search_text" name="TEXT" class="box_width200">
                    </span>
                </div> 
            </div>
            <div class="gridcont_left_300">
                <div id="grid1"></div>
            </div>
            <div class="gridcont_right_770">
                <div id="grid2"></div>
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
    const search_what = document.querySelector("#search_what"); //컨트롤 컴포넌트
    const search_text = document.querySelector("#search_text"); //select 컴포넌트
    let DS_LICENSE_CODE = [];

    //그리드1 설정
    const grid1ColumnLayout = [
        { dataField: "EMP_NO",
            headerText: "사번",
            dataType: "text",
            width : "20%",
            editable : false
        },
        { dataField: "NAME",
            headerText: "성명",
            dataType: "text",
            width : "30%",
        },
        { dataField: "DEPT_NAME",
            headerText: "부서",
            width : "25%",
        },
        { dataField: "JOB_DUTY_NAME",
            headerText: "직책",
            width : "25%",
        }
    ];

    //그리드1 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowNumColumn: false,
                showRowCheckColumn: false,
                editable : false,
            })
    );

    //그리드2 설정
    const grid2ColumnLayout = [
        { dataField: "LICENSE_CODE",
            headerText: "*자격명",
            dataType: "text",
            width : "20%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_LICENSE_CODE;
                },
                keyField: "LICENSE_CODE", // key 에 해당되는 필드명
                valueField: "LICENSE_NAME", // value 에 해당되는 필드명
            }
        },
        { dataField: "LICENSE_NO",
            headerText: "*자격(면허)번호",
            dataType: "text",
            width : "20%",
        },
        { dataField: "OPER_ORG",
            headerText: "*발행처",
            dataType: "text",
            width : "20%",
        },
        { dataField: "POSS_DT",
            headerText: "*취득일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
            editRenderer : we_calendar_Renderer
        },
        { dataField: "REMARKS",
            headerText: "비고",
            dataType: "text",
            width : "*%",
        },
        { dataField: "EMP_NO",
            visible : false
        },
        { dataField: "SEQ",
            visible : false
        }
    ];

    //그리드2 생성
    grid2 = AUIGrid.create("#grid2", grid2ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid2, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid2, event.rowIndex, 0);
    });
    //셀 선택 변경 이벤트 바인딩
    AUIGrid.bind(grid1, "selectionChange", function(event) {
        search_grid2_onclick();
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
                search_grid2_onclick();
            }
        });
    }

    function search_grid2_onclick(){

        //검색데이터
        let selectParam = {
            EMP_NO : AUIGrid.getSelectedRows(grid1)[0].EMP_NO
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

    function add_grid2_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid2, null);
        //새행 만들기
        let selectRowItem = AUIGrid.getSelectedRows(grid1)[0];
        const item = {};
        item.EMP_NO = selectRowItem.EMP_NO;
        AUIGrid.addRow(grid2, item, "last");
    }

    //그리드 저장 함수
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
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_grid2_onclick();
                }else return;
            }
        });
    }

    //그리드 삭제 함수
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
        let delItemsName = checkedItems.map(row => row.item.LICENSE_CODE).join(", ");
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
            successDelete : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_grid2_onclick();
                }else return;
            }
        });
    }

    //컴포넌트 필수항목 입력 체크
    function requireCheck(require){
        let isValid = true;
        switch(require){
            case "SAVE_GRID2":
                let addedRowItems2 = AUIGrid.getAddedRowItems(grid2);
                let editedRowItems2 = AUIGrid.getEditedRowItems(grid2);
                let items2 = [...addedRowItems2,...editedRowItems2];
                for(const row of items2){
                    if(isNull(row.LICENSE_CODE)){
                        alert("자격명은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.POSS_DT)){
                        alert("취득일은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.LICENSE_NO)){
                        alert("자격(면허)번호는 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.OPER_ORG)){
                        alert("발행처는 반드시 입력해야 합니다.");
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

    async function getSelect_grid2_licenseCode(){
        let code = await we_getCode('135');
        code.forEach(row=>{
            let item = {};
            item.LICENSE_CODE = row.CODE_NO;
            item.LICENSE_NAME = row.CODEDTL_NM;
            DS_LICENSE_CODE.push(item);
        });
    }

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid2", search: true, add: true, save: true, del: true});
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //공통코드 가져오기
        //그리드 DDL
        Promise.all([
            getSelect_grid2_licenseCode()
        ]).then(function () {
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        });

    };

</script>


<%@ include file = "../../inc_footer.jsp" %>