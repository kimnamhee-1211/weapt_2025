<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrap">
    <div class="aside" id="aside_haeng">
        <div class="nav">관리일반</div>
        <ul class="tree">
            <li id="ilb01">
                <input type="checkbox" id="root" class="tree_cb">
                <label for="root">법규관리</label>
                <ul class="tree_nav">
                    <li id="ilb01010"><a>관리규약/규칙</a></li>
                    <li id="ilb01020"><a>예산(안)</a></li>
                    <li id="ilb01030"><a>안전관리계획</a></li>
                    <li id="ilb01040"><a>소방계획서</a></li>
                    <li id="ilb01050"><a>교육관리</a></li>
                </ul>
            </li>
            <li id="ilb02">
                <input type="checkbox" id="root2" class="tree_cb">
                <label for="root2">계약관리</label>
                <ul class="tree_nav">
                    <li id="ilb02010"><a>계약업체등록</a></li>
                    <li id="ilb02020"><a>계약등록/조회</a></li>
                    <li id="ilb02030"><a>해지계약조회</a></li>
                </ul>
            </li>
            <li id="ilb03">
                <input type="checkbox" id="root3" class="tree_cb">
                <label for="root3">관리직원</label>
                <ul class="tree_nav">
                    <li id="ilb03010"><a>관리직원등록</a></li>
                    <li id="ilb03020"><a>아이디등록</a></li>
                    <li id="ilb03030"><a>관리직원자격증관리</a></li>
                    <li id="ilb03040"><a>부서/직책등록</a></li>
                    <li id="ilb03050"><a>전자결재선조회</a></li>
                    <li id="ilb03060"><a>퇴사직원조회</a></li>
                    <li id="ilb03070"><a>관리조직도</a></li>
                    <li id="ilb03080"><a>자위소방대</a></li>

                </ul>
            </li>
            <li id="ilb04">
                <input type="checkbox" id="root4" class="tree_cb">
                <label for="root4">근태관리</label>
                    <ul class="tree_nav">
                    <li id="ilb04010"><a>근태등록</a></li>
                    <li id="ilb04020"><a>개인근태조회</a></li>
                    <li id="ilb04030"><a>월간근태조회</a></li>
                    <li id="ilb04040"><a>근태관리환경설정</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>


<script>

    const sectionId = "ilban";
    const navId = "aside_ilban";

</script>
