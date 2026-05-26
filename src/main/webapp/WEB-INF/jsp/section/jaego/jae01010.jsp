<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "jae_nav.jsp" %>

    <div id="section">
        <div class="section1">
            <div class="section1_nav"><i class="icon-cubes"></i>구입업체등록</div>
            <div class="section1_btn" id="section1_btn">
                <button id="">검색</button>
                <button id="">추가</button>
                <button id="" class="print_btn">인쇄</button>
            </div>
        </div>
        <div class="section2">
            <div class="section2_line1">
                <form action="." method="post">
                    <span class="select-container">&emsp;검색조건 :&nbsp;
                        <select class="select_cont150">
                            <option value="all">전체</option>
                            <option value="normal">정상구입업체</option>
                            <option value="close">해지구입업체</option>
                        </select>
                    </span>
                    <span class="search-box">&nbsp;
                        <input style="width:150px; height:20px;" type="text" placeholder="업체명">
                    </span>
                </form>
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
    const search_select = document.querySelector("search_select")	//select 컴포넌트
    const search_date = document.querySelector("#search_date")	//select 컴포넌트
    const search_input = document.querySelector("search_input")	//select 컴포넌트
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
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });

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

    //그리드 추가 함수
    function add_grid1_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid1, null);
        //새행 만들기
        let selectRowItem = AUIGrid.getSelectedRows(grid1)[0];
        const item = {};
        item.REG_DATE = getToday("yyyyMMdd");
        AUIGrid.addRow(grid1, item, "selectionDown");
    }

    //그리드 저장 함수
    function save_grid1_onclick(){
        // 추가된 행 아이템들(배열)
        let addedRowItems = AUIGrid.getAddedRowItems(grid1);
        // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
        let editedRowItems = AUIGrid.getEditedRowItems(grid1);

        //검증
        let itemCount = addedRowItems.length + editedRowItems.length;
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
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : {
                column : ["MST_NO"],
                seq : [1]
            },
            before : {
                action : "insert",
                saveMode : "I",
                beforeParam : addedRowItems
            }
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

    //그리드 삭제 함수
    function delete_grid1_onclick(){

        //검증
        const checkedItems = AUIGrid.getCheckedRowItems(grid1);
        let itemCount = checkedItems.length;
        if (itemCount=== 0) {
            alert("체크된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("삭제는 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.item.TITLE).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1)

        // 체크된 행 삭제 처리
        AUIGrid.removeCheckedRows(grid1);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : AUIGrid.getRemovedItems(grid1),
            before : {}
        };

        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (json) => {
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

    //crud 권한 처리 함수
    function checkCrudPermission(pgId){
        we_checkCrudPermission(pgId,{
            successPer : (data) => {
                //권한에 따라 버튼 숨김
                btnPermission(data)
            }
        });
    }

    async function getSelect_search_select(){

        search_select.innerHTML = "";
        //검색데이터
        let param = {};

        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_select",
            param: param,
        }
        let list = await we_getSelect(data);

        if(list){
            list.forEach(row => {
                search_mstDate.insertAdjacentHTML("beforeend",
                    "<option value='" + row.CD + "'>" + row.NAME + "</option>");
            })
        }
        search_select.selectedIndex = 0;
    }

    async function getSelect_grid1_gbn(){
        //검색데이터
        let param = {};
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_grid1_gbn",
            param: param,
        }
        DS_GBN = await we_getSelect(data);
    }


    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, add: true, del: true, save: true});

        document.querySelector("#section1_btn").insertAdjacentHTML("afterbegin", "<button id='regist_btn' onclick='regist_onclick()' class='admin_btn'>기본 등록</button>");
        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        Promise.all([
            getSelect_search_select(),
            getSelect_grid1_gbn()
        ]).then(function (){
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        })
    };

</script>


<%@ include file = "../../inc_footer.jsp" %>