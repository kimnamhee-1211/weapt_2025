<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrap">
    <div class="aside" id="aside_iljung">
        <div class="nav">일정관리</div>
        <ul class="tree">
            <li>
                <input type="checkbox" id="root" class="tree_cb">
                <label for="root">일정관리</label>
                <ul class="tree_nav">
                    <li id="ilj01010">월간일정</li>
                    <li id="ilj01020">주간일정</li>
                    <li id="ilj01030">일일일정</li>
                    <li id="ilj01040">일정조회</li>
                    <li id="ilj01050">업무일지조회</li>
                    <li id="ilj01060">업무일지결재</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root2" class="tree_cb">
                <label for="root2">계획관리</label>
                <ul class="tree_nav">
                    <li id="ilj02010">월중관리계획</li>
                    <li id="ilj02020">연중관리계획</li>
                    <li id="ilj02030">월중핵심과제등록</li>
                    <li id="ilj02040">구분설정</li>
                </ul>
            </li>
        </ul>
    </div>
</div>

<script>

    const sectionId = "iljung";
    const navId = "aside_iljung";

</script>
