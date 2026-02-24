<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "hom_nav.jsp" %>

        <div id="section">
            <div class="section1">    <%--관리자 페이지 임. 처음 작성 페이지 그리고 그리드 클릭으로 써진 것 나올때 사용--%> 
                <span class="section1_nav"><i class="icon-home"></i>법령자료실(관리자작성 읽기[수정])</span>
                <div class="section1_btn">
                    <button id="save_btn" onclick="">저장</button>
                    <button id="list_btn" onclick=""><a href="hom03010.jsp">목록</a></button>
                    <button id="del_btn" onclick="" class="del_btn">삭제</button>  <%--그리드 클릭으로 써진 것 나올때만--%>                      
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="search-box">제목 :&nbsp;
                            <input type="text" id="title" class="box_width600">                        
                        </span>
                        <span class="search-box">&emsp;작성자 :&nbsp;
                            <input type="text" id="writer" class="box_width100">                        
                        </span>
                        <span class="search-box">&emsp;작성일 :&nbsp;
                            <input type="date" id="today" value="<%= today %>">                      
                        </span>
                    </form>
                </div>
            </div>
            <div style="height: 564px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                   스마트 에디터 영역
                </div>
            </div>
            <div class="section3_line1">
                <form action="/upload" method="post" enctype="multipart/form-data">
                    <input type="file" name="myfile" style="border:none; width: 90%;">  <!--책임관리자용으로 파일형식 크기 제한없음-->
                    <button type="submit">전송</button> 
                </form>                
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>