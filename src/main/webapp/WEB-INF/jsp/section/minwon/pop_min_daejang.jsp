<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    #info_table td, #cnt_table td {
        text-align: center;
    }

</style>

<div class="layer_bg" id="pop_min_daejang">
    <div class="popup" style="width:910px;">
        <div id="pop_title" class="pop_title">&#10004;&nbsp;세대민원대장</div>
        <div class="section1_btn" id="pop_btn"></div>
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
            <table id="cnt_table">
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
            <div class="section1_btn" id="pop_btn1"></div>
        </div>
        <div id="popGrid1"></div>
    </div>
    <jsp:include page="/WEB-INF/jsp/section/minwon/pop_min_jeon01.jsp"/>
</div>



<script>
    const popupId = "pop_min_daejang";
    let querySet;

    let popGrid1;	// 그리드 컴포넌트
    let focus1 = 0;	//그리드 컴포넌트 포커스

    //팝업 컴포넌트
    const pop_btn = document.querySelector("#pop_btn");
    const pop_title = document.querySelector("#pop_title");
    const info_table = document.querySelector("#info_table");
    const cnt_table = document.querySelector("#cnt_table");
    const input_totalCnt = document.querySelector("#input_totalCnt"); //input 컴포넌트
    const input_procCnt = document.querySelector("#input_procCnt"); //input 컴포넌트
    const input_holdCnt = document.querySelector("#input_holdCnt"); //input 컴포넌트
    const input_rejectCnt = document.querySelector("#input_rejectCnt"); //input 컴포넌트
    const input_pendingCnt = document.querySelector("#input_pendingCnt"); //input 컴포넌트

    let pop_data;

    //그리드 설정
    const popGrid1ColumnLayout = [
        { dataField: "SLIP_NO",
            visible : false
        },
        { dataField: "MINWON_DATE",
            headerText: "접수일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%"
        },
        { dataField: "DESCR",
            headerText: "접수 내역",
            dataType: "text",
            width : "*%",
            style: "line-break-column",
        },
        { dataField: "STATUS_NAME",
            headerText: "처리상태",
            dataType: "text",
            width : "10%",
        },
        { dataField: "WORK_USER",
            headerText: "처리자",
            dataType: "text",
            width : "10%",
        },
    ];

    //그리드 생성
    popGrid1 = AUIGrid.create("#popGrid1", popGrid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
                showRowCheckColumn : false,
                height : 400,
                width : 890,
                rowHeight : 60,
                wordWrap: true,

            })
    );

    //셀 선택 변경 이벤트 바인딩
    AUIGrid.bind(popGrid1, "cellDoubleClick", function(event) {
        open_popup1_onclick();
    });

    //팝업 닫기 이벤트
    function open_popup1_onclick(){
        let slipNo = AUIGrid.getSelectedRows(popGrid1)[0].SLIP_NO
        let minwonDate = AUIGrid.getSelectedRows(popGrid1)[0].MINWON_DATE
        pop_data.slipNo = slipNo;
        pop_data.minwonDate = minwonDate;
        pop_data.saveKey = "U"
        let pop_item = {
            pgId: pgId,
            menuId: menuId,
            querySet: "min011",
            pop_data: pop_data
        }
        pop_onload1(pop_item);
        popupOpen(popupId1);
    }

    function close_popup1_onclick(){
        popupClose(popupId1);
        clearInput(popupId1);
    }

    function add_popGrid1_onclick(){
        pop_data.slipNo = null;
        pop_data.saveKey = "I"
        let pop_item = {
            pgId: pgId,
            menuId: menuId,
            querySet: "min011",
            pop_data: pop_data
        }
        pop_onload1(pop_item);
        popupOpen(popupId1);
    }

    //그리드 조회 함수
    async function search_popGrid1_onclick(){

        let selectParam = {
            GBN : pop_data.gbn,
            LINE_GBN : (pop_data.gbn == "0" || pop_data.gbn == "1" ) ? pop_data.lineGbn : "",
            DONG_ID : pop_data.dongId,
            HO_ID : pop_data.hoId,
            MINWON_AREAR_SEQ : (pop_data.gbn == "0" || pop_data.gbn == "1" ) ? "" : pop_data.minwonArearSeq
        }
        if(pop_data.gbn == "1" && pop_data.lineGbn != "109999"){
            selectParam.LINE_NO = pop_data.hoNo
        }else{
            selectParam.LINE_NO = ""
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : querySet + "_popGrid1",
            param: selectParam,
        }

        return we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                //그리드 데이터 세팅
                AUIGrid.setGridData(popGrid1, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(popGrid1, focus1, 0);
                focus1 = 0;
            }
        });
    }


    function search_infoTable() {
        let selectParam = {
            DONG_ID : pop_data.dongId,
            HO_ID : pop_data.hoId,
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
            info_table.innerHTML = ""
            let inner = `
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
            `
            info_table.innerHTML = inner;
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
                                <th colspan="2">구분</th>
                            </tr>
                            <tr>
                                <td><input type="text" id="td_dongName" name="DONG_NAME"></td>
                                <td><input type="text" id="td_lineNo" name="LINE_NO"></td>
                                <td><input type="text" id="td_floor" name="FLOOR"></td>
                                <td colspan="2"><input type="text" id="td_lineGbnNm" name="LINE_GBN_NM"></td>
                            </tr>
                        </tbody>
                    `
            info_table.innerHTML = inner;

            document.querySelector("#td_dongName").value = isNull(pop_data.dongName) ? "" : pop_data.dongName;
            document.querySelector("#td_lineNo").value = isNull(pop_data.lineNo) ? "" : pop_data.hoNo;
            document.querySelector("#td_lineGbnNm").value = pop_data.lineGbnNm;
            if(pop_data.lineNo == "109002"){
                document.querySelector("#td_floor").value = isNull(pop_data.floor) ? "" : pop_data.floor
            }else if(pop_data.lineNo == "109999"){
                document.querySelector("#td_floor").value =  isNull(pop_data.floor) ? "" : "지하 " + pop_data.floor
            }else{
                document.querySelector("#td_floor").value = ""
            }
        }
        else if(pop_data.gbn == "2"){
            pop_title.innerHTML = "&#10004;&nbsp;[동외]동용민원대장"
            info_table.innerHTML = ""
            let inner = `
                        <tbody>
                            <tr>
                                <th colspan="7">구분</th>
                            </tr>
                            <tr>
                                <td colspan="7"><input type="text" id="td_arearName" name="AREAR_NAME"></td>
                            </tr>
                        </tbody>
                    `
            info_table.innerHTML = inner;

            document.querySelector("#td_arearName").value = pop_data.arearName;
        }
    }

    function search_cntTable() {

        let selectParam = {
            GBN : pop_data.gbn,
            LINE_GBN : (pop_data.gbn == "0" || pop_data.gbn == "1" ) ? pop_data.lineGbn : "",
            DONG_ID : pop_data.dongId,
            HO_ID : pop_data.hoId,
            MINWON_AREAR_SEQ : (pop_data.gbn == "0" || pop_data.gbn == "1" ) ? "" : pop_data.minwonArearSeq
        }
        if(pop_data.gbn == "1" && pop_data.lineGbn != "109999"){
            selectParam.LINE_NO = pop_data.hoNo
        }else{
            selectParam.LINE_NO = ""
        }

        //파라미터
        let selectData = {
            sectionId: sectionId,
            component: querySet + "_cntTable",
            param: selectParam,
        }

        we_select(selectData, {
            successSelect: (json) => {
                let data = json.DATA;
                dataToInput(data[0], "cnt_table");
            }
        });
    }


    function pop_onload(pop_item){

        querySet = isNull(pop_item.querySet) ? pop_item.pgId : pop_item.querySet;
        pop_data =  pop_item.pop_data

        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#pop_btn", grid: "popGrid1", search: true, print : true});
        pop_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");
        btnMaker({ tag: "#pop_btn1", grid: "popGrid1", add: true});
        if(!isNull(pop_item.btnHidden)){
            btnHidden(pop_item.btnHidden, pop_item.popupId);
        }

        if(!isNull(pop_item.disabled)){
            disableInput(pop_item.popupId);
        }

        if(!isNull(pop_data)){
            info_table_make();
            search_cntTable();
            search_popGrid1_onclick();
        }

    }
   

</script>
