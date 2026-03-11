package egovframework.com.baseCrud.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.com.login.model.LoginVO;



public interface BaseBoardService {

	public Map<String, Object> boardSelectOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

	public Map<String, Object> boardSave(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

	public Map<String, Object> boardDeleteOne(String sectionId, String component,  Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

}
