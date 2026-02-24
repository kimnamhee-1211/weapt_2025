<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

                    <div class="layer_bg">
                        <div class="popup" style="width:540px;">
                            <div class="pop_title" style="border:none" >&#10004; &nbsp;광고게시문</div>
                            <form action="." method="post">
                                <table style="width:520px;">
                                    <tbody >
                                        <colgroup>
                                            <col style ="width:20%">
                                            <col style ="width:30%">
                                            <col style ="width:20%">
                                            <col style ="width:30%">
                                        <colgroup>
                                        <tr>
                                            <th>게시시작</th>
                                            <td><input type="date" id="today" value="<%= today %>"></td>
                                            <th>게시종료</th>
                                            <td><input type="date" id="today" value="<%= today %>"></td>
                                        </tr>
                                        <tr>
                                            <th>제목</th>
                                            <td colspan="3"><input type="text" id="" ></td>
                                        </tr>
                                        <tr>
                                            <th>광고주</th>
                                            <td><input type="text" id="" ></td>
                                            <th>대표자명</th>
                                            <td><input type="text" id="" ></td>
                                        </tr>
                                        <tr>
                                            <th>연락처</th>
                                            <td><input type="text" id="" ></td>
                                            <th>금액(원)</th>
                                            <td><input type="number" id="" ></td>
                                        </tr>
                                        <tr>
                                            <th>내용</th>
                                            <td colspan='3'><input type="text" id="" ></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </form>

                            <div class="pop_btn">
                                <span id="save_btn" onclick="" class="popup_btn">등록</span>
                                <label for="layer_popup" class="popup_closs_btn">닫기</label>                    
                            </div>
                        </div>
                    </div>
                
                        
   

 
