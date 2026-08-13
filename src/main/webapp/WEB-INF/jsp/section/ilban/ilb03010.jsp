<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>


    <div id="section">
        <div class="section1">
            <span class="section1_nav"><i class="icon-chart-bar"></i>관리직원등록</span>
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
        <div class="section2">
            <div class="section2_block">
                <span class="section1_nav_mic">
                    <i class="icon-mic"></i>전화번호(하이픈(-) 필수 포함)는 반드시 입력해야 합니다.
                </span>
                <span class="search-box section1_btn">
                    퇴사일 :
                    <input type="date" id="input_resignDate" name="RESIGN_DATE" class="box_width100">
                     &nbsp; 퇴사사유 :
                    <input type="text" id="input_resignReason" name="RESIGN_REASON" class="box_width200">
                    <button id="resign_btn_grid1" class="del_btn" onclick="resign_onclick()">퇴사</button>
                    &nbsp;
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
    const search_what = document.querySelector("#search_what"); //컨트롤 컴포넌트
    const search_text = document.querySelector("#search_text"); //select 컴포넌트
    const input_resignDate = document.querySelector("#input_resignDate"); //input 컴포넌트
    const input_resignReason = document.querySelector("#input_resignReason"); //input 컴포넌트
    let DS_DEPT_CD = [];
    let DS_JOB_DUTY_CD = [];

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "EMP_NO",
            headerText: "사번",
            dataType: "text",
            width : "8%",
        },
        { dataField: "NAME",
            headerText: "성명",
            dataType: "text",
            width : "10%",
        },
        { dataField: "JOIN_YN",
            headerText: "근무상태",
            width : "10%",
            editable : false
        },
        { dataField: "DEPT_CD",
            headerText: "부서",
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
        { dataField: "JOB_DUTY_CD",
            headerText: "직책",
            dataType: "text",
            width : "15%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_JOB_DUTY_CD;
                },
                keyField: "JOB_DUTY_CD", // key 에 해당되는 필드명
                valueField: "JOB_DUTY_NAME", // value 에 해당되는 필드명
            }
        },
        { dataField: "HP_NO",
            headerText: "전화번호",
            dataType: "text",
            width : "15%",
        },
        { dataField: "JOIN_DATE",
            headerText: "입사일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
            editRenderer : we_calendar_Renderer
        },
        { dataField: "RESIGN_DATE",
            headerText: "퇴사일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
            editable : false
        },
        { dataField: "RESIGN_REASON",
            headerText: "퇴사사유",
            dataType: "text",
            width : "15%",
            style : "text-align-left",
            editable : false,
        },
        { dataField: "REMARK",
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
                height : 580,
                showRowNumColumn: false,
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });


    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
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
        item.JOIN_DATE = getToday("yyyyMMdd");
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
                column : ["EMP_NO"],
                seq : [1]
            },
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
                    search_grid1_onclick()
                }else return;
            }
        });
    }

    function resign_onclick(){
        // 추가된 행 아이템들(배열)
        let checkedItems = AUIGrid.getCheckedRowItemsAll(grid1);
        let itemCount = checkedItems.length;
        //검증
        if(itemCount == 0){
            alert("체크된 행이 없습니다.");
            return;
        }
        if(isNull(input_resignDate.value)){
            alert("퇴사일은 반드시 입력해야 합니다.");
            return;
        }
        if(itemCount > 100){
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.NAME).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount + "건) 퇴사처리하시겠습니까?")) return;

        //포커스 지정
        focus = gridFocus(grid1);

        checkedItems.forEach(row =>{
            row.RESIGN_DATE = input_resignDate.value.replace(/-/g, "");
            row.RESIGN_REASON = input_resignReason.value;
        })

        //저장 데이터
        let saveParam = {
            insertParam : null,
            updateParam : checkedItems,
            key : {},
            before : {
                action : "update",
                saveMode : "U",
                beforeParam : checkedItems
            }
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_resign",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_grid1_onclick()
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
                    if(isNull(row.NAME)){
                        alert("이름은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.HP_NO)){
                        alert("전화번호는 반드시 입력해야 합니다.");
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

    async function getSelect_grid1_jobDutyCd(){
        //검색데이터
        let param = {};
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_grid1_jobDutyCd",
            param: param,
        }
        DS_JOB_DUTY_CD = await we_getSelect(data);
    }


    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid : "grid1", search : true, add : true, save: true, print : true});

        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //공통코드 가져오기
        //그리드 DDL
        Promise.all([
            getSelect_grid1_deptCd(),
            getSelect_grid1_jobDutyCd()
        ]).then(function () {
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        });

    };

</script>


<%@ include file = "../../inc_footer.jsp" %>