<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/iljung/ilj_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-calendar-plus-o"></i>일정조회</div>
                <div class="section1_btn" id="section1_btn"></div>
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
                    </div>
                    <div>
                        <span class="search-box">제목&내용 :&nbsp;
                            <input style="width:713px; height:20px;" type="text" placeholder=" 검색어를 입력하십시오." id="search_text">
                        </span>
                    </div>
                </div>
            </div>
            <div id="grid1"></div>
            <jsp:include page="/WEB-INF/jsp/section/iljung/pop_iljung.jsp" />
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
    const sectionId = "${sectionId}";	//섹션ID
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let querySet = "ilj01015";
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
        { dataField: "MST_MONTH",
            visible : false
        },
        { dataField: "SEQ",
            visible : false
        },
        { dataField: "SC_DATE",
            headerText: "일자",
            width : "10%",
            dataType: "date",
            formatString: "yyyy-mm-dd",
        },
        { dataField: "TITLE",
            headerText: "일정명",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "GBN_NAME",
            headerText: "일정구분",
            width : "8%",
            dataType: "text",
        },
        { dataField: "STATUS_NM",
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
                editable : false,
                showRowCheckColumn: false,
            })
    );

    //그리드 이벤트
    //행 클릭 시
    AUIGrid.bind(grid1, "cellDoubleClick", function(event) {
        let pop_item = {
            pgId : pgId,
		    menuId : menuId,
            querySet : querySet,
            saveKey : "U",
            searchItem : {
                MST_NO : event.item.MST_NO,
                SC_DATE : event.item.SC_DATE,
                MST_MONTH : event.item.MST_MONTH,
                SEQ : event.item.SEQ,
            },
        };
        pop_onload(pop_item);
        //팝업 열기 이벤트
        popupOpen(popupId);
    });


    //그리드 조회 함수
    function search_grid1_onclick(){

        if(!requireCheck("SEARCH_GRID1")) return;

        //검색데이터
        let selectParam = {
            START_DATE : search_startDate.value.replace(/-/g,''),
            END_DATE : search_endDate.value.replace(/-/g,''),
            SCH_GBN : search_schGbn.value,
            MAIN_DEPT_CD : search_mainDeptCd.value,
            STATUS_CD : search_statusCd.value,
            TEXT : search_text.value,
        };

        //파라미터
        let selectData = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
            param: selectParam,
        };

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
                    alert("시작 기간은 반드시 입력해야 합니다.");
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

    async function getSelect_search_schGbn(){
        search_schGbn.innerHTML = "";
        //검색데이터
        let param = {
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_schGbn",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            search_schGbn.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");  //필요시
            list.forEach(row => {
                search_schGbn.insertAdjacentHTML("beforeend",
                    "<option value='" + row.SCH_GBN + "'>" + row.GBN_NAME + "</option>");
            })
        }
        search_schGbn.value = search_schGbn.options[0].value;
    }


    async function getSelect_search_mainDeptCd(){
        search_mainDeptCd.innerHTML = "";
        //검색데이터
        let param = {
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_mainDeptCd",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            search_mainDeptCd.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");  //필요시
            list.forEach(row => {
                search_mainDeptCd.insertAdjacentHTML("beforeend",
                    "<option value='" + row.DEPT_CD + "'>" + row.DEPT_NAME + "</option>");
            })
        }
        search_mainDeptCd.selectedIndex = 0;
    }

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, print:true});
        search_startDate.value = getToday("yyyy-MM-dd");
        search_endDate.value = getToday("yyyy-MM-dd");
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        Promise.all([
            //공통코드 가져오기
            selectOptionMaker("120", search_statusCd, "(전체)", false),
            //그리드 DDL
            getSelect_search_schGbn(),
            getSelect_search_mainDeptCd(),
        ]).then(function (){
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        })

    };

</script>



<%@ include file = "../../inc_footer.jsp" %>