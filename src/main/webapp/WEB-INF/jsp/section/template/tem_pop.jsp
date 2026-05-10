<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div class="layer_bg" id="pop_contract" onchange="inputToGrid(grid1, popupId)">
        <div class="popup" style="width:840px;">
            <div class="pop_title" style="border:none" >&#10004; &nbsp;계약등록</div>
            <div class="section1_btn" id="pop_btn"></div>
            <table style="width:820px;">
                <tbody >
                    <colgroup>
                        <col style ="width:10%">
                        <col style ="width:23%">
                        <col style ="width:10%">
                        <col style ="width:23%">
                        <col style ="width:11%">
                        <col style ="width:23%">
                    <colgroup>
                    <tr>
                        <th>No.</th>
                        <td><input type="text" id="" name="CONTRACT_NO" disabled></td>
                        <th>계약구분</th>
                        <td>
                            <select id="input_contractdiv" name="CONTRACT_DIV"></select>
                        </td>
                        <th>*계약업체</th>
                        <td><select id="input_supplier" name="SUPPLIER_CD"></select></td>
                    </tr>
                    <tr>
                        <th>계약명</th>
                        <td colspan="3"><input type="text" name="CONTRACT_NAME" ></td>
                        <th>전화번호</th>
                        <td><input type="text" id="input_compPhonNo" name="COMP_PHON_NO" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                    </tr>
                    <tr>
                        <th>계약일</th>
                        <td><input type="date" id="" name="CONTRACT_DATE" data-format="date"></td>
                        <th>계약시작일</th>
                        <td><input type="date" id="" name="STRAT_DATE" data-format="date"></td>
                        <th>계약만기일</th>
                        <td><input type="date" id="input_endDate" name="END_DATE" data-format="date"></td>
                    </tr>
                    <tr>
                        <th>계약금액</th>
                        <td><input type="text" name="CONTRACT_AMOUNT" oninput="inputMoneyFormat(this)" ></td>
                        <th>지불방법</th>
                        <td colspan="3"><input type="text" name="PAY_TYPE" ></td>
                    </tr>
                    <tr>
                        <th>해지일</th>
                        <td><input type="date" id="input_cancelDate" name="CANCEL_DATE" data-format="date"></td>
                        <th>해지사유</th>
                        <td colspan='3'><input type="text" name="CANCEL_REASON" ></td>
                    </tr>
                    <tr>
                        <th rowspan="2">
                            보증<br><input type="checkbox" id="" name="GUARANTEE_YN" value="1">
                        </th>
                        <td><input type="text" id="" name="GUARANTEE_NAME" placeholder="보증명"></td>
                        <th>보증금액</th>
                        <td><input type="text" id="" name="GUARANTEE_AMOUNT" oninput="inputMoneyFormat(this)"></td>
                        <th>보증기간</th>
                        <td><input type="text" id="" name="GUARANTEE_TERM"></td>
                    </tr>
                    <tr>
                        <td colspan="5"><input type="text" id="" name="GUARANTEE_REMARKS" placeholder="보증내용"></td>
                    </tr>
                    <tr>
                        <th>비고</th>
                        <td colspan="5"><input type="text" id="REMARKS"></td>
                        <input type="text" name="SUPPLIER_NAME" id="input_supplierName" hidden="hidden">
                        <input type="text" name="LICENSE_NO" id="input_licenseNo" hidden="hidden">
                        <input type="text" name="OWNER" id="input_owner" hidden="hidden">
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

<script>
    const popupId = "pop_contract";
    const pop_btn = document.querySelector("#pop_btn"); //팝업버튼 컴포넌트
    const input_contractdiv = document.querySelector("#input_contractdiv"); //input 컴포넌트
    const input_supplier = document.querySelector("#input_supplier"); //input 컴포넌트
    const input_compPhonNo = document.querySelector("#input_compPhonNo"); //input 컴포넌트
    const input_supplierName = document.querySelector("#input_supplierName"); //input 컴포넌트
    const input_licenseNo = document.querySelector("#input_licenseNo"); //input 컴포넌트
    const input_owner = document.querySelector("#input_owner"); //input 컴포넌트
    const input_endDate = document.querySelector("#input_endDate"); //input 컴포넌트
    const input_cancelDate = document.querySelector("#input_cancelDate"); //input 컴포넌트

    let DS_SUPPLIER = [];

    async function getSelect_input_supplier(){
        input_supplier.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId : sectionId,
            component : "pop_contract_input_supplier",
            param: param,
        }

        DS_SUPPLIER = await we_getSelect(data);

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
        btnMaker({ tag: "#pop_btn", grid: "grid1", save : true});
        pop_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");

        if(!isNull(pop_item.btnHidden)){
            btnHidden(pop_item.btnHidden, pop_item.popupId);
        }

        if(!isNull(pop_item.disabled)){
            disableInput(pop_item.popupId);
        }

        //공통코드 가져오기
        selectOptionMaker("134", input_contractdiv, "", false);
        getSelect_input_supplier();

    }



</script>

