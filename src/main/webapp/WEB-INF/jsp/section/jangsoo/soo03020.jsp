<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>연도별수선일정
                </div>
                 <div class="section1_btn" id="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                     <span class="search-box">수립조정년월 :&nbsp;
                        <select id="search_planMonth" class="select_cont100"></select>&emsp;
                    </span>
                    <span class="search-box">&emsp;년도 :&nbsp;
                        <input type="number" id="search_stYear" min="1900" max="2100" maxlength="4" step="1" oninput="inputNumFormat(this)">
                        &emsp;~&emsp;
                         <input type="text" id="search_endYear" min="1900" max="2100" maxlength="4" oninput="inputNumFormat(this)">
                    </span>
                </div>
            </div>
            <div id="grid1"  style="height: 611px; border: 1px solid #bcbcbc;"></div>
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
    const search_planMonth = document.querySelector("#search_planMonth");
    const search_stYear = document.querySelector("#search_stYear");
    const search_endYear = document.querySelector("#search_endYear");

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "CODE_NAME",
            headerText: "공사종별",
            dataType: "text",
            width : "30%",
            style : "text-align-left",
        }
    ];


    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
                showRowCheckColumn : false,
                showRowNumColumn : false,
                displayTreeOpen: true,
                rowCheckDependingTree: true,
                treeIdField: "CD",
                treeIdRefField: "UP_CD",
                flat2tree: true,
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시



    async function grid1_column_make(){
        let columns = [];

        let stYear = Number(search_stYear.value);

        for(let i = stYear; i <= Number(search_endYear.value); i++){
            let item = {};
            item.dataField = String(i);
            item.headerText = String(i);
            item.dataType  = "text";
            item.width = "8%";
            columns.push(item);

        }
        let new_cols = [...grid1ColumnLayout, ...columns];

        AUIGrid.changeColumnLayout(grid1, new_cols);
    }


    //그리드 조회 함수
    function search_grid1_onclick(){
        grid1_column_make();

        //검색데이터
        let selectParam = {
            PLAN_MONTH : search_planMonth.value,
            ST_YEAR : search_stYear.value,
            END_YEAR : search_endYear.value,
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

                items = {};
                data.forEach( row => {
                    const key = JSON.stringify([row.CD, row.NAME]);

                    if (!items[key]) {
                        items[key] = {
                            CD: row.CD,
                            NAME: row.NAME,
                            UP_CD : row.UP_CD
                        };
                    }
                    items[key][row.PLAN_YEAR] = row.NAME;
                })
                let gridDate = Object.values(items);

                //그리드 데이터 세팅
                AUIGrid.setGridData(grid1, gridDate);
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

    async function getSelect_search_planMonth(){
        search_planMonth.innerHTML = "";
        //검색데이터
        let param = {
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_planMonth",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            list.forEach(row => {
                search_planMonth.insertAdjacentHTML("beforeend",
                    "<option value='" + row.PLAN_MONTH + "'>" + row.PLAN_MONTH_NM + "</option>");
            })
        }
        search_planMonth.selectedIndex = 0;
    }


    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, print : true});

        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        Promise.all([
            getSelect_search_planMonth(),
        ]).then(function (){
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        })
    };

</script>


<%@ include file = "../../inc_footer.jsp" %>