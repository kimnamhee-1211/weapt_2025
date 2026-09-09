<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/popup/pop_addr.jsp"/>
    <div class="layer_bg" id="pop_supplier" onchange="inputToGrid(grid1, popup)">
        <div class="popup" style="width:540px;">
            <div class="pop_title" style="border:none" >&#10004; &nbsp;계약업체등록</div>
            <div class="pop_btn" id="pop_btn"></div>
            <table style="width:520px;">
                <tbody>
                    <colgroup>
                        <col style ="width:20%">
                        <col style ="width:30%">
                        <col style ="width:20%">
                        <col style ="width:30%">
                    <colgroup>
                    <tr>
                        <th>No.</th>
                        <td ><input type="text" id="input_supplierCd" name="SUPPLIER_CD" disabled></td>
                        <th>등록일</th>
                        <td><input type="date" id="input_regDate" name="REG_DATE" data-format="date"></td>
                    </tr>
                    <tr>
                        <th>상호</th>
                        <td colspan="3"><input type="text" id="input_supplierName" name="SUPPLIER_NAME"></td>
                    </tr>
                    <tr>
                        <th>사업자번호</th>
                        <td><input type="text" id="input_licenseNo" name="LICENSE_NO" data-format="licenseNo" oninput="inputBRNFormat(this)" placeholder="숫자만 입력해주세요" maxlength="12"></td>
                        <th>사용여부</th>
                        <td>
                            <select id="input_useYn" name="USE_YN">
                                <option value="1">사용</option>
                                <option value="0">미사용</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>대표명</th>
                        <td><input type="text" id="input_owner" name="OWNER"></td>
                        <th>대표전화번호</th>
                        <td><input type="text" id="input_ownerPhonNo" name="OWNER_PHON_NO" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td><input type="text" id="input_compPhonNo" name="COMP_PHON_NO" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                        <th>팩스번호</th>
                        <td><input type="text" id="input_faxNo" name="FAX_NO" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                    </tr>
                    <tr>
                        <th>업태</th>
                        <td><input type="text" id="input_type" name="TYPE" ></td>
                        <th>종목</th>
                        <td><input type="text" id="input_items" name="ITEMS"></td>
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
                        <td colspan='3'><input type="text" id="input_addr2" name="ADDR2" ></td>
                    </tr>
                    <tr>
                        <th>비고</th>
                        <td colspan='3'><input type="text" id="input_remarks" name="REMARKS">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

<script>
    const popupId = "pop_supplier";
    const popup = document.querySelector("#pop_supplier");
    const pop_btn = document.querySelector("#pop_btn");

    function close_popup_onclick(){
        popupClose(popup);
        clearInput(popup);
    }

    function pop_onload(pop_item){
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#pop_btn", grid: "grid1", save: true});
        pop_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");
    }

</script>
                        
   

 
