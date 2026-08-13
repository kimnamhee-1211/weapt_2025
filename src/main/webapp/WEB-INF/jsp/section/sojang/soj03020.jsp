<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-star-filled"></i>사용자권한등록</span>
                <span class="section1_nav_mic">&emsp;
                    <i class="icon-mic"></i>사용자 검색 후 사용자를 선택하여 사용자권한을 설정 저장합니다.
                </span>  
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <span class="search-box">관리소명 :&nbsp;&nbsp;</span>
                    <span id="title_officeName" class="search-box"></span>
                </div>
            </div>

            <div class="gridcont_left_300">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>사용자</span>
                </div>
                <div id="grid1"></div>
            </div>

            <div class="gridcont_right_770">
                <div class="section_middle_title">
                    <span><i class="icon-pause"></i>사용자권한등록</span>
                    <span class="section_middle_btn" id="section2_btn"></span>&emsp;&emsp;
                </div>
                <div id="grid2"></div>
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
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
        let grid1;	// 그리드 컴포넌트
        let grid2;	// 그리드 컴포넌트
        let focus = 0;	//그리드 컴포넌트 포커스
        let focus2 = 0;	//그리드 컴포넌트 포커스
        const title_officeName = document.querySelector("#title_officeName"); //title 컴포넌트
        const title_jobDutyName = document.querySelector("#title_jobDutyName"); //title 컴포넌트
        const title_userName = document.querySelector("#title_userName"); //title 컴포넌트

        //그리드1 설정
        const grid1ColumnLayout = [
            { dataField: "USER_ID",
                headerText: "ID",
                dataType: "text",
                width : "30%",
            },
            { dataField: "JOB_DUTY_NAME",
                headerText: "직책",
                dataType: "text",
                width : "40%",
            },
            { dataField: "USER_NAME",
                headerText: "사용자",
                dataType: "text",
                width : "30%",
            },
            { dataField: "USERGROUP_ID",
                visisble : false
            },
        ];

        //그리드1 생성
        grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
            Object.assign({}, we_grid_Props,
                { showRowNumColumn: false,
                    editable : false,
                    showRowCheckColumn : false,
                })
        );

        //그리드2 설정
        const grid2ColumnLayout = [
            { dataField: "MENU_NAME",
                headerText: "메뉴명",
                dataType: "text",
                width : "*%",
                editable : false
            },
            { dataField: "MENU_ID",
                headerText: "메뉴ID",
                dataType: "text",
                width : "14%",
                editable : false
            },
            { dataField: "PG_ID",
                headerText: "프로그램ID",
                dataType: "text",
                width : "12%",
                editable : false
            },
            { dataField: "M_LEVEL",
                headerText: "레벨",
                dataType: "text",
                width : "5%",
                editable : false
            },
            { dataField: "UP_MENU_ID", //트리용 키
                visible : false
            },
            { dataField: "USER_ID", //트랜젝션용 키
                visible : false
            },
            { dataField: "USERGROUP_ID", //트랜젝션용 키
                visible : false
            },
            { dataField: "FORM_USE",
                headerText: "사용유무",
                width : "10%",
                renderer : we_cb_10_Renderer
            },
            { dataField: "GRD_READ",
                headerText: "읽기",
                width : "6%",
                renderer : we_cb_10_Renderer
            },
            { dataField: "GRD_CREATE",
                headerText: "쓰기",
                width : "6%",
                renderer : we_cb_10_Renderer
            },
            { dataField: "GRD_UPDATE",
                headerText: "수정",
                width : "6%",
                renderer : we_cb_10_Renderer
            },
            { dataField: "GRD_DELETE",
                headerText: "삭제",
                width : "6%",
                renderer : we_cb_10_Renderer
            },
            { dataField: "GRD_EXCEL",
                headerText: "엑셀",
                width : "6%",
                renderer : we_cb_10_Renderer
            },
        ];

        //그리드2 생성
        grid2 = AUIGrid.create("#grid2", grid2ColumnLayout,
            Object.assign({}, we_grid_Props,
                {  showRowNumColumn: false,
                    // 일반 데이터를 트리로 표현할지 여부(treeIdField, treeIdRefField 설정 필수)
                    flat2tree: true,
                    // 트리의 고유 필드명
                    treeIdField: "MENU_ID",
                    // 계층 구조에서 내 부모 행의 treeIdField 참고 필드명
                    treeIdRefField: "UP_MENU_ID",
                    // 최초 보여질 때 모두 열린 상태로 출력 여부
                    displayTreeOpen : true,
                    // 트리 의존적인 경우, 부모를 체크하면 자식도 체크됨.
                    rowCheckDependingTree: true,
                    showRowCheckColumn : false,
                })
        );

        //그리드 이벤트
        //체크박스 클릭 시 : select + onlycheck
        AUIGrid.bind(grid1, "rowCheckClick", function(event) {
            AUIGrid.setSelectionByIndex(grid1, event.rowIndex);
        });
        AUIGrid.bind(grid2, "rowCheckClick", function(event) {
            AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
        });
        //셀 선택 변경 이벤트 바인딩
        AUIGrid.bind(grid1, "selectionChange", function(event) {
            search_grid2_onclick();
        });


        //그리드 조회 함수
        function search_grid1_onclick(){

            //검색데이터
            let selectParam = {}

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

        function search_grid2_onclick(){

            //검색데이터
            let selectParam = {
                USER_ID : AUIGrid.getSelectedRows(grid1)[0].USER_ID,
                USERGROUP_ID : isNull(AUIGrid.getSelectedRows(grid1)[0].USERGROUP_ID) ? "500" : AUIGrid.getSelectedRows(grid1)[0].USERGROUP_ID,
            }

            //파라미터
            let selectData = {
                sectionId : sectionId,
                component : pgId + "_grid2",
                param: selectParam,
            }

            we_select( selectData,{
                successSelect : (json) => {
                let data = json.DATA;
                    //그리드 데이터 세팅
                    AUIGrid.setGridData(grid2, data);
                    //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                    AUIGrid.setSelectionByIndex(grid2, focus2, 0);
                    focus2 = 0;

                }
            });
        }

        function save_grid2_onclick(){
            let editedRowItem = AUIGrid.getEditedRowItems(grid2);

            // 추가된 행 아이템들(배열)
            let addedRowItems = AUIGrid.getEditedRowItems(grid2).filter(row => row.USERMENU_ID == null);
            // 수정된 행 아이템들(배열) : 수정된 필드와 수정안된 필드 모두를 얻음.
            let editedRowItems = AUIGrid.getEditedRowItems(grid2).filter(row => row.USERMENU_ID != null);
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
                key : {},
                before : {}
            }

            //파라미터
            let saveData  = {
                sectionId : sectionId,
                component : pgId + "_grid2",
                param: saveParam,
            }

            we_save( saveData ,{
                successSave : (data) => {
                    alert(data.O_MSG);
                    if(data.O_RESULT > 0){
                        search_grid2_onclick();
                    }else{
                        return;
                    }
                }
            });
        }

        //컴포넌트 필수항목 입력 체크
        function requireCheck(require){
            let isValid = true;
            switch(require){
                case "SAVE_GRID1":
                    isValid = AUIGrid.validateGridData(grid1, [], "필수 필드는 반드시 값을 직접 입력해야 합니다.");
                    break;
                case "SAVE_GRID2":
                    isValid = AUIGrid.validateGridData(grid2, [], "필수 필드는 반드시 값을 직접 입력해야 합니다.");
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
            title_officeName.innerHTML = loginUser.officeName;
            //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
            btnMaker({ tag: "#section2_btn", grid: "grid2", save : true});
            //crud 권한 처리 함수
            checkCrudPermission(pgId);

            //공통코드 가져오기
            //그리드 DDL

            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        };



    </script>














<%@ include file = "../../inc_footer.jsp" %>