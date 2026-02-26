<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/sojang/soj_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-star-filled"></i>관리소현황
                </div>               
                <div class="section1_btn" id="section1_btn">
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="select-container">관리소상태 :&nbsp;
                            <select id="search_status" name="STATUS" class="select_cont100">
                            </select>
                        </span>
                        <span class="select-container">&emsp;계약유형 :&nbsp;
                            <select id="search_contKindCd" name="CONT_KIND_CD" class="select_cont100">
                            </select>
                        </span>
                    </form>
                </div>
            </div>
            <div id="grid1">
            </div>
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
    const pgId = "${pgId}";	//프로그램ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_status = document.querySelector("#search_status"); //select 컴포넌트
    const search_contKindCd = document.querySelector("#search_contKindCd"); //select 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "OFFICE_CODE",
            headerText: "코드",
            dataType: "text",
            width : "8%",
            editable : false,
        },
        { dataField: "OFFICE_NAME",
            headerText: "관리소명",
            dataType: "text",
            width : "20%",
            editable : false,
            style : "text-align-left",
        },
        { dataField: "PART1_NM",
            headerText: "관리소구분",
            dataType: "text",
            width : "10%",
        },
        { dataField: "PART2_NM",
            headerText: "관리구분",
            dataType: "text",
            width : "10%",
        },
        { dataField: "OFFICE_CNT",
            headerText: "세대수",
            dataType: "numeric",
            width : "8%",
            editable : false,
        },
        { dataField: "TEL",
            headerText: "전화번호",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { dataField: "FAX",
            headerText: "팩스번호",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { dataField: "ADDR",
            headerText: "주소",
            dataType: "text",
            width : "30%",
            editable : false,
            style : "text-align-left",
        },
        { dataField: "MAGOR_NAME",
            headerText: "소장명",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { dataField: "MAJOR_HP",
            headerText: "소장 전화번호",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { dataField: "COMP_NAME",
            headerText: "관리회사",
            dataType: "text",
            width : "14%",
            editable : false,
        },
        { dataField: "MGMUSER_ID",
            headerText: "관리자ID",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { dataField: "OFFICE_HARD_SIZE",
            headerText: "사용기가",
            dataType: "numeric",
            width : "8%",
            editable : false,
        },
        { dataField: "OFFICE_USER_CNT",
            headerText: "사용자수",
            dataType: "numeric",
            width : "8%",
            editable : false,
        },
        { dataField: "STATUS_NM",
            headerText: "상태",
            dataType: "text",
            width : "7%",
        },
        { dataField: "START_DATE",
            headerText: "계약시작일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
            editable : false,
        },
        { dataField: "END_DATE",
            headerText: "계약만료일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
            editable : false,
        },
        { dataField: "CONT_KIND_NM",
            headerText: "계약유형",
            dataType: "text",
            width : "12%",
        },
        { dataField: "CONT_AMT",
            headerText: "계약금액",
            dataType: "numeric",
            width : "10%",
            editable : false,
            formatString : "#,###"
        },
        { dataField: "REV_DATE",
            headerText: "계약해지일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
            editable : false,
        },
        { dataField: "REV_REASON",
            headerText: "계약해지이유",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { dataField: "PLAN_GBN_NM",
            headerText: "조정",
            dataType: "text",
            width : "10%",
        },
        { dataField: "PLAN_MONTH",
            headerText: "조정년월",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
            editable : false,
        },
        { dataField: "REPAIR_STATUS_NM",
            headerText: "조정마감상태",
            dataType: "text",
            width : "15%",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowCheckColumn: false,
                editable : false,
            })
    );

    //그리드 이벤트

    //팝업 이벤트


    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
            STATUS : search_status.value,
            CONT_KIND_CD : search_contKindCd.value,
        }

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
        selectOptionMaker("104", search_status, "전체", false);
        selectOptionMaker("129", search_contKindCd, "전체", false);
        //그리드 DDL

        //로드 시 그리드 바로 조회
        search_grid1_onclick();
    };

</script>



<%@ include file = "../../inc_footer.jsp" %>