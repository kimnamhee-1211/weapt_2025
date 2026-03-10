<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/sojang/soj_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-star-filled"></i>사용자관리
                </div>
                <div class="section1_btn" id="section1_btn"></div>
                <!-- 팝업시작-->
                <div class="layer_bg" id="grid1_popup" onchange="inputToGrid(grid1, popupId)">
                    <div class="popup" style="width: 600px;">
                        <div class="pop_title">&#10004; 사용자등록</div>
                        <div>
                            <span> &#9726&nbsp;사용자ID : </span>
                            <span><input type="text" id="" name="USER_ID" disabled></span> <!-- 추가하면 자동계산 생성-->
                        </div>
                        <table id="popupId" style="line-height:40px;">
                        <tbody>
                            <tr>
                                <th style="width: 150px;">직원선택</th>
                                <td style="width: 150px;">
                                    <select id="input_empNo" name="EMP_NO" onchange="input_empNo_change(this)"></select>
                                </td><th style="width: 150px;">세부그룹</th>
                                <td style="width: 150px;">
                                    <select id="input_groupDtlNo" name="GROUP_DTL_CD"></select>
                                </td>
                            </tr>
                            <tr>
                                <th style="width: 150px;">비밀번호</th>
                                <td style="width: 150px;"><input type="password" id="input_passwd1" name="PASSWD1"  onchange="input_passwd_change(this)"></td>
                                <th style="width: 150px;">비밀번호 확인</th>
                                <td style="width: 150px;"><input type="password" id="input_passwd2" name="PASSWD2" onchange="input_passwd_change(this)"></td>
                            </tr>
                            <tr>
                                <th style="width: 150px;">등록일</th>
                                <td style="width: 150px;">
                                    <input type="date" id="" name="REGI_DATE" data-format="date">
                                </td
                                ><th style="width: 150px;">ID구분</th>
                                <td style="width: 150px;">
                                    <select id="input_idGbn" name="ID_GBN"></select>
                                </td>
                            </tr>
                            <tr>
                                <th style="width: 150px;">부서</th>
                                <td style="width: 150px;">
                                    <select id="input_deptCd" name="DEPT_CD"></select>
                                </td><th style="width: 150px;">직책</th>
                                <td style="width: 150px;">
                                    <select id="input_jobDutyCd" name="JOB_DUTY_CD"></select>
                                </td>
                            </tr>
                            <tr>
                                <th style="width: 150px;">사용자</th>
                                <td style="width: 150px;">
                                    <input type="text" id="" name="USER_NAME" >
                                </td>

                                <th style="width: 150px;">휴대전화</th>
                                <td style="width: 150px;"><input type="text" id="" name="HP_NO" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                            </tr>
                            <tr>
                                <th style="width: 150px;">상태</th>
                                <td style="width: 150px;">
                                    <select id="input_status" name="STATUS"></select>
                                </td>
                                <th style="width: 150px;">해지일</th>
                                <td style="width: 150px;">
                                    <input type="date" id="" name="REG_END_DATE" data-format="date">
                                </td>
                            </tr>
                            <tr>
                                <th style="width: 150px;">비고</th>
                                <td colspan="3"><input type="text" id="" name="REMARKS"></td>
                            </tr>
                        </tbody>
                        </table>
                        <div style="line-height:25px;">
                            <i class="icon-mic"></i>비밀번호를 입력하지 않으면 직원의 휴대번호 끝 4자리로 자동 설정되며,<br>
                            <i class="icon-mic"></i>휴대번호가 없을 시 '1234'로 지정됩니다.
                        </div>
                        <div class="pop_btn">
                            <button id="save_btn1" onclick="save_grid1_onclick()">저장</button>
                            <button id="close_btn1" onclick="close_popup_onclick()">닫기</button>
                        </div>
                    </div>
                </div>
                <!-- 팝업끝-->
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <span class="search-box">관리소명 : &nbsp;</span>
                    <span id="title_officeName" class="search-box"></span>
                    <span class="select-container">&emsp; 검색조건 :&nbsp;
                    <select id="search_status" name="STATUS" class="select_cont70"></select>
                    </span>
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
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const popupId = "grid1_popup"; //팝업 컴포넌트
    const title_officeName = document.querySelector("#title_officeName"); //title 컴포넌트
    const input_empNo = document.querySelector("#input_empNo"); //select 컴포넌트
    const input_groupDtlNo = document.querySelector("#input_groupDtlNo"); //select 컴포넌트
    const input_idGbn = document.querySelector("#input_idGbn"); //select 컴포넌트
    const input_deptCd = document.querySelector("#input_deptCd"); //select 컴포넌트
    const input_jobDutyCd = document.querySelector("#input_jobDutyCd"); //select 컴포넌트
    const input_status = document.querySelector("#input_status"); //select 컴포넌트
    const input_passwd1 = document.querySelector("#input_passwd1"); //select 컴포넌트
    const input_passwd2 = document.querySelector("#input_passwd2"); //select 컴포넌트

    let DS_EMP = [];

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "USER_ID",
            headerText: "ID",
            dataType: "text",
            width : "10%",
        },
        { dataField: "USER_NAME",
            headerText: "사용자",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { dataField: "REGI_DATE",
            headerText: "등록일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
        },
        { dataField: "ID_GBN_NM",
            headerText: "ID구분",
            dataType: "text",
            width : "*%",
        },
        { dataField: "DEPT_NAME",
            headerText: "부서",
            dataType: "text",
            width : "15%",
            editable : false,
        },
        { dataField: "JOB_DUTY_NAME",
            headerText: "직책",
            dataType: "text",
            width : "10%",
            editable : false,
        },
        { dataField: "HP_NO",
            headerText: "휴대전화",
            dataType: "text",
            width : "15%",
            editable : false,
        },
        { dataField: "GROUP_DTL_NM",
            headerText: "세부권한",
            dataType: "text",
            width : "15%",
        },
        { dataField: "STATUS_NM",
            headerText: "상태",
            dataType: "text",
            width : "10%",
        },
        { dataField: "REG_END_DATE",
            headerText: "해지일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
        },
        { dataField: "OFFICE_CODE",
          visible : false
        },
        { dataField: "COMP_CODE",
            visible : false
        },
        { dataField: "EMP_NO",
            visible : false
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
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
        input_passwd2.value = "";
        //팝업 열기 이벤트
        popupOpen(popupId);
    });

    //팝업 이벤트
    //팝업 닫기 이벤트
    function close_popup_onclick(){
        let td = input_passwd2.closest("td");
        td.style.border = "";
        popupClose(popupId);
        clearInput(popupId);
    }

    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
            COMP_CODE : loginUser.compCode,
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

    //그리드 추가 함수
    function add_grid1_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid1, null);
        //새행 만들기
        const item = {};
        let id = nextAlpha(AUIGrid.getColumnValues(grid1,"USER_ID").reduce((a, b) => a > b ? a : b));
        item.USER_ID = id + loginUser.officeCode;
        item.REGI_DATE = getToday("yyyyMMdd");
        item.GROUP_DTL_CD = '500';
        item.OFFICE_CODE = loginUser.officeCode;
        item.COMP_CODE = loginUser.compCode;
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

        if(!isNull(addedRowItems)) {
            addedRowItems.forEach(row => {
                if (!isNull(row.PASSWD1)) {
                    if (isNull(row.PASSWD2) || row.PASSWD1 != row.PASSWD2) {
                        alert("비밀번호를 확인해주세요.");
                        input_passwd2.style.border = "1px solid red";
                    }
                }
            });
        }
        if(!isNull(addedRowItems)) {
            editedRowItems.forEach(row => {
                if (!isNull(row.PASSWD1)) {
                    if (isNull(row.PASSWD2) || row.PASSWD1 != row.PASSWD2) {
                        alert("비밀번호를 확인해주세요.");
                        input_passwd2.style.border = "1px solid red";
                    }
                }
            });
        }

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

        let beforeParam = [...addedRowItems, ...editedRowItems];

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : [],
            before : {
                action : "all",
                saveMode : "U",
                beforeParam : beforeParam
            }
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
        let delItemsName = checkedItems.map(row => row.item.USER_ID).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1);

        // 체크된 행 삭제 처리
        AUIGrid.removeCheckedRows(grid1);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : AUIGrid.getRemovedItems(grid1),
            before : {}
        }

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
                }else{
                    return;
                }
            }
        });
    }

    //컴포넌트 필수항목 입력 체크
    function requireCheck(require){
        let isValid = true;
        switch(require){
            case "SAVE_GRID1":
                isValid = AUIGrid.validateGridData(grid1, [], "필수 필드는 반드시 값을 직접 입력해야 합니다.");
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

    function input_empNo_change(obj){
        if(isNull(obj.value)){
            clearInput(popupId)
        }else{
            if(AUIGrid.getColumnValues(grid1, "EMP_NO").includes(obj.value)){
                alert("이미 등록된 직원입니다");
                clearInput(popupId)
            }
            let data = DS_EMP.filter(row => obj.value == row.EMP_NO);
            dataToInput(data[0], popupId);
        }
    }
    function input_passwd_change(obj){
        let td = input_passwd2.closest("td");
        if(!isNull(input_passwd2.value) && input_passwd1.value != input_passwd2.value){
            alert("비밀번호가 일치하지 않습니다.");
            input_passwd2.value == "";
            td.style.border = "1px solid red";
        }if(input_passwd1.value == input_passwd2.value){
            td.style.border = "";
        }
    }

    async function getSelectOption_input_empNo(){
        input_empNo.innerHTML = "";
        //검색데이터
        let param = {
            OFFICE_CODE : loginUser.officeCode,
            COMP_CODE : loginUser.compCode,
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_input_empNo",
            param: param,
        }
        let list = await we_getSelectOption(data);
        if(list){
            DS_EMP = list;
        }
    }

    async function getSelectOption_input_deptCd(){
        input_deptCd.innerHTML = "";
        //검색데이터
        let param = {}
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_input_deptCd",
            param: param,
        }
        let list = await we_getSelectOption(data);

        if(list){
            list.forEach(row => {
                input_deptCd.insertAdjacentHTML("beforeend",
                    "<option value='" + row.DEPT_CD + "'>" + row.DEPT_NAME + "</option>");
            })
        }
    }

    async function getSelectOption_input_jobDutyCd(){
        input_jobDutyCd.innerHTML = "";
        //검색데이터
        let param = {
            OFFICE_CODE : loginUser.officeCode,
        }
        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_input_jobDutyCd",
            param: param,
        }
        let list = await we_getSelectOption(data);

        if(list){
            list.forEach(row => {
                input_jobDutyCd.insertAdjacentHTML("beforeend",
                    "<option value='" + row.JOB_DUTY_CD + "'>" + row.JOB_DUTY_NAME + "</option>");
            })
        }
    }


    //로드
    window.onload = function() {
        title_officeName.innerHTML = loginUser.officeName;

        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid: "grid1", search : true, add : true, del : true});

        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        //공통코드 가져오기
        if(loginUser.compCode != null && loginUser.compCode == loginUser.officeCode){
            selectOptionMaker("128", input_groupDtlNo, "").then(() => {
                input_groupDtlNo.insertAdjacentHTML("afterbegin", "<option value='500' selected>관리소(기본)</option>");
            });
        }else{
            selectOptionMaker("127", input_groupDtlNo, "").then(() => {
                input_groupDtlNo.insertAdjacentHTML("afterbegin", "<option value='500' selected>관리소(기본)</option>");
            });
        }
        selectOptionMaker("105", input_idGbn, "");
        selectOptionMaker("100", input_status, "");

        getSelectOption_input_empNo().then(() => {
            input_empNo.insertAdjacentHTML("afterbegin", "<option value='' selected>(전체)</option>");
            DS_EMP.forEach(row => {
                input_empNo.insertAdjacentHTML("beforeend",
                    "<option value='" + row.EMP_NO + "'>" + row.EMP + "</option>");
            })
        });
        getSelectOption_input_deptCd();
        getSelectOption_input_jobDutyCd();

        //그리드 DDL
        //gridDdlMaker("107", grid1, "STATE", false);
        //로드 시 그리드 바로 조회
        search_grid1_onclick();
    };

</script>






    
<%@ include file = "../../inc_footer.jsp" %>