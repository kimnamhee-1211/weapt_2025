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



<!DOCTYPE html>
<html lang="ko">
<head> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
    <link rel="stylesheet" type="text/css" href="/resources/css/we_style.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/css/we_style_pop.css"/>
    <link rel="stylesheet" href="/resources/fontello_we/css/animation.css" >
    <link rel="stylesheet" href="/resources/fontello_we/css/menu.css" >
    <script type='text/javascript' src="/resources/js/we_script.js"></script>
    <title>종합관리솔루션</title>
</head>