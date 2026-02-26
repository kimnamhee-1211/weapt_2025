<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrap">
    <div class="aside" id="aside_hwan">
        <div class="nav">환경보안</div>
        <ul class="tree">
            <li>
                <input type="checkbox" id="root" class="tree_cb">
                <label for="root">환경위생관리</label>
                <ul class="tree_nav">
                    <li id="hwa01010">환경위생관리</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root2" class="tree_cb">
                <label for="root2">청소용역직원관리</label>
                <ul class="tree_nav">
                    <li id="hwa02010">청소용역직원등록</li>
                    <li id="hwa02020">퇴사직원조회</li>
                    <li id="hwa02030">근태등록</li>
                    <li id="hwa02040">개인근태조회</li>
                    <li id="hwa02050">월간근태조회</li>
                </ul>
            </li>
            <li >
                <input type="checkbox" id="root3" class="tree_cb">
                <label for="root3">보안경비관리</label>
                <ul class="tree_nav">
                    <li id="hwa03010">보안경비관리</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root4" class="tree_cb">
                <label for="root4">경비용역직원관리</label>
                <ul class="tree_nav">
                    <li id="hwa04010">경비용역직원등록</li>
                    <li id="hwa04020">퇴사직원조회</li>
                    <li id="hwa04030">근태등록</li>
                    <li id="hwa04040">개인근태조회</li>
                    <li id="hwa04050">월간근태조회</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root5" class="tree_cb">
                <label for="root5">조경관리</label>
                <ul class="tree_nav">
                    <li id="hwa05010">조경관리</li>
                    <li id="hwa05020">수목관리</li>
                    <li id="hwa05030">수목관리내역조회</li>
                    <li id="hwa05040">폐기수목조회</li>
                </ul>
            </li>
        </ul>
    </div>
</div>


<script>
    const sectionId = "hwan";
    const navId = "aside_hwan";
</script>
