<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="layer_bg" id="pop_min_daejang">
    <div id="popup" style="width:910px;">
        <div id="pop_title" class="pop_title">&#10004;&nbsp;세대민원대장</div>
        <div class="section1_btn" id="pop1_btn">
            <button id="search_btn" onclick="">검색</button>
            <button id="print_btn" onclick="" class="print_btn">인쇄</button>
        </div>
        <div id="info_title" style="height:40px; line-height:40px;">&#9726&nbsp;동호정보</div>
        <div class="">
            <table id="info_table">
                <tbody>
                <tr>
                    <th>동</th>
                    <th>호</th>
                    <th>면적</th>
                    <th>세대주</th>
                    <th>집전화</th>
                    <th>핸드폰</th>
                    <th>거주형태</th>
                </tr>
                <tr>
                    <td><input type="text" id="td_dongName" name="DONG_NAME"></td>
                    <td><input type="text" id="td_hoName" name="HO_NAME"></td>
                    <td><input type="text" id="td_houseSize" name="HOUSE_SIZE"></td>
                    <td><input type="text" id="td_householder" name="HOUSEHOLDER"></td>
                    <td><input type="text" id="td_housePhonNo" name="HOUSE_PHON_NO"></td>
                    <td><input type="text" id="td_hpNo" name="HP_NO"></td>
                    <td><input type="text" id="td_liveType" name="LIVE_TYPE"></td>
                </tr>
                </tbody>
            </table>
        </div>
        <div style="height:40px; line-height:40px;">&#9726&nbsp;민원통계</div>
        <div class="">
            <table id="_table">
                <tbody>
                <tr>
                    <th>민원건수</th>
                    <th>처리건수</th>
                    <th>보류건수</th>
                    <th>반려건수</th>
                    <th>미처리건수</th>
                </tr>
                <tr>
                    <td><input type="text" id="input_totalCnt" name="TOTAL_CNT"></td>
                    <td><input type="text" id="input_procCnt" name="PROC_CNT"></td>
                    <td><input type="text" id="input_holdCnt" name="HOLD_CNT"></td>
                    <td><input type="text" id="input_rejectCnt" name="REJECT_CNT"></td>
                    <td><input type="text" id="input_pendingCnt" name="PENDING_CNT"></td>
                </tr>
                </tbody>
            </table>
        </div>
        <div style="height:40px; line-height:40px;">
            &#9726&nbsp;민원접수 및 처리내역
            <div class="section1_btn">
                <button id="add_btn" onclick="">추가</button>
            </div>
        </div>
        <div id="pop_grid1" style="height: 400px; border: 1px solid #bcbcbc;"></div>
    </div>
</div>


<script>
    const popupId = "pop_min_daejang";
    let querySet;
    let pop_data;
    let pop_grid1;	// 그리드 컴포넌트
    let focus1 = 0;	//그리드 컴포넌트 포커스

    const pop1_btn = document.querySelector("#pop1_btn");
    const pop_title = document.querySelector("#pop_title");

    //팝업 컴포넌트
    const info_table = document.querySelector("#info_table");
    const input_totalCnt = document.querySelector("#input_totalCnt"); //input 컴포넌트
    const input_procCnt = document.querySelector("#input_procCnt"); //input 컴포넌트
    const input_holdCnt = document.querySelector("#input_holdCnt"); //input 컴포넌트
    const input_rejectCnt = document.querySelector("#input_rejectCnt"); //input 컴포넌트
    const input_pendingCnt = document.querySelector("#input_pendingCnt"); //input 컴포넌트



    function search_infoTable() {
        let selectParam = {
            DONG_ID : pop_data.dongId,
            HO_ID : pop_data.id,
        }
        //파라미터
        let selectData = {
            sectionId: sectionId,
            component: querySet + "_infoTable",
            param: selectParam,
        }

        we_select(selectData, {
            successSelect: (json) => {
                let data = json.DATA;
                document.querySelector("#td_houseSize").value = data[0].HOUSE_SIZE;
                document.querySelector("#td_householder").value = data[0].HOUSEHOLDER;
                document.querySelector("#td_housePhonNo").value = data[0].HOUSE_PHON_NO;
                document.querySelector("#td_hpNo").value = data[0].HP_NO;
                document.querySelector("#td_liveType").value = data[0].LIVE_TYPE;
            }
        });
    }

    function info_table_make() {
        if(pop_data.gbn == "0") {
            pop_title.innerHTML = "&#10004;&nbsp;세대민원대장"
            document.querySelector("#td_dongName").value = pop_data.dongName;
            document.querySelector("#td_hoName").value =  pop_data.hoName;
            search_infoTable();
        }
        else if(pop_data.gbn == "1"){
            pop_title.innerHTML = "&#10004;&nbsp;[동별]공용민원대장"
            let inner = `
                        <tbody>
                            <tr>
                                <th>동</th>
                                <th>열</th>
                                <th>층</th>
                                <th>구분</th>
                                <th>비고</th>
                            </tr>
                            <tr>
                                <td><input type="text" id="td_dongName" name="DONG_NAME"></td>
                                <td><input type="text" id="td_lineNo" name="LINE_NO"></td>
                                <td><input type="text" id="td_floor" name="FLOOR"></td>
                                <td><input type="text" id="td_lineGbnNm" name="LINE_GBN_NM"></td>
                                <td><input type="text" name=""></td>
                            </tr>
                        </tbody>
                    `
            info_table.innerHTML = inner;

            document.querySelector("#td_dongName").value = isNull(pop_data.dongName) ? "" : pop_data.dongName;
            document.querySelector("#td_lineNo").value = isNull(pop_data.lineNo) ? "" : pop_data.lineNo;
            document.querySelector("#td_floor").value = (pop_data.lineNo == "109002") ? (isNull(pop_data.floor) ? "" : pop_data.floor) : "";
            document.querySelector("#td_lineGbnNm").value = pop_data.lineGbnNm;
        }
        else if(pop_data.GBN == "2"){
            pop_title.innerHTML = "&#10004;&nbsp;[동외]동용민원대장"
            info_table.innerHTML = ""
            let inner = `
                        <tbody>
                            <tr>
                                <th>구분</th>
                                <th>비고</th>
                            </tr>
                            <tr>
                                <td><input type="text" id="td_arearName" name="AREAR_NAME"></td>
                                <td><input type="text" name=""></td>
                            </tr>
                        </tbody>
                    `
            info_table.innerHTML = inner;

            document.querySelector("#td_arearName").value = pop_data.AREAR_NAME;
        }
    }

    function search_aptBlock_onclick() {

        //검색데이터
        let selectParam = {
            DONG_ID: AUIGrid.getSelectedRows(grid1)[0].DONG_ID
        }

        //파라미터
        let selectData = {
            sectionId: sectionId,
            component: pgId + component,
            param: selectParam,
        }

        we_select(selectData, {
            successSelect: (json) => {
                let data = json.DATA;

                if (viewGbn = "108001") {
                    apt_block_make(data);
                } else if (viewGbn = "108002") {
                    etc_block_make(data);
                } else {
                    cb_block_make(data);
                }
            }
        });
    }



    function pop_onload(pop_item){
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#pop1_btn", grid: "pop_grid1", search: true, save : true, print : true});
        pop1_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");
        if(pop_item){
            querySet = isNull(pop_item.querySet) ? pop_item.pgId : pop_item.querySet;
            pop_data =  pop_item.pop_data
        }
        if(!isNull(pop_data)){
            info_table_make();

        }


    }
   

</script>
