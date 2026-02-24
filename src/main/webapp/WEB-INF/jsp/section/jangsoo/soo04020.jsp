<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../../inc_head.jsp" %>
<%@ include file = "../../inc_nav.jsp" %>
<%@ include file = "soo_nav.jsp" %>

        <div id="section">
            <div class="section1">
                <div class="section1_nav">
                    <span><i class="icon-recycle"></i>적립요구액(연간수선비)</span>
                    <span class="section1_nav_mic">&emsp;
                        <i class="icon-mic"></i>연간수선비 적립요구액은 장기수선계획 수립시 이용되는 메뉴입니다. 
                    </span>
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
                            <select id="year_month"  class="select_cont100"  >
                                <option value="year_month"><****></option>
                            </select>
                        </span>                       
                    </form>
                </div>
            </div>
            <div id="" class="soo04020_gridcontainer">
                <div style="height:235px; border: 1px solid #bcbcbc;" >
                    <div id="" class="">
                        그리드영역
                    </div>
                </div>
                <div>
                    <table class="soo04020_table">
                        <tbody>
                            <tr>
                                <td rowspan='2' style="width:20%; text-align:left;">&#9726&nbsp;장기수선충당금 면적단가&emsp; =</td>
                                <td style="border-bottom:1px solid #bcbcbc;">장기수선계획기간 중의 연간추정수선비총액</td>
                                <td rowspan='2' style="width:5%"> = </td>
                                <td style="border-bottom:1px solid #bcbcbc;" ><****></td>
                                <td rowspan='2'>= <****>원(m&#178; . 월)&nbsp; 
                                <!-- <button style="height:25px;">면적단가</button> -->                                
                                    <span class="section_middle_btn">
                                        <input type="checkbox" id="layer_popup" class="layer_popup">
                                        <label for="layer_popup" class="pop_labal popup_btn">면적단가</label>
                                        <!-- 변경 팝업시작--> 
                                        <div class="layer_bg">
                                            <div class="popup" style="width:400px;">
                                                <div class="pop_title">&#10004;면적단가설정</div>
                                                <form action="." method="post">
                                                    <div style="padding: 30px; border: 1px solid #bcbcbc;">
                                                        <span class="search-box">&emsp;&emsp;&emsp;
                                                            <select id="" class="select_cont100">
                                                                <option  value=""><****></option> <!-- 공통코드 124-->  
                                                            </select>&emsp;&emsp;
                                                            <select id="" class="select_cont100">
                                                                <option value=""><****></option> <!-- 공통코드 123-->
                                                            </select>                       
                                                        </span>
                                                    </div>
                                                </form>
                                                <div class="pop_btn">
                                                    <button id="new_save_btn" onclick="">저장</button>
                                                    <label for="layer_popup" class="popup_closs_btn">닫기</label>                    
                                                </div>
                                            </div>
                                        </div>
                                        <!-- 팝업끝-->
                                    </span>
                                </td>
                            </tr>
                            <tr>                        
                                <td>총공급면적 &#10005; 12 &#10005; 계획기간(년) </td>
                                <td> <****> (m&#178;) &#10005; 12(개월) &#10005; <****>(년)</td>                        
                            </tr>
                        </tbody>
                    </table>
                </div>
                &#9726&nbsp;월간 세대별 장기수선충당금 적립요구액 (연간수선비)
                </div>
                <div style="height:268px; border: 1px solid #bcbcbc;">
                    <div id="" name="" class="">
                        그리드영역
                    </div>
                </div>
            </div>            
        </div>
    </div>
<%@ include file = "../../inc_footer.jsp" %>