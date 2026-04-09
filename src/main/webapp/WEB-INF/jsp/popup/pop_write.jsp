<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div class="layer_bg" id="pop_write">
        <div class="popup" style="width:910px;">
            <div class="pop_title0" >
                <span id="board_id"></span>  <%-- 각 게시판 메뉴명--%>
                <div class="section1_btn" id="pop_btn"></div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <span>제목 :&nbsp;
                        <input type="text" name="BOARD_TITLE" id="board_title" class="box_width450">
                    </span>
                    <span>&ensp;작성자 :&nbsp;
                        <input type="text" name="BOARD_WRITER" id="board_writer" class="box_width100" disabled>
                    </span>
                    <span>&ensp;작성일 :&nbsp;
                        <input type="date" name="BOARD_DATE" id="board_date" data-format="date" disabled>
                    </span>
                </div>
            </div>
            <div>
                <textarea class="pop_write_textarea" name="BOARD_CONTENT" id="board_content" data-format="html"></textarea>
            </div>
            <input type="text" name="BOARD_NO" id="board_no" hidden="hidden">
            <input type="text" name="USER_ID" id="user_id" hidden="hidden">
            <%--여러 파일 업로드 및 삭제 input_file.html 참조--%>

            <div class="pop_title0" >
                <span>첨부파일</span>  <%-- 각 게시판 메뉴명--%>
                <div class="section1_btn" id="pop_btn2">
            </div>
            <div id="file_grid1"></div>
            <input type="file" id="fileSelector" hidden />
        </div>
    </div>

    <script>

        const pop_btn = document.querySelector("#pop_btn"); //팝업버튼 컴포넌트
        const board_id = document.querySelector("#board_id"); //팝업 컴포넌트
        const board_title = document.querySelector("#board_title"); //팝업 컴포넌트
        const board_writer = document.querySelector("#board_writer"); //팝업 컴포넌트
        const board_date = document.querySelector("#board_date"); //팝업 컴포넌트
        const board_content = document.querySelector("#board_content"); //팝업 컴포넌트
        const board_no = document.querySelector("#board_no"); //팝업 컴포넌트
        const user_id = document.querySelector("#user_id"); //팝업 컴포넌트

        let file_grid1;	// 그리드 컴포넌트
        let file_focus = 0;	//그리드 컴포넌트 포커스
        const fileSelector = document.querySelector("#fileSelector"); //팝업-첨부파일 컴포넌트

        //파일 저장 캐시
        let orgFileNm = {};
        let newfiles = [];
        // 최근 그리드 파일 선택 행 아이템 보관 변수
        let recentGridItem = null;

        //그리드 설정
        const fileGrid1ColumnLayout = [
            { dataField: "BOARD_DIV",
                visible : false
            },
            { dataField: "BOARD_NO",
                visible : false
            },
            { dataField: "ATT_NO",
                visible : false
            },
            { dataField: "SYS_FILE_NM",
                visible : false
            },
            { dataField: "FILE_PATH",
                visible : false
            },
            { dataField: "FILE_NM",
                headerText: "제목",
                dataType: "text",
                width : "*%",
                style : "text-align-left",
                editable : false
            },
            {
                dataField: "FILE_SIZE",
                headerText: "파일크기",
                width: "20%",
                style: "align_right",
                editable : false,
                dataType: "numeric", <%-- 데이터타입 설정 필수 --%>
                formatString: "#,###.###", <%-- formatString 설정 필수 --%>
                renderer: {
                    type: "TemplateRenderer",
                    aliasFunction: function(rowIndex, columnIndex, value, headerText, item) { <%-- 엑셀, PDF 등 내보내기 시 값 가공 함수 --%>
                        return value;
                    }
                },
                labelFunction: function(rowIndex, columnIndex, value, headerText, item) { <%--HTML 템플릿 작성 --%>
                    let isMiB = Number(value) / 1024 / 1024 >= 1;
                    return isMiB ? String(Math.ceil(Number(value) / 1024 / 1024 * 100) / 100) + "MB" : String(Math.ceil(Number(value) / 1024 * 100) / 100) + "KB";
                }
            },
            {
                dataField: "",
                width: "10%",
                renderer: {
                    type: "ButtonRenderer",
                    labelText: "다운로드",
                    onClick: function (event) {
                        file_down_onclick(event.item);
                    }
                }
            }
        ];

        //그리드 생성
        file_grid1 = AUIGrid.create("#file_grid1", fileGrid1ColumnLayout,
            Object.assign({}, we_file_Props,
                {})
        );

        function search_file1_onclick(){

            //검색데이터
            let param = {
                BOARD_DIV : board_div,
                BOARD_NO : board_no.value,
            }

            //파라미터
            let selectData = {
                sectionId : sectionId,
                component : pgId + "_file1",
                param: param,
            }

            we_select( selectData,{
                successSelect : (json) => {
                    let data = json.DATA;
                    data.forEach(row => {
                        orgFileNm.ATT_NO = row.FILE_NM
                    });

                    AUIGrid.setGridData(file_grid1, data);
                    AUIGrid.setSelectionByIndex(file_grid1, file_focus, 0);
                    file_focus = 0;
                }
            });
        }

        function add_file1_onclick() {
            // 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
            AUIGrid.forceEditingComplete(file_grid1, null);
            //새행 만들기
            const item = {};
            item.BOARD_DIV = board_div;
            item.BOARD_NO = board_no.value;
            AUIGrid.addRow(file_grid1, item, "selectionDown");
            fileSelector.click(); // 파일 브라우저 열기
        }

        fileSelector.onchange = () => {
            let files =  Array.from(fileSelector.files);
            newfiles = newfiles.concat(files); // 누적 저장

            <%-- 업데이트 할 필드와 값 설정 --%>
            let item = new Object();
            item.FILE_NM = files[0].name;
            item.FILE_SIZE = files[0].size;
            AUIGrid.updateRow(file_grid1, item, "selectedIndex");

            alert("저장 버튼을 클릭 시 새로 등록한 첨부파일이 저장됩니다.");
        };


        function save_file1_onclick() {
            if(isNull(newfiles)){
                alert("새롭게 저장할 첨부파일이 없습니다.");
                return;
            }

            let saveParam = [];
            //파라미터
            let saveData  = {
                sectionId : sectionId,
                component : pgId + "_file1",
                param : saveParam,
            }

            for (let i = 0; i < newfiles.length; i++) {
                let file = newfiles[i];
                let formData = new FormData();

                formData.set("BOARD_DIV", board_div);
                formData.set("BOARD_NO", board_no.value);
                formData.set("FILE_NM", file.name);
                formData.set("FILEDATA", file);
                formData.set("FILE_SIZE", file.size);

                saveParam.push(formData);
            }

            we_fileSave(saveData ,{
                successFileSave : (data) => {
                    if(newfiles.length == data){
                        alert("총 " + data + "건의 첨부파일을 저장하였습니다.");
                        fileSelector.value = '';
                        search_file1_onclick();
                    }
                }
            });

        }

        function delete_file1_onclick(){
            const checkedItems = AUIGrid.getCheckedRowItems(file_grid1);

            let itemCount = checkedItems.length;
            if (itemCount=== 0) {
                alert("체크된 항목이 없습니다");
                return;
            }

            let delItemsName = checkedItems.map(row => row.item.FILE_NM).join(", ");
            if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return;

            //포커스 지정
            file_focus = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1)

            // 체크된 행 삭제 처리
            AUIGrid.removeCheckedRows(file_grid1);
            // 삭제된 행 아이템들(배열) -> 삭제 데이터

            let newDel = [];
            let deleteParam = [];

            checkedItems.forEach( row => {
                if(AUIGrid.isAddedByRowIndex(file_grid1, row.rowIndex)){
                    newDel.push(row.item)
                }else{
                    deleteParam.push(row.item)
                }
            })

            if(!isNull(newDel)){
                newfiles = newfiles.filter(file =>
                    !newDel.some(del => del.FILE_NM === file.FILE_NM)
                );
            }
            if(!isNull(deleteParam)){
                let deleteData = {
                    sectionId :  sectionId,
                    component : pgId + "_grid1",
                    param : deleteParam,
                }

                we_fileDelete(deleteData,{
                    successFileDelete : (data) => {
                        if(itemCount == data) {
                            alert("총 " + data + "건의 첨부파일을 삭제하였습니다.");
                            search_file1_onclick();
                        }
                    }
                });

            }
        }


        function file_down_onclick(item) {
            let selectRowItem = AUIGrid.getSelectedRows(grid1)[0];
            let Data = {
                sectionId : sectionId,
                component : pgId + "_grid1",
                param : selectRowItem,
            }

            we_fileDown(sectionId,{
                successFileDown : (data) => {
                    if(data > 0) {

                    }
                }
            });
        }

        function pop_onload(pop_item){

            board_id.innerHTML = pop_item.pop_title;
            file_path = pop_item.pop_file_path;

            btnMaker({ tag: "#pop_btn", grid: "board1", save : true, del : true});
            pop_btn.insertAdjacentHTML("beforeend",
                "<button id='close_btn1' class='btn_left3' onclick='close_popup_onclick()'>닫기</button>");

            btnMaker({ tag: "#pop_btn2", grid: "file1", add : true, save : true, del : true});

            if(!isNull(pop_item.btnHidden)){
                btnHidden(pop_item.btnHidden, pop_item.popupId);
            }

            if(!isNull(pop_item.disabled)){
                disableInput(pop_item.popupId);
            }

        }

    </script>
                
                        
   

 
