<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="nav_wrap">
    <div class="nav_aside" id="aside_haeng">
        <div class="nav">행정관리</div>
        <ul class="nav_tree">
            <li>
                <input type="checkbox" id="root" class="tree_cb">
                <label for="root">전자결재</label>
                <ul class="tree_nav">
                    <li id="hae01010">기안문서</li>
                    <li id="hae01020">지출결의</li>
                    <li id="hae01030">문서관리양식설정</li>
                    <li id="hae01040">전자결재취소내역(관리자)</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root2" class="tree_cb">
                <label for="root2">문서관리</label>
                <ul class="tree_nav">
                    <li id="hae02010">기안문서</li>
                    <li id="hae02020">발송문서</li>
                    <li id="hae02030">입찰공고</li>
                    <li id="hae02040">접수문서</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root3" class="tree_cb">
                <label for="root3">방송&게시문</label>
                <ul class="tree_nav">
                    <li id="hae03010">방송문</li>
                    <li id="hae03020">공고문</li>
                    <li id="hae03030">광고게시문</li>
                    <li id="hae03040">게시문현황</li>
                    <li id="hae03050">게시문환경설정</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root4" class="tree_cb">
                <label for="root4">메시지</label>
                <ul class="tree_nav">
                    <li id="hae04010"><a href="hae04010.jsp">메시지보내기</a></li>
                    <li id="hae04020"><a href="hae04020.jsp">메시지조회</a></li>
                    <li id="hae04030"><a href="hae04030.jsp">연도별수선예정금액</a></li>
                    <li id="hae04040"><a href="hae04040.jsp">메시지충전현황</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root5" class="tree_cb">
                <label for="root5">생산문서관리</label>
                <ul class="tree_nav">
                    <li id="hae05010">생산문서</li>
                    <li id="hae05020">폐기문서</li>
                    <li id="hae05030">생산문서환경설정</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root6" class="tree_cb">
                <label for="root6">행정관리</label>
                <ul class="tree_nav">
                    <li id="hae06010">행정서식관리</li>
                    <li id="hae06020">부과내역서</li>
                    <li id="hae06030">자금및지출결의</li>
                    <li id="hae06040">재무제표</li>
                </ul>
            </li>
        </ul>
    </div>
</div>

<script>
    const sectionId = "haeng";
    const navId = "aside_haeng"


</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_nav.js"></script>