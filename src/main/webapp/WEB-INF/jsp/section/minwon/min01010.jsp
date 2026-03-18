<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../../inc_head.jsp" %>
<%@ include file="../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/minwon/min_nav.jsp"/>

<style>
    .step_block{
        border: 1px solid #bcbcbc;
        background-color: #f4e1d6;
        height : 30px;
        weight: 40px;
    }
    .ho_block{
        border: 1px solid #bcbcbc;
        background-color: #f4e1d6;
        height : 30px;
        weight: 80px;
    }

    .el_block{}
    .rooftop_block{}
    .door_block{}


</style>
<div id="section">
    <div class="section1">
        <span class="section1_nav"><i class="icon-phone-squared"></i>민원접수</span>
        <span class="section1_nav_mic">&emsp;
                    <i class="icon-mic"></i>동(또는 동외민원)을 클릭하면 해당 동이미지(설정된 동외민원)를 볼 수 있습니다. 각 호(세대민원), 계단, 현관, E/L 을 클릭하여 민원접수, 처리 하십시오.
                </span>
    </div>
    <div class="section2">
        <div class="section2_line0"></div>
    </div>
    <div>
        <div id="grid1" class="gridcont_left_100"></div>
        <div id="apt_block" class="gridcont_right_970" style="height: 652px; border: 1px solid #bcbcbc;">
            <table id="dong_table"></table>
        </div>
        <div>
            <div id="min-jeon01">
                <input type="checkbox" id="layer_popup" class="layer_popup">
                <label for="layer_popup" class="pop_labal">클릭하면 나타나는 민원전표(세대)</label>
                <%-- table 팝업시작--%>
                <%@ include file="../../popup/pop_min_jeon01.jsp" %>
                <%-- table 팝업 끝--%>
            </div>
            <div id="min-jeon02">
                <input type="checkbox" id="layer_popup2" class="layer_popup">
                <label for="layer_popup2" class="pop_labal">클릭하면 나타나는 민원전표(공용민원)</label>
                <%-- table 팝업시작--%>
                <%@ include file="../../popup/pop_min_jeon02.jsp" %>
                <%-- table 팝업 끝--%>
            </div>
            <div id="min-jeon03">
                <input type="checkbox" id="layer_popup3" class="layer_popup">
                <label for="layer_popup3" class="pop_labal">클릭하면 나타나는 민원전표(동외민원)</label>
                <%-- table 팝업시작--%>
                <%@ include file="../../popup/pop_min_jeon03.jsp" %>
                <%-- table 팝업 끝--%>
            </div>
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
     *        기본 crud 버튼 생성
     *        crud 권한 처리 함수 호출
     *        공통코드 가져오기		(미사용시 생략)
     *        (필요 시)그리드 조회 함수 호출    (미사용시 생략)
     *
     */

        //변수 선언
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    let dong_table = document.querySelector("#dong_table");

    //그리드1 설정
    const grid1ColumnLayout = [
        {
            dataField: "DONG_ID",
            headerText: "동번호",
            dataType: "text",
            width: "30%",
            visible : false
        },
        {
            dataField: "DONG_NAME",
            headerText: "동명",
            dataType: "text",
            width: "*%",
        },
    ];

    //그리드1 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowNumColumn: false,
                showRowCheckColumn: false,
                editable: false
            })
    );

    //그리드 이벤트
    //셀 선택 변경 이벤트 바인딩
    AUIGrid.bind(grid1, "selectionChange", function (event) {
        //search_grid2_onclick();
    });


    //그리드 조회 함수
    function search_grid1_onclick() {

        //검색데이터
        let selectParam = {}

        //파라미터
        let selectData = {
            sectionId: sectionId,
            component: pgId + "_grid1",
            param: selectParam,
        }

        we_select(selectData, {
            successSelect: (json) => {
                let data = json.DATA;
                //그리드 데이터 세팅
                AUIGrid.setGridData(grid1, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(grid1, focus, 0);
                focus = 0;
            }
        });
    }

    function search_grid2_onclick() {

        //검색데이터
        let selectParam = {
            CODEDV_NO: AUIGrid.getSelectedRows(grid1)[0].DONG_ID
        }

        //파라미터
        let selectData = {
            sectionId: sectionId,
            component: pgId + "_grid2",
            param: selectParam,
        }

        we_select(selectData, {
            successSelect: (json) => {

            }
        });
    }

    function aptBlock_make(data) {
        let higher = Number(data[0].HIGHER_FLOOR)
        for (let i = higher; i >= 1; i--) {
            let tr = document.createElement('tr');
            data.forEach(row => {
                let td = document.createElement('td');
                if (Number(row.END_FLOOR) >= i >= Number(row.START_FLOOR)) {
                    switch (true) {
                        case (i == row.END_FLOOR && row.EL_CNT == "Y") :
                            if(LINE_GBN = "step"){
                                td.className = "el_block step_block";
                            }else{
                                td.className = "el_block ho_block";
                            }
                            td.innerHTML = "EL"
                            td.id = i.toString() + "_el";
                            break;
                        case (i == row.END_FLOOR && row.ROOFTOP_CNT == "Y") :
                            if(LINE_GBN = "step"){
                                td.className = "rooftop_block step_block";
                            }else{
                                td.className = "rooftop_block ho_block";
                            }
                            td.innerHTML = "루프탑"
                            td.id = i.toString() + "_rooftop";
                            break;
                        case (i == row.START_FLOOR && row.DOOR_CNT == "Y") :
                            if(LINE_GBN = "step"){
                                td.className = "door_block step_block";
                            }else{
                                td.className = "door_block ho_block";
                            }
                            td.innerHTML = "현관"
                            td.id = i.toString() + "_door";
                            break;
                        case (row.LINE_GBN == "step") :
                            td.className = "step_block";
                            td.innerHTML = "계단"
                            td.id = i.toString() + "_step";
                            break;
                        default :
                            td.className = "ho_block";
                            td.innerHTML = row.DONG_NAME;
                            td.id = i.toString() + row.HO_NO;
                            break;
                    }
                } else {
                    td.className = "blank_block";
                }
                tr.appendChild(td);
            })
            dong_table.appendChild(tr);
        }
        let rower = Number(data[0].LOWER_FLOOR)
        for (let i = 1; i > rower; i++) {
            let tr = document.createElement('tr');
            let td = document.createElement('td');
            td.className = "underground_block";
            td.innerHTML = "지하주차장(동지하 포함)"
            td.id = i.toString() + "_underground";
            tr.appendChild(td);
            dong_table.appendChild(tr);
        }
    }

    dong_table.addEventListener('click', (e) => {
        if(e.target.tagName == "TD"){
            let tdId = e.target.id
            if(!tdId.includes("_")){
                let item = {
                    pgId : pgId,
                    menuId : menuId,
                    querySet : "min001",
                }
                pop_onload(pop_item);
            }else {

            }
        }
    })


    //컴포넌트 필수항목 입력 체크
    function requireCheck(require) {
        let isValid = true;
        switch (require) {
        }
        return isValid;
    }

    //crud 권한 처리 함수
    function checkCrudPermission(pgId) {
        we_checkCrudPermission(pgId, {
            successPer: (data) => {
                //권한에 따라 버튼 숨김
                btnPermission(data)
            }
        });
    }

    //로드
    window.onload = function () {
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        //btnMaker({ tag: "#section_middle_btn1", grid:"grid1", add: true, save: true});
        //btnMaker({ tag: "#section_middle_btn2", grid:"grid2", add: true, save: true});
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        //로드 시 그리드 바로 조회
        search_grid1_onclick();
    };

</script>


<%@ include file="../../inc_footer.jsp" %>