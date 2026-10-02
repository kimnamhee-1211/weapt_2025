<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>장기수선계획조회
                </div>
                 <div class="section1_btn" id="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <span class="search-box">수립조정년월 :&nbsp;
                        <select id="search_planMonth" class="select_cont100"></select>&emsp;
                    </span>
                    <span class="select-container">&emsp;
                        <input type="radio" id="" name="" class="">
                        <label for="option1">총괄</label>
                    </span>
                    <span class="select-container">&emsp;
                        <input type="radio" id="" name="" class="">
                        <label for="option2">총괄구분</label>
                    </span>
                    <span class="select-container">&emsp;
                        <input type="radio" id="" name="" class="" checked>
                        <label for="option3">공사종별</label>
                    </span>
                    <span class="select-container">&emsp;&emsp;수선예정년 :&nbsp;
                        <select id="search_planYear" name="" class="select_cont70"></select>
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
    const search_planMonth = document.querySelector("#search_planMonth")	//select 컴포넌트
    const search_date = document.querySelector("#search_date")	//select 컴포넌트
    const search_planYear = document.querySelector("#search_planYear")	//select 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "CODE_NAME",
            headerText: "공사종별",
            dataType: "text",
            width : "30%",
            style : "text-align-left",
            editable : false
        },
        { dataField: "REGUL_YN_NM",
            headerText: "방법",
            dataType: "text",
            width : "10%",
            editable : false
        },
        { dataField: "PERIOD",
            headerText: "주기",
            dataType: "text",
            width : "10%",
            editable : false
        },
        { dataField: "RATE",
            headerText: "수선율",
            dataType: "text",
            width : "10%",
            editable : false
        },
        { dataField: "RE_YEAR",
            headerText: "최종년도",
            dataType: "text",
            width : "10%",
            editable : false
        },
        { dataField: "PLAN_YEAR",
            headerText: "예정년도",
            dataType: "text",
            width : "10%",
            editable : false
        },
        { dataField: "PLAN_AMT",
            headerText: "수선예정금액",
            dataType: "numeric",
            formatString : "#,###",
            width : "20%",
            editable : false
        },
        { dataField: "PLAN_REMARKS",
            headerText: "실시 및 계획",
            dataType: "text",
            width : "30%",
            style : "text-align-left",
        },
    ];

    const footerLayout1 = [{
        dataField: "PLAN_AMT",
        positionField: "PLAN_AMT",
        operation: "SUM",
        formatString: "#,###"
    }];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowCheckColumn : false,
                showRowNumColumn : false,
                displayTreeOpen: true,
                rowCheckDependingTree: true,
                treeIdField: "CD",
                treeIdRefField: "UP_CD",
                flat2tree: true,
            })
    );
    AUIGrid.setFooter(grid1, footerLayout1);

    //그리드 이벤트
    //체크박스 클릭 시

    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            PLAN_MONTH : search_planMonth.value,
            DATE : search_date.value,
            PLAN_YEAR : search_planYear.value
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


    //그리드 저장 함수
    function save_grid1_onclick(){

        // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
        let editedRowItems = AUIGrid.getEditedRowItems(grid1);

        //검증
        let itemCount = editedRowItems.length;
        if(itemCount == 0){
            alert("변경된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        if(!confirm("총 " + itemCount + "건의 변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_GRID1")) return;

        //포커스 지정
        focus = gridFocus(grid1);

        //저장 데이터
        let saveParam = {
            insertParam : null,
            updateParam : editedRowItems,
            key : {},
            before : {}
        };

        //파라미터
        let saveData  = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_grid1_onclick();
                }else return;
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

    async function getSelect_search_planYear(){
        search_planYear.innerHTML = "";
        //검색데이터
        let param = {
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_planYear",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            search_planYear.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");
            list.forEach(row => {
                search_planYear.insertAdjacentHTML("beforeend",
                    "<option value='" + row.PLAN_YEAR + "'>" + row.PLAN_YEAR + "</option>");
            })
        }
        search_planYear.selectedIndex = 0;
    }

    search_planMonth.addEventListener("change", function (){
        getSelect_search_planYear();
    })


    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, save: true, print : true});

        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        Promise.all([
            getSelect_search_planMonth(),
            getSelect_search_planYear()
        ]).then(function (){
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        })
    };

</script>

<%@ include file = "../../inc_footer.jsp" %>