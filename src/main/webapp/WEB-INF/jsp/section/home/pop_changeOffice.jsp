<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div class="layer_bg" id="pop_changeOffice">
        <div class="popup" style="width:600px;">
            <div class="pop_title" style="border:none" >&#10004; &nbsp;관리소 검색</div>
            <span>&emsp;&#9726&nbsp;관리소명(코드 외) :&nbsp;</span>
            <span><input type="text" id="search_officeName" name="OFFICE_NAME" style="width:250px;"></span>
            <div class="section_middle_btn" id="pop_changeOffice_btn"></div>
            <div id="officeGrid1"></div>
            <form id="changeOffice_form" method="post" action="/changeOffice">
                <input type="text" id="input_officeCode" name="OFFICE_CODE" hidden="hidden">
            </form>
        </div>
    </div>

<script>
    const pop_changeOffice = "pop_changeOffice";
    let officeGrid1;	// 그리드 컴포넌트
    const pop_changeOffice_btn = document.querySelector("#pop_changeOffice_btn");
    const search_officeName = document.querySelector("#search_officeName"); //search 컴포넌트
    const input_officeCode = document.querySelector("#input_officeCode");
    const changeOffice_form = document.querySelector("#changeOffice_form");

    const officeGrid1ColumnLayout = [
        { dataField: "OFFICE_CODE",
            headerText: "단지코드",
            dataType: "text",
            width : "20%",
        },
        { dataField: "OFFICE_NAME",
            headerText: "관리소명",
            dataType: "text",
            width : "*%",
        },
        { dataField: "TEL",
            headerText: "전화번호",
            dataType: "text",
            width : "20%",
        },
        { dataField: "CONT_KIND_NM",
            headerText: "계약유형",
            dataType: "text",
            width : "20%",
        },
    ];

    //그리드 생성
    officeGrid1 = AUIGrid.create("#officeGrid1", officeGrid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                height : 300,
                editable : false,
                showRowNumColumn: false,
                rowCheckToRadio : true
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(officeGrid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(officeGrid1, event.rowIndex);
    });

    //팝업 닫기 이벤트
    function close_changeOffice_onclick(){
        popupClose(pop_changeOffice);
        clearInput(pop_changeOffice);
    }

    //그리드 조회 함수
    function search_officeGrid1_onclick(){

        //검색데이터
        let selectParam = {
            OFFICE_NAME : search_officeName.value,
        }

        const controller = new AbortController();
        const timer = setTimeout(() => controller.abort(), 60_000);

        try {
            const query = new URLSearchParams(selectParam)

            const res = fetch(
                ctx + "/selectOffice/" + "?" + query,
                {
                    method: "GET",
                    headers: {
                        "Accept": "application/json",
                    },
                    credentials: "include",
                    signal: controller.signal
                });
            if (!res.ok) {
                alert("요청이 실패하였습니다");
                return;
            }
            const data = res.json();
            //그리드 데이터 세팅
            AUIGrid.setGridData(officeGrid1, data);
            //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
            AUIGrid.setSelectionByIndex(officeGrid1, 0, 0);

        } catch (err) {
            if (err.name === "AbortError") {
                console.error("요청 타임아웃");
                alert("조회 시간이 초과되었습니다");
            } else {
                console.error(err);
                alert("조회에 실패하였습니다");
            }
            throw err;

        } finally {
            clearTimeout(timer);
            //로딩종료
        }
    }

    function select_officeGrid1_onclick(){

        if(!confirm("'" + AUIGrid.getSelectedRows(grid1)[0].OFFICE_NAME + "' 관리소로 변경하시겠습니까?")) return;

        input_officeCode.value = AUIGrid.getSelectedRows(grid1)[0].OFFICE_CODE;

        changeOffice_form.submit();

    }

    function changeOffice_onload(){
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#pop_changeOffice_btn", grid: "officeGrid1", search : true});
        pop_changeOffice_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='select_officeGrid1_onclick()'>선택</button>" +
            "<button id='close_btn1' class='btn_left3' onclick='close_changeOffice_onclick()'>닫기</button>");


        search_officeGrid1_onclick();

    }



</script>

