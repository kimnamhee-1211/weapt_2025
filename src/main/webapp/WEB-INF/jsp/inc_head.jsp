<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // 날짜 포맷들
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");   // 날짜용
    SimpleDateFormat yearMonthFormat = new SimpleDateFormat("yyyy-MM"); // 년월용

    Calendar cal = Calendar.getInstance();

    // 오늘 날짜
    String today = dateFormat.format(cal.getTime());

    // 어제 날짜
    cal.add(Calendar.DATE, -1);
    String yesterday = dateFormat.format(cal.getTime());

    // 현재 월의 1일
    cal = Calendar.getInstance(); // 다시 초기화
    cal.set(Calendar.DAY_OF_MONTH, 1);
    String firstDayOfMonth = dateFormat.format(cal.getTime());

    // 현재 년월
    String yearMonth = yearMonthFormat.format(cal.getTime());
%>

<%@ page import="egovframework.com.login.model.LoginVO" %>
<%
    // session 가져오기
    LoginVO loginUser   = (LoginVO) session.getAttribute("loginUser");
    String userId       = loginUser != null ? loginUser.getUserId() : "";
    String userName     = loginUser != null ? loginUser.getUserName() : "";
    String empNo        = loginUser != null ? loginUser.getEmpNo() : "";
    String officeCode   = loginUser != null ? loginUser.getOfficeCode() : "";
    String officeName   = loginUser != null ? loginUser.getOfficeName() : "";
    String compCode     = loginUser != null ? loginUser.getCompCode() : "";
    String compName     = loginUser != null ? loginUser.getCompName() : "";
    String usergroupId  = loginUser != null ? loginUser.getUsergroupId() : "";
%>



<!DOCTYPE html>
<html lang="ko">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
    <link rel="stylesheet" type="text/css" href= "${pageContext.request.contextPath}/resources/css/we_style.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/we_style_pop.css"/> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontello_we/css/animation.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontello_we/css/menu.css" >
    
    <!-- AUIGrid 라이센스 파일입니다. 그리드 출력을 위해 꼭 삽입하십시오. -->
	<script src="${pageContext.request.contextPath}/resources/grid/AUIGrid/AUIGridLicense.js"></script>
	<!-- AUIGrid 라이브러리 메인 JS -->
	<script src="${pageContext.request.contextPath}/resources/grid/AUIGrid/AUIGrid.js"></script>
	<!-- AUIGrid CSS 테마 파일 (원하는 테마로 변경 가능) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/grid/AUIGrid/AUIGrid_style.css" />

    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_nav.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_script.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_grid_script.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_crud_script.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_unit_script.js"></script>

    <script>
        //ContextPath
        const ctx = "${pageContext.request.contextPath}";

        //session loginUser
        const loginUser = {
            userId      : "<%= userId %>",
            userName    : "<%= userName %>",
            empNo       : "<%= empNo %>",
            officeCode  : "<%= officeCode %>",
            officeName  : "<%= officeName %>",
            compCode    : "<%= compCode %>",
            compName    : "<%= compName %>",
            usergroupId    : "<%= usergroupId %>",
        };

    </script>


    <title>종합관리솔루션</title>
</head>

