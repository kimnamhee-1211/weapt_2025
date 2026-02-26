<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/sojang/soj_nav.jsp" />

	<div id="section">
		<div class="section1">
	     	<div class="section1_nav">
	         	<i class="icon-star-filled"></i>메뉴관리
	     	</div>
		     <div class="section1_btn" id="section1_btn"></div>
		</div>
		<div class="section2">
		    <div class="section2_line1">
				<span class="search-box">메뉴명 :&nbsp;
					<input type="text" id="search_menuName" class="search-txt100">
				</span>
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
        const pgId = "${pgId}";	//프로그램ID
        let grid1;	// 그리드 컴포넌트
        let focus = 0;	//그리드 컴포넌트 포커스
		const search_menuName = document.querySelector("#search_menuName")	//select 컴포넌트 : 메뉴명


        //그리드 설정
        const grid1ColumnLayout = [
			{ dataField: "MENU_NAME",
				headerText: "메뉴명",
				dataType: "text",
				width : "*%",
				style : "text-align-left",
			},
            { dataField: "MENU_ID",
                headerText: "메뉴ID",
				dataType: "text",
				width : "15%",
			},
			{ dataField: "PG_ID",
                headerText: "프로그램ID",
				dataType: "text",
				width : "15%",
			},
			{ dataField: "MENU_GROUP",
				headerText: "메뉴그룹",
				dataType: "text",
				width : "10%",
				editRenderer : {
					type : "InputEditRenderer",
					onlyNumeric : true, // 0~9 까지만 허용
					maxlength : 3
				}
			},
            { dataField: "M_LEVEL",
                headerText: "레벨",
				dataType: "text",
				width : "8%",
				editRenderer : {
					type : "InputEditRenderer",
					onlyNumeric : true, // 0~9 까지만 허용
					maxlength : 1,
					validator : function(oldValue, newValue, item, dataField, fromClipboard, which) { //유효성 검증
						let isValid = false;
						let numVal = Number(newValue);
						if(!isNaN(numVal) && numVal < 4) {
							isValid = true;
						}
						return { "validate" : isValid, "message" : "메뉴 레벨은 1, 2, 3만 제공됩니다." };
					}
				}
			},
            { dataField: "LEVEL_ORDER",
                headerText: "레벨순서",
                dataType: "text",
				width : "8%",
			},
            { dataField: "UP_MENU_ID",
                headerText: "상위메뉴",
				dataType: "text",
				width : "15%",
				editRenderer : {
					type : "InputEditRenderer",
					onlyNumeric : true, // 0~9 까지만 허용
					maxlength : 9
				}
			},
			{ dataField: "FORM_USE",
				headerText: "사용유무",
				width : "10%",
				renderer : we_cb_10_Renderer
			}
        ];

		//그리드 생성
		grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
			Object.assign({}, we_grid_Props,
				{
					showRowNumColumn: false,
					// 일반 데이터를 트리로 표현할지 여부(treeIdField, treeIdRefField 설정 필수)
					flat2tree: true,
					// 트리의 고유 필드명
					treeIdField: "MENU_ID",
					// 계층 구조에서 내 부모 행의 treeIdField 참고 필드명
					treeIdRefField: "UP_MENU_ID",
					// 최초 보여질 때 모두 열린 상태로 출력 여부
					displayTreeOpen : true,
					// 트리 의존적인 경우, 부모를 체크하면 자식도 체크됨.
					rowCheckDependingTree: true
				})
		);

		//그리드 이벤트
		//체크박스 클릭 시
		AUIGrid.bind(grid1, "rowCheckClick", function(event) {
			AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
		});

		//그리드 조회 함수
        function search_grid1_onclick(){

			//검색데이터
			let selectParam = {
				MENU_NAME : search_menuName.value,
			}

            //파라미터
            let selectData = {
				sectionId : sectionId,
                component : pgId + "_grid1",
                param: selectParam,
            }

            we_select( selectData,{
                successSelect : (data) => {
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
			// 그리드의 편집 인푸터가 열린 경우 에디팅 완료 상태로 만듬.
			AUIGrid.forceEditingComplete(grid1, null);
			//새행 만들기
			let selectRowItem = AUIGrid.getSelectedRows(grid1)[0];
			const item = {};
			item.MENU_GROUP = selectRowItem.MENU_GROUP;
			item.M_LEVEL = selectRowItem.M_LEVEL;
			item.UP_MENU_ID = selectRowItem.UP_MENU_ID;
			//let rowIndex = selctItsems.rowIndex + 1;
			//AUIGrid.addTreeRowByIndex(grid1, item, rowIndex, "selectionDown");
			AUIGrid.addRow(grid1, item, "selectionDown");
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
				alert("변경사항 저장은 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)")
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
				key : [],
				before : {}
			}

			//파라미터
			let saveData  = {
				sectionId :  sectionId,
				component : pgId + "_grid1",
				param: saveParam,
			}

			we_save( saveData ,{
				successSave : (data) => {
					alert(data.O_MSG);
					if(data.O_RESULT > 0){
						search_grid1_onclick()
					}else return;
				}
			});
		}

		//그리드 삭제 함수
		function delete_grid1_onclick(){

			//검증
			const checkedItems = AUIGrid.getCheckedRowItems(grid1);
			let itemCount = checkedItems.length;
			if (itemCount=== 0) {
				alert("체크된 항목이 없습니다");
				return;
			}
			if(itemCount > 100){
				alert("삭제는 최대 100건까지만 가능합니다. (현재 " + itemCount + "건)")
				return;
			}
			let delItemsName = checkedItems.map(row => row.item.MENU_NAME).join(", ");
			if (!confirm( delItemsName + "을/를(총 " + itemCount +"건) 삭제하시겠습니까?")) return

			//포커스 지정
			focus = (checkedItems[0].rowIndex -1) < 1 ? 0 : (checkedItems[0].rowIndex -1)

			// 체크된 행 삭제 처리
			AUIGrid.removeCheckedRows(grid1);

			// 삭제된 행 아이템들(배열) -> 삭제 데이터
			let param = {
				deleteParam : AUIGrid.getRemovedItems(grid1),
				before : {}
			};

			//공통 저장 트렌젝션용 데이터
			let deleteData = {
				sectionId :  sectionId,
				component : pgId + "_grid1",
				param : param,
			}

			we_delete(deleteData,{
				successDelete : (data) => {
					alert(data.O_MSG);
					if(data.O_RESULT > 0){
						search_grid1_onclick();
					}else return;
				}
			});
		}

		//컴포넌트 필수항목 입력 체크
		function requireCheck(require){
			let isValid = true;
			switch(require){
				case "SAVE_GRID1":
					let addedRowItems = AUIGrid.getAddedRowItems(grid1);
					let editedRowItems = AUIGrid.getEditedRowItems(grid1);
					let items = [...addedRowItems,...editedRowItems];
					for(const row of items){
						if(isNull(row.MENU_GROUP)){
							alert("메뉴그룹은 반드시 입력해야 합니다.");
							isValid = false;
							break;
						}
						if(isNull(row.MENU_ID)) {
							alert("메뉴ID는 반드시 입력해야 합니다.");
							isValid = false;
							break;
						}if(isNull(row.MENU_NAME)){
							alert("메뉴명은 반드시 입력해야 합니다.");
							isValid = false;
							break;
						}
						if(isNull(row.M_LEVEL)){
							alert("레벨은 반드시 입력해야 합니다.");
							isValid = false;
							break;
						}
						if(isNull(row.LEVEL_ORDER)){
							alert("레벨순서는 반드시 입력해야 합니다.");
							isValid = false;
							break;
						}
					}
					break;
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
			btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, add: true, del: true, save: true});
			//crud 권한 처리 함수
			checkCrudPermission(pgId);
			//로드 시 그리드 바로 조회
			search_grid1_onclick();
		};

	</script>




    
<%@ include file = "../../inc_footer.jsp" %>