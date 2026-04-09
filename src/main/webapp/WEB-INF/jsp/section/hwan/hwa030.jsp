<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

        <div class="section2">
            <div class="section2_line0"></div>
        </div>

        <div class="section2">
            <div class="gridcont_left_450">
                <div class="section_middle_title">
                    <span id="grid_title"></span>
                </div>
                <div id="grid1"></div>
            </div>
            <div class="gridcont_right_620">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>근태등록</span>
                </div>
                <div class="attendance" id="input_absent">
                    <div>&emsp;&#9726&nbsp;대 &nbsp;&nbsp;상 &nbsp;&nbsp;자&nbsp;&nbsp; : &nbsp;
                        <span id="input_name"></span>
                        <input name="EMP_NO" id="input_empNo" hidden="hidden">
                    </div>  <!--직 성명 표현 -->
                    <div>&emsp;&#9726&nbsp;등 &nbsp;&nbsp;록 &nbsp;&nbsp;일&nbsp;&nbsp; :&nbsp;
                        <input type="date" id="input_regDate" name="REG_DATE" ></div>
                    <div>&emsp;&#9726&nbsp;근&nbsp;태&nbsp;구&nbsp;분&nbsp; :&nbsp;
                        <select id="input_absentCd" name="ABSENT_CD" class="select_cont100"></select>
                    </div>
                    <div>&emsp;&#9726&nbsp;기&emsp;&emsp; &nbsp;&nbsp;간&nbsp; :&nbsp;
                        <input type="date" id="input_startDate" name="START_DATE">&nbsp; ~ &nbsp;<input type="date" id="input_endDate" name = "END_DATE">
                    </div>
                    <div>&emsp;&#9726&nbsp;실사용일수 :&nbsp;
                        <input type="text" id="input_useDayCnt" name="USE_DAY_CNT" class="search-txt100">
                        &nbsp;(휴일을 제외한 실제사용일수 입력함, 반차인경우 0.5)
                    </div>
                    <div>&emsp;&#9726&nbsp;내&emsp;&emsp; &nbsp;&nbsp;용&nbsp; :&nbsp; </div>
                    <textarea id="input_descr" name="DESCR"></textarea>
                </div>
                <div id="tip_mic">
                    <i class="icon-mic"></i>수정/삭제는 개인근태조회에서 할 수 있습니다. <br>
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
    let empGbm; //메뉴 구분자(청소 : 1 경비 : 2)
    let querySet;
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const inputId = "input_absent";
    const grid_title = document.querySelector("#grid_title"); //select 컴포넌트

    const input_name = document.querySelector("#input_name"); //select 컴포넌트
    const input_empNo = document.querySelector("#input_empNo"); //select 컴포넌트
    const input_regDate = document.querySelector("#input_regDate"); //select 컴포넌트
    const input_absentCd = document.querySelector("#input_absentCd"); //select 컴포넌트
    const input_startDate = document.querySelector("#input_startDate"); //select 컴포넌트
    const input_endDate = document.querySelector("#input_endDate"); //select 컴포넌트
    const input_useDayCnt = document.querySelector("#input_useDayCnt"); //select 컴포넌트
    const input_descr = document.querySelector("#input_descr"); //select 컴포넌트

    //그리드1 설정
    const grid1ColumnLayout = [
        { dataField: "EMP_GBN",
            visible : false
        },
        { dataField: "EMP_NO",
            headerText: "사번",
            dataType: "text",
            width : "18%",
        },
        { dataField: "NAME",
            headerText: "성명",
            dataType: "text",
            width : "22%",
        },
        { dataField: "DEPT_NAME",
            headerText: "부서",
            dataType: "text",
            width : "30%",
        },
        { dataField: "JOB_DUTY_NAME",
            headerText: "직책",
            dataType: "text",
            width : "30%",
        },

    ];

    //그리드1 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowCheckColumn: false,
                showRowNumColumn: false,
                editable : false
            })
    );

    //그리드 이벤트
    //셀 선택 변경 이벤트 바인딩
    AUIGrid.bind(grid1, "selectionChange", function(event) {
        clearInput(inputId);
        input_name.innerHTML = AUIGrid.getSelectedRows(grid1)[0].NAME;
        input_empNo.value = AUIGrid.getSelectedRows(grid1)[0].EMP_NO;
    });

    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
            EMP_GBN : empGbm
        };

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : querySet + "_grid1",
            param: selectParam,
        };

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

    //그리드 저장 함수
    function save_input1_onclick(){
        // 추가된 행 아이템들(배열)
        let addedRowItems = [
            {
                EMP_NO : input_empNo.value,
                ABSENT_CD : input_absentCd.value,
                START_DATE : input_startDate.value.replace(/-/g, ''),
                END_DATE : input_endDate.value.replace(/-/g, ''),
                USE_DAY_CNT : input_useDayCnt.value,
                DESCR: input_descr.value,
                REG_DATE : input_regDate.value.replace(/-/g, ''),
                EMP_GBN : empGbm
            }
        ]

        let editedRowItems = [];

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
        if(!requireCheck("SAVE_INPUT1")) return;

        //포커스 지정
        focus = AUIGrid.getSelectedIndex(grid1)[0];

        //저장 데이터
        let saveParam = {
            insertParam : addedRowItems,
            updateParam : editedRowItems,
            key : ["REG_SEQ"],
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : querySet + "_input1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
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
                if(isNull(input_absentCd.value)){
                    alert("근태구분은 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
                }
                if(isNull(input_startDate.value)){
                    alert("시작일은 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
                }
                if(isNull(input_endDate.value)){
                    alert("종료일은 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
                }
                if(isNull(input_useDayCnt.value)){
                    alert("사용일수는 반드시 입력해야 합니다.");
                    isValid = false;
                    break;
                }

                break;

        }
        return isValid;
    }

    //로드
    function pop_onload(pop_item){

        grid_title.innerHTML = isNull(pop_item.gridTitle) ? "" : pop_item.gridTitle;
        querySet = isNull(pop_item.querySet) ? pop_item.pgId : pop_item.querySet;
        empGbm = isNull(pop_item.empGbm) ? "" : pop_item.empGbm;

        if(!isNull(pop_item.btnHidden)){
            btnHidden(pop_item.btnHidden, pop_item.popupId);
        }

        if(!isNull(pop_item.btnHidden)){
            btnHidden(pop_item.btnHidden, pop_item.popupId);
        }

        if(!isNull(pop_item.disabled)){
            disableInput(pop_item.popupId);
        }

        //공통코드 가져오기
        selectOptionMaker("137", input_absentCd, "", false);
        //그리드 DDL
        //로드 시 그리드 바로 조회
        search_grid1_onclick();

    }

</script>

