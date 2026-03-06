<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrap">
    <div class="aside" id="aside_minwon">
        <div class="nav">민원관리</div>
        <ul class="tree">
            <li>
                <input type="checkbox" id="root1"  class="tree_cb">
                <label for="root1">민원관리</label>
                <ul class="tree_nav">
                    <li id="min01010"><a>민원접수</a></li>
                    <li id="min01020"><a>민원처리</a></li>
                    <li id="min01030"><a>민원조회</a></li>
                    <li id="min01040"><a>세대민원대장</a></li>
                    <li id="min01050"><a>공용민원대장</a></li>
                    <li id="min01060"><a>민원일지결재</a></li>
                    <li id="min01070"><a>세대정보등록</a></li>
                    <li id="min01080"><a>민원환경설정</a></li>
                    <li id="min01090"><a>삭제민원조회(관리자)</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root2"  class="tree_cb">
                <label for="root2">단지현황</label>
                <ul class="tree_nav">
                    <li id="min02010"><a>단지배치도</a></li>
                    <li id="min02020"><a>세대평면도</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root3"  class="tree_cb">
                <label for="root3">민원통계</label>
                <ul class="tree_nav">
                    <li id="min03010"><a href="min03010.jsp">월별통계</a></li>
                    <li id="min03020"><a href="min03020.jsp">처리자별통계</a></li>
                    <li id="min03030"><a href="min03030.jsp">구분통계</a></li>
                    <li id="min03040"><a href="min03040.jsp">동별통계</a></li>
                    <li id="min03050"><a href="min03050.jsp">분야별통계</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>

<script>
    //변수 설정
    const sectionId = "minwon";
    const navId = "aside_minwon";

</script>