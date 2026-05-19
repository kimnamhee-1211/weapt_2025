/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.com.login;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.nhncorp.lucy.security.xss.XssPreventer;

import egovframework.com.cmmn.service.CommonService;

import egovframework.com.login.model.LoginVO;
import egovframework.com.login.service.LoginService;
import egovframework.com.util.Egov.EgovProperties;
import egovframework.com.util.RSA.RSATest;

import org.slf4j.Logger;

/**
 * @Class Name : LoginController.java
 * @Description : Login Controller Class
 * @Modification Information
 * @
 * @  수정일          수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2025.09     김남희        최초생성
 *
 * @author 김남희
 * @since 2025.09
 * @version 1.0
 * @see
 *
 *  Copyright (C) by  All right reserved.
 */

@Controller
public class LoginController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

	@Resource(name = "loginService")
	protected LoginService loginService;


    //index
	@RequestMapping(value = "/start")
	public String start(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.debug("^o^ [ start ]");
//		RSATest rsaTest = new RSATest();
//		rsaTest.getPublicKey();

		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") != null){
			return "section/home/hom01010";
		}

		String publicKey = EgovProperties.getProperty("RSA.publicKey");
		session.setAttribute("pbkey", publicKey);
		
		return "index";
	}
	
	//login + 캡챠 인증
	@RequestMapping(value = "/login", method = { RequestMethod.POST })
	public String login(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.debug("^o^ [ login ] request params : "+params);
		
		RSATest rsaTest = new RSATest();
		String privateKey = EgovProperties.getProperty("RSA.privateKey");
		
		// 캡챠 검증
		HttpSession session = request.getSession();
		String captchaEnc = session.getAttribute("captchaEnc").toString();
		String captcha = rsaTest.decryptData(privateKey, captchaEnc);
		
        session.getAttribute("captcha_time");
        
        if( !captcha.equals(params.get("captchaInput"))){
        	LOGGER.debug("^o^ [ login ] 캡챠 인증 실패 !! "+captcha+" : "+params.get("captchaInput"));

        	return "redirect:/start";
        }

		// 패스워드 복호화
		String passwordEnc = params.get("password").toString();
		
		String password = rsaTest.decryptData(privateKey, passwordEnc);
		LOGGER.debug("^o^ [ login ] password 복호화 : " + password);


		LoginVO loginUser = new LoginVO();

		String userId = params.get("userId").toString();
		loginUser.setUserId(userId);
		loginUser.setPassword(password);

		loginUser = loginService.login(loginUser);

		if(loginUser != null){
			session.setAttribute("loginUser", loginUser);
	
			LOGGER.debug("^o^ [ login ] 로그인 성공 : " + userId + " / " + password);
			return "section/home/hom01010";
			
		}else{
			LOGGER.debug("^o^ [ login ] 로그인 실패 : " + userId + " / " + password);
			return "redirect:/start";
		}

	}

	//관리소변경 - 관리소 조회
	@RequestMapping(value = "/selectOffice")
	@ResponseBody
	public List<Map<String, Object>> selectOffice(@RequestParam Map<String, Object> params) throws Exception {

		List<Map<String, Object>> resultList  = loginService.selectOffice(params);

		return resultList;
	}

	//관리소변경 - 관리소 조회
	@RequestMapping(value = "/changeOffice",  method = { RequestMethod.POST })
	public String changeOffice(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

		LoginVO resultList  = loginService.changeOffice(params);

		if(resultList != null){
			HttpSession session = request.getSession();

			session.setAttribute("orginLoginUser", session.getAttribute("loginUser"));
			session.setAttribute("loginUser", resultList);

		}

		return "section/home/hom01010";

	}






}
