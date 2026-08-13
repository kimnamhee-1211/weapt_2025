<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>

    <div id="section">
        <div class="section1">
            <div class="section1_nav"><i class="icon-calendar-plus-o"></i>폐기장비조회</div>
            <div class="section1_btn" id="section1_btn"></div>
            <span class="search-box section1_btn">
                <button id="cancelResign_btn_grid1" class="del_btn" onclick="cancelResign_onclick()">복원</button>
            </span>
        </div>
        <div class="section2">
            <div class="section2_line1">
                <span class="search-box">폐기기간 :&nbsp;
                    <input type="date" id="search_startDate" name="START_DATE">&nbsp; ~ &nbsp;
                    <input type="date" id="search_endDate" name="END_DATE">
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
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_startDate = document.querySelector("#search_startDate");
    const search_endDate = document.querySelector("#search_endDate");

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "EQU_NO",
            headerText: "장비번호",
            dataType: "text",
            width : "8%"
        },
        { dataField: "EQU_GBN_NM",
            headerText: "메뉴(장소명)",
            dataType: "text",
            width : "15%",
        },
        { dataField: "EQU_NAME",
            headerText: "장비명",
            dataType: "text",
            width : "20%",
            style : "text-align-left",
        },
        { dataField: "DISUSE_DATE",
            headerText: "폐기일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%"
        },
        { dataField: "DISUSE_REASON",
            headerText: "폐기사유",
            dataType: "text",
            width : "20%"
        },
        { dataField: "INSTALL_DATE",
            headerText: "설치일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
        },
        { dataField: "MAKE_BY",
            headerText: "제조사",
            dataType: "text",
            width : "20%",
            style : "text-align-left",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowNumColumn : false,
                editable : false,
            })
    );

    //그리드 이벤트

    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
            START_DATE: search_startDate.value.replace(/-/g,""),
            END_DATE: search_endDate.value.replace(/-/g,""),
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

    function cancelResign_onclick(){
        // 추가된 행 아이템들(배열)
        let checkedItems = AUIGrid.getCheckedRowItemsAll(grid1);
        let itemCount = checkedItems.length;

        //검증
        if(itemCount == 0){
            alert("체크된 행이 없습니다.");
            return;
        }

        if(itemCount > 100){
            alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)");
            return;
        }

        if (!confirm("폐기 장비를(총 " + itemCount + "건) 복원처리하시겠습니까?")) return;

        //포커스 지정
        focus = gridFocus(grid1);

        //저장 데이터
        let saveParam = {
            insertParam : null,
            updateParam : checkedItems,
            key : {},
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_cancelResign",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                alert(json.O_MSG);
                if(json.O_RESULT > 0){
                    search_grid1_onclick()
                }else return;
            }
        });
    }

    //컴포넌트 필수항목 입력 체크
    function requireCheck(require){
        let isValid = true;
        switch(require){
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
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, print : true});
        search_startDate.value = getToday("yyyy-MM-dd");
        search_endDate.value = addDate(getToday("yyyy-MM-dd"), 7, "yyyy-MM-dd");
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //로드 시 그리드 바로 조회
        search_grid1_onclick();
    };

</script>



<%@ include file = "../../inc_footer.jsp" %>