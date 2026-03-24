<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../../inc_head.jsp" %>
<%@ include file="../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/minwon/min_nav.jsp"/>

<style>
    .step_block {
        border: 1px solid #bcbcbc;
        background-color: #f4e1d6;
        height: 30px;
        weight: 30px;
    }

    .ho_block {
        border: 1px solid #bcbcbc;
        background-color: #f4e1d6;
        height: 30px;
        weight: 60px;
    }

    .el_block {
    }

    .rooftop_block {
    }

    .door_block {
    }

    .cb_block {
        border: 1px solid #bcbcbc;
        background-color: #f4e1d6;
        height: 30px;
        weight: 80px;
    }

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
        <jsp:include page="/WEB-INF/jsp/section/minwon/pop_min_daejang.jsp"/>
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
                dataField: "VIEW_GBN",
                dataType: "text",
                visible: false
            },
            {
                dataField: "DONG_ID",
                dataType: "text",
                visible: false
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
            search_aptBlock_onclick();
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

        function search_aptBlock_onclick() {

            //검색데이터
            let selectParam = {
                DONG_ID: AUIGrid.getSelectedRows(grid1)[0].DONG_ID
            }

            let viewGbn = AUIGrid.getSelectedRows(grid1)[0].VIEW_GBN;

            let component = ""
            if (viewGbn = "108001") {
                component = "_apt"
            } else if (viewGbn = "108003") {
                component = "_etc"
            } else {
                component = "_cb"
            }

            //파라미터
            let selectData = {
                sectionId: sectionId,
                component: pgId + component,
                param: selectParam,
            }

            we_select(selectData, {
                successSelect: (json) => {
                    let data = json.DATA;
                    if (viewGbn = "108001") {
                        apt_block_make(data);
                    } else if (viewGbn = "108003") {
                        etc_block_make(data);
                    } else {
                        cb_block_make(data);
                    }
                }
            });
        }

        function apt_block_make(data) {
            let dongName = AUIGrid.getSelectedRows(grid1)[0].DONG_NAME
            dong_table.innerHTML = ""
            let floors = Number(data[0].FLOORS);
            let dataLength = data.length;
            for (let i = floors; i >= 1; i--) {
                let tr = document.createElement('tr');
                data.forEach(row => {
                    let rooftopCnt = Number(row.ROOFTOP_CNT);
                    let elCnt = Number(row.EL_CNT);
                    let endFloor = Number(row.END_FLOOR)
                    let td = document.createElement('td');
                    if ((elCnt + rooftopCnt + endFloor) >= i && i >= Number(row.START_FLOOR)) {
                        switch (true) {
                            case (i > endFloor && i <= endFloor + rooftopCnt) :
                                if (row.LINE_GBN == "109002") {
                                    td.className = "rooftop_block step_block";
                                } else {
                                    td.className = "rooftop_block ho_block";
                                }
                                td.innerHTML = "루프탑"
                                td.id = dongName + "-" + i.toString() + row.HO_NO + "_rooftop";
                                break;
                            case (i > endFloor && i <= endFloor + rooftopCnt + elCnt) :
                                if (row.LINE_GBN == "109002") {
                                    td.className = "el_block step_block";
                                } else {
                                    td.className = "el_block ho_block";
                                }
                                td.innerHTML = "EL"
                                td.id = dongName + "-" + i.toString() + row.HO_NO + "_el";
                                break;
                            case (i == row.START_FLOOR && row.DOOR_CNT == "1") :
                                if (row.LINE_GBN == "109002") {
                                    td.className = "door_block step_block";
                                } else {
                                    td.className = "door_block ho_block";
                                }
                                td.innerHTML = "현관"
                                td.id = dongName + "-" + i.toString() + row.HO_NO + "_door";
                                break;
                            case (row.LINE_GBN == "109002") :
                                td.className = "step_block";
                                td.innerHTML = "계단"
                                td.id = dongName + "-" + i.toString() + row.HO_NO + "_step";
                                break;
                            default :
                                td.className = "ho_block";
                                td.innerHTML = row.HO_NM;
                                td.id = dongName + "-" + i.toString() + row.HO_NO + "_ho";
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
            for (let i = 1; i <= rower; i++) {
                let tr = document.createElement('tr');
                let td = document.createElement('td');
                td.className = "underground_block";
                td.rowSpan = dataLength;
                td.innerHTML = "지하주차장(동지하 포함)"
                td.id = dongName + "-" + i.toString() + row.HO_NO + "_underground";
                tr.appendChild(td);
                dong_table.appendChild(tr);
            }
        }

        function cb_block_make(data) {
            dong_table.innerHTML = ""
            let higher = Math.ceil(data.length / 4);
            for (let i = 0; i < higher; i++) {
                let tr = document.createElement('tr');
                for (let l = 0; i < 3; i++) {
                    let td = document.createElement('td');
                    id.className = "cb_block";
                    td.innerHTML = data.HO_NM
                    td.id = dongName + "-" + i.toString() + row.HO_NO + "_cb";
                    tr.appendChild(td);
                }
                dong_table.appendChild(tr);
            }
        }

        function etc_block_make(data) {
            dong_table.innerHTML = ""
            for (let i = 0; i < higher; i++) {
                let tr = document.createElement('tr');
                for (let l = 0; i < 3; i++) {
                    let td = document.createElement('td');
                    id.className = "cb_block";
                    td.innerHTML = data.AREAR_NAME
                    td.id = data.MINWON_AREAR_SEQ
                    tr.appendChild(td);
                }
                dong_table.appendChild(tr);
            }
        }


        dong_table.addEventListener('click', (e) => {
            let viewGbn = AUIGrid.getSelectedRows(grid1)[0].VIEW_GBN;
            if (e.target.tagName == "TD") {
                let tdId = e.target.id
                let item = {
                    pgId: pgId,
                    menuId: menuId,
                    querySet: "min001",
                    pop_data: pop_data = {}
                }
                if (viewGbn == "108001") {
                    let gbn = tdId.slice("_")[1]
                    let dongId = tdId.slice("_")[0]
                    switch (true) {
                        case (gbn == "ho"):
                            pop_data.GBN = "1"
                            pop_data.LINE_GBN = "109001"
                            break;
                        case (gbn == "step"):
                            pop_data.GBN = "2"
                            pop_data.LINE_GBN = "109002"
                            break;
                        case (gbn == "el"):
                            pop_data.GBN = "3"
                            pop_data.LINE_GBN = "109997"
                            break;
                        case (gbn == "rooftop"):
                            pop_data.GBN = "4"
                            pop_data.LINE_GBN = "109998"
                            break;
                        case (gbn == "underground"):
                            pop_data.GBN = "5"
                            pop_data.LINE_GBN = "109999"
                            break;
                        case (gbn == "door"):
                            pop_data.GBN = "21"
                            pop_data.LINE_GBN = "109003"
                            break;
                    }
                } else if (viewGbn == "108003") {
                    pop_data.MINWON_AREAR_SEQ = tdId
                } else {

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
            //crud 권한 처리 함수
            checkCrudPermission(pgId);
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        };

    </script>


<%@ include file="../../inc_footer.jsp" %>