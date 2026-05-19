<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="nav_wrap">
    <div class="nav_aside" id="aside_sojang">
        <div class="nav">관리소장</div>
        <ul class="nav_tree">
            <li id="soj02">
                <input type="checkbox" id="root2" class="tree_cb">
                <label for="root2">관리소장</label>
                <ul class="tree_nav">
                    <li id="soj01010">관리업무마감</li>
                </ul>
            </li>
            <li id="soj03">
                <input type="checkbox" id="root3" class="tree_cb">
                <label for="root3">관리자</label>
                <ul class="tree_nav">
                    <li id="soj03010">사용자관리</li>
                    <li id="soj03020">사용자권한등록</li>
                    <li id="soj03030">결재선등록</li>
                    <li id="soj03040">메시지충전</li>
                    <li id="soj03050"><a href="soj03050.jsp">Data Conversion</a></li>
                    <li id="soj03060"><a href="soj03060.jsp">마감해지</a></li>
                </ul>
            </li>

            <li id="soj04">
                <input type="checkbox" id="root4" class="tree_cb">
                <label for="root4">설정관리</label>
                <ul class="tree_nav">
                    <li id="soj04010"><a href="soj04010.jsp">민원관리설정</a></li>
                    <li id="soj04020"><a href="soj04020.jsp">안전진단양식설정</a></li>
                    <li id="soj04030"><a href="soj04030.jsp">전기안전점검약식</a></li>
                    <li id="soj04040"><a href="soj04040.jsp">설비안전점검양식</a></li>
                    <li id="soj04050"><a href="soj04050.jsp">수변전일지양식설정</a></li>
                    <li id="soj04060"><a href="soj04060.jsp">기계실일지양식설정</a></li>
                    <li id="soj04070"><a href="soj04070.jsp">점검일지양식설정</a></li>
                    <li id="soj04080"><a href="soj04080.jsp">업무일지양식설정</a></li>
                    <li id="soj04090"><a href="soj04090.jsp">장비관리설정</a></li>
                    <li id="soj04100"><a href="soj04100.jsp">재고관리설정</a></li>
                </ul>
            </li>
            <li id="soj05">
                <input type="checkbox" id="root5" class="tree_cb">
                <label for="root5">책임관리자</label>
                <ul class="tree_nav">
                    <li id="soj05010"><a href="soj05010.jsp">장기수선항목등록</a></li>
                    <li id="soj05020"><a href="soj05020.jsp">공종별단가기준예시</a></li>
                    <li id="soj05030"><a href="soj05030.jsp">휴무일등록</a></li>
                    <li id="soj05040">전산회사등록</li>
                    <li id="soj05050">관리자등록</li>
                    <li id="soj05060">관리회사등록</li>
                    <li id="soj05070">관리소등록</li>
                    <li id="soj05080">관리소현황</li>
                    <li id="soj05090">부서직책설정(공통)</li>
                    <li id="soj05100"><a href="soj05100.jsp">하드용량관리</a></li>
                    <li id="soj05110">관리자메뉴얼</li>
                    <li id="soj05120">수정사항</li>
                </ul>
            </li>
            <li id="soj06">
                <input type="checkbox" id="root6" class="tree_cb">
                <label for="root6">메시지설정</label>
                <ul class="tree_nav">
                    <li id="soj06010"><a href="soj06010.jsp">메시지금액관리</a></li>
                    <li id="soj06020"><a href="soj06020.jsp">메시지사용내역</a></li>
                    <li id="soj06030"><a href="soj06030.jsp">메시지전송관리</a></li>
                </ul>
            </li>
            <li id="soj07">
                <input type="checkbox" id="root7" class="tree_cb">
                <label for="root7">시스템관리</label>
                <ul class="tree_nav">
                    <li id="soj07010">메뉴관리</li>
                    <li id="soj07020">그룹별메뉴관리</li>
                    <li id="soj07030">세부그룹별메뉴관리</li>
                    <li id="soj07040">공통코드관리</li>
                    <li id="soj07050">Conversion 관리</li>
                </ul>
            </li>
        </ul>
    </div>
 </div>
 <script>
    //변수 설정
    const sectionId = "sojang";
    const navId = "aside_sojang";


 </script>