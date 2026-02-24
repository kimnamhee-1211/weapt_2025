<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "hom_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-home"></i>자주하는질의응답</span> <%-- 메뉴클릭시 바로 검색됨--%>
                <div class="section1_btn">  <%-- 책임관리자만 보이는 작성버튼--%>
                    <button id="write_btn" onclick="" class="admin_btn"><a href="hom02020write.jsp">작성</a></button>                  
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="select-container">검색조건 :&nbsp;
                            <select id="" name="" class="box_width100">
                                <option value="">전체</option>
                                <option value="">제목</option> 
                                <option value="">내용</option> 
                                <option value="">제목+내용</option>  
                            </select>
                        </span>
                        <span class="search-box">&nbsp;
                            <input type="" id="" class="box_width200">                        
                        </span>
                    </form>
                </div>
            </div>                        
            <div style="height: 566px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                     목록 그리드영역 (더블클릭하면 해당 제목의 내용보여지는 페이지로)
                    <a href="hom02020reading.jsp">----예시클릭</a>
                </div>
            </div>
             <%-- 총 15 줄 (정도) 페이지 넘어가면  페이지 표시  1~10 10개씩 앞뒤로 넘기기   --%>
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