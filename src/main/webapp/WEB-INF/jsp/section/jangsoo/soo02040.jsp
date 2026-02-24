<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "soo_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <i class="icon-recycle"></i>장기수선계획(상세)
                </div>
                 <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line1">
                    <form action="." method="post">
                        <span class="search-box">수립조정년월 :&nbsp;
                            <select id="year_month" class="select_cont100">
                                <option value="year_month"><****></option>  <!-- ****-** -->  
                            </select>&emsp;                       
                        </span>
                        <span class="select-container">&emsp;
                            <select id="jan_label_1" name="" class="select_cont150">
                                <option value="jan_label_1"><****></option>
                            </select>
                        </span>
                        <span class="select-container">&emsp;
                            <select id="jan_label_2" name="" class="select_cont150">
                                <option value="jan_label_2"><****></option>
                            </select>
                        </span>
                        <span class="select-container">&emsp;
                            <select id="jan_label_3" name="" class="select_cont150">
                                <option value="jan_label_3"><></option>
                            </select>
                        </span>   
                        <span>&emsp;
                            <input  type="checkbox" id="" name="" class="">&nbsp;실시 및 계획 포함&emsp;                        
                        </span>                      
                    </form>
                </div>
            </div>
            <div id=""  style="height: 611px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    장기수선계획(상세) 그리드영역
                </div>
            </div>            
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>