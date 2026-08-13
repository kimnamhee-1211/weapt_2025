<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>


        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-edit"></i>광고게시문</div>
                <div class="section1_btn"  id="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <div>
                        <span>게시기간 :&nbsp;
                            <input type="date" id="search_startDate" name="START_DATE">&nbsp; ~ &nbsp;
                            <input type="date" id="search_endDate" name="END_DATE">
                        </span>
                    </div>
                </div>
            </div>
            <div id="grid1"></div>

            <div class="layer_bg" id="pop_gwanggo">
                <div class="popup" style="width:910px;">
                    <div class="pop_title0">
                        <span>&#10004; &nbsp;광고게시문</span>
                        <div class="section1_btn" id="pop_btn"></div>
                    </div>
                    <table style="width:890px;">
                        <tbody>
                            <colgroup>
                                <col style ="width:20%">
                                <col style ="width:30%">
                                <col style ="width:20%">
                                <col style ="width:30%">
                            <colgroup>
                                <input type="text" name="REG_USER" id="board_regUser" hidden="hidden">
                                <input type="text" name="REG_DATE" id="board_regDate" hidden="hidden">
                            <tr>
                                <th>게시시작</th>
                                <td><input type="date" id="board_startDate" name="START_DATE" data-format="date"></td>
                                <th>게시종료</th>
                                <td><input type="date" id="board_endDate" name="END_DATE" data-format="date"></td>
                            </tr>
                            <tr>
                                <th>제목</th>
                                <td colspan="3"><input type="text" id="board_subject" name="SUBJECT" ></td>
                            </tr>
                            <tr>
                                <th>광고주</th>
                                <td><input type="text" id="board_adCompName" name="AD_COMP_NAME" ></td>
                                <th>대표자명</th>
                                <td><input type="text" id="board_adOwner" name="AD_OWNER" ></td>
                            </tr>
                            <tr>
                                <th>연락처</th>
                                <td><input type="text" id="board_telNo" name="TEL_NO" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                                <th>금액(원)</th>
                                <td><input type="text" id="board_adAmount" name="AD_AMOUNT" oninput="inputMoneyFormat(this)"></td>
                            </tr>
                            <tr>
                                <th>게시장소</th>
                                <td colspan='3'><input type="text" id="board_pointId" name="POINT_ID" data-format="html" maxlength="18"></td>
                            </tr>
                            <tr>
                                <th rowspan="5">내용</th>
                                <td colspan='3'><input type="text" id="board_docHtml" name="DOC_HTML" data-format="html"></td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

<%--파일 팝업 추가 --%>
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
const sectionId = "${sectionId}";	//섹션ID
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const popupId = "pop_gwanggo"; //팝업 컴포넌트
    const pop_btn = document.querySelector("#pop_btn"); //팝업버튼 컴포넌트
    const search_startDate = document.querySelector("#search_startDate"); //select 컴포넌트
    const search_endDate = document.querySelector("#search_endDate"); //select 컴포넌트
    const board_startDate = document.querySelector("#board_startDate"); //board 컴포넌트
    const board_endDate = document.querySelector("#board_endDate"); //board 컴포넌트
    const board_adCompName = document.querySelector("#board_adCompName"); //board 컴포넌트
    const board_adOwner = document.querySelector("#board_adOwner"); //board 컴포넌트
    const board_telNo = document.querySelector("#board_telNo"); //board 컴포넌트
    const board_adAmount = document.querySelector("#board_adAmount"); //board 컴포넌트
    const board_pointId = document.querySelector("#board_pointId"); //board 컴포넌트
    const board_subject = document.querySelector("#board_subject"); //board 컴포넌트
    const board_docHtml = document.querySelector("#board_docHtml"); //board 컴포넌트
    const board_regDate = document.querySelector("#board_regDate"); //board 컴포넌트
    const board_regUser = document.querySelector("#board_regUser"); //board 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "DOC_SEQ",
            visible : false
        },
        { dataField: "REG_USER",
            visible : false
        },
        { dataField: "SUBJECT",
            headerText: "제목",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "START_DATE",
            headerText: "게시 시작일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%"
        },
        { dataField: "END_DATE",
            headerText: "게시 종료일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%"
        },
        { dataField: "AD_COMP_NAME",
            headerText: "광고주",
            dataType: "text",
            width : "15%",
        },
        { dataField: "AD_OWNER",
            headerText: "대표자",
            dataType: "text",
            width : "8%",
        },
        { dataField: "AD_AMOUNT",
            headerText: "광고금액",
            dataType : "numeric",
            formatString : "#,###",
            width : "10%",
        },
        { dataField: "REG_DATE",
            headerText: "작성일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%"
        },
    ];


    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
                showRowCheckColumn: false,
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });
    //행 클릭 시
    AUIGrid.bind(grid1, "cellDoubleClick", function(event) {
        search_board1_onclick();
        //팝업 열기 이벤트
        popupOpen(popupId);
    });

    //팝업 이벤트
    //팝업 닫기 이벤트
    function close_popup_onclick(){
        popupClose(popupId);
        clearInput(popupId);
    }

    //그리드 조회 함수
    function search_grid1_onclick(callback){
        //검색데이터
        let selectParam = {
            START_DATE : search_startDate.value.replace(/-/g, ""),
            END_DATE : search_endDate.value.replace(/-/g, ""),
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
            DOC_SEQ : AUIGrid.getSelectedRows(grid1)[0].DOC_SEQ,
            cnt : "N"
        }

        //파라미터
        let boardSelectData = {
            sectionId : sectionId,
            component : pgId + "_board1",
            param: param,
        }

        we_boardSelect( boardSelectData,{
            successBoardSelect : (json) => {
                let data = json.DATA;
                saveKey = "U";
                dataToInput(data, popupId);
                //search_file1_onclick();
            }
        });
    }

    //그리드 추가 함수
    function add_grid1_onclick(){
        saveKey = "I";
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid1, null);
        //새행 만들기
        const item = {};
        item.REG_USER = loginUser.userId;
        item.REG_DATE = getToday("yyyyMMdd");
        AUIGrid.addRow(grid1, item, "last");
        //그리드-input 태그 바인딩
        gridToInput(grid1, popupId);
        //팝업 열기 이벤트
        popupOpen(popupId);
    }


    //그리드 저장 함수
    function save_board1_onclick(){

        let addItem = null;
        let editItem = null;

        let item = {
            DOC_SEQ : AUIGrid.getSelectedRows(grid1)[0].DOC_SEQ,
            SUBJECT : board_subject.value,
            DOC_HTML : board_docHtml.value,
            REG_DATE : board_regDate.value.replace(/-/g, ""),
            REG_USER : board_regUser.value,
            START_DATE : board_startDate.value.replace(/-/g, ""),
            END_DATE : board_endDate.value.replace(/-/g, ""),
            AD_COMP_NAME : board_adCompName.value,
            AD_OWNER : board_adOwner.value.replace(/-/g, ""),
            TEL_NO : board_telNo.value,
            AD_AMOUNT : board_adAmount.value,
            POINT_ID : board_pointId.value
        };

        if(!confirm("게시글 [" + item.SUBJECT + "]을/를 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_BOARD1")) return;

        if(saveKey == "U") {
            editItem = item;
        }else{
            addItem = item;
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
            component : pgId + "_board1",
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

        if (!confirm("게시글 [" + selctedItem.SUBJECT + "]을/를 삭제하시겠습니까?")) return;

        //포커스 지정
        let selctedRowIndex = AUIGrid.getSelectedIndex(grid1)[0];
        focus = (selctedRowIndex -1) < 1 ? 0 : (selctedRowIndex -1);

        let param =  {
            deleteParam : {
                DOC_SEQ : AUIGrid.getSelectedRows(grid1)[0].DOC_SEQ,
            }
        };

        //공통 저장 트렌젝션용 데이터
        let boardDeleteOneData = {
            sectionId : sectionId,
            component : pgId + "_board1",
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
            case "SAVE_GRID1":
                if(isNull(board_subject.value)){
                    alert("제목은 반드시 입력해야 합니다.");
                    board_subject.focus();
                    isValid = false
                }
                if(isNull(board_adCompName.value)){
                    alert("내용은 반드시 입력해야 합니다.");
                    board_docHtml.focus();
                    isValid = false
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

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search : true, add : true});
        btnMaker({ tag: "#pop_btn", grid: "board1", save : true, del : true});
        pop_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //공통코드 가져오기
        //그리드 DDL
        //로드 시 그리드 바로 조회
        search_grid1_onclick();
    };

</script>

<%@ include file = "../../inc_footer.jsp" %>