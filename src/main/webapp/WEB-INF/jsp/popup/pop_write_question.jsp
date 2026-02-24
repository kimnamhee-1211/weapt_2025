<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

                    <div class="layer_bg">
                        <div class="popup" style="width:910px;">
                            <div class="pop_title0" >
                                <span id="">&#10004;&nbsp;질문/건의</span>  <%-- 각 게시판 메뉴명--%>
                                <div class="section1_btn">
                                    <button id="save_btn" onclick="">제출</button>  <%-- 찾은 파일도 함께 저장--%>
                                    <label for="layer_popup" class="popup_closs_btn">닫기</label>                    
                                </div>
                            </div>  
                            <div class="section2">
                                <div class="section2_line1">
                                    <form action="." method="post">
                                        <span>제목 :&nbsp;
                                            <input type="text" id="title" class="box_width700">                        
                                        </span>
                                    </form>
                                </div>
                            </div>                            
                            <div>
                                <textarea class="pop_write_textarea"></textarea>
                            </div>
                            <div class="question_mic">
                                1. 질문/건의 전 자주하는질의응답 메뉴에서 질의내용을 검색해 보시기 바랍니다. <br>
                                2. 제목 및 내용은 제출하면 삭제할 수 없으니 전체 글을 작성 후 제출바랍니다.
                            </div>
    
                            <%--여러 파일 업로드 및 삭제 input_file.html 참조--%>
                            <div >
                                <%--<form action="/upload" method="post" enctype="multipart/form-data">--%>

                                    <input type="file" id="fileInput" />
                                    <button class="find_btn" id="selectFileBtn">파일찾기</button>

                                    <div class="file-list" id="fileList"></div>

                                <%--</form>--%>        
                            </div>
                        </div>
                    </div>
                    <%--script - jsp 와 충돌 해결바람 script input_file.html 참조 --%>
                    <script>
                       
                      
                    </script>
                
                        
   

 
