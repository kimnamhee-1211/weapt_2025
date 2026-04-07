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
                    <td><input type="text" id="td_hoNo" name="HP_NO"></td>
                    <td><input type="text" id="td_liveTypeName" name="LIVE_TYPE_NAME"></td>
                </tr>
                </tbody>
            </table>
        </div>
        <div style="height:40px; line-height:40px;">&#9726&nbsp;민원통계</div>
        <div class="">
            <table>
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
    const pop1_btn = document.querySelector("#pop1_btn");
    const pop_title = document.querySelector("#pop_title");

    //팝업 컴포넌트
    let info_table = document.querySelector("#info_table");
    const input_totalCnt = document.querySelector("#input_totalCnt"); //input 컴포넌트
    const input_procCnt = document.querySelector("#input_procCnt"); //input 컴포넌트
    const input_holdCnt = document.querySelector("#input_holdCnt"); //input 컴포넌트
    const input_rejectCnt = document.querySelector("#input_rejectCnt"); //input 컴포넌트
    const input_pendingCnt = document.querySelector("#input_pendingCnt"); //input 컴포넌트

    let pop_data = {}
    let info = {}

    function search_infoTable_onclick() {
        info_table_make()
        let selectParam = {
            DONG_ID : pop_data.DONG_ID,
            HO_ID : pop_data.HO_ID,
            GBN : pop_data.GBN,
            LINE_GBN : pop_data.LINE_GBN,
            MINWON_AREAR_SEQ : pop_data.MINWON_AREAR_SEQ
        }

        //파라미터
        let selectData = {
            sectionId: sectionId,
            component: "pop_contract_info_table",
            param: selectParam,
        }

        we_select(selectData, {
            successSelect: (json) => {
                let data = json.DATA;
                //세대
                if(pop_data.GBN == "0") {
                }
                //동내공용
                else if(pop_data.GBN == "1"){
                    if( pop_data.LINE_GBN = "109002"){
                    }else{
                    }
                }
                //동외공용
                else if(pop_data.GBN  == "2") {
                }
            }
        });

    }


    function info_table_make(popNum) {
        if(pop_data.GBN == "0") {
            pop_title.innerHTML = "&#10004;&nbsp;세대민원대장"
        }
        else if(pop_data.GBN == "1"){
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
                                <td><input type="text" id="td_hoName" name="HO_NAME"></td>
                                <td><input type="text" id="td_floor" name="FLOOR"></td>
                                <td><input type="text" id="td_lineGbnNm" name="LINE_GBN_NM"></td>
                                <td><input type="text" name=""></td>
                            </tr>
                        </tbody>
                    `
            info_table.innerHTML = inner;
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
        }
    }






    function pop_onload(pop_item){
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#pop1_btn", grid: "pop_grid1", search: true, save : true, print : true});
        pop1_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");

        pop_data =  pop_item.pop_data
        if(!isNull(pop_data)){
            search_infoTable_onclick()
        }

    }
   

</script>
