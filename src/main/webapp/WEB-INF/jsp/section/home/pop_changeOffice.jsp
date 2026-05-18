<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div class="layer_bg" id="pop_changeOffice">
        <div class="popup" style="width:600px;">
            <div class="pop_title" style="border:none" >&#10004; &nbsp;관리소 검색</div>
            <span>&emsp;&#9726&nbsp;관리소명(코드 외) :&nbsp;</span>
            <span><input type="text" id="search_officeName" name="officeName" style="width:250px;"></span>
            <div class="section_middle_btn" id="pop_changeOffice_btn"></div>
            <div id="officeGrid1"></div>
        </div>
    </div>

<script>
    const pop_changeOffice = "pop_changeOffice";
    const pop_changeOffice_btn = document.querySelector("#pop_changeOffice_btn");
    const search_officeName = document.querySelector("#search_officeName"); //search 컴포넌트

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
            })
    );
    
    

    //그리드 조회 함수
    function search_officeGrid1_onclick(){

        //검색데이터
        let selectParam = {
            OFFICE_NAME : search_officeName.value,
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pop_changeOffice + "_officeGrid1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                //그리드 데이터 세팅
                AUIGrid.setGridData(officeGrid1, data);
                //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
                AUIGrid.setSelectionByIndex(officeGrid1, focus, 0);
                focus = 0;
            }
        });
    }


    function pop_onload(){
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#pop_changeOffice_btn", grid: "officeGrid1", search : true});
        pop_changeOffice_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");

        //공통코드 가져오기
        search_officeGrid1_onclick();

    }



</script>

