<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="nav_wrap">
    <div class="nav_aside" id="aside_haeng">
        <div class="nav">관리일반</div>
        <ul class="nav_tree">
            <li id="ilb01">
                <input type="checkbox" id="root" class="tree_cb">
                <label for="root">법규관리</label>
                <ul class="tree_nav">
                    <li id="ilb01010">관리규약/규칙</li>
                    <li id="ilb01020">예산(안)</li>
                    <li id="ilb01030">안전관리계획</li>
                    <li id="ilb01040">소방계획서</li>
                    <li id="ilb01050">교육관리</li>
                </ul>
            </li>
            <li id="ilb02">
                <input type="checkbox" id="root2" class="tree_cb">
                <label for="root2">계약관리</label>
                <ul class="tree_nav">
                    <li id="ilb02010">계약업체등록</li>
                    <li id="ilb02020">계약등록/조회</li>
                    <li id="ilb02030">해지계약조회</li>
                </ul>
            </li>
            <li id="ilb03">
                <input type="checkbox" id="root3" class="tree_cb">
                <label for="root3">관리직원</label>
                <ul class="tree_nav">
                    <li id="ilb03010">관리직원등록</li>
                    <li id="ilb03020">아이디등록</li>
                    <li id="ilb03030">관리직원자격증관리</li>
                    <li id="ilb03040">부서/직책등록</li>
                    <li id="ilb03050">전자결재선조회</li>
                    <li id="ilb03060">퇴사직원조회</li>
                    <li id="ilb03070">관리조직도</li>
                    <li id="ilb03080">자위소방대</li>

                </ul>
            </li>
            <li id="ilb04">
                <input type="checkbox" id="root4" class="tree_cb">
                <label for="root4">근태관리</label>
                    <ul class="tree_nav">
                    <li id="ilb04010">근태등록</li>
                    <li id="ilb04020">개인근태조회</li>
                    <li id="ilb04030">월간근태조회</li>
                    <li id="ilb04040">근태관리환경설정</li>
                </ul>
            </li>
        </ul>
    </div>
</div>


<script>

    const sectionId = "ilban";
    const navId = "aside_ilban";



</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_nav.js"></script>