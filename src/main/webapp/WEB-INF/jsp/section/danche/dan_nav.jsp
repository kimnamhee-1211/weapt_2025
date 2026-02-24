<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrap">
    <div class="aside" id="aside_danche">
        <div class="nav">회의단체</div>
        <ul class="tree">
            <li>
                <input type="checkbox" id="root" class="tree_cb">
                <label for="root">입주자대표회의</label>
                <ul class="tree_nav">
                    <li id="dan01010"><a>동대표명단</a></li>
                    <li id="dan01020"><a>입대의회의록</a></li>
                    <li id="dan01030"><a>전임동대표</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root2" class="tree_cb">
                <label for="root2">합동대표회의</label>
                <ul class="tree_nav">
                    <li id="dan02010"><a href="dan02010.jsp">합동대표명단</a></li>
                    <li id="dan02020"><a href="dan02020.jsp">입대의회의록</a></li>
                    <li id="dan02030"><a href="dan02030.jsp">전임합동대표</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root3" class="tree_cb">
                <label for="root3">선거관리위원회</label>
                <ul class="tree_nav">
                    <li id="dan03010"><a href="dan03010.jsp">선거관리위원회</a></li>
                    <li id="dan03020"><a href="dan03020.jsp">위원회회의록</a></li>
                    <li id="dan03030"><a href="dan03030.jsp">전임위원회</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root4" class="tree_cb">
                <label for="root4">층간소음관리위원회</label>
                <ul class="tree_nav">
                    <li id="dan04010"><a href="dan04010.jsp">층간소음관리위원회</a></li>
                    <li id="dan04020"><a href="dan04020.jsp">위원회회의록</a></li>
                    <li id="dan04030"><a href="dan04030.jsp">전임위원회</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root5" class="tree_cb">
                <label for="root5">통반장</label>
                <ul class="tree_nav">
                    <li id="dan05010"><a href="dan05010.jsp">통반장명단</a></li>
                    <li id="dan05020"><a href="dan05020.jsp">전임통반장</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root6" class="tree_cb">
                <label for="root6">부녀회</label>
                <ul class="tree_nav">
                    <li id="dan06010"><a href="dan06010.jsp">부녀회명단</a></li>
                    <li id="dan06020"><a href="dan06020.jsp">전임부녀회</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root7" class="tree_cb">
                <label for="root7">노인회</label>
                <ul class="tree_nav">
                    <li id="dan07010"><a href="dan07010.jsp">노인회명단</a></li>
                    <li id="dan07020"><a href="dan07020.jsp">전임노인회</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root8" class="tree_cb">
                <label for="root8">번영회</label>
                <ul class="tree_nav">
                    <li id="dan08010"><a href="dan08010.jsp">번영회명단</a></li>
                    <li id="dan08020"><a href="dan08020.jsp">전임번영회</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root9" class="tree_cb">
                <label for="root9">임차인대표회의</label>
                <ul class="tree_nav">
                    <li id="dan09010"><a href="dan09010.jsp">임차인대표명단</a></li>
                    <li id="dan09020"><a href="dan09020.jsp">입대의회의록</a></li>
                    <li id="dan09030"><a href="dan09030.jsp">전임임차인대표</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root10" class="tree_cb">
                <label for="root10">임차인선거관리위원회</label>
                <ul class="tree_nav">
                    <li id="dan10010"><a href="dan10010.jsp">선거관리위원회명단</a></li>
                    <li id="dan10020"><a href="dan10020.jsp">위원회회의록</a></li>
                    <li id="dan10030"><a href="dan10030.jsp">전임위원회</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root11" class="tree_cb">
                <label for="root11">관리단</label>
                <ul class="tree_nav">
                    <li id="dan11010"><a href="dan11010.jsp">관리단명단</a></li>
                    <li id="dan11020"><a href="dan11020.jsp">관리단회의록</a></li>
                    <li id="dan11030"><a href="dan11030.jsp">전임관리단</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root12" class="tree_cb">
                <label for="root12">커뮤니티소위원회</label>
                <ul class="tree_nav">
                    <li id="dan12010"><a href="dan12010.jsp">커뮤니티소위원회명단</a></li>
                    <li id="dan12020"><a href="dan12020.jsp">위원회회의록</a></li>
                    <li id="dan12030"><a href="dan12030.jsp">전임위원회</a></li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root13" class="tree_cb">
                <label for="root13">위원회</label>
                <ul class="tree_nav">
                    <li id="dan13010"><a href="dan13010.jsp">위원회명단</a></li>
                    <li id="dan13020"><a href="dan13020.jsp">위원회회의록</a></li>
                    <li id="dan13030"><a href="dan13030.jsp">전임위원회</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>

<script>
    const sectionId = "danche";
    const navId = "aside_danche";
</script>
