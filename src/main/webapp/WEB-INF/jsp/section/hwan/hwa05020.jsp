<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/hwan/hwa_nav.jsp" />

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-picture"></i>수목관리</span>
                <span class="section1_nav_mic">&emsp;<i class="icon-mic"></i>
                    수목명 행을 더블 클릭하면 해당 수목관리이력카드메뉴로 이동됩니다.
                </span>
                <div class="section1_btn" id="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line0"></div>
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

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "EQU_GBN",
           visible : false
        },
        { dataField: "EQU_NO",
            visible : false
        },
        { dataField: "EQU_NAME",
            headerText: "수목명",
            dataType: "text",
            width : "15%",
            style : "text-align-left",
        },
        { dataField: "FORM",
            headerText: "분류",
            dataType: "text",
            width : "15%",
        },
        { dataField: "DIMENSION",
            headerText: "과",
            dataType: "text",
            width : "15%",
        },
        { dataField: "SIZE",
            headerText: "규격",
            dataType: "text",
            width : "15%",
        },
        { dataField: "INSTALL_DATE",
            headerText: "식목일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "12%",
        },
        { dataField: "INSTALL_PLACE",
            headerText: "식목장소",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "FILE_NM",
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

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
                showRowCheckColumn : false
            })
    );

    //그리드 이벤트
    AUIGrid.bind(grid1, "cellDoubleClick", function(event) {
        let paramMap = {};
        paramMap.EQU_NO = AUIGrid.getSelectedRows(grid1)[0].EQU_NO;
        location.href = ctx + "/goMenu/hwan/hwa05025?paramMap=" + paramMap;
    });


    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
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

    //그리드 추가 함수
    function add_grid1_onclick(){
        location.href = ctx + "/goMenu/hwan/hwa05025";
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
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, add: true, print: true});

        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //로드 시 그리드 바로 조회
        search_grid1_onclick();
    };

</script>



<%@ include file = "../../inc_footer.jsp" %>