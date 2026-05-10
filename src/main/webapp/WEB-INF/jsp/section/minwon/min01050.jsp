<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/minwon/min_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-phone-squared"></i>공용민원대장</div>
                <div class="section1_btn" id="section1_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <div>
                        <span>기간 :&nbsp;
                            <input type="date" id="search_startDate">&nbsp; ~ &nbsp;
                            <input type="date" id="search_endDate">
                        </span>&emsp;&emsp;
                        <span id="gongyong">
                            <input type="radio" id="search_gbn12" value="all" name="GBN_12" checked> 전체공용&emsp;
                            <input type="radio" id="search_gbn1" value="1" name="GBN_12"> 동별공용&emsp;
                            <input type="radio" id="search_gbn2" value="2" name="GBN_12"> 동외공용&emsp;
                        </span>
                    </div>
                </div> 
            </div>
            <div id="grid1" ></div>
            <jsp:include page="/WEB-INF/jsp/section/minwon/min001.jsp"/>
            <jsp:include page="/WEB-INF/jsp/section/minwon/min011.jsp"/>
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
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_startDate = document.querySelector("#search_startDate")	//select 컴포넌트
    const search_endDate = document.querySelector("#search_endDate")	//select 컴포넌트
    const search_gbn12 = document.querySelector("#search_gbn12");
    const search_gbn1 = document.querySelector("#search_gbn1");
    const search_gbn2 = document.querySelector("#search_gbn2");

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "DONG_NAME",
            headerText: "동",
            dataType: "text",
            width : "12%",
        },
        { dataField: "PLACE",
            headerText: "장소",
            dataType: "text",
            width : "*%",
            style : "text-align-left",
        },
        { dataField: "TOTAL_CNT",
            headerText: "민원건수",
            dataType : "numeric",
            formatString : "#,###",
            width : "8%",
        },
        { dataField: "PROC_CNT",
            headerText: "처리건수",
            dataType : "numeric",
            formatString : "#,###",
            width : "8%",
        },
        { dataField: "HOLD_CNT",
            headerText: "보류건수",
            dataType : "numeric",
            formatString : "#,###",
            width : "8%",
        },
        { dataField: "REJECT_CNT",
            headerText: "반려건수",
            dataType : "numeric",
            formatString : "#,###",
            width : "8%",
        },
        { dataField: "PENDING_CNT",
            headerText: "미처리건수",
            dataType : "numeric",
            formatString : "#,###",
            width : "8%",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowCheckColumn : false,
                editable : false
            })
    );

    //그리드 이벤트
    AUIGrid.bind(grid1, "cellDoubleClick", function(event) {
        getSelect_min_setting();
        open_popup_onclick(AUIGrid.getSelectedRows(grid1)[0]);
    });

    //팝업 닫기 이벤트
    function close_popup_onclick(){
        popupClose(popupId);
        clearInput(popupId);
    }

    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            START_DATE : search_startDate.value.replace(/-/g,""),
            END_DATE : search_endDate.value.replace(/-/g,""),
            GBN_12: document.querySelector("input[name='GBN_12']:checked")?.value || "",
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
                data.forEach( row =>{
                    row.PLACE = make_place(row);
                })

                //그리드 데이터 세팅
                AUIGrid.setGridData(grid1, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(grid1, focus, 0);
                focus = 0;
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
        search_grid1_onclick();

    };

</script>



<%@ include file = "../../inc_footer.jsp" %>