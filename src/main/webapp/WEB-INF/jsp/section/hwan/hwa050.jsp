<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

            <div class="section2">
                <div class="section2_line1">
                    <span class="search-box">검색조건 :&nbsp;
                        <input type="month" id="search_date" name="DATE">
                    </span>&emsp;
                    <span class="select-container">&emsp;성명 :&nbsp;
                         <input type="text" id="search_name" name="NAME">
                    </span>
                </div>
            </div>
            <div id="grid1"></div>
<script>
    /** 작성 순서
     *
     * 변수 선언 :
     *      pgId, 그리드 컴포넌트, 그리드 컴포넌트 포커스, 입력부 컴포넌트, 팝업 컴포넌트, select 컴포넌트
     * 그리드 설정
     * 그리드 생성
     * 그리드 이벤트 :
     *      체크박스 클릭 시 셀렉트 이벤트, 셀 선택 변경 이벤트, 더블 클릭 시 팝업 오픈 이벤트
     * 팝업 이벤트 : (미사용시 생략)
     * 그리드 조회 함수
     * 그리드 추가 함수    (미사용시 생략)
     * 그리드 저장 함수    (미사용시 생략)
     * 그리드 삭제 함수    (미사용시 생략)
     * 컴포넌트 필수항목 입력 체크    (미사용시 생략)
     * crud 권한 처리 호출 함수
     *
     * 기타
     * 로드 :
     *      기본 crud 버튼 생성
     *      crud 권한 처리 함수 호출
     *      공통코드 가져오기		(미사용시 생략)
     *      그리드 DDL 설정       (미사용시 생략)
     *      (필요 시)그리드 조회 함수 호출    (미사용시 생략)
     *
     */

        //변수 선언
    let empGbm; //메뉴 구분자(청소 : 1 경비 : 2)
    let querySet;
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_date = document.querySelector("#search_date"); //컨트롤 컴포넌트
    const search_name = document.querySelector("#search_name"); //select 컴포넌트

    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "EMP_GBN",
            visible : false
        },
        { dataField: "EMP_NO",
            headerText: "사번",
            dataType: "text",
            width : "7%",
        },
        { dataField: "NAME",
            headerText: "성명",
            dataType: "text",
            width : "10%",
        },
        { dataField: "STATUS",
            headerText: "근무상태",
            dataType: "text",
            width : "7%",
        },
        { dataField: "DEPT_NAME",
            headerText: "부서",
            dataType: "text",
            width : "10%",
        },
        { dataField: "JOB_DUTY_NAME",
            headerText: "직책",
            dataType: "text",
            width : "10%",
        },
        { dataField: "ALL_CNT",
            headerText: "총사용일수",
            dataType: "numeric",
            formatString: "#,##0.0",
            width : "8%",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                editable : false,
                showRowNumColumn: false,
            })
    );

    //그리드 이벤트
    //체크박스 클릭 시
    AUIGrid.bind(grid1, "rowCheckClick", function(event) {
        AUIGrid.setSelectionByIndex(grid1, event.rowIndex, 0);
    });

    async function grid1_column_make(){
        let columns = [];

        let list = await we_getCode('137');
        list.forEach((row, idx)=>{
            let item = {};
            item.dataField  = row.CODE_NO;
            item.headerText = row.CODEDTL_NM;
            item.dataType  = "numeric";
            item.formatString = "#,##0.0";
            item.width = "5%";
            columns.push(item);
        });
        let new_cols = [...grid1ColumnLayout, ...columns];

        AUIGrid.changeColumnLayout(grid1, new_cols);
    }

    //팝업 이벤트


    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {
            DATE : search_date.value.replace(/-/g, ''),
            NAME : search_name.value,
            EMP_GBN : empGbm
        }

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : querySet + "_grid1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                let absentCdArr = [];
                let gridData = [];
                absentCdArr = ["100001", "100002","100003","100004","100005","100006","100007","100008","100009","100010","100011"]

                let items = {}
                data.forEach(row=>{
                    if(!items[row.EMP_NO]) {
                        items[row.EMP_NO] = {};
                        items[row.EMP_NO]['OFFICE_CODE'] = row.OFFICE_CODE;
                        items[row.EMP_NO]['EMP_NO'] = row.EMP_NO;
                        items[row.EMP_NO]['DATE'] = row.DATE;
                        items[row.EMP_NO]['NAME'] = row.NAME;
                        items[row.EMP_NO]['DEPT_CD'] = row.DEPT_CD;
                        items[row.EMP_NO]['DEPT_NAME'] = row.DEPT_NAME;
                        items[row.EMP_NO]['JOB_DUTY_CD'] = row.JOB_DUTY_CD;
                        items[row.EMP_NO]['JOB_DUTY_NAME'] = row.JOB_DUTY_NAME;
                        items[row.EMP_NO]['STATUS'] = row.STATUS;
                        items[row.EMP_NO]['ALL_CNT'] = 0.0;
                        absentCdArr.forEach(absentCd=>{
                            items[row.EMP_NO][absentCd] = 0.0;
                        })
                    }
                });

                data.forEach(row=>{
                    if(!isNull(row.ABSENT_CD) && !isNull(items[row.EMP_NO]) && (row.ABSENT_CD in items[row.EMP_NO])) {
                        items[row.EMP_NO][row.ABSENT_CD] += row.USE_DAY_CNT;
                    }
                    items[row.EMP_NO]['ALL_CNT'] += row.USE_DAY_CNT;
                });

                gridData = Object.values(items);
                //그리드 데이터 세팅
                AUIGrid.setGridData(grid1, gridData);
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

    //로드
    function pop_onload(pop_item){
        querySet = isNull(pop_item.querySet) ? pop_item.pgId : pop_item.querySet;
        empGbm = isNull(pop_item.empGbm) ? "" : pop_item.empGbm;

        if(!isNull(pop_item.btnHidden)){
            btnHidden(pop_item.btnHidden, pop_item.popupId);
        }

        if(!isNull(pop_item.disabled)){
            disableInput(pop_item.popupId);
        }

        search_date.value = getToday("yyyy") + "-" + getToday("MM");

        Promise.all([
            grid1_column_make()
        ]).then(function () {
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        });
    }


</script>
