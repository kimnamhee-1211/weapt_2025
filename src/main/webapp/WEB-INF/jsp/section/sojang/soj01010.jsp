<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/sojang/soj_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-star-filled"></i>관리업무마감
                </div>
                <div class="section1_btn">
                    <button onclick="save_grid1_onclick()">마감</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <span id="">종전마감일 :&nbsp;&nbsp;</span>
                    <span id="title_endDate"></span>
                    <span>금차마감일 :&nbsp;
                        <input type="date" id="input_endDate" data-format="date">
                    </span>
                </div> 
            </div>
            <div id="tip_mic">
                <i class="icon-mic"></i>소장님 퇴사 전 마감(퇴사일 전일 또는 전전일 적정) 마감 하시기 바랍니다.<br>
                <i class="icon-mic"></i>마감일 후에는 마감일 이전 업무를 수정, 삭제할 수 없습니다.<br>
                <i class="icon-mic"></i>마감해제가 필요하면 전산회사에 문의하십시오.<br>
                <i class="icon-mic"></i>요청하신 마감해제는 종전 마감일 이후 일자로 해제됩니다.
            </div>
        </div>


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
    const sectionId = "${sectionId}";	//섹션ID
    const pgId = "${pgId}";	//프로그램ID
    const menuId = "${menuId}";	//메뉴ID
    const title_endDate = document.querySelector("#title_endDate"); //title 컴포넌트
    const input_endDate = document.querySelector("#input_endDate"); //input 컴포넌트
    let DS_END_DATE = [];

    //그리드 조회 함수
    function search_grid1_onclick(){
        //검색데이터
        let selectParam = {}

        //파라미터
        let selectData = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param: selectParam,
        }

        we_select( selectData,{
            successSelect : (json) => {
                let data = json.DATA;
                DS_END_DATE = data;
                title_endDate.value = DS_END_DATE[0].END_DATE
            }
        });
    }

    //그리드 저장 함수
    function save_grid1_onclick(){

        if(isNull(input_endDate.value)){
            alert("마감일을 지정해주세요.");
            return;
        }

        if(!confirm( input_endDate.value + "일자로 업무를 마감하시겠습니까?")) return;

        let seq = 1;
        if(DS_END_DATE[0].END_DATE == input_endDate.value.replace(/-/g, "")){
            seq =  seq + parseInt(DS_END_DATE[0].SEQ);
        }

        //저장 데이터
        let saveParam = {
            insertParam : [{
                END_DATE : input_endDate.value.replace(/-/g, ""),
                SEQ : String(seq),
                REG_DATE : getToday("yyyyMMdd"),
            }],
            updateParam : null,
            key : {},
            before : {}
        }

        //파라미터
        let saveData  = {
            sectionId : sectionId,
            component : pgId + "_grid1",
            param: saveParam,
        }

        we_save( saveData ,{
            successSave : (json) => {
                if(json.O_RESULT > 0){
                    alert( input_endDate.value + "일자로 업무를 마감했습니다.");
                    search_grid1_onclick();
                }else{
                    alert(json.O_MSG);
                    return;
                }
            }
        });
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
        input_endDate.value = getToday("yyyy-MM-dd");
        //crud 권한 처리 함수
        checkCrudPermission(pgId);
        search_grid1_onclick();
    };

</script>


    
<%@ include file = "../../inc_footer.jsp" %>