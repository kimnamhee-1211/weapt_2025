package egovframework.com.section.service;

import egovframework.com.login.model.LoginVO;

import java.util.List;
import java.util.Map;

public interface JangsooService {

    public Map<String, Object> delete_soo02010_grid1(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
    public List<Map<String, Object>> selectList_soo02010_grid2(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
    public List<Map<String, Object>> selectList_soo02010_pop3Grid1(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
    public Map<String, Object> change_planMonth(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
    public Map<String, Object> copy_planMonth(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
    public Map<String, Object> add_repairCode(String sectionId, String component, List<Map<String, Object>> param, LoginVO loginUser, String pgId, String menuId);

    public List<Map<String, Object>> selectList_soo02020_grid1(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
    public Map<String, Object> delete_soo02020_grid1(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
    public Map<String, Object> saveList_soo02020_grid3(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
    public List<Map<String, Object>> selectList_soo02030_grid1(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
}
