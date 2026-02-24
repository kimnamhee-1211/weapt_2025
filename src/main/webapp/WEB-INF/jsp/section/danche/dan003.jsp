<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


    <div class="section2">
        <div class="section2_line1">
            <span>검색조건 :&nbsp;</span>
            <span class="select-container">
                <select class="select_cont100" id="search_what">
                    <option value="name">성명</option>
                    <option value="dong">동</option>
                    <option value="ho">호</option>
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
    const search_what = document.querySelector("search_what")	//select 컴포넌트
    const search_text = document.querySelector("#search_text")	//select 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "EMP_NO",
            headerText: "번호",
            dataType: "text",
            width : "8%",
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
        { dataField: "GRADE_CD",
            headerText: "직위",
            dataType: "text",
            width : "10%",
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
        },
        { dataField: "HP_NO",
            headerText: "연락처",
            dataType: "text",
            width : "10%",
        },
        { dataField: "DISUSE_DATE",
            headerText: "퇴임일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
        },
        { dataField: "DISUSE_REASON",
            headerText: "퇴임사유",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable: false
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
            WHAT : search_what.value,
            TEXT : search_text.value,
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : querySet + "_grid1",
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

    function cancelDisuse_onclick(){
        // 추가된 행 아이템들(배열)
        let checkedItems = AUIGrid.getCheckedRowItemsAll(grid1);
        let itemCount = checkedItems.length;

        //검증
        if(itemCount == 0){
            alert("체크된 행이 없습니다.");
            return;
        }

        if(itemCount > 100){
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.NAME).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount + "건) 복귀처리하시겠습니까?")) return;

        //포커스 지정
        focus = gridFocus(grid1);

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
            component : querySet + "_cancelDisuse",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
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
                break;
        }
        return isValid;
    }


    function pop_onload(pop_item){
        querySet = isNull(pop_item.querySet) ? pop_item.pgId : pop_item.querySet;

        //그리드 DDL

        //로드 시 그리드 바로 조회
        search_grid1_onclick();
    }


</script>
