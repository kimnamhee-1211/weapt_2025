package egovframework.com.baseCrud.service;

import egovframework.com.login.model.LoginVO;

import java.util.List;
import java.util.Map;

public interface ApprovalService {

	public List<Map<String, Object>> getApprovalDuty(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId);

	public List<Map<String, Object>> selectApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId);

	public List<Map<String, Object>> processApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId);

	public List<Map<String, Object>> processCancelApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId);

}
