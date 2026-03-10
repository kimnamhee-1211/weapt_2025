<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  System.out.println("로그인 페이지 !!");
  String pbkey = session.getAttribute("pbkey")==null?"":session.getAttribute("pbkey").toString();  
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/we_style.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/we_style_pop.css"/> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontello_we/css/animation.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontello_we/css/menu.css" >
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_grid.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/we_crud.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jsencrypt/3.3.2/jsencrypt.min.js"></script>    
    <style>
   
  </style>
  <title>종합관리솔루션</title>
  
  <script type="text/javaScript" language="javascript" defer="defer">
	    function setCookie (name, value, expires) {
		    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
		}
		
		function getCookie(Name) {
		    var search = Name + "=";
		    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
		        offset = document.cookie.indexOf(search);
		        if (offset != -1) { // 쿠키가 존재하면
		            offset += search.length;
		            // set index of beginning of value
		            end = document.cookie.indexOf(";", offset);
		            // 쿠키 값의 마지막 위치 인덱스 번호 설정
		            if (end == -1)
		                end = document.cookie.length;
		            return unescape(document.cookie.substring(offset, end));
		        }
		    }
		    return "";
		}
		
		function saveid(form) {
		    var expdate = new Date();
		    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
		    if (form.checkId.checked)
		        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
		    else
		        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
		    setCookie("saveid", form.id.value, expdate);
		}
		
		function fnCallBackLaw(retVal){
			if (retVal) {
				alert('retVal = ' + retVal);
			}
		}
		
		
    </script>
</head>
<body style="background-color: #f4f4f9;">
    <div id="index">
        <div class="slider-container">
            <div id="logo_area"> 공동주택 &#8226; 집합건물 관리를 위한<br><h1>&emsp;종합관리솔루션</h1> </div>
            <div class="arrow left">&#10094;</div>
            <div class="slider">
                <div class="slider-track">
                    <!-- 10개의 콘텐츠 -->
                    <div class="item">
                    <span class="icon_back"><i class="icon-calendar-plus-o"></i></span><br>       
                    일정관리
                    </div>

                    <div class="item">
                    <span class="icon_back"><i class="icon-volume-control-phone"></i></span><br>       
                    민원관리
                    </div>

                    <div class="item">
                    <span class="icon_back"><i class="icon-chart-bar"></i></span><br>       
                    관리일반
                    </div>

                    <div class="item">
                    <span class="icon_back"><i class="icon-edit"></i></span><br>       
                    행정관리
                    </div>

                    <div class="item">
                    <span class="icon_back"><i class="icon-docs"></i></span><br>       
                    일지결재
                    </div>

                    <div class="item">
                    <span class="icon_back"><i class="icon-cubes"></i></span><br>       
                    재고관리
                    </div>

                    <div class="item">
                    <span class="icon_back"><i class="icon-cog-alt"></i></span><br>       
                    장비관리
                    </div>

                    <div class="item">
                    <span class="icon_back"><i class="icon-id-card-o"></i></span><br>       
                    환경보안
                    </div>

                    <div class="item">
                    <span class="icon_back"><i class="icon-recycle"></i></span><br>       
                    장기수선
                    </div>

                    <div class="item">
                    <span class="icon_back"><i class="icon-user-add"></i></span><br>       
                    회의단체
                    </div>
                </div>
            </div>
            <div class="arrow right">&#10095;</div>
            <div id="allmenu_area_space"> </div>
            <div id="allmenu_area">
                <input type="checkbox" id="allmenu_layer_popup" class="layer_popup" >
                <label for="allmenu_layer_popup" class="pop_labal iconmenu">
                    <h2><i class=" icon-menu-1"></i></h2>
                    <h3>전체메뉴</h3>
                </label>
                <!-- 팝업시작-->
                <%@ include file = "popup/pop_allmenu.jsp" %>
                <!-- 팝업끝-->
            </div>
        </div>

        <div id="slider-container2" >
            <div class="slider-container2">
                <div class="slides" id="slides">
                    <div class="slide"><img src="/resources/images/index01.png" alt="슬라이드 1"></div>
                    <div class="slide"><img src="/resources/images/index02.png" alt="슬라이드 2"></div>
                    <div class="slide"><img src="/resources/images/index03.png" alt="슬라이드 3"></div>
                    <div class="slide"><img src="/resources/images/index04.png" alt="슬라이드 4"></div>
                    <div class="slide"><img src="/resources/images/index05.png" alt="슬라이드 5"></div>
                    <div class="slide"><img src="/resources/images/index06.png" alt="슬라이드 6"></div>
                    <div class="slide"><img src="/resources/images/index07.png" alt="슬라이드 7"></div>
                    <div class="slide"><img src="/resources/images/index08.png" alt="슬라이드 8"></div>
                    <div class="slide"><img src="/resources/images/index09.png" alt="슬라이드 9"></div>
                    <div class="slide"><img src="/resources/images/index10.png" alt="슬라이드 10"></div>
                </div>
            </div>
            <div class="buttons">
                <button class="btn active" data-index="0">1</button>
                <button class="btn" data-index="1">2</button>
                <button class="btn" data-index="2">3</button>
                <button class="btn" data-index="2">4</button>
                <button class="btn" data-index="2">5</button>
                <button class="btn" data-index="2">6</button>
                <button class="btn" data-index="2">7</button>
                <button class="btn" data-index="2">8</button>
                <button class="btn" data-index="2">9</button>
                <button class="btn" data-index="2">10</button>
            </div>
        </div>

        <div id="login_aea">
            <div class="login-container">
                <h2>로그인</h2>
                <form id="login-form" method="post">
                    <div class="input-group">
                        <label for="userId">아이디</label>
                        <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required>
                    </div>
                    <div class="input-group">
                        <label for="password">비밀번호</label>
                        <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
                    </div>
                    <div class="input-group">
                        <label for="password">인증번호</label>
                        <span>
                            <img id="captchaImage" class="captcha-image" src="" alt="CAPTCHA 이미지">
                            <span id="refresh" onclick="getCaptcha()">새로고침</span>
                        </span>
                        <input type="text" value="" name="captchaInput" id="captchaInput" maxlength="6" required>
                    </div>
                    <div class="remember-me">
                        <input type="checkbox" id="remember-me">
                        <label for="remember-me">아이디 기억</label>
                    </div>
                    <button type="submit">로그인</button>
                </form>
            </div>
        </div>
        <div id="footer_resize"></div>
        <div id="index_footer">
            <div class="footer_left">
                &nbsp;Copyright(c)&emsp;에이앤비솔루션(주)&emsp;All right Reserved.&emsp;Tel.031-905-6741&emsp;Fax.031-905-6740&emsp;
                <a href="">[<i class="icon-phone-squared"></i>견적문의 031-905-6744 ]</a>&emsp;
            </div>
        </div>
    </div>
    <script>
    const track = document.querySelector('.slider-track');
    const leftBtn = document.querySelector('.arrow.left');
    const rightBtn = document.querySelector('.arrow.right');

    const itemWidth = 140; // 80px width + 25px margin
    const totalItems = 10;
    const visibleItems = 5;

    let position = 0; // 현재 왼쪽에서 이동한 수

    leftBtn.addEventListener('click', () => {
        if (position > 0) {
        position--;
        track.style.transform = `translateX(-\${itemWidth * position}px)`;
        }
    });

    rightBtn.addEventListener('click', () => {
        if (position < totalItems - visibleItems) {
        position++;
        track.style.transform = `translateX(-\${itemWidth * position}px)`;
        }
    });
    </script>

    <script>
    const slides = document.getElementById('slides');
    const buttons = document.querySelectorAll('.btn');
    let currentIndex = 0;
    let autoSlide = true;
    const totalSlides = buttons.length;

    function showSlide(index) {
        slides.style.transform = `translateX(-\${index * 100}%)`;
        buttons.forEach(btn => btn.classList.remove('active'));
        buttons[index].classList.add('active');
        currentIndex = index;
    }

    function nextSlide() {
        currentIndex = (currentIndex + 1) % totalSlides;
        showSlide(currentIndex);
    }

    let slideInterval = setInterval(() => {
        if (autoSlide) nextSlide();
    }, 3000); // 3초마다 전환

    buttons.forEach(button => {
        button.addEventListener('click', () => {
	        const index = parseInt(button.getAttribute('data-index'));
	        autoSlide = false;
	        clearInterval(slideInterval);
	        showSlide(index);
        });
    });
    </script>


    <script>
    // 페이지 로드 시 기억된 아이디 자동 입력
    window.onload = function() {
        if (localStorage.getItem('rememberMe') === 'true') {
            document.getElementById('userId').value = localStorage.getItem('userId');
            document.getElementById('remember-me').checked = true;
        }

        getCaptcha();
    };

    // 로그인 폼 제출 시 아이디 기억 여부 확인
    document.getElementById('login-form').addEventListener('submit', function(event) {
        event.preventDefault(); // 기본 제출 이벤트 방지

        const username = document.getElementById('userId').value;
        const rememberMe = document.getElementById('remember-me').checked;

        if (rememberMe) {
            localStorage.setItem('userId', username); // 아이디 저장
            localStorage.setItem('rememberMe', 'true'); // "아이디 기억" 상태 저장
        } else {
            localStorage.removeItem('userId'); // 아이디 삭제
            localStorage.removeItem('rememberMe'); // "아이디 기억" 상태 삭제
        }

        // 로그인 후 처리 (예: 서버에 로그인 요청)
        // alert(`로그인 시도: \${username}`);
        var loginForm = document.querySelector("#login-form");
        if (loginForm.id.value =="") {
	        alert("<spring:message code="comUatUia.validate.idCheck" />"); 
	    } else if (loginForm.password.value =="") {
	        alert("<spring:message code="comUatUia.validate.passCheck" />");
	    } else {
	    	loginForm.password.value = encryptWithJS();
	    	loginForm.action="<c:url value='/login'/>";
	    	loginForm.submit();
	    }
    });
 	// 입력값 자동 대문자 변환
    document.getElementById('captchaInput').addEventListener('input', function(e) {
        e.target.value = e.target.value.toUpperCase();
        // 입력 시 에러 스타일 제거
        // e.target.classList.remove('error', 'success');
    });
	
	// CAPTCHA 가져오기
    function getCaptcha() {
        const img = document.getElementById('captchaImage');
        const input = document.getElementById('captchaInput');
        
        // 로딩 효과
        img.style.opacity = '0.5';
        
        // 새 이미지 로드
        const timestamp = new Date().getTime();
        img.src = 'captcha?action=image&t=' + timestamp;
        
        img.onload = function() {
            img.style.opacity = '1';
            input.value = '';
            input.classList.remove('error', 'success');
            input.focus();
        };

    }
    // CAPTCHA 새로고침
    function refreshCaptcha() {

        //서버에 새로고침 요청
        fetch('captcha?action=refresh', { method: 'GET' })
            .then(response => {
                if(response.ok){
                    const img = document.getElementById('captchaImage');
                    const input = document.getElementById('captchaInput');

                    // 로딩 효과
                    img.style.opacity = '0.5';

                    // 새 이미지 로드
                    const timestamp = new Date().getTime();
                    img.src = 'captcha?action=image&t=' + timestamp;

                    img.onload = function() {
                        img.style.opacity = '1';
                        input.value = '';
                        input.classList.remove('error', 'success');
                        input.focus();
                    };
                }
            })
            .catch(error => console.error('Refresh error:', error));

    }


	
 // CAPTCHA 음성 재생
    function playCaptchaAudio() {
        if (isAudioPlaying) {
            return;
        }

        const audioBtn = document.getElementById('audioBtn');
        const audio = document.getElementById('captchaAudio');
        
        // 버튼 상태 변경
        isAudioPlaying = true;
        audioBtn.disabled = true;
        audioBtn.innerHTML = '🔊 재생중...';
        audioBtn.classList.add('audio-playing');

        // 오디오 소스 설정
        const timestamp = new Date().getTime();
        audio.src = 'captcha?action=audio&t=' + timestamp;
        
        // 재생
        audio.play().then(() => {
            console.log('Audio playing...');
        }).catch(error => {
            console.error('Audio play error:', error);
            showMessage('음성 재생에 실패했습니다.', 'error');
            resetAudioButton();
        });

        // 재생 완료 이벤트
        audio.onended = function() {
            resetAudioButton();
        };

        // 에러 이벤트
        audio.onerror = function() {
            console.error('Audio loading error');
            showMessage('음성을 불러올 수 없습니다.', 'error');
            resetAudioButton();
        };

        // 3초 후 자동 리셋 (안전장치)
        setTimeout(() => {
            if (isAudioPlaying) {
                resetAudioButton();
            }
        }, 10000);
    }

    // 오디오 버튼 리셋
    function resetAudioButton() {
        const audioBtn = document.getElementById('audioBtn');
        isAudioPlaying = false;
        audioBtn.disabled = false;
        audioBtn.innerHTML = '🔊 음성듣기';
        audioBtn.classList.remove('audio-playing');
    }
    
    function encryptWithJS() {
    	var encryptedText = "";
    	var pbkey = "${pbkey}";
    	var jsEncrypt = new JSEncrypt();
    	jsEncrypt.setPublicKey('-----BEGIN PUBLIC KEY-----\n' + pbkey + '\n-----END PUBLIC KEY-----');
    	
        if (!jsEncrypt) {
        	alert("먼저 공개키를 가져와주세요.");
            return;
        }
        
        const plainText = document.getElementById('password').value;
        if (!plainText.trim()) {
            alert("암호화할 텍스트를 입력해주세요");
            return;
        }
        
        try {
            const encrypted = jsEncrypt.encrypt(plainText);
            if (encrypted) {
            	encryptedText = encrypted;
            } else {
            	alert("JavaScript 암호화 실패");
            }
        } catch (error) {
        	alert("JavaScript 암호화 중 오류: " + error.message);
        }
        
        return encryptedText;
    }
    </script>

</body>
</html>