<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

                    <div class="layer_bg">
                        <div class="popup" style="width:420px;">
                            <div class="pop_title">&#10004; &nbsp;인 쇄</div>
                            <form action="." method="post">
                                <div style="margin-top: 10px; padding: 15px; border: 1px solid #bcbcbc;">
                                    <div id="">&#9726&nbsp;인쇄기간 :&nbsp;  <!--일단은 today today 로 표시-->
                                    <input type="date" id="st_date" value="<%= today %>">&nbsp; ~ &nbsp;<input type="date" id="end_date" value="<%= today %>">
                                    </div>
                                </div>
                            </form>
                            <div >
                                <i class="icon-mic"></i>3개월 기간내 인쇄가 가능합니다.
                            </div>
                            <div class="pop_btn">
                                <span id="print_btn" onclick="" class="popup_btn">인쇄</span>
                                <label for="layer_popup" class="popup_closs_btn">닫기</label>                    
                            </div>
                        </div>
                    </div>