<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "hom_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-home"></i>질문/건의</span> <%-- 메뉴클릭시 바로 검색됨--%>
                <div class="section1_btn"> 
                    <button id="search_btn" onclick="" class="admin_btn">검색</button>  <%-- 책임관리자만 보이는 검색버튼--%>
                    <input type="checkbox" id="layer_popup" class="layer_popup">
                    <label for="layer_popup" class="pop_labal popup_btn" >작성</label> <%--단지에서 작성--%>   
                    <!-- 변경 팝업시작--> 
                    <%@ include file = "../../popup/pop_write_question.jsp" %>
                    <!-- 팝업끝-->              
                </div>
            </div>

             <%-- 책임관리자만 보이는 검색조건 (검색버튼활용)
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="search-box">단지명 :&nbsp;
                            <input type="text" id="" class="box_width200">                        
                        </span> &emsp;
                        <span class="search-box">질의내용 :&nbsp;
                            <input type="text" id="" class="box_width200">                        
                        </span>
                    </form>
                </div>
            </div>  
            --%>

             <%-- 책임관리자 이외의 아이디 로그인으로 보이는  --%>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        검색조건 : &emsp;
                        <span id="question">
                            <input type="radio" id="danjee_question" name="question" value="danjee_question" checked>
                            <label for="danjee_question">내단지글보기&emsp;</label>
                            <input type="radio" id="my_question" name="question" value="my_question">
                            <label for="my_question">내글보기</label>                     
                        </span> 
                    </form>
                </div>
            </div> 

            <div style="height: 566px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                     목록 그리드영역 (더블클릭하면 해당 제목의 내용보여지는 페이지로)
                    <a href="hom02030reading.jsp">----예시클릭</a>
                </div>
            </div>
            <%-- 총 15 줄 (정도) 페이지 넘어가면  페이지 표시  1~10 10개씩 앞뒤로 넘기기 도 표시  --%>
            <div id="" class="pagination">
                <a href="?page=1">&laquo;</a>
                <a href="?page=1" class="active">1</a>
                <a href="?page=2">2</a>
                <a href="?page=3">3</a>
                <a href="?page=4">4</a>
                <a href="?page=5">5</a>
                <a href="?page=6">6</a>
                <a href="?page=7">7</a>
                <a href="?page=8">8</a>
                <a href="?page=9">9</a>
                <a href="?page=10" >10</a>
                <a href="?page=11">&raquo;</a>
            </div>            
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>