<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/iljung/ilj_nav.jsp" />

    <div id="section">
        <div class="section1">
            <span class="section1_nav"><i class="icon-calendar-plus-o"></i>업무일지결재</span>
            <div class="section1_btn" id="section1_btn">
            </div>
        </div>
        <div class="section2">
            <div class="section2_line0"></div>
        </div>
        <div id="conf_line">
            <div class="conf_line_left">
                <input type="date" id="search_scDate" name="SC_DATE">
            </div>
            <div id="gridAppr1" class="conf_line_right"></div> //결재란
        </div>
        <div id="grid1"  style="height: 546px;"></div>
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
    let gridAppr1;	// 결재란 그리드 컴포넌트
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_scDate = document.querySelector("#search_scDate"); //select 컴포넌트

    //결재란 생성
    gridAppr1 = AUIGrid.create("#gridAppr1", [],
        Object.assign({}, we_appr_Props,
            {})
    );

    //그리드2 설정
    const grid1ColumnLayout = [
        { dataField: "MST_NO",
            visible : false
        },
        { dataField: "MST_MONTH",
            visible : false
        },
        { dataField: "SEQ",
            visible : false
        },
        { dataField: "GBN_NAME",
            headerText: "일정구분",
            width : "8%",
            dataType: "text",
        },
        { dataField: "TITLE",
            headerText: "내용",
            dataType: "text",
            width : "*%",
            style: "line-break-column text-align-left",
        },
        { dataField: "MAIN_DEPT_NAME",
            headerText: "주무부서",
            width : "10%",
            dataType: "text",
        },
        { dataField: "STATUS_NM",
            headerText: "결과",
            width : "8%",
            dataType: "text",
        },
        { dataField: "WORKER_NAME",
            headerText: "처리자",
            width : "8%",
            renderer : we_cb_YN_Renderer
        },
    ];

    //그리드2 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
                showRowCheckColumn: false,
                height : 546
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(gridAppr1, "cellDoubleClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex);
    });
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });

    //결재란 생성
    async function getApprovalDuty_gridAppr1(){
        //검색데이터
        let param = {}
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId,
            param: param,
        }

        we_getApprovalDuty(data,{
            successGet : (data) => {
                let columns = [];
                if(data.length > 0){
                    data.forEach(row=>{
                        let item = {};
                        item.dataField  = row.CONFIRM_SEQ;
                        item.headerText = row.DUTY_CD;
                        item.dataType  = "text";
                        columns.push(item);
                    });
                }else{
                    for(let i = 0; i < 3; i++){
                        let item = {};
                        item.dataField  = "1";
                        item.headerText = "";
                        item.dataType  = "text";
                        columns.push(item);
                    }
                }

                AUIGrid.changeColumnLayout(gridAppr1, columns);
            }
        });
    }

    //그리드 조회 함수
    function search_gridAppr1_onclick(){

        //검색데이터
        let selectParam = {}

        //파라미터
        let selectData = {
            sectionId :  sectionId,
            component : pgId + "_gridAppr1",
            param: selectParam,
        }

        we_selectApproval( selectData,{
            successSelect : (data) => {
                //그리드 데이터 세팅
                AUIGrid.setGridData(gridAppr1, data);
            }
        });
    }

    function search_grid1_onclick(){

        if(!requireCheck("SEARCH_GRID1")) return;

        //검색데이터
        let selectParam = {}

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

    //컴포넌트 필수항목 입력 체크
    function requireCheck(require){
        let isValid = true;
        switch(require){
            case "SEARCH_GRID1":
                if(isNull(search_scDate.value)){
                    alert("일자는 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
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
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, print: true});
        search_startDate.value = getToday("yyyy-MM-dd");
        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        //결재란 생성
        getApprovalDuty_gridAppr1();

        //로드 시 그리드 바로 조회
        search_grid1_onclick();
    };

</script>



<%@ include file = "../../inc_footer.jsp" %>