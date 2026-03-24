<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div id="layer_bg" id="pop_min_daejang">
    <div id="popup" style="width:910px;">
        <div id="pop_title" class="pop_title">&#10004;&nbsp;세대민원대장</div>
        <div class="section1_btn" id="pop1_btn">
            <button id="search_btn" onclick="">검색</button>
            <button id="print_btn" onclick="" class="print_btn">인쇄</button>
        </div>
        <div id="info_title" style="height:40px; line-height:40px;">&#9726&nbsp;동호정보</div>
        <div class="">
            <table id="">
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
                    <td><input type="text" name=""></td>
                    <td><input type="text" name=""></td>
                    <td><input type="text" name=""></td>
                    <td><input type="text" name=""></td>
                    <td><input type="text" name=""></td>
                    <td><input type="text" name=""></td>
                    <td><input type="text" name=""></td>
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
                    <td><input type="text" id="input_totalCnt" name="TOTAL_CNT "></td>
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
    const popupId = "pop_contract";
    const pop1_btn = document.querySelector("#pop1_btn"); //팝업버튼 컴포넌트
    const input_contractdiv = document.querySelector("#input_contractdiv"); //select 컴포넌트
    const input_supplier = document.querySelector("#input_supplier"); //select 컴포넌트
    const input_compPhonNo = document.querySelector("#input_compPhonNo"); //select 컴포넌트
    const input_supplierName = document.querySelector("#input_supplierName"); //select 컴포넌트
    const input_licenseNo = document.querySelector("#input_licenseNo"); //select 컴포넌트
    const input_owner = document.querySelector("#input_owner"); //select 컴포넌트
    const input_endDate = document.querySelector("#input_endDate"); //select 컴포넌트
    const input_cancelDate = document.querySelector("#input_cancelDate"); //select 컴포넌트

    let DS_SUPPLIER = [];

    async function getSelectOption_input_supplier(){
        input_supplier.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId : sectionId,
            component : "pop_contract_input_supplier",
            param: param,
        }

        DS_SUPPLIER = await we_getSelectOption(data);

        if(DS_SUPPLIER) {
            DS_SUPPLIER.forEach(row => {
                input_supplier.insertAdjacentHTML("beforeend",
                    "<option value='" + row.SUPPLIER_CD + "'>" + row.SUPPLIER_NAME + "</option>");
            })
        }
    }
    input_supplier.addEventListener("change", async () => {
        if(!isNull(DS_SUPPLIER)){
            DS_SUPPLIER.forEach(row=>{
                if(row.SUPPLIER_CD == input_supplier.value){
                    input_compPhonNo.value = row.COMP_PHON_NO;
                    input_supplierName.value = row.SUPPLIER_NAME;
                    input_licenseNo.value = row.LICENSE_NO;
                    input_owner.value = row.OWNER;

                }
            });
        }
    });

    input_endDate.addEventListener("change", async () => {
        if(!isNull(input_endDate.value) && isNull(input_cancelDate.value)){
            input_cancelDate.value = input_endDate.value;
        }
    });

    function pop_onload(pop_item){
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#pop1_btn", grid: "pop_grid1", search: true, save : true, print : true});
        pop1_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");

        if(!isNull(pop_item.btnHidden)){
            btnHidden(pop_item.btnHidden, pop_item.popupId);
        }

        if(!isNull(pop_item.disabled)){
            disableInput(pop_item.popupId);
        }

        //공통코드 가져오기
        selectOptionMaker("134", input_contractdiv, "", false);
        getSelectOption_input_supplier();

    }
   

</script>
