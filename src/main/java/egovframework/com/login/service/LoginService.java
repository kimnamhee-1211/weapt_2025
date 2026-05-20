package egovframework.com.login.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.com.login.model.LoginVO;

public interface LoginService {

    public LoginVO login(LoginVO loginuser) throws Exception;

    public List<Map<String, Object>> selectOffice(Map<String, Object> params) throws Exception;

    public LoginVO changeOffice(Map<String, Object> params) throws Exception;

    public int checkPass(String param) throws Exception;

}
