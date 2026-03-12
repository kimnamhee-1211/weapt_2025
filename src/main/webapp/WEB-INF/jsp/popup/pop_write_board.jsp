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
   <div class="layer_bg" id="pop_write_board">
        <div class="popup" style="width:910px;">
            <div class="pop_title0" >
                <span id="board_id"></span>  <%-- 각 게시판 메뉴명--%>
                <div class="section1_btn" id="pop1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <span>제목 :&nbsp;
                        <input type="text" name="BOARD_TITLE" id="board_title" class="box_width450">
                    </span>
                    <span>&ensp;작성자 :&nbsp;
                        <input type="text" name="BOARD_WRITER" id="board_writer" class="box_width100" disabled>
                    </span>
                    <span>&ensp;작성일 :&nbsp;
                        <input type="date" name="BOARD_DATE" id="board_date" data-format="date" disabled>
                    </span>
                </div>
            </div>
            <div>
                <textarea class="pop_write_textarea" name="BOARD_CONTENT" id="board_content" data-format="html"></textarea>
            </div>
            <input type="text" name="BOARD_NO" id="board_no" hidden="hidden">
            <input type="text" name="USER_ID" id="user_id" hidden="hidden">
            <%--여러 파일 업로드 및 삭제 input_file.html 참조--%>

            <div class="pop_title0" >
                <span>첨부파일</span>  <%-- 각 게시판 메뉴명--%>
                <div class="section1_btn" id="pop1_btn2">
            </div>
            <div id="file_grid1"></div>
            <input type="file" id="fileSelector" hidden />
        </div>
    </div>

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
        const popupId = "pop_write_board";
        let querySet;
        let board_div; //게시판 구분
        let grid1;	// 그리드 컴포넌트
        let focus = 0;	//그리드 컴포넌트 포커스
        let saveKey = "U";

        const search_what = document.querySelector("#search_what"); //select 컴포넌트
        const search_text = document.querySelector("#search_text"); //select 컴포넌트
        const pop1_btn = document.querySelector("#pop1_btn"); //팝업버튼 컴포넌트
        const board_id = document.querySelector("#board_id"); //팝업 컴포넌트
        const board_title = document.querySelector("#board_title"); //팝업 컴포넌트
        const board_writer = document.querySelector("#board_writer"); //팝업 컴포넌트
        const board_date = document.querySelector("#board_date"); //팝업 컴포넌트
        const board_content = document.querySelector("#board_content"); //팝업 컴포넌트
        const board_no = document.querySelector("#board_no"); //팝업 컴포넌트
        const user_id = document.querySelector("#user_id"); //팝업 컴포넌트

        //첨부파일 컴포넌트
        let file_grid1;	// 그리드 컴포넌트
        let file_focus = 0;	//그리드 컴포넌트 포커스
        const fileSelector = document.querySelector("#fileSelector"); //팝업-첨부파일 컴포넌트

        //파일 저장 캐시
        let orgFileNm = {};  //파일 저장 캐시
        let newfiles = [];// 최근 그리드 파일 선택 행 아이템 보관 변수
        let recentGridItem = null;


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

        //그리드 설정
        const fileGrid1ColumnLayout = [
            { dataField: "BOARD_DIV",
                visible : false
            },
            { dataField: "BOARD_NO",
                visible : false
            },
            { dataField: "ATT_NO",
                visible : false
            },
            { dataField: "SYS_FILE_NM",
                visible : false
            },
            { dataField: "FILE_PATH",
                visible : false
            },
            { dataField: "FILE_NM",
                headerText: "제목",
                dataType: "text",
                width : "*%",
                style : "text-align-left",
                editable : false
            },
            {
                dataField: "FILE_SIZE",
                headerText: "파일크기",
                width: "20%",
                style: "align_right",
                editable : false,
                dataType: "numeric", <%-- 데이터타입 설정 필수 --%>
                formatString: "#,###.###", <%-- formatString 설정 필수 --%>
                renderer: {
                    type: "TemplateRenderer",
                    aliasFunction: function(rowIndex, columnIndex, value, headerText, item) { <%-- 엑셀, PDF 등 내보내기 시 값 가공 함수 --%>
                        return value;
                    }
                },
                labelFunction: function(rowIndex, columnIndex, value, headerText, item) { <%--HTML 템플릿 작성 --%>
                    let isMiB = Number(value) / 1024 / 1024 >= 1;
                    return isMiB ? String(Math.ceil(Number(value) / 1024 / 1024 * 100) / 100) + "MB" : String(Math.ceil(Number(value) / 1024 * 100) / 100) + "KB";
                }
            },
            {
                dataField: "",
                width: "10%",
                renderer: {
                    type: "ButtonRenderer",
                    labelText: "다운로드",
                    onClick: function (event) {
                        file_down_onclick(event.item);
                    }
                }
            }
        ];

        //그리드 생성
        file_grid1 = AUIGrid.create("#file_grid1", fileGrid1ColumnLayout,
            Object.assign({}, we_file_Props,
                {})
        );

        //그리드 이벤트
        //행 클릭 시
        AUIGrid.bind(grid1, "cellDoubleClick", function(event) {
            search_board1_onclick();
            //팝업 열기 이벤트
            popupOpen(popupId);
        });

        //팝업 이벤트
        //팝업 닫기 이벤트
        function close_popup_onclick(){
            AUIGrid.clearGridData(file_grid1);
            popupClose(popupId);
            clearInput(popupId);
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
                component : querySet + "_board1",
                param: param,
            }

            we_boardSelect( boardSelectData,{
                successBoardSelect : (json) => {
                let data = json.DATA;
                    saveKey = "U";
                    dataToInput(data, popupId);
                    search_file1_onclick();
                }
            });
        }

        function search_file1_onclick(){

            //검색데이터
            let param = {
                BOARD_DIV : board_div,
                BOARD_NO : board_no.value,
            }

            //파라미터
            let selectData = {
                sectionId : sectionId,
                component : querySet + "_file1",
                param: param,
            }

            we_select( selectData,{
                successSelect : (json) => {
                let data = json.DATA;
                    data.forEach(row => {
                        orgFileNm.ATT_NO = row.FILE_NM
                    });

                    AUIGrid.setGridData(file_grid1, data);
                    AUIGrid.setSelectionByIndex(file_grid1, file_focus, 0);
                    file_focus = 0;
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
            gridToInput(grid1, popupId);
            //팝업 열기 이벤트
            popupOpen(popupId);
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
                key : [],
                before : {}
            }

            //파라미터
            let boardSaveData  = {
                sectionId : sectionId,
                component : querySet + "_board1",
                param: saveParam,
            }

            we_boardSave(boardSaveData ,{
                successBoardSave : (data) => {
                    alert(data.O_MSG);
                    if(data.O_RESULT > 0){
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
                component : querySet + "_board1",
                param : param,
            }

            we_boardDeleteOne(boardDeleteOneData,{
                successboardDeleteOne : (data) => {
                    alert(data.O_MSG);
                    if(data.O_RESULT > 0){
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


        function pop_onload(pop_item){
            btnMaker({ tag: "#pop1_btn", grid: "board1", save : true, del : true});
            pop1_btn.insertAdjacentHTML("beforeend",
                "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");

            btnMaker({ tag: "#pop1_btn2", grid: "file1", add : true, save : true, del : true});

            board_id.innerHTML = isNull(pop_item.pop_title) ? "&#10004;" : pop_item.pop_title;
            querySet = isNull(pop_item.querySet) ? pop_item.pgId : pop_item.querySet;
            board_div = isNull(pop_item.board_div) ? "" :pop_item.board_div;

            if(querySet){
                //로드 시 그리드 바로 조회
                search_grid1_onclick();
            }
        }

    </script>
                
                        
   

 
