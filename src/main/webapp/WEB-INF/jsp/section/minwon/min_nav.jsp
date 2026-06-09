<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="nav_wrap">
    <div class="nav_aside" id="aside_minwon">
        <div class="nav">민원관리</div>
        <ul class="nav_tree"></ul>
    </div>
</div>
<jsp:include page="/WEB-INF/jsp/section/minwon/min_comm.jsp" />

<script>
    //변수 설정
    const sectionId = "minwon";
    const navId = "aside_minwon";
    const menu_group = "020";

</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_nav.js"></script>