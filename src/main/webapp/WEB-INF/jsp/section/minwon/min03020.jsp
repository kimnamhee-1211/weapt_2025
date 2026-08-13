<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>


        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-phone-squared"></i>처리자별통계</div>
                <div class="section1_btn" id="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <span class="search-box">민원접수일 :&nbsp;
                        <input type="date" id="search_startDate">&nbsp;~&nbsp;
                        <input type="date" id="search_endDate">
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
    const sectionId = "${sectionId}";	//섹션ID
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_startDate= document.querySelector("#search_startDate")	//select 컴포넌트
    const search_endDate = document.querySelector("#search_endDate")	//select 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "WORK_USER",
            headerText: "처리자",
            dataType: "text",
            width : "20%"
        },
        { dataField: "TOTAL_CNT",
            headerText: "민원건수",
            dataType: "text",
        },
        { dataField: "PROC_CNT",
            headerText: "처리건수",
            dataType: "text",
        },
        { dataField: "ING_CNT",
            headerText: "처리중건수",
            dataType: "text",
        },
        { dataField: "HOLD_CNT",
            headerText: "보류건수",
            dataType: "text",
        },
        { dataField: "REJECT_CNT",
            headerText: "반려건수",
            dataType: "text",
        },
        { dataField: "RPENDING_CNT",
            headerText: "미처리건수",
            dataType: "text",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
                showRowCheckColumn : false,
                showRowNumColumn : false,
            })
    );

    //그리드 이벤트

    //그리드 조회 함수
    function search_grid1_onclick(){

        if(!requireCheck("SEARCH_GRID1")) return;

        //검색데이터
        let selectParam = {
            START_DATE : search_startDate.value.replace(/-/g,""),
            END_DATE : search_endDate.value.replace(/-/g,""),
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
            case "SEARCH_GRID1":
                if(isNull(search_startDate.value)){
                    alert("시작날짜는 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
                }
                if(isNull(search_endDate.value)){
                    alert("종료날짜는 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
                }
                break;
        }
        return isValid;
    }

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, print : true});
        search_startDate.value = addDate(getToday("yyyy-MM-dd"), -7, "yyyy-MM-dd");
        search_endDate.value = getToday("yyyy-MM-dd");

        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //로드 시 그리드 바로 조회
        search_grid1_onclick();

    };

</script>

<%@ include file = "../../inc_footer.jsp" %>