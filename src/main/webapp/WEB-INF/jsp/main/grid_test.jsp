<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  System.out.println("로그인 페이지 !!");
  String pbkey = session.getAttribute("pbkey")==null?"":session.getAttribute("pbkey").toString();  
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
    <link rel="stylesheet" type="text/css" href="/resources/css/we_style.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/css/we_style_pop.css"/> 
    <link rel="stylesheet" href="/resources/fontello_we/css/animation.css" >
    <link rel="stylesheet" href="/resources/fontello_we/css/menu.css" >
    <script type="text/javascript" src="/resources/js/we_script.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jsencrypt/3.3.2/jsencrypt.min.js"></script>    
    
    <!-- AUIGrid 라이센스 파일입니다. 그리드 출력을 위해 꼭 삽입하십시오. -->
	<script src="/resources/grid/AUIGrid/AUIGridLicense.js"></script>
	<!-- AUIGrid 라이브러리 메인 JS -->
	<script src="/resources/grid/AUIGrid/AUIGrid.js"></script>
	<!-- AUIGrid CSS 테마 파일 (원하는 테마로 변경 가능) -->
	<link rel="stylesheet" href="/resources/grid/AUIGrid/AUIGrid_style.css" />
    
    
  <title>종합관리솔루션</title>
  
	<script>
		// AUIGrid 생성 후 반환 ID
		let myGridID;
		
		document.addEventListener("DOMContentLoaded", () => {
		  // 칼럼 레이아웃 정의  
		  const columnLayout = [
		    { dataField: "name", headerText: "Name", width: 140 },
		    { dataField: "country", headerText: "Country", width: 120 },
		    { dataField: "product", headerText: "Product", width: 120 },
		    { dataField: "quantity", headerText: "Quantity" },
		    { dataField: "price", headerText: "Price", dataType: "numeric" },
		    { dataField: "date", headerText: "Date" }
		  ];
		  
		  // 그리드 속성 설정
		  const gridProps = { 
		    editable: true
		  };
		
		  // 실제로 #grid_wrap 에 그리드 생성
		  myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridProps);
		
		  // 그리드 cellClick 이벤트 바인딩
		  AUIGrid.bind(myGridID, "cellClick", function(event) {
		    console.log(event);
		    // 그리드 셀 클릭 시 알림 창
		    alert(`${event.type} 이벤트, 클릭한 값: ${event.value}`);
		  });
		
		  // 데이터 로딩
		  fetch("/resources/grid/test/data/normal_100.json")
		    .then(response => {
		      if (!response.ok) throw new Error("HTTP error " + response.status);
		      return response.json();
		    })
		    .then(data => {
		      // 그리드에 데이터 JSON 데이터 삽입
		      AUIGrid.setGridData(myGridID, data);
		    })
		    .catch(error => {
		      alert("데이터 요청 실패: " + error.message);
		    });
		});
	</script>
</head>
<body style="background-color: #f4f4f9;">
	<h1>AUIGrid Quick Start</h1>
  	<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
  	<div id="grid_wrap" style="width:800px; height:480px;"></div>
</body>
</html>