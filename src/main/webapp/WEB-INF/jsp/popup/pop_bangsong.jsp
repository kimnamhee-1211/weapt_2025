<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

                    <div class="layer_bg" id="pop_bangsong">
                        <div class="popup" style="width:910px;">
                            <div class="pop_title0">
                                <span id="">&#10004;&nbsp;방송문</span>
                                <div class="section1_btn"  id="pop_btn1">
                                    <button id="save_btn1" onclick="save_board1_onclick()">저장</button>
                                    <button id="del_btn1" onclick="delete_board1_onclick()">삭제</button>
                                    <button id="close_btn1" onclick="close_popup_onclick()">닫기</button>
                                </div>
                            </div>  
                            <div class="section2">
                                <div class="section2_line2">
                                    <div>
                                        <span>방송일 :&nbsp;
                                            <input type="date" id="today" value="<%= today %>">
                                        </span>
                                        <span>&emsp;방송시간 :&nbsp;
                                            <input type="text" id="title" class="box_width200">
                                        </span>
                                        <span>&emsp;방송횟수(회) :&nbsp;
                                            <input type="text" id="writer" class="box_width100">
                                        </span>
                                        <span>&emsp;방송인 :&nbsp;
                                            <input type="text" id="writer" class="box_width100">
                                        </span>
                                    </div>
                                    <div>
                                        <span>제목 :&nbsp;
                                            <input type="text" id="title" class="box_width600">
                                        </span>
                                        <span>&emsp;&nbsp;방송의뢰자 :&nbsp;
                                            <input type="text" id="writer" class="box_width100">
                                        </span>
                                    </div>
                                </div>
                            </div>                            
                            <div>
                                <textarea id="" class="pop_bangsong_textarea" data-format="html"></textarea>
                            </div>                            
                        </div>
                    </div>

                
                        
   

 
