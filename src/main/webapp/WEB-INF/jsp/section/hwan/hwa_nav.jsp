<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrap">
    <div class="aside" id="aside_hwan">
        <div class="nav">환경보안</div>
        <ul class="tree">
            <li>
                <input type="checkbox" id="root" class="tree_cb">
                <label for="root">환경위생관리</label>
                <ul class="tree_nav">
                    <li id="hwa01010"><a>환경위생관리</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root2" class="tree_cb">
                <label for="root2">청소용역직원관리</label>
                <ul class="tree_nav">
                    <li id="hwa02010"><a>청소용역직원등록</a></li>
                    <li id="hwa02020"><a>퇴사직원조회</a></li>
                    <li id="hwa02030"><a>근태등록</a></li>
                    <li id="hwa02040"><a>개인근태조회</a></li>
                    <li id="hwa02050"><a>월간근태조회</a></li>
                </ul>
            </li>
            <li >
                <input type="checkbox" id="root3" class="tree_cb">
                <label for="root3">보안경비관리</label>
                <ul class="tree_nav">
                    <li id="hwa03010"><a>보안경비관리</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root4" class="tree_cb">
                <label for="root4">경비용역직원관리</label>
                <ul class="tree_nav">
                    <li id="hwa04010"><a>경비용역직원등록</a></li>
                    <li id="hwa04020"><a>퇴사직원조회</a></li>
                    <li id="hwa04030"><a>근태등록</a></li>
                    <li id="hwa04040"><a>개인근태조회</a></li>
                    <li id="hwa04050"><a>월간근태조회</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root5" class="tree_cb">
                <label for="root5">조경관리</label>
                <ul class="tree_nav">
                    <li id="hwa05010"><a>조경관리</a></li>
                    <li id="hwa05020"><a>수목관리</a></li>
                    <li id="hwa05030"><a>수목관리내역조회</a></li>
                    <li id="hwa05040"><a>폐기수목조회</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>


<script>
    const sectionId = "hwan";
    const navId = "aside_hwan";
</script>
