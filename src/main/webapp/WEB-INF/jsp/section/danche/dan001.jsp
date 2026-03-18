<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


    <div class="section2">
        <div class="section2_line1">
            <span>검색조건 :&nbsp;</span>
            <span class="select-container">
                <select class="select_cont100" id="search_option">
                    <option value="name" selected>성명</option>
                    <option value="name">동</option>
                    <option value="name">호</option>
                </select>
            </span>
            <span class="search-box">&nbsp;
                <input class="box_width200" type="text" id="search_text">
            </span>
        </div>
    </div>
    <div id="grid1"></div>


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
    let querySet;
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_option = document.querySelector("#search_option")	//select 컴포넌트
    const search_text = document.querySelector("#search_text")	//select 컴포넌트
    let DS_DUTY_CD = [];

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "EMP_NO",
            headerText: "번호",
            dataType: "text",
            width : "8%",
            editable : false
        },
        { dataField: "DONG",
            headerText: "동",
            dataType: "text",
            width : "8%",
        },
        { dataField: "HO",
            headerText: "호",
            dataType: "text",
            width : "8%",
        },
        { dataField: "DUTY_CD",
            headerText: "직위",
            dataType: "text",
            width : "15%",
            renderer: {
                type: "DropDownListRenderer",
                listFunction: function (rowIndex, columnIndex, item, dataField) {
                    return DS_DUTY_CD;
                },
                keyField: "DUTY_CD", // key 에 해당되는 필드명
                valueField: "DUTY_NAME", // value 에 해당되는 필드명
            }
        },
        { dataField: "NAME",
            headerText: "이름",
            dataType: "text",
            width : "10%",
        },
        { dataField: "REG_DATE",
            headerText: "취임일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
            editRenderer : we_calendar_Renderer
        },
        { dataField: "HP_NO",
            headerText: "연락처",
            dataType: "text",
            width : "10%",
        },
        { dataField: "BIRTH",
            headerText: "생년월일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
            editRenderer : we_calendar_Renderer
        },
        { dataField: "REMARKS",
            headerText: "비고",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
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
            OPTION : search_option.value,
            TEXT : search_text.value,
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : querySet + "_grid1",
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
            key : ["EMP_NO"],
            before : {}
        };

        //파라미터
        let saveData  = {
            sectionId :  sectionId,
            component : querySet + "_grid1",
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
        let delItemsName = checkedItems.map(row => row.item.NAME).join(", ");
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
            component : querySet + "_grid1",
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

    function disuse_onclick(){
        // 추가된 행 아이템들(배열)
        let checkedItems = AUIGrid.getCheckedRowItemsAll(grid1);
        let itemCount = checkedItems.length;
        //검증
        if(itemCount == 0){
            alert("체크된 행이 없습니다.");
            return;
        }
        if(isNull(input_disuseDate.value)){
            alert("퇴사일은 반드시 입력해야 합니다.");
            return;
        }
        if(itemCount > 100){
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.NAME).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount + "건) 퇴사처리하시겠습니까?")) return;

        //포커스 지정
        focus = gridFocus(grid1);

        checkedItems.forEach(row =>{
            row.DISUSE_DATE = input_disuseDate.value.replace(/-/g, "");
            row.DISUSE_REASON = input_disuseReason.value;
        });

        //저장 데이터
        let saveParam = {
            insertParam : null,
            updateParam : checkedItems,
            key : [],
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : querySet + "_disuse",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_grid1_onclick()
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
                    if(isNull(row.NAME)){
                        alert("이름은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.DONG)){
                        alert("동은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.HO)){
                        alert("호수는 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                }
                break;
        }
        return isValid;
    }

    async function getSelectOption_grid1_gradeCd(){
        let  code = await we_getCode('126');
        code.forEach(row=>{
            let item = {};
            item.DUTY_CD = row.CODE_NO;
            item.DUTY_NAME = row.CODEDTL_NM;
            DS_DUTY_CD.push(item);
        });

    }


    function pop_onload(pop_item){
        querySet = isNull(pop_item.querySet) ? pop_item.pgId : pop_item.querySet;
        //그리드 DDL
        Promise.all([
            getSelectOption_grid1_gradeCd()
        ]).then(function () {
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        });
    }


</script>
