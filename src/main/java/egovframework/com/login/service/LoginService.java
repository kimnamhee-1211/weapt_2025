package egovframework.com.login.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.com.login.model.LoginVO;

public interface LoginService {

    public LoginVO login(LoginVO loginuser) throws Exception;


}
