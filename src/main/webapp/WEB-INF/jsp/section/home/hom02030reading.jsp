<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "hom_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <span class="section1_nav"><i class="icon-home"></i>질문/건의</span> <%--목록화면에서 클릭하면 읽히는--%>
                <div class="section1_btn">
                    <button id="list_btn" onclick=""><a href="hom02030.jsp">목록</a></button>                  
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <span style="font-weight: 600;">제 목 :&nbsp; 
                        <****> 
                    </span>
                    <span class="section1_btn">
                        <****> (<****>)&emsp; <%--단지명 (아이디)--%> <****>&emsp; <%--접수일시--%> 
                    </span>
                </div>
            </div>
            <div>
                <textarea id="" class="hom02030w_textarea"> </textarea>
            </div>
            <div class="section3_line1">
                <span class="">첨부파일 :&nbsp; 
                        <****> 
                </span>
            </div>
            <div class="section_middle_title">
                <span><i class="icon-pause"></i>답변</span>
                <span class="section_middle_btn">
                    <button id="save_btn" onclick="" class="admin_btn">저장</button>
                </span>               
            </div>
            <div>
                <textarea id="" class="hom02030w_textarea"> </textarea>
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>