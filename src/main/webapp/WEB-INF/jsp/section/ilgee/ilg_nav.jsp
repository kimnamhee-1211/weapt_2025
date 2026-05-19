<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="nav_wrap">
    <div class="nav_aside" id="aside_ilgee">
        <div class="nav">일지결재</div>
        <ul class="nav_tree">
            <li>
                <input type="checkbox" id="root" class="tree_cb">
                <label for="root">업무일지</label>
                <ul class="tree_nav">
                    <li id="ilg01010"><a>**일지</a></li>
                    <li id="ilg01090"><a>업무일지조회</a></li>
                    <li id="ilg01095"><a href="ilg01095.jsp">업무일지사진첩</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root1" class="tree_cb">
                <label for="root1">전기분야</label>
                <ul class="tree_nav">
                    <li id="ilg02010"><a href="ilg02010.jsp">전기분야**일지</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root2" class="tree_cb">
                <label for="root2">전기분야관리</label>
                <ul class="tree_nav">
                    <li id=""><a href="ilg03010.jsp">전기분야관리</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root3" class="tree_cb">
                <label for="root3">설비영선</label>
                <ul class="tree_nav">
                    <li id="ilg04010"><a href="ilg04010.jsp">설비영선**일지</a></li>
                </ul>
            </li>
             <li>
                <input type="checkbox" id="root4" class="tree_cb">
                <label for="root4">설비영선관리</label>
                <ul class="tree_nav">
                    <li id="ilg05010"><a href="ilg05010.jsp">설비영선관리</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root5" class="tree_cb">
                <label for="root5">기계설비</label>
                <ul class="tree_nav">
                    <li id="ilg06010"><a href="ilg06010.jsp">기계설비**일지</a></li>
                </ul>
            </li>
                <li>
                <input type="checkbox" id="root6" class="tree_cb">
                <label for="root6">안전진단</label>
                <ul class="tree_nav">
                    <li id="ilg07010"><a href="ilg07010.jsp">안전진단**일지</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>

<script>

    const sectionId = "ilgee";
    const navId = "aside_ilgee";

</script>
