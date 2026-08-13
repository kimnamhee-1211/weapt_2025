<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>

    <div id="section">
        <div class="section1">
            <div class="section1_nav"><i class="icon-calendar-plus-o"></i>고장처리내역조회</div>
            <div class="section1_btn" id="section1_btn"> </div>
        </div>
        <div class="section2">
            <div class="section2_line1">
                <span class="search-box">조회기간 :&nbsp;
                    <input type="date" id="search_startDate" name="START_DATE">&nbsp; ~ &nbsp;
                    <input type="date" id="search_endDate" name="END_DATE">
                </span>
                <span class="select-container">&emsp;메뉴(장소)명 :&nbsp;
                    <select id="search_equGbn" class="select_cont100"></select>
                </span>
                <span class="select-container">&emsp;장비명 :&nbsp;
                    <select id="search_equNo" class="select_cont200"></select>
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
    const search_startDate = document.querySelector("#search_startDate")	//select 컴포넌트
    const search_endDate = document.querySelector("#search_endDate")	//select 컴포넌트
    const search_equGbn = document.querySelector("#search_equGbn")	//select 컴포넌트
    const search_equNo = document.querySelector("#search_equNo")	//select 컴포넌트


    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "ST_DATE",
            headerText: "일자",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%"
        },
        { dataField: "EQU_GBN_NM",
            headerText: "메뉴(장소명)",
            dataType: "text",
            width : "15%",
        },
        { dataField: "EQU_NAME",
            headerText: "장비명",
            dataType: "text",
            width : "20%",
            style : "text-align-left",
        },
        { dataField: "CONTENT",
            headerText: "고장발생 및 처리내역",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "TRO_USER",
            headerText: "처리자",
            dataType: "text",
            width : "12%",
        },
        { dataField: "TRO_AMT",
            headerText: "처리금액",
            dataType : "numeric",
            formatString : "#,###",
            width : "15%",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowCheckColumn : false,
                height: 659,
                editable : false
            })
    );

    //그리드 이벤트

    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            START_DATE : search_startDate.value.replace(/-/g,""),
            END_DATE : search_endDate.value.replace(/-/g,""),
            EQU_GBN : search_equGbn.value,
            EQU_NO : search_equNo.value
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

    async function getSelect_search_equGbn(){

        search_equGbn.innerHTML = "";
        //검색데이터
        let param = {};

        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_equGbn",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            list.forEach(row => {
                search_equGbn.insertAdjacentHTML("beforeend",
                    "<option value='" + row.MENU_ID + "'>" + row.MENU_NAME + "</option>");
            })
        }
        search_equGbn.selectedIndex = 0;

       await getSelect_search_equNo();
    }

    async function getSelect_search_equNo(){
        search_equNo.innerHTML = "";
        //검색데이터
        let param = {
            EQU_GBN : search_equGbn.value
        };
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_equNo",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            search_equNo.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");  //필요시
            list.forEach(row => {
                search_equNo.insertAdjacentHTML("beforeend",
                    "<option value='" + row.EQU_NO + "'>" + row.EQU_NAME + "</option>");
            })
        }
        search_equNo.selectedIndex = 0;
    }

    search_equGbn.addEventListener("change", () => {
        getSelect_search_equNo();
    })

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, print : true});
        search_startDate.value = addDate(getToday("yyyy-MM-dd"), -7, "yyyy-MM-dd");
        search_endDate.value = getToday("yyyy-MM-dd");
        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        Promise.all([
            getSelect_search_equGbn(),
        ]).then(function (){
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        })
    };

</script>



<%@ include file = "../../inc_footer.jsp" %>