<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="nav_wrap">
    <div class="nav_aside" id="aside_template">
        <div class="nav">TEMPLATE</div>
        <ul class="nav_tree">
            <li>
                <input type="checkbox" id="root1" class="tree_cb">
                <label for="root1">TEMPLATE</label>
                <ul class="tree_nav">
                    <li id="tem_grid1">tem_grid1</li>
                    <li id="tem_popup">tem_popup</li>
                    <li id="tem_grid2">tem_grid2</li>
                    <li id="tem_board">tem_board</li>
                </ul>
            </li>
        </ul>
    </div>
 </div>

 <script>
    //변수 설정
    const sectionId = "template";
    const navId = "aside_template";

 </script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_nav.js"></script>
