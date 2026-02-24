<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrap">
    <div class="aside" id="aside_iljung">
        <div class="nav">일정관리</div>
        <ul class="tree">
            <li>
                <input type="checkbox" id="root" class="tree_cb">
                <label for="root">일정관리</label>
                <ul class="tree_nav">
                    <li id="ilj01010"><a>월간일정</a></li>
                    <li id="ilj01020"><a>주간일정</a></li>
                    <li id="ilj01030"><a>일일일정</a></li>
                    <li id="ilj01040"><a>일정조회</a></li>
                    <li id="ilj01050"><a>업무일지조회</a></li>
                    <li id="ilj01060"><a>업무일지결재</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root2" class="tree_cb">
                <label for="root2">계획관리</label>
                <ul class="tree_nav">
                    <li id="ilj02010"><a>월중관리계획</a></li>
                    <li id="ilj02020"><a>연중관리계획</a></li>
                    <li id="ilj02030"><a>월중핵심과제등록</a></li>
                    <li id="ilj02040"><a>구분설정</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>


    <script>

        const sectionId = "iljung";
        const navId = "aside_iljung";

    </script>
