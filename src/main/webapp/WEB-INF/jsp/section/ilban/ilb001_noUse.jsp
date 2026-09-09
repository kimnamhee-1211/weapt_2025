<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


        <div class="section2">
            <div class="section2_line1">
                <span>검색조건 :&nbsp;
                    <select id="search_what" class="select_cont100">
                        <option value="all">제목+내용</option>
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
                </span>
                <span>&nbsp;
                   <input type="text" id="search_text" class="search-txt300">
                </span>
            </div>
        </div>
        <div id="grid1"></div>
        <!-- 변경 팝업시작-->
        <%@ include file = "../../popup/pop_write.jsp" %>

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
    const moduleId = "ilb001";
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    let saveKey = "U";
    const search_what = document.querySelector("#search_what"); //select 컴포넌트
    const search_text = document.querySelector("#search_text"); //select 컴포넌트


    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "OFFICE_CODE",
            visible : false
        },
        { dataField: "BOARD_DIV",
            visible : false
        },
        { dataField: "BOARD_NO",
            visible : false
        },
        { dataField: "USER_ID",
            visible : false
        },
        { dataField: "BOARD_TITLE",
            headerText: "제목",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "ATT_NO",
            headerText: "첨부파일",
            dataType: "text",
            width : "6%",
            renderer : {
                type : "TemplateRenderer",
            },
            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { //HTML 템플릿 작성
                if(value) return `<i class="demo-icon icon-floppy" style="font-size:18px;"></i>`;
                else return null;
            }
        },
        { dataField: "BOARD_WRITER",
            headerText: "작성자",
            dataType: "text",
            width : "15%",
        },
        { dataField: "BOARD_DATE",
            headerText: "작성일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "20%"
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_board_Props,
            {})
    );

    //그리드 이벤트
    //행 클릭 시
    AUIGrid.bind(grid1, "cellDoubleClick", function(event) {
        search_board1_onclick();
        //팝업 열기 이벤트
        popupOpen(popup);
    });

    //팝업 이벤트
    //팝업 닫기 이벤트
    function close_popup_onclick(){
        AUIGrid.clearGridData(file_grid1);
        popupClose(popup);
        clearInput(popup);
    }



    //그리드 조회 함수
    function search_grid1_onclick(callback){
        //검색데이터
        let selectParam = {
            WHAT : search_what.value,
            TEXT : search_text.value == null ? '' : search_text.value,
            BOARD_DIV : board_div
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : moduleId + "_grid1",
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

                //search_board1 콜백
                if (typeof callback === "function") {
                    callback();
                }
            }
        });
    }

    function search_board1_onclick(){

        //검색데이터
        let param = {
            BOARD_DIV : board_div,
            BOARD_NO : AUIGrid.getSelectedRows(grid1)[0].BOARD_NO,
            cnt : "N"
        }

        //파라미터
        let boardSelectData = {
            sectionId : sectionId,
            component : moduleId + "_board1",
            param: param,
        }

        we_boardSelect( boardSelectData,{
            successBoardSelect : (json) => {
                let data = json.DATA;
                saveKey = "U";
                dataToInput(data, popup);
                search_file1_onclick();
            }
        });
    }

    //그리드 추가 함수
    function add_grid1_onclick(){
        saveKey = "I";
        //새행 만들기
        const item = {};
        item.BOARD_WRITER = loginUser.userName;
        item.BOARD_DATE = getToday("yyyyMMdd");
        item.BOARD_DIV = board_div;
        item.USER_ID = loginUser.userId;

        AUIGrid.addRow(grid1, item, "first");
        //grid-input 태그 바인딩
        gridToInput(grid1, popup);
        //팝업 열기 이벤트
        popupOpen(popup);
    }

    //그리드 저장 함수
    function save_board1_onclick(){

        let addItem = null;
        let editItem = null;

        let item = {
            BOARD_TITLE : board_title.value,
            BOARD_WRITER : board_writer.value,
            BOARD_DATE : board_date.value.replace(/-/g, ""),
            BOARD_CONTENT : board_content.value,
            BOARD_DIV : board_div,
            BOARD_NO : board_no.value,
            USER_ID : user_id.value
        };

        if(!confirm("게시글 [" + item.BOARD_TITLE + "]을/를 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_BOARD1")) return;

        if(saveKey == "U") {
            if(loginUser.userId != AUIGrid.getSelectedRows(grid1)[0].USER_ID){
                alert("게시글은 작성자만 수정할 수 있습니다");
                return;
            }
            editItem = item;
        }else{
            addItem  = item;
        }

        //포커스 지정
        focus = AUIGrid.getSelectedIndex(grid1)[0];

        //저장 데이터
        let saveParam = {
            insertParam : addItem,
            updateParam : editItem,
            key : {},
            before : {}
        }

        //파라미터
        let boardSaveData  = {
            sectionId : sectionId,
            component : moduleId + "_board1",
            param: saveParam,
        }

        we_boardSave(boardSaveData ,{
            successBoardSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    saveKey = "U";
                    search_grid1_onclick(function() {
                        search_board1_onclick();
                    });
                }else return;
            }
        });
    }

    //그리드 삭제 함수
    function delete_board1_onclick(){

        //검증
        let selctedItem = AUIGrid.getSelectedRows(grid1)[0];
        if(loginUser.userId != selctedItem.USER_ID){
            alert("게시글은 작성자만 삭제할 수 있습니다");
            return;
        }
        if (!confirm("게시글 [" + selctedItem.BOARD_TITLE + "]을/를 삭제하시겠습니까?")) return;

        //포커스 지정
        let selctedRowIndex = AUIGrid.getSelectedIndex(grid1)[0];
        focus = (selctedRowIndex -1) < 1 ? 0 : (selctedRowIndex -1);


        let param =  {
            deleteParam : {
                BOARD_DIV : board_div,
                BOARD_NO : board_no.value
            }
        };

        //공통 저장 트렌젝션용 데이터
        let boardDeleteOneData = {
            sectionId : sectionId,
            component : moduleId + "_board1",
            param : param,
        }

        we_boardDeleteOne(boardDeleteOneData,{
            successboardDeleteOne : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    //팝업 닫기
                    close_popup_onclick();
                    search_grid1_onclick();
                }else return;
            }
        });
    }


    //컴포넌트 필수항목 입력 체크
    function requireCheck(require){
        let isValid = true;
        switch(require){
            case "SAVE_BOARD1":
                if(isNull(board_title.value)){
                    alert("제목은 반드시 입력해야 합니다.");
                    board_title.focus();
                    isValid = false
                }
                if(isNull(board_content.value)){
                    alert("내용은 반드시 입력해야 합니다.");
                    board_content.focus();
                    isValid = false
                }
                break;
        }
        return isValid;
    }

</script>
