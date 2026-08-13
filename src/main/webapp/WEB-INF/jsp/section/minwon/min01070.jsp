<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>


    <div id="section">
        <div class="section1">
            <span class="section1_nav"><i class="icon-phone-squared"></i>세대정보등록</span>
            <div class="section1_btn" id="section1_btn"></div>
        </div>
        <div class="section2">
            <div class="section2_line1">
                <div>
                    <span>동호:&nbsp;
                        <input type="text" id="search_stDong" name="" class="box50" oninput="inputNumFormat(this)">동
                        <input type="text" id="search_stHo" name="" class="box50" oninput="inputNumFormat(this)">호&emsp;~
                        <input type="text" id="search_endDong" name="" class="box50" oninput="inputNumFormat(this)">동
                        <input type="text" id="search_endHo" name="" class="box50" oninput="inputNumFormat(this)">호&emsp;&emsp;
                    </span>
                </div>
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
    const search_stDong = document.querySelector("#search_stDong")	//select 컴포넌트
    const search_stHo = document.querySelector("#search_stHo")	//select 컴포넌트
    const search_endDong = document.querySelector("#search_endDong")	//select 컴포넌트
    const search_endHo = document.querySelector("#search_endHo")	//select 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "DONG_NAME",
            headerText: "동",
            dataType: "text",
            width : "10%",
            editable : false
        },
        { dataField: "HO",
            headerText: "호",
            dataType: "text",
            width : "10%",
            editable : false
        },
        { dataField: "HOUSE_SIZE",
            headerText: "면적",
            dataType: "text",
            width : "10%",
            editable : false
        },
        { dataField: "IBJU_DATE",
            headerText: "입주일자",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%",
        },
        { dataField: "HOUSEHOLDER",
            headerText: "세대주",
            dataType: "text",
            width : "10%",
        },
        { dataField: "HOUSE_PHON_NO",
            headerText: "집전화",
            dataType: "text",
            width : "10%",
        },
        { dataField: "HP_NO",
            headerText: "휴대전화",
            dataType: "text",
            width : "10%",
        },
        { dataField: "LIVE_TYPE",
            headerText: "거주형태",
            dataType: "text",
            width : "10%",
        },
        { dataField: "REMARKS",
            headerText: "비고",
            dataType: "text",
            width : "10%",
        },

    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowCheckColumn : false,
            })
    );

    //그리드 이벤트

    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            ST_DONG : search_stDong.value,
            ST_HO : search_stHo.value,
            END_DONG : search_endDong.value,
            END_HO : search_endHo.value
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


    //그리드 저장 함수
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
            key : {},
            before : {}
        };

        //파라미터
        let saveData  = {
            sectionId :  sectionId,
            component : pgId + "_grid1",
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
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, save: true, print : true});

        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        search_grid1_onclick();

    };

</script>
<%@ include file = "../../inc_footer.jsp" %>