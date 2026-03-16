<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/sojang/soj_nav.jsp" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <div id="section">
        <div class="section1">
            <div class="section1_nav">
                <i class="icon-star-filled"></i>관리회사등록
            </div>
            <div class="section1_btn" id="section1_btn"></div>
            <!-- 변경 팝업시작-->
            <div class="layer_bg" id="grid1_popup" onchange="inputToGrid(grid1, popupId)" >
                <div class="popup" style="width:620px;">
                    <div class="pop_title">&#10004;관리회사등록</div>
                    <div style="padding: 15px;">
                        <table>
                            <tbody>
                            <tr>
                                <th style="width: 100px;">관리회사코드</th>
                                <td style="width: 200px;"><input type="text" id="" name="COMP_CODE" oninput="inputNumFormat(this)" disabled></td> <!-- 101부터 증가-->
                                <th style="width: 100px;">등록일</th>
                                <td style="width: 200px;"><input type="date" id="" name="REGI_DAY" data-format="date"></td>
                            </tr>
                            <tr>
                                <th>*관리회사명</th>
                                <td><input type="text" id="" name="COMP_NAME" ></td>
                                <th>사업자번호</th>
                                <td><input type="text" id="" name="NUM" oninput="inputBRNFormat(this)" placeholder="숫자만 입력해주세요" maxlength="12"></td>
                            </tr>
                            <tr>
                                <th>대표자</th>
                                <td><input type="text" id="" name="CEO" ></td>
                                <th>대표자전화번호</th>
                                <td><input type="text" id="" name="CEO_HP" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                            </tr>
                            <tr>
                                <th>업태</th>
                                <td><input type="text" id="" name="CON" ></td>
                                <th>종목</th>
                                <td><input type="text" id="" name="ITEM" ></td>
                            </tr>
                            <tr>
                                <th rowspan='3'>주소</th>
                                <td colspan='2'>
                                    <input type="text" id="input_zip" name="ZIP">
                                </td>
                                <td>
                                    <button id="addr_popup_btn1" class="addr_popup_btn" type="button" onclick="search_addr_onclick()">주소찾기</button>
                                </td>
                            </tr>
                            <tr>
                                <td colspan='3'><input type="text" id="input_addr1" name="ADDR1" ></td>
                            </tr>
                            <tr>
                                <td colspan='3'><input type="text" id="" name="ADDR2" ></td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td><input type="text" id="" name="TEL" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                                <th>팩스번호</th>
                                <td><input type="text" id="" name="FAX" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                            </tr>
                            <tr>
                                <th>E-Mail</th>
                                <td><input type="email" id="" name="EMAIL" ></td>
                                <th>홈페이지</th>
                                <td><input type="text" id="" name="HOMEPAGE" ></td>
                            </tr>
                            <!--관리자 없어짐-->
                            <tr>
                                <th>상태</th>
                                <td>
                                    <select id="input_state" name="STATE">
                                    </select>
                                </td>
                                <th>해지일</th>
                                <td><input type="date" id="input_offDay" name="OFF_DAY" data-format="date"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="pop_btn" id="pop1_btn"></div>
                </div>
                <!-- 팝업끝-->
            </div>
        </div>
        <div id="grid1"></div>
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
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const popupId = "grid1_popup"; //팝업 컴포넌트
    const pop1_btn = document.querySelector("#pop1_btn"); //팝업버튼 컴포넌트
    const input_state = document.querySelector("#input_state"); //select 컴포넌트
    const input_offDay = document.querySelector("#input_offDay"); //컨트롤 컴포넌트


    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "COMP_CODE",
            headerText: "코드",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { dataField: "REGI_DAY",
            headerText: "등록일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "15%",
            editable : false,
        },
        { dataField: "COMP_NAME",
            headerText: "관리회사명",
            dataType: "text",
            width : "*%",
            editable : false,
            style : "text-align-left",
        },
        { dataField: "TEL",
            headerText: "전화번호",
            dataType: "text",
            width : "15%",
            editable : false,
        },
        { dataField: "CEO",
            headerText: "대표자",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { dataField: "STATE_NM",
            headerText: "상태",
            dataType: "text",
            width : "15%",
        }
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
                height : 660,
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });
    //행 클릭 시
    AUIGrid.bind(grid1, "cellDoubleClick", function(event) {
        //그리드-input 태그 바인딩
        gridToInput(grid1, popupId);
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
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
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
        const item = {};
        AUIGrid.addRow(grid1, item, "last");
        //그리드-input 태그 바인딩
        gridToInput(grid1, popupId);
        //팝업 열기 이벤트
        popupOpen(popupId);
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
            key : ["COMP_CODE"],
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    //팝업 닫기
                    close_popup_onclick();
                    search_grid1_onclick()
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
        let delItemsName = checkedItems.map(row => row.item.COMP_NAME).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1);

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
                let addedRowItems = AUIGrid.getAddedRowItems(grid1);
                let editedRowItems = AUIGrid.getEditedRowItems(grid1);
                let items = [...addedRowItems,...editedRowItems];
                for(const row of items){
                    if(isNull(row.COMP_NAME)){
                        alert("관리회사명은 반드시 입력해야 합니다.");
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

    input_state.addEventListener("change", async () => {
        if(input_state.value == "107003" || !isNull(input_offDay.value)) {
            input_offDay.value = getToday("yyyy-MM-dd")
        }
    });

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", add : true, del : true});
        btnMaker({ tag: "#pop1_btn", grid: "grid1", save : true});
        pop1_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //공통코드 가져오기
        selectOptionMaker("107", input_state, "", false);
        //그리드 DDL
        //로드 시 그리드 바로 조회
        search_grid1_onclick();
    };

</script>




<%@ include file = "../../inc_footer.jsp" %>