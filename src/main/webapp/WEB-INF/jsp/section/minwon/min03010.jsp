<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/minwon/min_nav.jsp" />

    <div id="section">
        <div class="section1">
            <div class="section1_nav"><i class="icon-phone-squared"></i>월별통계</div>
            <div class="section1_btn">
                <button id="search_btn" onclick="">검색</button>
                <button id="print_btn" onclick="" class="print_btn">인쇄</button>
            </div>
        </div>
        <div class="section2">
            <div class="section2_line1">
                    <span class="search-box">민원접수월 :&nbsp;
                        <input type="month" id="" value="<%= yearMonth %>">&nbsp;~&nbsp;
                        <input type="month" id="" value="<%= yearMonth %>">
                    </span>
            </div>
        </div>
        <div id="grid1"></div>
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
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_select = document.querySelector("#search_select")	//select 컴포넌트
    const search_date = document.querySelector("#search_date")	//select 컴포넌트
    const search_input = document.querySelector("#search_input")	//select 컴포넌트
    let DS_GBN = []

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "MST_NO",
            visible : false
        },
        { dataField: "GBN",
            headerText: "구분",
            dataType: "text",
            width : "10%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_GBN;
                },
                keyField: "CD", // key 에 해당되는 필드명
                valueField: "NAME", // value 에 해당되는 필드명
            }
        },
        { dataField: "TITLE",
            headerText: "일정제목",
            dataType: "text",
            width : "20%",
        },
        { dataField: "DESCR",
            headerText: "내용",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "REG_DATE",
            headerText: "작성일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%"
        },
        { dataField: "MAKE_DATE",
            headerText: "생산일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
            editRenderer : we_calendar_Renderer
        },
        { dataField: "IMPORTANT_YN",
            headerText: "중요일정",
            width : "8%",
            renderer : we_cb_10_Renderer
        },
        { dataField: "IMPORTANT_YN",
            headerText: "나만의 일정",
            width : "8%",
            renderer : we_cb_YN_Renderer
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
            })
    );

    //그리드 이벤트

    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            SELECT : search_select.value,
            DATE : search_date.value,
            INPUT : search_input.value
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

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, print : true});


        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //로드 시 그리드 바로 조회
        search_grid1_onclick();

    };

</script>

<%@ include file = "../../inc_footer.jsp" %>