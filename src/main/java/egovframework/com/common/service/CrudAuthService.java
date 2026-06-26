package egovframework.com.common.service;

import egovframework.com.login.model.LoginVO;

import java.util.List;
import java.util.Map;

public interface CrudAuthService {

    public Map<String, Object> getCrudAuth(String menuId, String userid);


}
