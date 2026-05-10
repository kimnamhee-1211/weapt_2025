<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/ilban/ilb_nav.jsp" />

    <div id="section">
        <div class="section1">
            <span class="section1_nav"><i class="icon-chart-bar"></i>퇴사직원조회</span>
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
                    <i class="icon-mic"></i>복귀 버튼을 사용하여 퇴사 직원을 재직 상태로 복귀 처리합니다.
                </span>
                <span class="search-box section1_btn">
                    <button id="cancelResign_btn_grid1" class="del_btn" onclick="cancelResign_onclick()">복귀</button>
                </span>
            </div>
        </div>

        <div id="grid1"></div>

    </div>

<script>
    /** 작성 순서 pgId, 그리드 컴포넌트, 그리드 컴포넌트 포커스, 입력부 컴포넌트, 팝업 컴포넌트, select 컴포넌트
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
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_what = document.querySelector("#search_what"); //컨트롤 컴포넌트
    const search_text = document.querySelector("#search_text"); //select 컴포넌트

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
        { dataField: "RESIGN_DATE",
            headerText: "퇴사일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
        },
        { dataField: "RESIGN_REASON",
            headerText: "퇴사사유",
            dataType: "text",
            width : "15%",
            style : "text-align-left",
        },
        { dataField: "DEPT_NAME",
            headerText: "부서",
            dataType: "text",
            width : "12%",
        },
        { dataField: "JOB_DUTY_NAME",
            headerText: "직책",
            dataType: "text",
            width : "15%",
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
                editable : false,
                height : 580,
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


    function cancelResign_onclick(){
        // 추가된 행 아이템들(배열)
        let checkedItems = AUIGrid.getCheckedRowItemsAll(grid1);
        let itemCount = checkedItems.length;
        //검증
        if(itemCount == 0){
            alert("체크된 행이 없습니다.");
            return;
        }

        if(itemCount > 100){
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.NAME).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount + "건) 복귀처리하시겠습니까?")) return;

        //포커스 지정
        focus = gridFocus(grid1);

        //저장 데이터
        let saveParam = {
            insertParam : null,
            updateParam : checkedItems,
            key : [],
            before : {
                // action : "update",
                // saveMode : "U",
                // beforeParam : checkedItems
            }
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_cancelResign",
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
        btnMaker({ tag: "#section1_btn", grid : "grid1", search : true, print : true});

        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //공통코드 가져오기
        //로드 시 그리드 바로 조회
        search_grid1_onclick();

    };

</script>



<%@ include file = "../../inc_footer.jsp" %>