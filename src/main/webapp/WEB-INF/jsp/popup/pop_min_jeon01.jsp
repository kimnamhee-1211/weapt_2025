<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="layer_bg" id="pop_min_jeon01">
    <div class="popup" style="width: 740px;">
        <div class="pop_title">&#10004; 세대민원전표</div>
        <div id="min_tb" class="gridcont_right_720">
            <div class="section_middle_title">
                <span><i class="icon-pause"></i>접&ensp;수</span>
                <span class="section_middle_btn" id="pop_btn">
                </span>
                <span class="search-box section1_btn">
                    <button id="find_btn" onclick="" class="find_btn">메시지전송</button>
                    <%-- 설정에서 선택해야 나옴 --%>
                </span>
            </div>
            <table style="width:720px;">
                <colgroup>
                    <col style="width:12%">
                    <col style="width:32%">
                    <col style="width:12%">
                    <col style="width:16%">
                    <col style="width:12%">
                    <col style="width:16%">
                </colgroup>
                <tbody id="min_tb_01">
                <tr>
                    <th>동호</th>
                    <td>
                        <input type="text" id="input_dongName" name="DONG_NAME" class="box50">동
                        <input type="text" id="input_ho" name="HO" class="box50">호
                        <input type="text" id="input_dongId" name="DONG_ID" hidden="hidden">
                        <input type="text" id="input_hoId" name="HO_ID" hidden="hidden">
                        <input type="text" id="input_gbn" name="GBN" hidden="hidden">
                        <input type="text" id="input_slipNo" name="SLIP_NO" hidden="hidden">
                    </td>
                    <%-- 민원인과 연락처는 세대정보등록에서 가져오고 수정가능 --%>
                    <th>민원인</th>
                    <td><****></td>
                    <th>연락처</th>
                    <td><****></td>
                </tr>
                <tr>
                    <th>접수일시</th>
                    <td colspan="3">
                        <span><input type="date" id="input_minwonDate" name="MINWON_DATE" data-format="date"></span>&emsp;&emsp;
                        <%-- 환경설정에 체크되어 있으면 서버 현재시간 가져오기 --%>
                        <span>
                            <input type="checkbox" id="input_timeInput" name="TIME_INPUT">
                            <label for="input_timeInput">시간선택 :</label>
                        </span>
                        <%-- 체크되면 시,분 보여지기 --%>
                        <span>&ensp;<input type="time" id="input_time" class="box50"></span>
                    </td>
                    <th>전표번호</th>
                    <%-- 오늘날짜 순번으로 자동생성 --%>
                    <td><****></td>
                </tr>
                <tr>
                    <th>구분</th>
                    <td>
                        <select id="input_minownGbn" name="MINOWN_GBN"></select>
                    </td>
                    <th>접수자</th>
                    <td>
                        <select id="input_receiptUser" name="RECEIPT_USER">
                            <%-- 직원등록 민원 YES 선택할 수 있게 --%>
                            <option value=""><****></option>
                            <option value="">직접입력</option>
                        </select>
                    </td>
                    <td colspan="2">
                        <input type="text" id="input_receiptUserName">
                    </td>
                </tr>
                <tr>
                    <th>접수내역</th>
                    <td colspan="5" class="min_memo">
                        <textarea id="input_descr" name="DESCR" class="min01020_textarea"><****></textarea>
                    </td>
                </tr>
                <tr>
                    <th>
                        <button id="find_btn01" onclick="" class="find_btn_m">사진찾기</button>
                    </th>
                    <td colspan="5">
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
            <div>
                <i class="icon-mic"></i>사진첨부는 2개까지 가능합니다.
            </div>
            <div class="section_middle_title">
                <span><i class="icon-pause"></i>처&ensp;리</span>
                <span class="section_middle_btn">
                            <button id="find_btn" onclick="" class="find_btn">소모품사용</button>
                            <%-- 설정에서 선택해야 나옴 --%>
                            <button id="find_btn" onclick="" class="find_btn">계량기사용</button>
                            <%-- 설정에서 선택해야 나옴 --%>
                        </span>
            </div>
            <table style="width:720px;">
                <colgroup>
                    <col style="width:12%">
                    <col style="width:24%">
                    <col style="width:12%">
                    <col style="width:20%">
                    <col style="width:12%">
                    <col style="width:20%">
                </colgroup>

                <tbody id="min_tb_02">

                <tr>
                    <th>처리일시</th>
                    <td colspan="3">
                        <span><input type="date" id="input_workDate" name="WORK_DATE" data-format="date"></span>&emsp;&emsp;
                        <span>
                            <input type="checkbox" id="input_workTimeInput" name="TIME_INPUT">
                            <label for="input_workTimeInput">시간선택 :</label>
                        </span>
                        <span>&ensp;<input type="time" id="input_workTimeInputName"></span>
                    </td>
                </tr>
                <tr>
                    <th>상태</th>
                    <td style="width: 100px;">
                        <select id="input_statusCd" name="STATUS_CD">&nbsp;
                            <option value="condition"><****></option>
                        </select>
                    </td>
                    <th>처리자</th>
                    <td>
                        <select id="input_workUser" name="WORK_USER">&nbsp;
                            <option value="condition"><****></option>
                        </select>
                    </td>
                    <td colspan="2"><input type="text" id="input_workUserName"></td>
                </tr>
                <tr>
                    <th>처리내역</th>
                    <td colspan="5" class="min_memo">
                        <textarea id="input_workDesc" name="WORK_DESC" class="min01020_textarea"><****></textarea>
                    </td>
                </tr>
                <tr>
                    <th>
                        <button id="find_btn02" onclick="" class="find_btn_m">사진찾기</button>
                    </th>
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
</div>

<script>
    const popupId = "pop_min_jeon01";
    const pop_btn = document.querySelector("#pop_btn"); //팝업버튼 컴포넌트
    const input_dongName = document.querySelector("#input_dongName");
    const input_ho = document.querySelector("#input_ho");
    const input_dongId = document.querySelector("#input_dongId");
    const input_hoId = document.querySelector("#input_hoId");
    const input_gbn = document.querySelector("#input_gbn");
    const input_slipNo = document.querySelector("#input_slipNo");

    const input_minwonDate = document.querySelector("#input_minwonDate");
    const input_timeInput = document.querySelector("#input_timeInput");
    const input_time = document.querySelector("#input_time");
    const input_minownGbn = document.querySelector("#input_minownGbn");
    const input_receiptUser = document.querySelector("#input_receiptUser");
    const input_receiptUserName = document.querySelector("#input_receiptUserName");
    const input_descr = document.querySelector("#input_descr");

    const input_workDate = document.querySelector("#input_workDate");
    const input_workTimeInput = document.querySelector("#input_workTimeInput");
    const input_workTimeInputName = document.querySelector("#input_workTimeInputName");
    const input_statusCd = document.querySelector("#input_statusCd");
    const input_workUser = document.querySelector("#input_workUser");
    const input_workUserName = document.querySelector("#input_workUserName");
    const input_workDesc = document.querySelector("#input_workDesc");

    async function getSelectOption_input_minownGbn() {
        input_minownGbn.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId: sectionId,
            component: pgId + "_input_minownGbn",
            param: param,
        }

        let list  = await we_getSelectOption(data);

        if (list) {
            list.forEach(row => {
                input_minownGbn.insertAdjacentHTML("beforeend",
                    "<option value='" + row.SUPPLIER_CD + "'>" + row.SUPPLIER_NAME + "</option>");
            })
        }
    }


    async function getSelectOption_input_statusCd() {
        input_statusCd.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId: sectionId,
            component: pgId + "_input_statusCd",
            param: param,
        }

        let list  = await we_getSelectOption(data);

        if (list) {
            list.forEach(row => {
                input_statusCd.insertAdjacentHTML("beforeend",
                    "<option value='" + row.SUPPLIER_CD + "'>" + row.SUPPLIER_NAME + "</option>");
            })
        }
    }

    async function getSelectOption_input_user() {
        input_receiptUser.innerHTML = "";
        input_workUser.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId: sectionId,
            component: pgId + "_input_user",
            param: param,
        }

        let list  = await we_getSelectOption(data);

        if (list) {
            input_receiptUser.insertAdjacentHTML("beforeend", "<option value='write' selected>직접입력</option>");  //필요시
            input_workUser.insertAdjacentHTML("beforeend", "<option value='write' selected>직접입력</option>");  //필요시
            list.forEach(row => {
                input_receiptUser.insertAdjacentHTML("beforeend",
                    "<option value='" + row.SUPPLIER_CD + "'>" + row.SUPPLIER_NAME + "</option>");
                input_workUser.insertAdjacentHTML("beforeend",
                    "<option value='" + row.SUPPLIER_CD + "'>" + row.SUPPLIER_NAME + "</option>");
            })

        }
    }


    function pop_onload(pop_item){
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({tag: "#pop_btn", grid: "grid1", save: true, del: true, print: true});
        pop_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");

        if(!isNull(pop_item.btnHidden)){
            btnHidden(pop_item.btnHidden, pop_item.popupId);
        }

        if(!isNull(pop_item.disabled)){
            disableInput(pop_item.popupId);
        }

        input_minwonDate.value = getToday("yyyy-MM-dd")
        getSelectOption_input_minownGbn();
        getSelectOption_input_statusCd();
        getSelectOption_input_user();
    }


</script>



