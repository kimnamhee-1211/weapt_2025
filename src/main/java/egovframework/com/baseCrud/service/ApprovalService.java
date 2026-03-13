package egovframework.com.baseCrud.service;

import egovframework.com.login.model.LoginVO;

import java.util.List;
import java.util.Map;

public interface ApprovalService {

    public List<Map<String, Object>> getApprDuty(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

    public List<Map<String, Object>> getApprDutyLine(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

    public List<Map<String, Object>> selectApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

    public List<Map<String, Object>> processApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

    public List<Map<String, Object>> processCnlApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

}
