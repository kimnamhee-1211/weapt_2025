<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "min_nav.jsp" %>
>

        <div id="section">
            <div class="section1">
                <div class="section1_nav"><i class="icon-phone-squared"></i>민원조회</div>
                <div class="section1_btn">
                    <button id="search_btn" onclick="">검색</button>
                    <button id="print_btn" onclick="" class="print_btn">인쇄</button>
                </div>
            </div>
            <div class="section2">
                <div class="section2_line3">
                    <form action="." method="post">
                        <div>
                            <span>기간 :&nbsp;
                                <input type="date" id="firstDayOfMonth" value="<%= firstDayOfMonth %>">&nbsp; ~ &nbsp;
                                <input type="date" id="today"  value="<%= today %>"> 
                            </span>
                            <span>&emsp;구분 :&nbsp;
                                <select id="gubun" class="select_cont100">
                                    <option value="gubun"><****></option>
                                </select>
                            </span>
                            <span>&emsp;상태 :&nbsp;
                                <select id="condition" class="select_cont100">
                                    <option value="condition"><****></option>
                                </select>
                            </span>
                            <span class="">&emsp;
                                <input  type="checkbox" id="recently" checked>
                                <label for="recently">&nbsp;최근일자순&emsp;</label>
                            </span>
                        </div>
                        <div>
                            <span class="search-box">세대/공용구분 :&nbsp;
                                <select id="sedae_gubun" class="select_cont100">
                                    <option value="all">전체</option>        <!-- 전체일때 둘다 안보인>-->
                                    <option value="sedae">세대</option>     
                                    <option value="gongyong">공용</option>
                                </select>&emsp;
                                <span id="sedae">
                                <input type="" id="" name="" class="box50">동
                                <input type="" id="" name="" class="box50">호&emsp;~&emsp;</td> 
                                <input type="" id="" name="" class="box50">동
                                <input type="" id="" name="" class="box50">호&emsp;&emsp;&emsp;
                                </span>
                                <span id="gongyong">
                                <input type="radio" id="" name=""> 전체공용&emsp; 
                                <input type="radio" id="" name=""> 동별공용&emsp;
                                <input type="radio" id="" name=""> 동외공용&emsp;                           
                                </span>
                            </span>
                        </div>
                        <div>
                            <span class="search-box">민원내용 :&nbsp;
                                <select id="sedae_gubun" class="select_cont150">
                                    <option value="all_2">접수+처리내용</option>
                                    <option value="receipt">접수내용</option>
                                    <option value="handling">처리내용</option>
                                </select>&emsp;                             
                                <input style="width:713px; height:20px;" type="text" placeholder=" 검색어를 입력하십시오.">                   
                            </span>
                        </div>
                    </form>                                               
                </div> 
            </div>
            <div id=""  style="height: 546px; border: 1px solid #bcbcbc;">
                <div id="" name="">
                    민원조회 그리드영역
                </div>
            </div>
        </div>
    </div>

<%@ include file = "../../inc_footer.jsp" %>