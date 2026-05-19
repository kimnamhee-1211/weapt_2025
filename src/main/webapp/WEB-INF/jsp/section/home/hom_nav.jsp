<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="nav_wrap">
    <div class="nav_aside" id="aside_home">
            <div class="nav">결재 & <span style="font-weight: 500;"> HOME </span></div>
            <ul class="nav_tree">
                <li>
                    <input type="checkbox" id="root" class="tree_cb">
                    <label for="root">결재현황</label>
                    <ul class="tree_nav">
                        <li id="hom01010">결재현황</li>
                    </ul>
                </li>
                <li>
                    <input type="checkbox" id="root2" class="tree_cb">
                    <label for="root2">HOME</label>
                    <ul class="tree_nav">
                        <li id="hom02010">공지사항</li>
                        <li id="hom02020">자주하는질의응답</li>
                        <li id="hom02030">질문/건의</li>
                        <li id="hom02040">하드용량보기</li>
                    </ul>
                </li>
                <li>
                    <input type="checkbox" id="root3"  class="tree_cb">
                    <label for="root3">자료실</label>
                    <ul class="tree_nav">
                        <li id="hom03010">법령자료실</li>
                        <li id="hom03020">실무자료실</li>
                        <li id="hom03030">장기수선계획</li>
                    </ul>
                </li>
                <li>
                    <input type="checkbox" id="root4" class="tree_cb">
                    <label for="root4">LINK</label>
                        <ul class="tree_nav">
                        <li id="hom04010"><a href="http://www.anbit.co.kr/" target="_blank">에이앤비솔루션</a></li>
                        <li id="hom04020"><a href="https://www.k-apt.go.kr/" target="_blank">공동주택관리정보</a></li>
                    </ul>                   
                </li>
            </ul>
        </div>
    </div>

<script>
    const sectionId = "home";
    const navId = "aside_home";
</script>
