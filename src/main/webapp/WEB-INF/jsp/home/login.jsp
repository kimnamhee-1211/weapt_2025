<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : egovSampleList.jsp
  * @Description : Sample List 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
  System.out.println("로그인 페이지 !!");
  String pbkey = session.getAttribute("pbkey")==null?"":session.getAttribute("pbkey").toString();

  System.out.println("pbkey => "+pbkey);
  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><spring:message code="title.sample" /></title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jsencrypt/3.3.2/jsencrypt.min.js"></script>
    <script type="text/javaScript" language="javascript" defer="defer">
	    function checkLogin(userSe) {
		    // 일반회원
		    document.loginForm.rdoSlctUsr[0].checked = true;
		    document.loginForm.rdoSlctUsr[1].checked = false;
		    document.loginForm.rdoSlctUsr[2].checked = false;
		    document.loginForm.userSe.value = "GNR";
		}
		
		function actionLogin() {
			if (document.loginForm.id.value =="") {
		        alert("<spring:message code="comUatUia.validate.idCheck" />"); 
		    } else if (document.loginForm.password.value =="") {
		        alert("<spring:message code="comUatUia.validate.passCheck" />");
		    } else {
		    	document.loginForm.password.value = encryptWithJS();
		    	
		        document.loginForm.action="<c:url value='/login'/>";
		        document.loginForm.submit();
		    }
		}
		
		
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
		
		function getid(form) {
			document.loginForm.checkId.checked = ((document.loginForm.id.value = getCookie("saveid")) != "");
		}
		
		function fnInit() {
			getid(document.loginForm);
		    
		    fnLoginTypeSelect("typeGnr");
		    
		    refreshCaptcha();
		    encryptWithJS();
		    
		}
		
		function fnLoginTypeSelect(objName){
		
				//document.getElementById("typeGnr").className = "";
				//document.getElementById(objName).className = "on"; 
				
				document.loginForm.userSe.value = "GNR";
		}
		
		function fnShowLogin(stat) {
			
		}
		
		function fnCallBackLaw(retVal){
			if (retVal) {
				alert('retVal = ' + retVal);
			}
		}
		
		/*
		function fnPrindUBI(){
	    	fnUBIPopupModal('ubiBasic.jsp','aaa=111','800px','800px','scroll:no;status:no;center:yes;resizable:yes;','fnCallBackLaw');
	    }
	    */
		$(function () {
			$("#id").keydown(function(key){
				if (key.keyCode == 13) { // 엔터키면
					$("#password").focus();
		        }
			});
			$("#password").keydown(function(key){
				if (key.keyCode == 13) { // 엔터키면
					actionLogin();
		        }
			});
		})
		
		// 입력값 자동 대문자 변환
        document.getElementById('captchaInput').addEventListener('input', function(e) {
            e.target.value = e.target.value.toUpperCase();
            // 입력 시 에러 스타일 제거
            // e.target.classList.remove('error', 'success');
        });
		
		// CAPTCHA 새로고침
        function refreshCaptcha() {
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
                hideMessage();
                input.focus();
            };

            // 서버에 새로고침 요청
            fetch('captcha?action=refresh', { method: 'GET' })
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
</head>

<body onload="fnInit()" style='background-image: url( "/resources/images/pastel.jpg" ); background-repeat: no-repeat; background-position:center top; background-attachment: fixed;'>
    <div id="content">
		<div style="text-align:center;">
			<div style="float:left; width:25%">
				&nbsp;
			</div>
			<div style="float:left; width:50%">
				&nbsp;
			</div>
			<div style="float:left; width:25%;">
				<!-- 일반로그인 -->
				<div class="login_form">
					<form:form name="loginForm" id="loginForm" action="<c:url value='/goPage.do'/>" method="post">
						<input type="hidden" id="message" name="message" value="<c:out value='${message}'/>">
						<input type="hidden" id="formUrl" name="formUrl" value="x_admin/login">
						
						<fieldset>
							<img src="<c:url value='/resources/images/weapt_logo5.png'/>" style="width:180px; height:60px; margin:30px 30px 0px 40px; text-align:center;" alt="login title image"  title="login title image"> 
							<div class="login_input">
								<ul>
									<!-- 아이디 -->
									<c:set var="title"><spring:message code="comUatUia.loginForm.id"/></c:set>
									<li>
										<label for="id">${title}</label>
										<input type="text" value="joy" name="id" id="id" maxlength="10" title="${title} ${inputTxt}" placeholder="${title} ${inputTxt}">
									</li>
									<!-- 비밀번호 -->
									<c:set var="title"><spring:message code="comUatUia.loginForm.pw"/></c:set>
									<li>
										<label for="password">${title}</label>
										<input type="password" value="4175" name="password" id="password" maxlength="13" title="${title} ${inputTxt}" placeholder="${title} ${inputTxt}">
									</li>
									<!-- 인증 -->
									<c:set var="title">인증</c:set>
									<li>
										<label for="captchaText">${title}</label>
										<img id="captchaImage" class="captcha-image" src="" alt="CAPTCHA 이미지">
										<input type="text" value="" name="captchaInput" id="captchaInput" maxlength="6" title="" placeholder="">
									</li>
									<!-- 아이디 저장 -->
									<c:set var="title"><spring:message code="comUatUia.loginForm.idSave"/></c:set>
									<li class="chk">
										<input type="checkbox" name="checkId" class="check2" onclick="javascript:saveid(document.loginForm);" id="checkId">${title}
									</li>
									<li>
										<input type="button" class="btn_login" value="<spring:message code="comUatUia.loginForm.login"/>" onclick="actionLogin()"> <!-- 로그인  -->
									</li>
								</ul>
							</div>
							
							
						</fieldset>
						
						<input name="userSe" type="hidden" value="GNR"/>
						<input name="j_username" type="hidden"/>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	
	<div id="footer">
		<div style="text-align:center;">
			<div style="float:left; width:25%">
				&nbsp;
			</div>
			<div style="float:left; width:50%">
				Apt & business Solution Inc. All rights reserved<br/>
				TEL &nbsp;&nbsp; 031-905-6741 &nbsp;&nbsp;&nbsp;&nbsp; FAX &nbsp;&nbsp; 031-905-6740
			</div>
			<div style="float:left; width:25%">
				&nbsp;
			</div>
		</div>
	</div>	
</body>
</html>
