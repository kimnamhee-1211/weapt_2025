<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>


    <div id="section">
        <div class="section1">
            <div class="section1_nav"><i class="icon-cog-alt"></i>장비이력카드</div>
            <div class="section1_btn" id="section1_btn"></div>
            <span class="search-box section1_btn">
                <button id="find_btn" class="left_btn" onclick="" >사진찾기</button>
                <button id="list_btn" class="left_btn" onclick="goEquList_onclick()">목록</button>
            </span>
            <span class="search-box section1_btn">
                폐기일 :
                <input type="date" id="input_resignDate" class="box_width100">
                 &nbsp; 폐기사유 :
                <input type="text" id="input_resignReason" class="box_width100">
                <button id="list_btn" class="del_btn" onclick="resign_onclick()">폐기</button>
            </span>
        </div>
        <div class="section2">
            <div class="section2_line1">
                <span class="search-box">장비명선택 :&nbsp;
                    <select id="search_equName" class="select_cont300"></select>
                </span>
            </div>
        </div>
        <div style=height:282px;>
            <div id="sajin" class="gridcont_left_535">
                <div class="jangbi_sajin" style="height: 280px; border: 1px solid #bcbcbc;">
                사진
                </div>
            </div>
            <div id="jangbi_table" class="gridcont_right_535">
                <input type="text" name="EQU_GBN" id="input_equGbn" hidden="hidden">
                <table class="input_table">
                    <tbody>
                        <tr>
                            <th style="width:100px;">관리번호</th>
                            <td style="width:433px;"><input type="text" name="EQU_NO" id="input_equNo" disabled></td>
                        </tr>
                        <tr>
                            <th>장비명</th>
                            <td><input type="text" name="EQU_NAME" id="input_equName"></td>
                        </tr>
                        <tr>
                            <th>규격</th>
                            <td><input type="text" name="SIZE" id="input_size" ></td>
                        </tr>
                        <tr>
                            <th>형식</th>
                            <td><input type="text" name="FORM"  id="input_form"></td>
                        </tr>
                        <tr>
                            <th>제원</th>
                            <td><input type="text" name="DIMENSION" id="input_dimension"></td>
                        </tr>
                        <tr>
                            <th>제조사</th>
                            <td><input type="text" name="MAKE_BY" id="input_makeBy"></td>
                        </tr>
                        <tr>
                            <th>설치일</th>
                            <td><input type="date" name="INSTALL_DATE" id="input_installDate" data-format="date"></td>
                        </tr>
                        <tr>
                            <th style="height:53px;">비고</th>
                            <td> <textarea style="height:53px;" class="jan01015_textarea" name="REMARKS" id="input_remarks"></textarea></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div>
            <div class="section_middle_title">
                <span> <i class="icon-edit"></i>고장발생 및 처리내역</span>
                <span class="section1_nav_mic">&emsp;
                    <i class="icon-mic"></i>처리금액이 발생된 정비내역만 기록합니다.
                </span>
                <span class="section_middle_btn" id="section_middle_btn"></span>
            </div>
            <div id="grid1"></div>
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
    const sectionId = "${sectionId}";	//섹션ID
    const pgId = "${pgId}";//프로그램ID
    //부모(jan01010)에서 받아오는 값
    let menuId = "${menuId}";	//메뉴ID
    let param = "${param}";	//메뉴param
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_equName = document.querySelector("#search_equName");
    const input = document.querySelector("#jangbi_table"); // 입력부 컴포넌트
    const input_equGbn = document.querySelector("#input_equGbn");
    const input_equNo = document.querySelector("#input_equNo");
    const input_equName = document.querySelector("#input_equName");
    const input_size = document.querySelector("#input_size");
    const input_form = document.querySelector("#input_form");
    const input_dimension = document.querySelector("#input_dimension");
    const input_makeBy = document.querySelector("#input_makeBy");
    const input_installDate = document.querySelector("#input_installDate");
    const input_remarks = document.querySelector("#input_remarks");

    const input_resignDate = document.querySelector("#input_resignDate"); //input 컴포넌트
    const input_resignReason = document.querySelector("#input_resignReason"); //input 컴포넌트


    let DS_EQU = [];
    let equGbn = "";
    let equNo = "";
    let returnUrl = "";

    //그리드1 설정
    const grid1ColumnLayout = [
        { dataField: "REPAIR_SEQ",
            headerText: "수선순번",
            dataType: "text",
            width : "8%",
            editable : false
        },
        { dataField: "ST_DATE",
            headerText: "시작일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            editRenderer : we_calendar_Renderer,
            width : "10%",
        },
        { dataField: "END_DATE",
            headerText: "종료일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            editRenderer : we_calendar_Renderer,
            width : "10%",
        },
        { dataField: "TRO_USER",
            headerText: "처리자",
            dataType: "text",
            width : "12%",
        },
        { dataField: "TRO_AMT",
            headerText: "처리금액",
            dataType : "numeric",
            formatString : "#,###",
            width : "15%",
        },
        { dataField: "EQU_USER",
            headerText: "담당자",
            dataType: "text",
            width : "12%",
        },
        { dataField: "EQU_HP",
            headerText: "연락처",
            dataType: "text",
            width : "10%",
        },
        { dataField: "CONTENT",
            headerText: "내역",
            dataType: "text",
            width : "30%",
            style : "text-align-left",

        },
        { dataField: "REMARKS",
            headerText: "비고",
            dataType: "text",
            width : "20%",
            style : "text-align-left",
        },
        { dataField: "REQ_TIME",
            headerText: "접수시간",
            dataType: "text",
            width : "10%",
        },
        { dataField: "ARRIVE_TIME",
            headerText: "도착시간",
            dataType: "text",
            width : "10%",
        },
        { dataField: "RESTORE_TIME",
            headerText: "복구시간",
            dataType: "text",
            width : "10%",
        },

    ];

    //그리드1 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                height: 293,
                showRowNumColumn : false
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex);
    });

    //그리드 조회 함수
    function search_input1_onclick(){

        //검색데이터
        let selectParam = {
            EQU_GBN : input_equGbn.value,
            EQU_NO : search_equName.value
        }

        //파라미터
        let selectData = {
            sectionId :  sectionId,
            component : pgId + "_input1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                dataToInput(data[0], input);
                search_grid1_onclick();
            }
        });
    }

    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            EQU_GBN : input_equGbn.value,
            EQU_NO : search_equName.value
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                //그리드 데이터 세팅
                AUIGrid.setGridData(grid1, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(grid1, focus, 0);
                focus = 0;
            }
        });
    }

    //사진조회 함수


    //그리드 추가 함수
    function add_grid1_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid1, null);
        //새행 만들기
        const item = {};
        item.EQU_GBN = input_equGbn.value;
        item.EQU_NO = input_equNo.value;

        AUIGrid.addRow(grid1, item, "selectionDown");
    }


    //그리드 저장 함수
    function save_input1_onclick(){
        // 추가된 행 아이템들(배열)
        let addedRowItems = [];
        // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
        let editedRowItems = [];

        let item = inputToData(input)

        if(isNull(input_equNo.value)){
            addedRowItems = [{...item}];
        }else{
            editedRowItems =  [{...item}];
        }

        //검증
        if(!confirm("변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_INPUT1")) return;

        //포커스 지정

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : {
                column : ["EQU_NO"],
                seq : [1]
            },
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_input1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (data) => {
                alert(data.O_MSG);
                if(data.O_RESULT > 0){
                    if(!isNull(data.DATA[0].EQU_NO)){
                        Promise.all([
                            getSelect_search_equName()
                        ]).then(function () {
                            input_equGbn.value = equGbn;
                            search_equName.value = data.DATA[0].EQU_NO;
                            //로드 시 그리드 바로 조회
                            search_input1_onclick();
                        });
                    }
                }else return;
            }
        });
    }

    function save_grid1_onclick(){
        // 추가된 행 아이템들(배열)
        let addedRowItems = AUIGrid.getAddedRowItems(grid1);
        // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
        let editedRowItems = AUIGrid.getEditedRowItems(grid1);

        //검증
        let itemCount = addedRowItems.length + editedRowItems.length;
        if(itemCount == 0){
            alert("변경된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        if(!confirm("총 " + itemCount + "건의 변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_GRID1")) return;

        //포커스 지정
        focus = gridFocus(grid1);

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : {
                column : ["REPAIR_SEQ"],
                seq : [1]
            },
            before : {}
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

    function resign_onclick(){
        let item = inputToData(input)

        if (!confirm( input_equName.value + "을/를 폐기처리하시겠습니까?")) return;

        if(!requireCheck("DISUSE_INPUT1")) return;

        //포커스 지정
        focus = gridFocus(grid1);

        item.DISUSE_DATE = input_resignDate.value.replace(/-/g, "");
        item.DISUSE_REASON = input_resignReason.value;

        //저장 데이터
        let saveParam = {
            insertParam : null,
            updateParam : [{...item}],
            key : {},
            before : {}
        };

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_resign",
            param: saveParam,
        };

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    goEquList_onclick();
                }else return;
            }
        });
    }


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


        if (!confirm( "고장내역을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1);

        // 체크된 행 삭제 처리
        AUIGrid.removeCheckedRows(grid1);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : AUIGrid.getRemovedItems(grid1),
            before : {}
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
                if(isNull(input_equName.value)){
                    alert("장비명은 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
                }
                break;
            case "DISUSE_INPUT1":
                if(isNull(input_resignDate.value)){
                    alert("폐기일자는 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
                }
                break;
            case "SAVE_GRID1":
                let addedRowItems = AUIGrid.getAddedRowItems(grid1);
                let editedRowItems = AUIGrid.getEditedRowItems(grid1);
                let items = [...addedRowItems,...editedRowItems];
                for(const row of items){
                    if(isNull(row.ST_DATE)){
                        alert("시작일은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.END_DATE)){
                        alert("종료일은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
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

    function goEquList_onclick(){
        returnUrl = returnUrl.replaceAll("&amp;", "&");
        location.href =  ctx + "/goMenu/jangbi/"+equGbn+"-jan01010" + returnUrl;
    }

    async function getSelect_search_equName(){
        search_equName.innerHTML = "";
        //검색데이터
        let param = {
            EQU_GBN : equGbn
        }

        //파라미터
        let data = {
            sectionId : sectionId,
            component : pgId + "_search_equName",
            param: param,
        }

        DS_EQU = await we_getSelect(data);

        if(DS_EQU) {
            DS_EQU.forEach(row => {
                search_equName.insertAdjacentHTML("beforeend",
                    "<option value='" + row.EQU_NO + "'>" + row.EQU_NAME + "</option>");
            })
        }
    }

    //로드
    window.onload = function() {
        equGbn = "${requestParams.equGbn}";
        equNo = "${requestParams.equNo}";
        returnUrl = "${requestParams.returnUrl}";

        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"input1", search : true, save: true, del:true });
        btnMaker({ tag: "#section_middle_btn", grid:"grid1", add: true, save: true, del : true});
        //crud 권한 처리 함수
        //checkCrudPermission(pgId);

        Promise.all([
            getSelect_search_equName()
        ]).then(function () {
            input_equGbn.value = equGbn;
            search_equName.value = equNo;
            if(!isNull(equNo)){
                //로드 시 그리드 바로 조회
                search_input1_onclick();
            }
        });


    };

</script>


<%@ include file = "../../inc_footer.jsp" %>