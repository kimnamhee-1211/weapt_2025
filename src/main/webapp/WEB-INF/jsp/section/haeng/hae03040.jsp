<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/haeng/hae_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-edit"></i>게시문현황</div>
                <div class="section1_btn" id="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <div>
                        <span>게시기간 :&nbsp;
                            <input type="date" id="search_startDate" name="START_DATE">&nbsp; ~ &nbsp;
                            <input type="date" id="search_endDate" name="END_DATE">
                        </span>
                    </div>
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
    const search_startDate = document.querySelector("#search_startDate"); //select 컴포넌트
    const search_endDate = document.querySelector("#search_endDate"); //select 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "DOC_SEQ",
            visible : false
        },
        { dataField: "REG_USER",
            visible : false
        },
        { dataField: "SUBJECT",
            headerText: "제목",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "START_DATE",
            headerText: "게시 시작일",
            dataType: "date",
            formatString: "yyyy-mm-dd-HH-MM",
            width : "10%"
        },
        { dataField: "END_DATE",
            headerText: "게시 종료일",
            dataType: "date",
            formatString: "yyyy-mm-dd-HH-MM",
            width : "10%"
        },
        { dataField: "AD_COMP_NAME",
            headerText: "광고주",
            dataType: "text",
            width : "15%",
        },
        { dataField: "AD_AMOUNT",
            headerText: "광고금액",
            dataType: "text",
            width : "10%",
        },
        { dataField: "POINT_ID",
            headerText: "게시장소",
            dataType: "text",
            width : "25%",
        }
    ];


    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
                showRowCheckColumn : false
            })
    );

    //그리드 이벤트

    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
            START_DATE : search_startDate.value.replace(/-/g, ""),
            END_DATE : search_endDate.value.replace(/-/g, ""),
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
        btnMaker({ tag: "#section1_btn", grid:"grid1", search : true, print : true});
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //공통코드 가져오기
        //그리드 DDL
        //로드 시 그리드 바로 조회
        search_grid1_onclick();
    };

</script>



<%@ include file = "../../inc_footer.jsp" %>