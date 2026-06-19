<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/minwon/min_nav.jsp" />


    <div id="section">
        <div class="section1">
            <div class="section1_nav"><i class="icon-phone-squared"></i>민원조회</div>
            <div class="section1_btn" id="section1_btn"></div>
        </div>
        <div class="section2">
            <div class="section2_line3">
                <div style="display:flex;">
                    <span>기간 :&nbsp;
                        <input type="date" id="search_startDate">&nbsp; ~ &nbsp;
                        <input type="date" id="search_endDate">
                    </span>
                    <span>&emsp;구분 :&nbsp;
                        <select id="search_minwonGbn" name="MINOWN_GBN" class="select_cont100"></select>
                    </span>
                    <span>&emsp;상태 :&nbsp;
                        <select id="search_statusCd" name="STATUS_CD" class="select_cont100">
                            <option value="ALL" selected>전체</option>
                            <option value="1">처리</option>
                            <option value="2">보류</option>
                            <option value="3">반려</option>
                            <option value="4">처리중</option>
                            <option value="" selected>미결</option>
                        </select>
                    </span>
                    <span>&emsp;
                        <input  type="checkbox" id="search_desc" name="DESC" checked>
                        <label for="search_desc">&nbsp;최근순&emsp;</label>
                    </span>
                </div>
                <div style="display:flex;">
                    <span class="search-box">세대/공용구분 :&nbsp;
                        <select id="search_gbn" class="select_cont100" name="GBN">
                            <option value="" selected>전체</option>
                            <option value="0">세대</option>
                            <option value="12">공용</option>
                        </select>&emsp;
                        <span id="search_sedae" style="display: none">
                            <input type="text" id="search_stDong" name="ST_DONG" class="box50" oninput="inputNumFormat(this)">동
                            <input type="text" id="search_stHo" name="ST_HO" class="box50" oninput="inputNumFormat(this)">호&emsp;~
                            <input type="text" id="search_endDong" name="END_DONG" class="box50" oninput="inputNumFormat(this)"> 동
                            <input type="text" id="search_endHo" name="END_HO" class="box50" oninput="inputNumFormat(this)">호
                        </span>
                        <span id="search_gongyong" style="display: none">
                            <input type="radio" id="search_gbn12" value="all" name="GBN_12"> 전체공용&emsp;
                            <input type="radio" id="search_gbn1" value="1" name="GBN_12"> 동별공용&emsp;
                            <input type="radio" id="search_gbn2" value="2" name="GBN_12"> 동외공용&emsp;
                        </span>
                    </span>
                </div>
                <div style="display:flex;">
                    <span class="search-box">민원내용 :&nbsp;
                        <select id="search_what" name="WHAT" class="select_cont150">
                            <option value="all">접수+처리내용</option>
                            <option value="receipt">접수내용</option>
                            <option value="work">처리내용</option>
                        </select>&emsp;
                    </span>
                    <span>
                        <input style="width:713px;" type="text" id="search_text" name="TEXT" placeholder=" 검색어를 입력하십시오.">
                    </span>
                </div>
            </div>
        </div>
        <div id="grid1"  style="height: 546px;"></div>
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
    const sectionId = "${sectionId}";	//섹션ID
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    let grid1;	// 그리드 컴포넌트
    let focus = 0;	//그리드 컴포넌트 포커스
    const search_startDate = document.querySelector("#search_startDate");
    const search_endDate = document.querySelector("#search_endDate");
    const search_minwonGbn = document.querySelector("#search_minwonGbn");
    const search_statusCd = document.querySelector("#search_statusCd");
    const search_desc = document.querySelector("#search_desc");
    const search_gbn = document.querySelector("#search_gbn");
    const search_sedae = document.querySelector("#search_sedae");
    const search_stDong = document.querySelector("#search_stDong");
    const search_stHo = document.querySelector("#search_stHo");
    const search_endDong = document.querySelector("#search_endDong");
    const search_endHo = document.querySelector("#search_endHo");
    const search_gongyong = document.querySelector("#search_gongyong");
    const search_gbn12 = document.querySelector("#search_gbn12");
    const search_gbn1 = document.querySelector("#search_gbn1");
    const search_gbn2 = document.querySelector("#search_gbn2");
    const search_what = document.querySelector("#search_what");
    const search_text = document.querySelector("#search_text");


    //그리드 설정
    const grid1ColumnLayout = [
        { dataField: "SLIP_NO",
            headerText: "전표번호",
            dataType: "text",
            width : "8%"
        },
        { dataField: "MINWON_DATE",
            headerText: "접수일자",
            dataType: "date",
            formatString: "yyyy-mm-dd",
            width : "10%"
        },
        { dataField: "PLACE",
            headerText: "장소",
            dataType: "text",
            width : "20%"
        },
        { dataField: "DESCR",
            headerText: "내역",
            dataType: "text",
            width : "*%",
            style: "line-break-column",
        },
        { dataField: "RECEIPT_USER",
            headerText: "접수자",
            dataType: "text",
            width : "8%",
        },
        { dataField: "STATUS_NAME",
            headerText: "처리상태",
            dataType: "text",
            width : "8%",
        },
        { dataField: "WORK_USER",
            headerText: "처리자",
            dataType: "text",
            width : "8%",
        },
    ];

    //그리드 생성
    grid1 = AUIGrid.create("#grid1", grid1ColumnLayout,
        Object.assign({}, we_grid_Props,
            {
                showRowCheckColumn : false,
                showRowNumColumn : false,
                editable : false,
                height: 538,
                wordWrap: true,
            })
    );

    //그리드 이벤트
    AUIGrid.bind(grid1, "cellDoubleClick", function(event) {
        getSelect_min_setting();
        open_popup1_onclick(AUIGrid.getSelectedRows(grid1)[0]);
    });

    //팝업 이벤트
    function close_popup1_onclick(){
        popupClose(popupId1);
        clearInput(popupId1);
    }

    //그리드 조회 함수
    function search_grid1_onclick(){

        //검색데이터
        let selectParam = {
            START_DATE: search_startDate.value.replace(/-/g,""),
            END_DATE: search_endDate.value.replace(/-/g,""),
            MINWON_GBN: search_minwonGbn.value,
            STATUS_CD: search_statusCd.value,
            DESC : search_desc.checked ? "Y" : "N",
            GBN: search_gbn.value,
            ST_DONG: search_stDong.value,
            ST_HO: search_stHo.value,
            END_DONG: search_endDong.value,
            END_HO: search_endHo.value,
            GBN_12: document.querySelector("input[name='GBN_12']:checked")?.value || "",
            WHAT: search_what.value,
            TEXT: search_text.value
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
                data.forEach(row=>{
                    row.PLACE = make_place(row)
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

    search_gbn.addEventListener("change", () => {
        if(search_gbn.value == "0"){
            search_sedae.style.display = "inline"
            search_gongyong.style.display = "none"
        }else if(search_gbn.value == "12"){
            search_sedae.style.display = "none"
            search_gongyong.style.display = "inline"
        }else{
            search_sedae.style.display = "none"
            search_gongyong.style.display = "none"
        }
    });

    async function getSelect_search_minwonGbn() {
        search_minwonGbn.innerHTML = "";
        //검색데이터
        let param = {}

        //파라미터
        let data = {
            sectionId: sectionId,
            component: pgId + "_search_minwonGbn",
            param: param,
        }

        let list = await we_getSelect(data);

        if (list) {
            search_minwonGbn.insertAdjacentHTML("beforeend", "<option value='' selected>미선택</option>");
            list.forEach(row => {
                search_minwonGbn.insertAdjacentHTML("beforeend",
                    "<option value='" + row.GBN_ID + "'>" + row.GBN_NAME + "</option>");
            })
        }
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
        search_startDate.value = addDate(getToday("yyyy-MM-dd"), -7, "yyyy-MM-dd");
        search_endDate.value = getToday("yyyy-MM-dd");
        //crud 권한 처리 함수
        checkCrudPermission(pgId);

        Promise.all([
            getSelect_search_minwonGbn()
        ]).then(function () {
            //로드 시 그리드 바로 조회
            search_grid1_onclick();
        });

    };

</script>

<%@ include file = "../../inc_footer.jsp" %>