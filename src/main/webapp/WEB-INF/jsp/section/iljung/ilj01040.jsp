<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/iljung/ilj_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-calendar-plus-o"></i>일정조회</div>
                <div class="section1_btn" ID="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line2">
                    <div>
                        <span>기간 :&nbsp;
                            <input type="date" id="search_startDate">&nbsp; ~ &nbsp;
                            <input type="date" id="search_endDate">
                        </span>
                        <span>&emsp;일정구분 :&nbsp;
                            <select id="search_schGbn" class="select_cont100"></select>
                        </span>
                        <span>&emsp;주무부서 :&nbsp;
                            <label for="search_mainDeptCd"></label>
                            <select id="search_mainDeptCd" class="select_cont100"></select>
                        </span>
                        <span>&emsp;상태 :&nbsp;
                            <select id="search_statusCd" class="select_cont100"></select>
                        </span>
                        <span>&emsp;
                            <input  type="checkbox" id="search_importantYn">
                            <label for="search_importantYn">&nbsp;중요업무&emsp;</label>
                        </span>
                    </div>
                    <div>
                        <span class="search-box">제목&내용 :&nbsp;
                            <input style="width:713px; height:20px;" type="text" placeholder=" 검색어를 입력하십시오." id="search_text">
                        </span>TXT
                    </div>
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
    const pgId = "ilj01040";	//프로그램ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_startDate = document.querySelector("#search_startDate"); //select 컴포넌트
    const search_endDate = document.querySelector("#search_endDate"); //select 컴포넌트
    const search_schGbn = document.querySelector("#search_schGbn"); //select 컴포넌트
    const search_mainDeptCd = document.querySelector("#search_mainDeptCd"); //select 컴포넌트
    const search_statusCd = document.querySelector("#search_statusCd"); //select 컴포넌트
    const search_importantYn = document.querySelector("#search_importantYn"); //select 컴포넌트
    const search_text = document.querySelector("#search_text"); //select 컴포넌트

    //그리드1 설정
    const grid1ColumnLayout = [
        { dataField: "MST_NO",
            visible : false
        },
        { dataField: "IMPORTANT_YN",
            headerText: "중요",
            width : "5%",
            renderer : we_cb_YN_Renderer
        },
        { dataField: "MY_SCHEDULE",
            headerText: "나의 일정",
            width : "8%",
            renderer : we_cb_YN_Renderer
        },
        { dataField: "TITLE",
            headerText: "일정명",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "START_DATE",
            headerText: "시작일",
            width : "10%",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            editable : false
        },
        { dataField: "END_DATE",
            headerText: "종료일",
            width : "10%",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            editable : false
        },
        { dataField: "GBN_NAME",
            headerText: "일정구분",
            width : "8%",
            dataType: "text",
        },
        { dataField: "STATUS_CD",
            headerText: "일정상태",
            width : "8%",
            dataType: "text",
        },
        { dataField: "MAIN_DEPT_NAME",
            headerText: "주무부서",
            width : "10%",
            dataType: "text",
        },
    ];

    //그리드1 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false
            })
    );

    //그리드 이벤트



    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            START_DATE : search_startDate.value,
            END_DATE : search_schGbn.value,
            MAIN_DEPT_CD : search_mainDeptCd.value,
            STATUS_CD : search_statusCd.value,
            IMPORTANT_YN : search_importantYn.value,
            TEXT : search_text.value,
        };

        //파라미터
        let selectData = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
            param: selectParam,
        };

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

        }
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
        btnMaker({ tag: "#section1_btn1", grid:"grid1", search: true, print:true});
        search_startDate.value = getToday("yyyyMMdd");
        search_endDate.value = getToday("yyyyMMdd");

        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //로드 시 그리드 바로 조회
        search_grid1_onclick();
    };

</script>



<%@ include file = "../../inc_footer.jsp" %>