<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<jsp:include page="/WEB-INF/jsp/section/danche/dan_nav.jsp" />

        <div id="section">
            <div class="section1">
                <div class="section1_nav" id="pg_title"><i class="icon-user-add"></i>동대표명단</div>
                <div class="section1_btn" id="section1_btn"></div>
                <span class="search-box" style="float: right;">
                    퇴사일 :
                    <input type="date" id="input_disuseDate" name="DISUSE_DATE" class="box_width100">
                     &nbsp; 퇴사사유 :
                    <input type="text" id="input_disuseReason" name="DISUSE_REASON" class="box_width200">
                    <button id="disuse_btn_grid1" class="del_btn" onclick="disuse_onclick()">퇴사</button>
                </span>
            </div>
            <jsp:include page="/WEB-INF/jsp/section/danche/dan001.jsp" />
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

        let pg_title = document.getElementById("pg_title");
        const title = "${title}";
        if(!isNull(title)){
            pg_title.innerHTML = '<i class="icon-user-add"></i>';
            pg_title.append(document.createTextNode(title));
        }

        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#section1_btn", grid:"grid1", search: true, add: true, save: true});
        checkCrudPermission(pgId);

        let pop_item = {
            pgId : pgId,
            querySet : "dan001",
        };
        pop_onload(pop_item);
    };

</script>

<%@ include file = "../../inc_footer.jsp" %>