package egovframework.com.baseCrud.service;

import java.util.Map;

import egovframework.com.login.model.LoginVO;


public interface BaseBoardService {

    public Map<String, Object> boardSelectOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

    public int boardSave(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

    public int boardDeleteOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

}
