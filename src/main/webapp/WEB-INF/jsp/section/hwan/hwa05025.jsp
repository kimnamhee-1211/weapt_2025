<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/hwan/hwa_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-picture"></i>수목관리이력카드</div>
                <div class="section1_btn">
                    <button id="find_btn" onclick="">사진찾기</button>
                    <button id="save_btn" onclick="">저장</button>
                    <button id="add_btn" onclick="">추가</button>
                    <button id="closs_btn" onclick="" class="closs_btn">폐기</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                    <button id="list_btn" onclick=""><a href="jan01010.jsp">목록</a></button>
                </div>
            </div>
            <div style=height:300px;>
                <div id="sajin" class="gridcont_left_535">
                    <div class="jangbi_sajin" style="height: 300px; border: 1px solid #bcbcbc;">
                    사진
                    </div>
                </div>
                <div class="gridcont_right_535">
                    <table class="jan01015_table" id="input1_table">
                        <tbody>
                            <tr>
                                <th style="width:100px;">관리번호</th>
                                <td style="width:433px;"><input type="text" name="EQU_NO"></td>
                            </tr>
                            <tr>
                                <th>수목명</th>
                                <td><input type="text" name="EQU_NAME"></td>
                            </tr>
                            <tr>
                                <th>분류(과)</th>
                                <td><input type="text" name="FORM"></td>
                            </tr>
                            <tr>
                                <th>생산지</th>
                                <td><input type="text" name="MAKE_BY"></td>
                            </tr>
                            <tr>
                                <th>규격(크기)</th>
                                <td><input type="text" name="SIZE"></td>
                            </tr>
                            <tr>
                                <th>식목장소</th>
                                <td><input type="text" name="INSTALL_PLACE"></td>
                            </tr>
                            <tr>
                                <th>식목일</th>
                                <td><input type="date" name="INSTALL_DATE"></td>
                            </tr>
                            <tr>
                                <th style="height:62px;">비고</th>
                                <td><textarea class="jan01015_textarea" name="REMARKS"></textarea></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="section2">
                <div class="section_middle_title">
                    <span> <i class="icon-edit"></i>관리내역(영양제/촉진제/시비/토양개량/기타)</span>
                    <span class="section1_nav_mic">&emsp;
                        <i class="icon-mic"></i>처리금액이 발생된 정비내역만 기록합니다.
                    </span>
                    <span class="section_middle_btn" id="section_middle_btn">
                        <button id="">추가</button>
                    </span>
                </div>
            </div>
            <div id="grid1"></div>
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
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const inputId = "input1_table"; //팝업 컴포넌트
    let equNo = null;
    let DS_LICENSE_CODE = [];

    //그리드1 설정
    const grid1ColumnLayout = [
        { dataField: "REPAIR_SEQ",
            visible : false
        },
        { dataField: "내역",
            headerText: "폐기구분",
            dataType: "text",
            width : "10%",
            style : "text-align-left",
        },
        { dataField: "TRO_AMT",
            headerText: "처리금액",
            dataType: "text",
            width : "15%",
        },
        { dataField: "TRO_USER",
            headerText: "처리자",
            dataType: "text",
            width : "10%",
        },
        { dataField: "ST_DATE",
            headerText: "시작일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
        },
        { dataField: "END_DATE",
            headerText: "종료일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
        },
        { dataField: "EQU_USER",
            headerText: "담당자",
            dataType: "text",
            width : "10%",
        },
        { dataField: "REMARKS",
            headerText: "비고",
            dataType: "text",
            width : "10%",
        },
        { dataField: "FILE_SEQ",
            headerText: "첨부파일",
            dataType: "text",
            width : "6%",
            renderer : {
                type : "TemplateRenderer",
            },
            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { //HTML 템플릿 작성
                if(value) return `<i class="demo-icon icon-floppy" style="font-size:18px;"></i>`;
                else return null;
            }
        },
    ];

    //그리드1 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowNumColumn: false,
                editable : false,
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });

    //그리드 조회 함수
    function search_input1_onclick(){

        //검색데이터
        let selectParam = {
            EQU_NO : equNo
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_input1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.data;
                //그리드 데이터 세팅
                dataToInput(data)
                search_grid2_onclick();
            }
        });
    }

    function search_grid2_onclick(){

        //검색데이터
        let selectParam = {
            EMP_NO : AUIGrid.getSelectedRows(grid1)[0].EMP_NO
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_grid2",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.data;
                //그리드 데이터 세팅
                AUIGrid.setGridData(grid2, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(grid2, focus2, 0);
                focus2 = 0;
            }
        });
    }

    function add_grid2_onclick(){
        // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
        AUIGrid.forceEditingComplete(grid2, null);
        //새행 만들기
        let selectRowItem = AUIGrid.getSelectedRows(grid1)[0];
        const item = {};
        item.EMP_NO = selectRowItem.EMP_NO;
        AUIGrid.addRow(grid2, item, "last");
    }

    //그리드 저장 함수
    function save_grid2_onclick(){
        // 추가된 행 아이템들(배열)
        let addedRowItems = AUIGrid.getAddedRowItems(grid2);
        // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
        let editedRowItems = AUIGrid.getEditedRowItems(grid2);

        //검증
        let itemCount = addedRowItems.length + editedRowItems.length;
        if(itemCount == 0){
            alert("변경된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)")
            return;
        }
        if(!confirm("총 " + itemCount + "건의 변경사항을 저장하시겠습니까?")) return;
        if(!requireCheck("SAVE_GRID2")) return;

        //포커스 지정

        focus = AUIGrid.getSelectedIndex(grid1)[0];
        focus2 = gridFocus(grid2);

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : ["SEQ"],
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_grid2",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_grid2_onclick();
                }else return;
            }
        });
    }

    //그리드 삭제 함수
    function delete_grid2_onclick(){
        //검증
        const checkedItems = AUIGrid.getCheckedRowItems(grid2);
        let itemCount = checkedItems.length;
        if (itemCount=== 0) {
            alert("체크된 항목이 없습니다");
            return;
        }
        if(itemCount > 100){
            alert("삭제는 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }
        let delItemsName = checkedItems.map(row => row.item.CODEDTL_NM).join(", ");
        if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

        //포커스 지정
        focus2 = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1);

        // 체크된 행 삭제 처리
        AUIGrid.removeCheckedRows(grid2);

        // 삭제된 행 아이템들(배열) -> 삭제 데이터
        let param = {
            deleteParam : AUIGrid.getRemovedItems(grid2),
            before : {}
        };


        //공통 저장 트렌젝션용 데이터
        let deleteData = {
            sectionId :  sectionId,
            component : pgId + "_grid2",
            param : param,
        }

        we_delete(deleteData,{
            successDelete : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_grid2_onclick();
                }else return;
            }
        });
    }

    //컴포넌트 필수항목 입력 체크
    function requireCheck(require){
        let isValid = true;
        switch(require){
            case "SAVE_GRID2":
                let addedRowItems2 = AUIGrid.getAddedRowItems(grid2);
                let editedRowItems2 = AUIGrid.getEditedRowItems(grid2);
                let items2 = [...addedRowItems2,...editedRowItems2];
                for(const row of items2){
                    if(isNull(row.LICENSE_CODE)){
                        alert("자격명은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.POSS_DT)){
                        alert("취득일은 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.LICENSE_NO)){
                        alert("자격(면허)번호는 반드시 입력해야 합니다.");
                        isValid = false;
                        break;
                    }
                    if(isNull(row.OPER_ORG)){
                        alert("발행처는 반드시 입력해야 합니다.");
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

    async function getSelectOption_grid2_licenseCode(){
        let code = await we_getCode('135');
        code.forEach(row=>{
            let item = {};
            item.LICENSE_CODE = row.CODE_NO;
            item.LICENSE_NAME = row.CODEDTL_NM;
            DS_LICENSE_CODE.push(item);
        });
    }

    //로드
    window.onload = function() {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid2", search: true, add: true, save: true, del: true});
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //공통코드 가져오기
        //그리드 DDL
        Promise.all([
            getSelectOption_grid2_licenseCode()
        ]).then(function () {
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        });

    };

</script>






<%@ include file = "../../inc_footer.jsp" %>