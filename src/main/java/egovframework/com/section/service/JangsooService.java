package egovframework.com.section.service;

import egovframework.com.login.model.LoginVO;

import java.util.List;
import java.util.Map;

public interface JangsooService {
    public Map<String, Object> change_planMonth(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
    public Map<String, Object> copy_planMonth(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
    public Map<String, Object> add_repairCode(String sectionId, String component, List<Map<String, Object>> param, LoginVO loginUser, String pgId, String menuId);
}
