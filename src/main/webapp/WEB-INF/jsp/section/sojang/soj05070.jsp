<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/sojang/soj_nav.jsp" />

    <div id="section">
        <div class="section1">
            <div class="section1_nav">
                <i class="icon-star-filled"></i>관리소등록
            </div>
            <div class="section1_btn" id="section1_btn"></div>
        </div>
        <div class="section2">
            <div class="section2_line1">
                <span class="select-container">관리소상태 :&nbsp;
                    <select id="search_status" name="STATUS" class="select_cont100">
                    </select>
                </span>
                <span class="select-container">&emsp;계약유형 :&nbsp;
                    <select id="search_contKindCd" name="CONT_KIND_CD" class="select_cont100">
                    </select>
                </span>
                <span class="search-box">&emsp;계약만료일 :&nbsp;
                    <input class="search-txt100" type="date" id="search_endDate1" name = "END_DATE1">&nbsp;~&nbsp;
                    <input class="search-txt100" type="date" id="search_endDate2" name = "END_DATE2">
                </span>
            </div>
        </div>
        <div id="grid1"></div>
        <div class="section1">
            <%-- 추가 팝업시작--%>
            <div class="layer_bg" id="grid1_popup" onchange="inputToGrid(grid1, popupId)" >>
                <div class="popup" style="width:980px;">
                    <div class="pop_title">&#10004;관리소등록</div>
                    <div>
                        <span>&nbsp;&#9726 기본사항등록</span>
                        <span class="section_middle_btn" id="pop1_btn"></span>
                    </div>
                    <div>
                        <table>
                            <tbody>
                            <tr>
                                <th style="width: 90px;">관리소코드</th>
                                <td style="width: 150px;"><input type="text" id="" name="OFFICE_CODE" disabled></td>
                                <th style="width: 90px;">등록일</th>
                                <td style="width: 150px;"><input type="date" id="" name="START_DATE" data-format="date"></td>
                                <th style="width: 90px;">세대수</th>
                                <td style="width: 150px;"><input type="text" id="" name="OFFICE_CNT" ></td>
                                <th style="width: 90px;">관리면적</th>
                                <td style="width: 150px;"><input type="text" id="" name="OFFICE_AREAR" ></td>
                            </tr>
                            <tr>
                                <th>*관리소명</th>
                                <td><input type="text" id="" name="OFFICE_NAME" ></td>
                                <th>확장명</th>
                                <td><input type="text" id="" name="EXPLAN" ></td>
                                <th>상태</th>
                                <td>
                                    <select id="input_status" name="STATUS"><%--공통코드 104 --%>
                                    </select>
                                </td>
                                <th>해지일</th>
                                <td><input type="date" id="input_endDate" name="END_DATE" data-format="date"></td>
                            </tr>
                            <tr>
                                <th>관리소구분</th>
                                <td>
                                    <select id="input_part1" name="PART1"><%--공통코드 102--%></select>
                                </td>
                                <th>관리구분</th>
                                <td>
                                    <select id="input_part2" name="PART2"> <%--공통코드 103--%></select>
                                </td>
                                <th>전화번호</th>
                                <td><input type="text" id="" name="TEL" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                                <th>팩스번호</th>
                                <td><input type="text" id="" name="FAX" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                            </tr>
                            <tr>
                                <th rowspan='3'>주소</th>
                                <td colspan='2'>
                                    <input type="text" id="" name="ZIP">
                                </td>
                                <td>
                                    <button id="addr_popup_btn1" class="addr_popup_btn" type="button" onclick="search_addr_onclick()">주소찾기</button>
                                </td>
                                <th>관리회사</th>
                                <td colspan='3'><select id="input_compCode" name="COMP_CODE">
                                </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan='3'><input type="text" id="" name="ADDR1" ></td>  <%--주소1--%>
                                <th>관리자</th>
                                <td colspan='3'>
                                    <select id="input_mgmuserId" name="MGMUSER_ID">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan='3'><input type="text" id="" name="ADDR2" ></td><%--주소2--%>
                                <th>단지이메일</th>
                                <td colspan='3'><input type="email" id="" name="EMAIL" ></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div>
                        <span>&nbsp;&#9726 계약사항등록</span>
                        <span class="section_middle_btn" id="section2_btn"></span>
                    </div>
                    <div id="grid2"></div>
                </div>
            </div>  <%-- 팝업끝--%>
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
    const pgId = "${pgId}";	//프로그램ID
    let grid1;	// 그리드 컴포넌트
    let grid2;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    let focus2 = 0;	//그리드 컴포넌트 포커스
    const popupId = "grid1_popup"; //팝업 컴포넌트
    const pop1_btn = document.querySelector("#pop1_btn"); //팝업버튼 컴포넌트
    const search_status = document.querySelector("#search_status"); //select 컴포넌트
    const search_contKindCd = document.querySelector("#search_contKindCd"); //select 컴포넌트
    const search_endDate1 = document.querySelector("#search_endDate1"); //select 컴포넌트
    const search_endDate2 = document.querySelector("#search_endDate2"); //select 컴포넌트
    const input_status = document.querySelector("#input_status"); //select 컴포넌트
    const input_part1 = document.querySelector("#input_part1"); //select 컴포넌트
    const input_part2 = document.querySelector("#input_part2"); //select 컴포넌트
    const input_compCode = document.querySelector("#input_compCode"); //select 컴포넌트
    const input_mgmuserId = document.querySelector("#input_mgmuserId"); //select 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "OFFICE_CODE",
            headerText: "코드",
            dataType: "text",
            width : "8%",
            editable : false,
        },
        { dataField: "OFFICE_NAME",
            headerText: "관리소명",
            dataType: "text",
            width : "20%",
            editable : false,
            style : "text-align-left",
        },
        { dataField: "OFFICE_CNT",
            headerText: "세대수",
            dataType: "numeric",
            width : "8%",
            editable : false,
        },
        { dataField: "TEL",
            headerText: "전화번호",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { dataField: "OFFICE_HARD_SIZE",
            headerText: "사용기가",
            dataType: "numeric",
            width : "8%",
            editable : false,
        },
        { dataField: "OFFICE_USER_CNT",
            headerText: "사용자수",
            dataType: "numeric",
            width : "8%",
            editable : false,
        },
        { dataField: "STATUS_NM",
            headerText: "상태",
            dataType: "text",
            width : "10%",
        },
        { dataField: "START_DATE",
            headerText: "계약시작일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
            editable : false,
        },
        { dataField: "END_DATE",
            headerText: "계약만료일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
            editable : false,
        },
        { dataField: "CONT_KIND_NM",
            headerText: "계약유형",
            dataType: "text",
            width : "15%",
        },
        { dataField: "CONT_AMT",
            headerText: "계약금액",
            dataType: "numeric",
            width : "10%",
            editable : false,
            formatString : "#,###"
        },
        { dataField: "PLAN_GBN_NM",
            headerText: "조정",
            dataType: "text",
            width : "10%",
        },
        { dataField: "PLAN_MONTH",
            headerText: "조정년월",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
            editable : false,
        },
        { dataField: "REPAIR_STATUS_NM",
            headerText: "조정마감상태",
            dataType: "text",
            width : "15%",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
            })
    );

    const grid2ColumnLayout = [
        { dataField: "CONT_SEQ",
            headerText: "계약순번",
            dataType: "text",
            width : "8%",
            editable : false,
        },
        { dataField: "CONTRACT_NO",
            headerText: "계약번호",
            dataType: "text",
            width : "8%",
            editRenderer : {
                type : "InputEditRenderer",
                onlyNumeric : true, // 0~9 까지만 허용
                maxlength : 20,
            },
        },
        { dataField: "START_DAY",
            headerText: "계약시작일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",

        },
        { dataField: "END_DAY",
            headerText: "계약만료일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
        },
        { dataField: "CONT_KIND_NM",
            headerText: "계약유형",
            dataType: "text",
            width : "15%",
        },
        { dataField: "CONT_AMT",
            headerText: "계약금액",
            dataType: "numeric",
            width : "10%",
            formatString : "#,###"
        },
        { dataField: "REV_DATE",
            headerText: "계약해지일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
        },
        { dataField: "REV_REASON",
            headerText: "계약해지사유",
            dataType: "text",
            width : "12%",
        },
        { dataField: "REMARKS",
            headerText: "비고",
            dataType: "text",
            width : "*%",
        },
        { dataField: "OFFICE_CODE",
           visible : false
        },
    ];

    //그리드 생성
    grid2 = AUIGrid.create("#grid2", grid2ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                height : 314,
                width : 960,
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });
    AUIGrid.bind(grid2, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });
    //행 클릭 시
    AUIGrid.bind(grid1, "cellDoubleClick", function(event) {
        if(!isNull(AUIGrid.getSelectedRows(grid1)[0].COMP_CODE)) {
            getSelectOption_input_mgmuserId();
        }
        search_grid2_onclick();
        //그리드-input 태그 바인딩
        gridToInput(grid1, popupId);
        //팝업 열기 이벤트
        popupOpen(popupId);
    });

    //팝업 이벤트
    //주소찾기 이벤트
    function search_addr_onclick(){
        addrPopup(popupId);
    }
    //팝업 닫기 이벤트
    function close_popup_onclick(){
        popupClose(popupId);
        clearInput(popupId);
        AUIGrid.clearGridData(grid2);
    }

    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
            STATUS : search_status.value,
            CONT_KIND_CD : search_contKindCd.value,
            END_DATE1 : search_endDate1.value.replace(/-/g, ""),
            END_DATE2 : search_endDate2.value.replace(/-/g, "")
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_grid1",
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

    //그리드 조회 함수
    function search_grid2_onclick(){

        //검색데이터
        let selectParam = {
            OFFICE_CODE : AUIGrid.getSelectedRows(grid1)[0].OFFICE_CODE
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_grid2",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (data) => {
                //그리드 데이터 세팅
                AUIGrid.setGridData(grid2, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(grid2, focus2, 0);
                focus2 = 0;
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
        //팝업 열기 이벤트
        popupOpen(popupId);
        //그리드-input 태그 바인딩
        gridToInput(grid1, popupId);
    }

    //그리드 추가 함수
    function add_grid2_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid2, null);
        //새행 만들기
        const item = {};
        item.OFFICE_CODE = AUIGrid.getSelectedRows(grid1)[0].OFFICE_CODE;
        AUIGrid.addRow(grid2, item, "last");
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
            key : ["OFFICE_CODE"],
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    //팝업 닫기
                    search_grid1_onclick()
                }else return;
            }
        });
    }


    //그리드 저장 함수
    function save_grid2_onclick(){
        // 추가된 행 아이템들(배열)
        let addedRowItems = AUIGrid.getAddedRowItems(grid2);
        // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
        let editedRowItems = AUIGrid.getEditedRowItems(grid2);

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
        if(!requireCheck("SAVE_GRID2")) return;

        //포커스 지정
        focus = AUIGrid.getSelectedIndex(grid1)[0];
        focus2 = gridFocus(grid2);

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : ["CONT_SEQ"],
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_grid2",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    search_grid2_onclick();
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
            sectionId : sectionId,
            component : pgId + "_grid1",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    //팝업 닫기
                    close_popup_onclick();
                    search_grid1_onclick();
                }else return;
            }
        });
    }

    //그리드 삭제 함수
    function delete_grid2_onclick(){
        //검증
        const checkedItems = AUIGrid.getCheckedRowItems(grid2);
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
        focus = AUIGrid.getSelectedIndex(grid1)[0] + 1;
        focus2 = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1);

        // 체크된 행 삭제 처리
        AUIGrid.removeCheckedRows(grid2);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : AUIGrid.getRemovedItems(grid2),
            before : {}
        };
        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId : sectionId,
            component : pgId + "_grid2",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    search_grid2_onclick();
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
                    if(isNull(row.OFFICE_NAME)){
                        alert("관리소명은 반드시 입력해야 합니다.");
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

    async function getSelectOption_input_compCode(){
        input_compCode.innerHTML = "";
        //검색데이터
        let param = {
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_input_compCode",
            param: param,
        }
        let list = await we_getSelectOption(data);

        if(list){
            input_compCode.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");  //필요시
            list.forEach(row => {
                input_compCode.insertAdjacentHTML("beforeend",
                    "<option value='" + row.COMP_CODE + "'>" + row.COMP_NAME + "</option>");
            })
        }
        input_compCode.selectedIndex = 0;

    }

    async function getSelectOption_input_mgmuserId(){
        input_mgmuserId.innerHTML = "";
        //검색데이터
        let param = {
            COMP_CODE :  AUIGrid.getSelectedRows(grid1)[0].COMP_CODE
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_input_mgmuserId",
            param: param,
        }
        let list = await we_getSelectOption(data);

        if(list) {
            input_mgmuserId.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");  //필요시
            list.forEach(row => {
                input_mgmuserId.insertAdjacentHTML("beforeend",
                    "<option value='" + row.MGMUSER_ID + "'>" + row.MGMUSER_ID + "</option>");
            })
        }
        input_mgmuserId.value = AUIGrid.getSelectedRows(grid1)[0].MGMUSER_ID
    }

    input_compCode.addEventListener("change", async () => {
        if(!isNull(AUIGrid.getSelectedRows(grid1)[0].COMP_CODE)) {
            getSelectOption_input_mgmuserId();
        }
    });


    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid: "grid1", search : true, add : true, print : true});
        btnMaker({ tag: "#pop1_btn", grid: "grid1", save : true});
        pop1_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");
        btnMaker({ tag: "#section2_btn", grid: "grid2", add : true, save : true });
        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        Promise.all([
            //공통코드 가져오기
            selectOptionMaker("104", search_status, "전체", false),
            selectOptionMaker("129", search_contKindCd, "전체", false),
            selectOptionMaker("104", input_status, "", false),
            selectOptionMaker("102", input_part1, "", false),
            selectOptionMaker("103", input_part2, "", false),
            //그리드 DDL
            getSelectOption_input_compCode(),
        ]).then(function (){
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        })
    };

</script>

<%@ include file = "../../inc_footer.jsp" %>