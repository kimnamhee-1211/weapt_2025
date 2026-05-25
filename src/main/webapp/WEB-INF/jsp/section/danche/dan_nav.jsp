<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="nav_wrap">
    <div class="nav_aside" id="aside_danche">
        <div class="nav">회의단체</div>
        <ul class="nav_tree">
            <li>
                <input type="checkbox" id="root" class="tree_cb">
                <label for="root">입주자대표회의</label>
                <ul class="tree_nav">
                    <li id="dan01010">동대표명단</li>
                    <li id="dan01020">입대의회의록</li>
                    <li id="dan01030">전임동대표</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root2" class="tree_cb">
                <label for="root2">합동대표회의</label>
                <ul class="tree_nav">
                    <li id="dan02010">합동대표명단</li>
                    <li id="dan02020">합동대표회의록</li>
                    <li id="dan02030">전임합동대표</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root3" class="tree_cb">
                <label for="root3">선거관리위원회</label>
                <ul class="tree_nav">
                    <li id="dan03010">선거관리위원회</li>
                    <li id="dan03020">위원회회의록</li>
                    <li id="dan03030">전임위원회</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root4" class="tree_cb">
                <label for="root4">층간소음관리위원회</label>
                <ul class="tree_nav">
                    <li id="dan04010">층간소음관리위원회</li>
                    <li id="dan04020">위원회회의록</li>
                    <li id="dan04030">전임위원회</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root5" class="tree_cb">
                <label for="root5">통반장</label>
                <ul class="tree_nav">
                    <li id="dan05010">통반장명단</li>
                    <li id="dan05030">전임통반장</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root6" class="tree_cb">
                <label for="root6">부녀회</label>
                <ul class="tree_nav">
                    <li id="dan06010">부녀회명단</li>
                    <li id="dan06030">전임부녀회</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root7" class="tree_cb">
                <label for="root7">노인회</label>
                <ul class="tree_nav">
                    <li id="dan07010">노인회명단</li>
                    <li id="dan07030">전임노인회</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root8" class="tree_cb">
                <label for="root8">번영회</label>
                <ul class="tree_nav">
                    <li id="dan08010">번영회명단</li>
                    <li id="dan08030">전임번영회</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root9" class="tree_cb">
                <label for="root9">임차인대표회의</label>
                <ul class="tree_nav">
                    <li id="dan09010">임차인대표명단</li>
                    <li id="dan09020">입대의회의록</li>
                    <li id="dan09030">전임임차인대표</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root10" class="tree_cb">
                <label for="root10">임차인선거관리위원회</label>
                <ul class="tree_nav">
                    <li id="dan10010">선거관리위원회명단</li>
                    <li id="dan10020">위원회회의록</li>
                    <li id="dan10030">전임위원회</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root11" class="tree_cb">
                <label for="root11">관리단</label>
                <ul class="tree_nav">
                    <li id="dan11010">관리단명단</li>
                    <li id="dan11020">관리단회의록</li>
                    <li id="dan11030">전임관리단</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root12" class="tree_cb">
                <label for="root12">커뮤니티소위원회</label>
                <ul class="tree_nav">
                    <li id="dan12010">커뮤니티소위원회명단</li>
                    <li id="dan12020">위원회회의록</li>
                    <li id="dan12030">전임위원회</li>
                </ul>
            </li>
            <li>
                <input type="checkbox" id="root13" class="tree_cb">
                <label for="root13">위원회</label>
                <ul class="tree_nav">
                    <li id="dan13010">위원회명단</li>
                    <li id="dan13020">위원회회의록</li>
                    <li id="dan13030">전임위원회</li>
                </ul>
            </li>
        </ul>
    </div>
</div>

<script>
    const sectionId = "danche";
    const navId = "aside_danche";



</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_nav.js"></script>