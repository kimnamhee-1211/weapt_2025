<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/iljung/ilj_nav.jsp" />

    <div id="section">
        <div class="section1">
            <div class="section1_nav"><i class="icon-calendar-plus-o"></i>연중관리계획</div>
            <div class="section1_btn" id="section1_btn"></div>
        </div>
        <div class="section2">
            <div class="section2_line1">
                <span>수립기준일 :&nbsp;
                    <select id="search_mstDate" name="" class="select_cont100"></select>
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
    const search_mstDate = document.querySelector("#search_mstDate")	//select 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "MST_NO",
            visible : false
        },
        { dataField: "MST_MONTH",
            headerText: "등록월",
            dataType: "text",
            width : "8%",
            cellMerge : true
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowNumColumn: false,
                editable: false,
                enableCellMerge : true
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });

    async function grid1_column_make(){
        let columns = [];

        //검색데이터
        let param = { }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_grid1_column",
            param: param,
        }
        let list = await we_getSelectOption(data);

        list.forEach((row, idx)=>{
            let item = {};
            item.dataField  = row.SCH_GBN;
            item.headerText = row.GBN_NAME;
            item.dataType  = "text";
            item.width = "20%";
            columns.push(item);
        });
        let new_cols = [...grid1ColumnLayout, ...columns];

        AUIGrid.changeColumnLayout(grid1, new_cols);
    }

    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            MST_DATE : search_mstDate.value,
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.data;
                let items = {};
                data.forEach(row =>{
                    let month = row.MST_MONTH;
                    let dept  = row.SCH_GBN;
                    if(!items[month]){items[month] = {};}
                    if(!items[month][dept]){items[month][dept] = [];}
                    let item = {}
                    item.TITLE = row.TITLE
                    items[month][dept].push(item);
                })
                let rows = []
                Object.keys(items).forEach(month => {
                    let depts = items[month];
                    let max = Math.max(...Object.values(depts).map(v => v.length));
                    for(let i = 0; i < max; i++){
                        let row = {}
                        row.MST_MONTH = month;
                        Object.keys(depts).forEach(dept => {
                            row[dept] = depts[dept][i] ? depts[dept][i].TITLE : ""
                        })
                        rows.push(row);
                    }
                })
                rows.sort((a, b) => a.MST_MONTH.localeCompare(b.MST_MONTH));

                //그리드 데이터 세팅
                AUIGrid.setGridData(grid1, rows);
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

    async function getSelectOption_search_mstDate(){

        search_mstDate.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_mstDate",
            param: param,
        }
        let list = await we_getSelectOption(data);

        if(list){
            list.forEach(row => {
                search_mstDate.insertAdjacentHTML("beforeend",
                    "<option value='" + row.MST_DATE + "'>" + row.MST_DATE_FORMAT + "</option>");
            })
        }
        search_mstDate.selectedIndex = 0;
    }


    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true});
        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        Promise.all([
            getSelectOption_search_mstDate(),
            grid1_column_make()
        ]).then(function (){
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        })
    };

</script>

<%@ include file = "../../inc_footer.jsp" %>