<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/popup/pop_addr.jsp"/>

    <div id="section">
        <div class="section1">
            <div class="section1_nav">
                <i class="icon-recycle"></i>단지개요
            </div>
            <div class="section1_btn" id="section1_btn"> </div>
        </div>
        <div class="section2">
            <div class="section2_line0"></div>
        </div>
        <div id="house_table" class="soo01010_tb">
            <div>
                <i class="icon-th-large"></i>단지개요
            </div>
            <table class="input_table">
                <tbody>
                    <input type="text" id="input_officeCode" name="OFFICE_CODE" hidden="hidden">
                    <tr>
                        <th style="width: 150px;">명칭</th>
                        <td style="width: 387px;" colspan="2"><input type="text" id="input_houseName" name="HOUSE_NAME" maxlength="50"></td>
                        <th style="width: 150px;">사용승인일</th>
                        <td style="width: 387px;" colspan="2"><input type="date" id="input_useTestDate" name="USE_TEST_DATE" data-format="date"></td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td colspan="4"><input type="text" id="input_addr1" name="ADDR1"></td>
                        <td style="border-left: none">
                            <button id="addr_popup_btn1" class="addr_popup_btn" type="button" onclick="search_addr_onclick()">주소찾기</button>
                        </td>
                    </tr>
                    <tr>
                        <th>시공사/시행사</th>
                        <td colspan="2"><input type="text" id="input_buildComp" name="BUILD_COMP"></td>
                        <th>분양형태</th>
                        <td colspan="2"><input type="text" id="input_houseType" name="HOUSE_TYPE"></td>
                    </tr>
                    <tr>
                        <th>대지면적</th>
                        <td colspan="2"><input type="text" id="input_lotArea" name="LOT_AREA"></td>
                        <th>동수/세대수</th>
                        <td>
                            <input type="text" id="input_dongNum" name="DONG_NUM">
                        </td>
                        <td>
                            <input type="text" id="input_houseNum" name="HOUSE_NUM">
                        </td>
                    </tr>
                    <tr>
                        <th>연면적/용적율</th>
                        <td>
                            <input type="text" id="input_totGroundArea" name="TOT_GROUND_AREA">
                        </td>
                        <td>
                            <input type="text" id="input_floorAreaRatio" name="FLOOR_AREA_RATIO">
                        </td>
                        <th>건축면적/건폐율</th>
                        <td>
                            <input type="text" id="input_buildArea" name="BUILD_AREA">
                        </td>
                        <td>
                            <input type="text" id="input_buildLandRatio" name="BUILD_LAND_RATIO">
                        </td>
                    </tr>
                    <tr>
                        <th>건물구조</th>
                        <td colspan="2"><input type="text" id="input_buildStructure" name="BUILD_STRUCTURE"></td>
                        <th>복도유형</th>
                        <td colspan="2"><input type="text" id="" name=""></td>
                    </tr>
                    <tr>
                        <th>급수방식</th>
                        <td colspan="2"><input type="text" id="input_waterType" name="WATER_TYPE"></td>
                        <th>난방방식</th>
                        <td colspan="2"><input type="text" id="input_heatType" name="HEAT_TYPE"></td>
                    </tr>
                </tbody>
            </table>
            <div>
                <i class="icon-th-large"></i>부대시설 및 설비
            </div>
            <table class="input_table">
                <tbody>
                    <tr>
                        <th style="width: 150px;">관리사무소면적</th>
                        <td style="width: 387px;" colspan="2"><input type="text" id="input_officeGroundArea" name="OFFICE_GROUND_AREA"></td>
                        <th style="width: 150px;">경로당면적</th>
                        <td style="width: 387px;" colspan="2"><input type="text" id="input_silverGroundArea" name="SILVER_GROUND_AREA"></td>
                    </tr>
                    <tr>
                        <th>어린이놀이시설</th>
                        <td colspan="2"><input type="text" id="input_playgroundTotArea" name="PLAYGROUND_TOT_AREA"></td>
                        <th>주민운동시설</th>
                        <td colspan="2"><input type="text" id="input_residentWorkout1" name="RESIDENT_WORKOUT_1"></td>
                    </tr>
                    <tr>
                        <th>주차대수(지상/지하)</th>
                        <td>
                            <input type="text" id="input_parkGroundNum" name="PARK_GROUND_NUM">
                        </td>
                        <td>
                            <input type="text" id="input_parkUnderNum" name="PARK_UNDER_NUM">
                        </td>
                        <th>저수조용량</th>
                        <td colspan="2"><input type="text" id="input_storageWaterCapacity" name="STORAGE_WATER_CAPACITY"></td>
                    </tr>
                    <tr>
                        <th>승강기(제조사/대수)</th>
                        <td>
                            <input type="text" id="input_elevatorComp" name="ELEVATOR_COMP">
                        </td>
                        <td>
                            <input type="text" id="input_elevatorNum" name="ELEVATOR_NUM">
                        </td>
                        <th>화재수신반방식</th>
                        <td colspan="2"><input type="text" id="input_dvRound" name=""></td>
                    </tr>
                    <tr>
                        <th>수전용량</th>
                        <td colspan="2"<input type="text" id="input_defensiveCapacity" name="DEFENSIVE_CAPACITY"></td>
                        <th>발전기용량</th>
                        <td colspan="2"><input type="text" id="input_generatorCapacity" name="GENERATOR_CAPACITY"></td>
                    </tr>
                </tbody>
            </table>
            <div>
                <i class="icon-th-large"></i>기타
            </div>
            <div class="custom_textarea">
                <textarea id="input_remarks" name="REMARKS" class="soo01010_textarea"></textarea>
            </div>
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
    const sectionId = "${sectionId}";	//섹션ID
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    const input = document.querySelector("#house_table");
    const input_officeCode = document.querySelector("#input_officeCode");
    const input_houseName = document.querySelector("#input_houseName");
    const input_useTestDate = document.querySelector("#input_useTestDate");
    const input_addr1 = document.querySelector("#input_addr1");
    const input_buildComp = document.querySelector("#input_buildComp");
    const input_lotArea = document.querySelector("#input_lotArea");
    const input_dongNum = document.querySelector("#input_dongNum");
    const input_houseNum = document.querySelector("#input_houseNum");
    const input_totGroundArea = document.querySelector("#input_totGroundArea");
    const input_floorAreaRatio = document.querySelector("#input_floorAreaRatio");
    const input_buildArea = document.querySelector("#input_buildArea");
    const input_buildLandRatio = document.querySelector("#input_buildLandRatio");
    const input_buildStructure = document.querySelector("#input_buildStructure");
    const input_houseType = document.querySelector("#input_houseType");
    const input_waterType = document.querySelector("#input_waterType");
    const input_heatType = document.querySelector("#input_heatType");
    const input_officeGroundArea = document.querySelector("#input_officeGroundArea");
    const input_silverGroundArea = document.querySelector("#input_silverGroundArea");
    const input_playgroundTotArea = document.querySelector("#input_playgroundTotArea");
    const input_residentWorkout1 = document.querySelector("#input_residentWorkout1");
    const input_parkGroundNum = document.querySelector("#input_parkGroundNum");
    const input_parkUnderNum = document.querySelector("#input_parkUnderNum");
    const input_storageWaterCapacity = document.querySelector("#input_storageWaterCapacity");
    const input_elevatorComp = document.querySelector("#input_elevatorComp");
    const input_elevatorNum = document.querySelector("#input_elevatorNum");
    const input_dvRound = document.querySelector("#input_dvRound");
    const input_defensiveCapacity = document.querySelector("#input_defensiveCapacity");
    const input_generatorCapacity = document.querySelector("#input_generatorCapacity");
    const input_remarks = document.querySelector("#input_remarks");
    //그리드 설정

    //그리드 생성

    //그리드 이벤트

    //그리드 조회 함수
    function search_input1_onclick(){
        //검색데이터
        let selectParam = {
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
                dataToInput(data[0], input);
            }
        });
    }

    //그리드 저장 함수
    function save_input1_onclick(){

        // 추가된 행 아이템들(배열)
        let addedRowItems = []
        // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
        let editedRowItems =  []

        let item = inputToData(input)
        item.HOUSE_ADDR = input_addr1.value
        if(isNull(input_officeCode.value)){
            addedRowItems = [{...item}];
        }else{
            editedRowItems =  [{...item}];
        }

        //검증
        if(!confirm( "변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_input1")) return;

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : {},
            before : {}
        };

        //파라미터
        let saveData  = {
            sectionId :  sectionId,
            component : pgId + "_input1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_input1_onclick();
                }else return;
            }
        });
    }

    //컴포넌트 필수항목 입력 체크
    function requireCheck(require){
        let isValid = true;
        switch(require){
            case "SAVE_INPUT1":
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

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"input1", search: true, save: true, print : true});

        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        search_input1_onclick();

    };

</script>





<%@ include file = "../../inc_footer.jsp" %>