<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/minwon/min_nav.jsp"/>

    <div id="section">
        <div class="section1">
            <span class="section1_nav"><i class="icon-phone-squared"></i>민원처리</span>
            <div class="section1_btn" id="section1_btn"></div>
        </div>
        <div class="section2">
            <div class="section2_line1">
                <span>조회기간 :&nbsp; <!-- 기간은 2일 어제 오늘-->
                    <input type="date" id="search_startDate">&nbsp; ~ &nbsp;
                    <input type="date" id="search_endDate">
                </span>
                <span class="">&emsp;
                    <input  type="checkbox" checked="checked" id="search_desc">&nbsp;최근순&emsp;
                </span>
            </div>
        </div>
        <div class="gridcont_left_400">
            <div id="grid1"></div>
        </div>
        <div id="min_div" class="gridcont_right_670">
            <div class="section_middle_title">
                <span><i class="icon-pause"></i>접&ensp;수</span>
                <div class="search-box section1_btn">
                    <button id="photo_btn_input1" class="find_btn" onclick="">사진첨부</button>
                </div>
            </div>
            <table class="input_table" style="width:100%; table-layout: fixed;">
                <colgroup>
                    <col style="width:14%">
                    <col style="width:19%">
                    <col style="width:14%">
                    <col style="width:19%">
                    <col style="width:14%">
                    <col style="width:19%">
                </colgroup>
                <tbody>
                    <tr>
                        <th>장소</th>
                        <td><input type="text" id="input_place" name="PLACE" disabled></td>
                        <th>민원인</th>
                        <td><input type="text" id="input_minwonName" name="MINWON_NAME" disabled></td>
                        <th>연락처</th>
                        <td><input type="text" id="input_hpNo" name="HP_NO" disabled></td>
                    </tr>
                    <tr>
                        <input type="text" id="input_minwonDate" name="MINWON_DATE" hidden="hidden">
                        <th>접수일시</th>
                        <td><input type="text" id="input_minwonDateTime" name="MINWON_DATE_TIME" disabled></td>
                        <th>전표번호</th>
                        <td><input type="text" id="input_slipNo" name="SLIP_NO" disabled></td>
                        <th>접수자</th>
                        <td><input type="text" id="input_receiptUser" name="RECEIPT_USER" disabled></td>
                    </tr>
                    <tr>
                        <th>접수내역</th>
                        <td colspan="5" class="min_memo">
                            <textarea id="input_descr" name="DESCR" class="min01020_textarea"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th>사진파일</th>
                        <td colspan="5" class="find_td">
                            <div class="find_td">
                            <%-- 찾은 사진 리스트 (여러개 선택할 수 있게) 하나씩 삭제도 할 수 있게 --%>
                            예시) 찾은사진 1 [ 삭 제 ] <br>
                            찾은사진 2 [ 삭 제 ] <br>
                            찾은사진 2 [ 삭 제 ] <br>
                            찾은사진 2 [ 삭 제 ] <br>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div><i class="icon-mic"></i>접수내역 및 사진만 수정 가능합니다.</div>
            <div class="section_middle_title">
                <span><i class="icon-pause"></i>처&ensp;리</span>
                <span class="section_middle_btn" id="section_middle_btn"></span>
                <div class="search-box section1_btn">
                    <button id="photo_btn_input2" class="find_btn" onclick="">사진첨부</button>
                    <button onclick="" class="find_btn">소모품사용</button>
                    <button onclick="" class="find_btn">계량기사용</button>
                </div>
            </div>
            <table class="input_table" style="width:100%; table-layout: fixed;">
                <colgroup>
                    <col style="width:14%">
                    <col style="width:19%">
                    <col style="width:14%">
                    <col style="width:19%">
                    <col style="width:14%">
                    <col style="width:19%">
                    </colgroup>
                <tbody>
                    <tr>
                        <th>처리일시</th>
                        <td colspan="3">
                            <input type="text" id="input_workSeq" name="WORK_SEQ" hidden="hidden">
                            <div style="display: flex">
                                <span>
                                    <input type="date" id="input_workDate" name="WORK_DATE" data-format="date">
                                </span>&emsp;&emsp;
                                <span>
                                    <input type="checkbox" id="input_workTimeInput" name="WORK_TIME_INPUT">
                                    <label for="input_workTimeInput">시간선택</label>
                                </span>
                                <span id="span_workTime" style="display: none">&ensp;:
                                    <input type="time" id="input_workTime" name="WORK_TIME">
                                </span>
                            </div>
                        </td>
                        <th>구분</th>
                        <td>
                            <select id="input_minwonGbn" name="MINWON_GBN"></select>
                        </td>
                    </tr>
                    <tr>
                        <th>상태</th>
                        <td>
                            <select id="input_statusCd" name="STATUS_CD">
                                <option value="1">처리</option>
                                <option value="2">보류</option>
                                <option value="3">반려</option>
                                <option value="4">처리중</option>
                                <option value="" selected>미결</option>
                            </select>
                        </td>
                        <th>처리자</th>
                        <td><select id="input_workUser" name="WORK_USER"></select></td>
                        <td colspan="2"><input type="text" id="input_workUserName" name="WORK_USER_NAME"></td>
                    </tr>
                    <tr>
                        <th>처리내역</th>
                        <td colspan="5" class="min_memo">
                            <textarea id="input_workDesc" name="WORK_DESC" class="min01020_textarea"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th>사진파일</th>
                        <td colspan="5" class="find_td">
                            <div class="find_td">
                            <%-- 찾은 사진 리스트 (여러개 선택할 수 있게) 하나씩 삭제도 할 수 있게 --%>
                            예시) 찾은사진 1 [ 삭 제 ] <br>
                            찾은사진 2 [ 삭 제 ] <br>
                            찾은사진 2 [ 삭 제 ] <br>
                            찾은사진 2 [ 삭 제 ] <br>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
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
     * select option 조회 함수    (미사용시 생략)
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

    const search_startDate = document.querySelector("#search_startDate")	//select 컴포넌트
    const search_endDate = document.querySelector("#search_endDate")	//select 컴포넌트
    const search_desc = document.querySelector("#search_desc")	//select 컴포넌트

    const min_div = document.querySelector("#min_div");

    const input_place = document.querySelector("#input_place");
    const input_minwonDate = document.querySelector("#input_minwonDate");
    const input_slipNo = document.querySelector("#input_slipNo");
    const input_receiptUser = document.querySelector("#input_receiptUser");
    const input_descr = document.querySelector("#input_descr");

    const input_workSeq = document.querySelector("#input_workSeq");
    const input_workDate = document.querySelector("#input_workDate");
    const input_workTimeInput = document.querySelector("#input_workTimeInput");
    const input_workTime = document.querySelector("#input_workTime");
    const input_minwonGbn = document.querySelector("#input_minwonGbn");
    const input_statusCd = document.querySelector("#input_statusCd");
    const input_workUser = document.querySelector("#input_workUser");
    const input_workUserName = document.querySelector("#input_workUserName");
    const input_workDesc = document.querySelector("#input_workDesc");

    let input_user = []

    //그리드1 설정
    const grid1ColumnLayout = [
        { dataField: "SLIP_NO",
            headerText: "전표번호",
            width : "20%",
            dataType: "text",
        },
        { dataField: "MINWON_DATE",
            headerText: "접수일시",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "20%",
        },
        { dataField: "PLACE",
            headerText: "장소",
            dataType: "text",
            width : "*%",
        },
        { dataField: "STATUS_NAME",
            headerText: "상태",
            dataType: "text",
            width : "15%",
        },
    ];

    //그리드1 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowNumColumn: false,
                editable : false
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex);
    });

    //셀 선택 변경 이벤트 바인딩
    AUIGrid.bind(grid1, "selectionChange", function(event) {
        clearInput("min_div");
        search_input1_onclick();
    });


    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            START_DATE : search_startDate.value.replace(/-/g,""),
            END_DATE : search_startDate.value.replace(/-/g,""),
            DESC : search_desc.checked ? "Y" : "N"
        }

        //파라미터
        let selectData = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                data.forEach( row =>{
                    row.PLACE = make_place(row);
                })
                //그리드 데이터 세팅
                AUIGrid.setGridData(grid1, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(grid1, focus, 0);
                focus = 0;
            }
        });
    }

    function search_input1_onclick(){

        //검색데이터
        let selectParam = {
            SLIP_NO : AUIGrid.getSelectedRows(grid1)[0].SLIP_NO,
            MINWON_DATE : AUIGrid.getSelectedRows(grid1)[0].MINWON_DATE
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_input1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                dataToInput(data[0], "min_div");
                input_place.value = make_place(data[0]);
            }
        });
    }


    //그리드 저장 함수
    function save_grid1_onclick(){

         let item = inputToData("min_div");
        item.REG_DATE = getToday("yyyyMMdd");
        item.TIME_INPUT = input_workTimeInput.checked ? "1" : "0";
        if (!isNull(input_workTimeInput.value)) {
            item.TIME = input_workTimeInput.value.split(":")[0]
            item.MINUTE = input_workTimeInput.value.split(":")[1]
        }
        if (input_workUser.value == "write") {
            item.WORK_USER = item.WORK_USER_NAME
        }

        let addedRowItems = null;
        let editedRowItems = null;

        if (isNull(input_workSeq.value)) {
            addedRowItems = [{...item}];
        } else {
            editedRowItems = [{...item}];
        }

        //검증
        if (!confirm("변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_INPUT1")) return;

        //포커스 지정
        focus = AUIGrid.getSelectedIndex(grid1)[0];

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : ["WORK_SEQ"],
            before: {
                action: "update",
                saveMode: "U",
                beforeParam: [{...item}]
            }
        }

        //파라미터
        let saveData  = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
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

        if (!confirm("민원내역을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1);

        // 체크된 행 삭제 처리
        AUIGrid.removeCheckedRows(grid1);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : AUIGrid.getRemovedItems(grid1),
            before: {}
        };
        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    search_grid1_onclick();
                }else return;
            }
        });
    }

    //컴포넌트 필수항목 입력 체크
    function requireCheck(require){
        let isValid = true;
        switch(require){
            case "SAVE_INPUT1":
                if (input_workUser.value == "write") {
                    if (isNull(input_workUserName.value)) {
                        alert("처리자는 반드시 입력해야 합니다.");
                        isValid = false;
                    }
                }
                if (isNull(input_workDate.value)) {
                    alert("처리일은 반드시 입력해야 합니다.");
                    isValid = false;
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

    function make_place(data){
        let place = ""
        if(data.GBN == "0"){
            place =  data.HO_ID.split("-")[0] + "동 " + data.HO_ID.split("-")[1] + "호"
        }else if(data.GBN == "1"){
            if(data.LINE_GBN == "109999"){
                place = data.HO_ID.split("-")[0] + "동 지하주차장"
            }else{
                let lineGbnNm = "";
                switch (data.LINE_GBN){
                    case "109003" :
                        lineGbnNm = "현관";
                        break;
                    case "109997" :
                        lineGbnNm = " EL";
                        break;
                    case "109998" :
                        lineGbnNm = "옥탑";
                        break;
                    case "109002" :
                        lineGbnNm = "계단";
                        break;
                }
                place = data.HO_ID.split("-")[0] + "동 " + data.HO_ID.split("-")[1] + " " +  lineGbnNm
            }
        }else{
            place = data.AREAR_NAME;
        }
        return place;
    }

    async function getSelectOption_input1_minwonGbn() {
        input_minwonGbn.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId: sectionId,
            component: pgId + "_input1_minwonGbn",
            param: param,
        }

        let list = await we_getSelectOption(data);

        if (list) {
            input_minwonGbn.insertAdjacentHTML("beforeend", "<option value='' selected>미선택</option>");
            list.forEach(row => {
                input_minwonGbn.insertAdjacentHTML("beforeend",
                    "<option value='" + row.GBN_ID + "'>" + row.GBN_NAME + "</option>");
            })
        }
    }

    async function getSelectOption_input1_user() {

        input_workUser.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId: sectionId,
            component: pgId + "_input1_user",
            param: param,
        }

        let list = await we_getSelectOption(data);
        input_user = list;

        if (list) {
            input_workUser.insertAdjacentHTML("beforeend", "<option value='write' selected>직접입력</option>");  //필요시
            list.forEach(row => {
                input_workUser.insertAdjacentHTML("beforeend",
                    "<option value='" + row.NAME + "'>" + row.NAME + "</option>");
            })

        }
    }

    input_workTimeInput.addEventListener("change", () => {
        const el = document.querySelector("#span_workTime");
        if (input_workTimeInput.checked) {
            el.style.display = "inline";
            const now = new Date();
            const hh = String(now.getHours()).padStart(2, '0');
            const mm = String(now.getMinutes()).padStart(2, '0');
            input_workTime.value = `${hh}:${mm}`;
        } else {
            el.style.display = "none";
            input_workTime.value = "";
        }
    });

    input_workUser.addEventListener("change", () => {
        if(input_workUser.value != 'write'){
            input_workUserName.value = '';
        }
    });

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, save: true , del: true});
        search_startDate.value = getToday("yyyy-MM-dd");
        search_endDate.value = addDate(getToday("yyyy-MM-dd"), 7, "yyyy-MM-dd");

        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        Promise.all([
            //DDL
            getSelectOption_input1_minwonGbn(),
            getSelectOption_input1_user(),
        ]).then(function () {
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        })

    };

</script>

<%@ include file = "../../inc_footer.jsp" %>