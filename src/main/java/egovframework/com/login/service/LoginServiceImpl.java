package egovframework.com.login.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.*;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmmn.service.CommonService;
import egovframework.com.login.dao.LoginMapper;
import egovframework.com.login.model.LoginVO;

@Service("loginService")
public class LoginServiceImpl extends EgovAbstractServiceImpl implements LoginService{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginServiceImpl.class);
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	@Resource(name = "loginMapper")
	private LoginMapper loginMapper;

	
	
	@Override
	public void login(Map<String, Object> params) throws Exception {
		
		System.out.println("login 시작");
		List<Map<String,Object>> ddd1 = (List<Map<String, Object>>) commonService.selectComList(params,"egovframework.com.cmmn.service.LoginMapper","selectLoginList");
        System.out.println("login 끝"+ddd1.size());
		List<Map<String,Object>> ddd2 = (List<Map<String, Object>>) commonService.selectComList(params,"egovframework.com.cmmn.service.SampleMapper","selectSample");
		System.out.println("login 끝"+ddd2.size());
	}



	@Override
	public LoginVO login(LoginVO loginuser) throws Exception {

		System.out.println("login 시작 : " + loginuser);

		LoginVO loginUser = loginMapper.selectLoginUser(loginuser);

		System.out.println("login 끝" + loginUser);

		return loginUser;
	}

}
