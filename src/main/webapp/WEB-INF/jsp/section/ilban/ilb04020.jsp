<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>


        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-chart-bar"></i>개인근태조회</span>
                <div class="section1_btn" id="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <span class="search-box">조회기간 :&nbsp;
                        <input type="date" id="search_startDate" name="START_DATE">&nbsp; ~ &nbsp;<input type="date" id="search_endDate" name="END_DATE">
                    </span>
                    <span class="select-container">&emsp;구분 :&nbsp;
                        <select id="search_status" class="select_cont100">
                            <option value="work" selected>재직자</option>
                            <option value="resign">퇴직자</option>
                        </select>
                    </span>
                    <span class="select-container">&emsp;성명 :&nbsp;
                        <select id="search_empNo" class="select_cont100" name="EMP_NO"></select>
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
    const search_startDate = document.querySelector("#search_startDate"); //컨트롤 컴포넌트
    const search_endDate = document.querySelector("#search_endDate"); //select 컴포넌트
    const search_status = document.querySelector("#search_status"); //컨트롤 컴포넌트
    const search_empNo = document.querySelector("#search_empNo"); //select 컴포넌트
    let DS_ABSENT_CD = [];

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "EMP_NO",
            headerText: "사번",
            dataType: "text",
            width : "5%",
            editable : false
        },
        { dataField: "NAME",
            headerText: "성명",
            dataType: "text",
            width : "10%",
            editable : false
        },
        { dataField: "DEPT_NAME",
            headerText: "부서",
            dataType: "text",
            width : "12%",
            editable : false
        },
        { dataField: "JOB_DUTY_NAME",
            headerText: "직책",
            dataType: "text",
            width : "12%",
            editable : false
        },
        { dataField: "ABSENT_CD",
            headerText: "근태구분",
            width : "10%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_ABSENT_CD;
                },
                keyField: "ABSENT_CD", // key 에 해당되는 필드명
                valueField: "ABSENT_NAME", // value 에 해당되는 필드명
            }
        },
        { dataField: "START_DATE",
            headerText: "시작일",
            width : "10%",
            dataType: "date",
            formatString: "yyyy-mm-dd",
        },
        { dataField: "END_DATE",
            headerText: "종료일",
            width : "10%",
            dataType: "date",
            formatString: "yyyy-mm-dd",
        },
        { dataField: "USE_DAY_CNT",
            headerText: "사용일수",
            dataType: "numeric",
            formatString: "#,##0.0",
            width : "8%",
        },
        { dataField: "REG_DATE",
            headerText: "등록일",
            width : "10%",
            dataType: "date",
            formatString: "yyyy-mm-dd",
        },
        { dataField: "DESCR",
            headerText: "내용",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowNumColumn: false,
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });

    //팝업 이벤트
    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
            START_DATE : search_startDate.value.replace(/-/g, ''),
            END_DATE : search_endDate.value.replace(/-/g, ''),
            STATUS : search_status.value,
            EMP_NO : search_empNo.value
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

    //그리드 저장 함수
    function save_grid1_onclick(){
        // 추가된 행 아이템들(배열)
        let addedRowItems = [];
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

        focus = AUIGrid.getSelectedIndex(grid1)[0];

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
                    if(isNull(row.ABSENT_CD)){
                        alert("근태구분은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.START_DATE)){
                        alert("시작일은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.END_DATE)){
                        alert("종료일은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.USE_DAY_CNT)){
                        alert("사용일수는 반드시 입력해야 합니다.");
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

    async function getSelect_search_empNo(){
        search_empNo.innerHTML = "";
        //검색데이터
        let param = {
            STATUS : search_status.value,
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_empNo",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            search_empNo.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");
            list.forEach(row => {
                search_empNo.insertAdjacentHTML("beforeend",
                    "<option value='" + row.EMP_NO + "'>" + row.NAME + "</option>");
            })
        }
        search_empNo.selectedIndex = 0;
    }

    async function getSelect_grid1_absentCd(){
        //검색데이터
        let param = {};
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_grid1_absentCd",
            param: param,
        }
        let list = await we_getSelect(data);
        DS_ABSENT_CD = list;
    }

    

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid : "grid1", search : true, save: true, del:true, print : true});
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //공통코드 가져오기
        //그리드 DDL
        Promise.all([
            getSelect_search_empNo(),
            getSelect_grid1_absentCd()
        ]).then(function () {
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        });
    };

</script>



<%@ include file = "../../inc_footer.jsp" %>