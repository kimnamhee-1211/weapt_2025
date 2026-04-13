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
                            <input type="date" id="search_stDate">&nbsp; ~ &nbsp;
                            <input type="date" id="search_endDate">
                        </span>&emsp;&emsp;
                        <span id="gongyong">
                            <input type="radio" id="search_all" name="" checked> 전체공용&emsp;
                            <input type="radio" id="search_dong" name=""> 동별공용&emsp;
                            <input type="radio" id="search_etc" name=""> 동외공용&emsp;
                        </span>
                    </div>
                </div> 
            </div>
            <div id="grid1" ></div>
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
    const search_stDate = document.querySelector("#search_stDate")	//select 컴포넌트
    const search_endDate = document.querySelector("#search_endDate")	//select 컴포넌트
    const search_stDong = document.querySelector("#search_stDong")	//select 컴포넌트
    const search_stHo = document.querySelector("#search_stHo")	//select 컴포넌트
    const search_endDong = document.querySelector("#search_endDong")	//select 컴포넌트
    const search_endHo = document.querySelector("#search_endHo")	//select 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "SLIP_NO",
            visible : false
        },
        { dataField: "MINWON_DATE",
            headerText: "접수일",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%"
        },
        { dataField: "DESCR",
            headerText: "접수 내역",
            dataType: "text",
            width : "*%",
            style: "line-break-column",
        },
        { dataField: "STATUS_NAME",
            headerText: "처리상태",
            dataType: "text",
            width : "10%",
        },
        { dataField: "WORK_USER",
            headerText: "처리자",
            dataType: "text",
            width : "10%",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowCheckColumn : false,
                enable : false,
            })
    );

    //그리드 이벤트

    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            ST_DATE : search_stDate.value,
            END_DATE : search_endDate.value,
            ST_DONG : search_stDong.value,
            END_HO : search_stHo.value,
            ST_DONG : search_endDong.value,
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

        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        search_grid1_onclick();

    };

</script>


<%@ include file = "../../inc_footer.jsp" %>