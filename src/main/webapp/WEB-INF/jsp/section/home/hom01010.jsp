<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "hom_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-home"></i>결재현황</div>
                <div class="section1_btn">
                    기준일 이전 7일간&nbsp; <button id="search_btn" onclick="">검색</button>&emsp;
                    순번 및 결재주기&nbsp; <button id="save_btn" onclick="">저장</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span>결재기준일 :&nbsp;
                            <input type="date" id="today" value="<%= today %>">                        
                        </span>                            
                        <span class="section1_btn">  
                        결재 : &#9679; &ensp;미결 : &#9675; &ensp;보류 : &#9651; &ensp;휴가/결원 : &#9633; &ensp;
                        </span>                       
                    </form>                                                
                </div> 
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    <!-- 그리드영역 -->
                    <div id="grid_wrap" style="width:1076px; height:611px;"></div> 
                </div>
            </div>
        </div>
    </div>
    
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

<%@ include file = "../../inc_footer.jsp" %>