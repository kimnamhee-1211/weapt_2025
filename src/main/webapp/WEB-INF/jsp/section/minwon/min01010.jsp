<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../../inc_head.jsp" %>
<%@ include file="../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/minwon/min_nav.jsp"/>

<style>

    #dong_table{ border-collapse : collapse; }
    
    #dong_table .blank_block{
        border : none;
        height: 20px;
        font-size: 11px;

    }
    #dong_table .step_block {
        border: 1px solid #bcbcbc;
        background-color: #f4e1d6;
        height: 20px;
        width: 40px;
        font-size: 11px;
    }

    #dong_table .ho_block {
        border: 1px solid #bcbcbc;
        background-color: #f4e1d6;
        height: 20px ;
        width: 60px;
        font-size: 11px;
    }

    #dong_table .el_block {
    }

    #dong_table .rooftop_block {
    }

    #dong_table .door_block {
    }

    #dong_table .underground_block{
        border: 1px solid #bcbcbc;
        background-color: lightgrey;
        font-size: 11px;
        height: 20px ;
    }

    #dong_table .cb_block {
        border: 1px solid #bcbcbc;
        background-color: #f4e1d6;
        height: 30px;
        width: 80px;
    }

    #dong_table .etc_block {
        border: 1px solid #bcbcbc;
        background-color: #f4e1d6;
        height: 30px;
        width: 140px;
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
        <div id="apt_block" class="gridcont_right_970"
             style="height: 652px; border: 1px solid #bcbcbc; display: flex; justify-content: center; align-items: center;">
            <table id="dong_table"></table>
        </div>
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
                    editable: false,
                    height: 652,
                })
        );

        //그리드 이벤트
        AUIGrid.bind(grid1, "cellClick", function(event) {
            search_aptBlock_onclick();
        });

        //팝업 이벤트

        //팝업 닫기 이벤트
        function close_popup_onclick(){
            popupClose(popupId);
            clearInput(popupId);
        }

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
                    AUIGrid.setSelectionByIndex(grid1, 0, 0);
                    search_aptBlock_onclick();
                }
            });
        }

        function search_aptBlock_onclick() {
            let viewGbn = AUIGrid.getSelectedRows(grid1)[0].VIEW_GBN;
            //검색데이터
            let selectParam = {
                DONG_ID: AUIGrid.getSelectedRows(grid1)[0].DONG_ID
            }

            let component = ""
            if (viewGbn == "108001") {
                component = "_apt"
            } else if (viewGbn == "108002") {
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
                    if (viewGbn == "108001") {
                        apt_block_make(data);
                    } else if (viewGbn == "108002") {
                        etc_block_make(data);
                    } else {
                        cb_block_make(data);
                    }
                }
            });
        }

        //아파트
        function apt_block_make(data) {
            let dongName = AUIGrid.getSelectedRows(grid1)[0].DONG_NAME;
            let dongid = AUIGrid.getSelectedRows(grid1)[0].DONG_ID;
            let viewGbn = AUIGrid.getSelectedRows(grid1)[0].VIEW_GBN;
            dong_table.innerHTML = ""

            //지상
            let floors = Math.max(...data.map(row => Number(row.FLOORS)));
            let dataLength = data.length;
            let el_cnt = 1;
            let rooftop_cnt = 1;
            for (let i = floors; i >= 1; i--) {
                let tr = document.createElement('tr');
                data.forEach(row => {
                    let rooftopCnt = Number(row.ROOFTOP_CNT);
                    let elCnt = Number(row.EL_CNT);
                    let endFloor = Number(row.END_FLOOR)
                    let td = document.createElement('td');
                    if ((elCnt + rooftopCnt + endFloor) >= i && i >= Number(row.START_FLOOR)) {
                        switch (true) {
                            case (i > endFloor && i <= endFloor + elCnt) :
                                if (row.LINE_GBN == "109002") {
                                    td.className = "el_block step_block";
                                } else {
                                    td.className = "el_block ho_block";
                                }
                                td.innerHTML = "EL"
                                td.dataset.gbn = "1";
                                td.dataset.lineGbn = "109997";
                                td.dataset.lineGbnNm = "EL";
                                if(elCnt > 1 && el_cnt <= elCnt){
                                    td.innerHTML = "EL" + el_cnt
                                    el_cnt ++
                                }
                                break;
                            case (i > endFloor && i <= endFloor + elCnt + rooftopCnt) :
                                if (row.LINE_GBN == "109002") {
                                    td.className = "rooftop_block step_block";
                                } else {
                                    td.className = "rooftop_block ho_block";
                                }
                                td.innerHTML = "루프탑"
                                td.dataset.gbn = "1";
                                td.dataset.lineGbn = "109998";
                                if(rooftopCnt > 1 && el_cnt <= rooftopCnt){
                                    td.innerHTML = "루프탑" + rooftop_cnt
                                    rooftop_cnt ++
                                }
                                break;
                            case (i == row.START_FLOOR && row.DOOR_CNT == "1") :
                                if (row.LINE_GBN == "109002") {
                                    td.className = "door_block step_block";
                                } else {
                                    td.className = "door_block ho_block";
                                }
                                td.innerHTML = "현관"
                                td.dataset.gbn = "1";
                                td.dataset.lineGbn = "109003";
                                break;
                            case (row.LINE_GBN == "109002") :
                                td.className = "step_block";
                                td.innerHTML = "계단"
                                td.dataset.gbn = "1";
                                td.dataset.lineGbn = "109002";
                                break;
                            default :
                                td.className = "ho_block";
                                td.innerHTML = i.toString() + row.HO_NO;
                                td.dataset.hoName = i.toString() + row.HO_NO;
                                td.dataset.gbn = "0";
                                td.dataset.lineGbn = "109001";
                                break;
                        }
                        td.dataset.hoId = dongName + "-" + i.toString() + row.HO_NO
                        td.dataset.lineNo = row.HO_NO;
                        td.dataset.floor = i.toString();
                        td.dataset.dongId = dongid;
                    } else {
                        td.className = "blank_block";
                    }
                    tr.appendChild(td);
                })
                dong_table.appendChild(tr);
            }
            //지하
            let rower = Number(data[0].LOWER_FLOOR)
            for (let i = 1; i < rower + 1; i++) {
                let tr = document.createElement('tr');
                let td = document.createElement('td');
                td.className = "underground_block";
                td.colSpan = dataLength;
                td.innerHTML = "지하주차장(동지하 포함)"
                td.dataset.hoId = dongName + "-"
                td.dataset.gbn = "1";
                td.dataset.lineGbn = "109999";
                td.dataset.lineGbnNm = "지하주차장";
                td.dataset.floor = i.toString();
                td.dataset.dongName = dongName;
                td.dataset.dongId = dongid;
                td.dataset.viewGbn = viewGbn;
                tr.appendChild(td);
                dong_table.appendChild(tr);
            }
        }

        //상가 -> 수정 필요
        function cb_block_make(data) {
            let dongName = AUIGrid.getSelectedRows(grid1)[0].DONG_NAME
            let dongid = AUIGrid.getSelectedRows(grid1)[0].DONG_ID
            let viewGbn = AUIGrid.getSelectedRows(grid1)[0].VIEW_GBN;
            dong_table.innerHTML = ""
            let higher = Math.ceil(data.length / 4);
            let row = 0
            for (let i = 0; i < higher; i++) {
                let tr = document.createElement('tr');
                for (let l = 0; l < 4; l++) {
                    if(row < data.length){
                        let td = document.createElement('td');
                        id.className = "cb_block";
                        td.innerHTML = data[row].HO_NM
                        td.dataset.hoId = dongName + "-" + i.toString() +  data[row].HO_NO
                        td.dataset.type = "cb";
                        td.dataset.hoNo = data[row].HO_NO;
                        td.dataset.floor = i.toString();
                        td.dataset.lineNo = data[row].LINE_NO;
                        td.dataset.dongName = dongName;
                        td.dataset.dongId = dongid;
                        td.dataset.viewGbn = viewGbn;
                        tr.appendChild(td);
                        row ++;
                    }
                }
                dong_table.appendChild(tr);
            }
        }

        //동외민원
        function etc_block_make(data) {
            let dongName = AUIGrid.getSelectedRows(grid1)[0].DONG_NAME
            let dongid = AUIGrid.getSelectedRows(grid1)[0].DONG_ID
            let viewGbn = AUIGrid.getSelectedRows(grid1)[0].VIEW_GBN;
            dong_table.innerHTML = ""
            let higher = Math.ceil(data.length / 4);
            let row = 0
            for (let i = 0; i < higher; i++) {
                let tr = document.createElement('tr');
                for (let l = 0; l < 4; l++) {
                    if(row < data.length){
                        let td = document.createElement('td');
                        td.className = "etc_block";
                        td.innerHTML = data[row].AREAR_NAME
                        td.dataset.hoId = dongName + "-"
                        td.dataset.minwonArearSeq = data[row].MINWON_AREAR_SEQ
                        td.dataset.gbn = "2";
                        td.dataset.arearName = data[row].AREAR_NAME
                        td.dataset.dongName = dongName;
                        td.dataset.dongId = dongid;
                        td.dataset.viewGbn = viewGbn;
                        tr.appendChild(td);
                        row ++;
                    }
                }
                dong_table.appendChild(tr);
            }
        }

        //클릭시 민원대장("0")/민원전표("1")열기
        dong_table.addEventListener('click', (e) => {
            if (e.target.tagName == "TD" && e.target.className != "blank_block") {
                let pop_data = {...e.target.dataset}
                if(setting[0].VIEW_GBN == "0"){
                    open_popup_onclick(pop_data);
                }else{
                    pop_data.slipNo = null;
                    pop_data.minwonDate = null;
                    open_popup1_onclick(pop_data);
                }
            }
        })

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

            Promise.all([
                getSelect_min_setting()
            ]).then(function () {
                //로드 시 그리드 바로 조회
                search_grid1_onclick();
            })

        };

    </script>


<%@ include file="../../inc_footer.jsp" %>