<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <div class="layer_bg" id="pop_supplier" onchange="inputToGrid(grid1, popupId)">
        <div class="popup" style="width:540px;">
            <div class="pop_title" style="border:none" >&#10004; &nbsp;계약업체등록</div>
            <form action="" method="post">
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
                            <td ><input type="text" id="" name="SUPPLIER_CD" disabled></td>
                            <th>등록일</th>
                            <td><input type="date" id="" name="REG_DATE" data-format="date"></td>
                        </tr>
                        <tr>
                            <th>상호</th>
                            <td colspan="3"><input type="text" id="" name="SUPPLIER_NAME"></td>
                        </tr>
                        <tr>
                            <th>사업자번호</th>
                            <td><input type="text" id="" name="LICENSE_NO" data-format="licenseNo" oninput="inputBRNFormat(this)" placeholder="숫자만 입력해주세요" maxlength="12"></td>
                            <th>사용여부</th>
                            <td>
                                <select id="" name="USE_YN">
                                    <option value="1">사용</option>
                                    <option value="0">미사용</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>대표명</th>
                            <td><input type="text" id="" name="OWNER"></td>
                            <th>대표전화번호</th>
                            <td><input type="text" id="" name="OWNER_PHON_NO" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td><input type="text" name="COMP_PHON_NO" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                            <th>팩스번호</th>
                            <td><input type="text" id="" name="FAX_NO" oninput="inputTelFormat(this)" placeholder="숫자만 입력해주세요" maxlength="13"></td>
                        </tr>
                        <tr>
                            <th>업태</th>
                            <td><input type="text" id="" name="TYPE" ></td>
                            <th>종목</th>
                            <td><input type="text" id="" name="ITEMS"></td>
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
                            <td colspan='3'><input type="text" id="" name="ADDR2" ></td>
                        </tr>
                        <tr>
                            <th>비고</th>
                            <td colspan='3'><input type="text" id="" name="REMARKS">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>

            <div class="pop_btn">
                <button id="save_btn1" onclick="save_grid1_onclick()">저장</button>
                <button id="close_btn1" onclick="close_popup_onclick()">닫기</button>
            </div>
        </div>
    </div>

<script>







</script>
                        
   

 
