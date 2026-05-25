package egovframework.com.baseCrud.support;

import egovframework.com.login.model.LoginVO;

import java.util.List;
import java.util.Map;

public class SetParam {

	private SetParam() {}

	public static final String LOGIN_ID = "LOGIN_ID";
	public static final String LOGIN_NAME = "LOGIN_NAME";
	public static final String LOGIN_EMP_NO = "LOGIN_EMP_NO";
	public static final String LOGIN_OFFICE_CODE = "LOGIN_OFFICE_CODE";
	public static final String LOGIN_COMP_CODE = "LOGIN_COMP_CODE";
	public static final String LOGIN_USERGROUP_ID = "LOGIN_USERGROUP_ID";
	public static final String LOGIN_MGMCOMP_CODE = "LOGIN_MGMCOMP_CODE";
	public static final String LOGIN_MGM_CODE = "LOGIN_MGM_CODE";
	public static final String LOGIN_WORK_GROUP_ID = "LOGIN_WORK_GROUP_ID";
	public static final String LOGIN_LEVEL_CODE = "LOGIN_LEVEL_CODE";
	public static final String LOGIN_UP_MGMUSER_ID = "LOGIN_UP_MGMUSER_ID";
	public static final String LOGIN_UP_MGMUSER_NAME = "LOGIN_UP_MGMUSER_NAME";


	//loginUser param set
	public static void setUserToParam(LoginVO loginUser, Map<String, Object> param){
		param.put(LOGIN_ID, (String)loginUser.getUserId());
		param.put(LOGIN_NAME, (String)loginUser.getUserName());
		param.put(LOGIN_EMP_NO, (String)loginUser.getEmpNo());
		param.put(LOGIN_OFFICE_CODE, (String)loginUser.getOfficeCode());
		param.put(LOGIN_COMP_CODE, (String)loginUser.getCompCode());
		param.put(LOGIN_USERGROUP_ID, (String)loginUser.getUsergroupId());
		param.put(LOGIN_MGMCOMP_CODE, (String)loginUser.getMgmcompCode());
		param.put(LOGIN_MGM_CODE, (String)loginUser.getMgmCode());
		param.put(LOGIN_WORK_GROUP_ID, (String)loginUser.getWorkGroupId());
		param.put(LOGIN_LEVEL_CODE, (String)loginUser.getLevelCode());
		param.put(LOGIN_UP_MGMUSER_ID, (String)loginUser.getUpMgmuserId());
		param.put(LOGIN_UP_MGMUSER_NAME, (String)loginUser.getUpMgmuserName());

	}

	public static void setUserToParam(LoginVO loginUser, List<Map<String, Object>> param){
		for (Map<String, Object> row : param) {
			row.put(LOGIN_ID, (String)loginUser.getUserId());
			row.put(LOGIN_NAME, (String)loginUser.getUserName());
			row.put(LOGIN_EMP_NO, (String)loginUser.getEmpNo());
			row.put(LOGIN_OFFICE_CODE, (String)loginUser.getOfficeCode());
			row.put(LOGIN_COMP_CODE, (String)loginUser.getCompCode());
			row.put(LOGIN_USERGROUP_ID, (String)loginUser.getUsergroupId());
			row.put(LOGIN_MGMCOMP_CODE, (String)loginUser.getMgmcompCode());
			row.put(LOGIN_MGM_CODE, (String)loginUser.getMgmCode());
			row.put(LOGIN_WORK_GROUP_ID, (String)loginUser.getWorkGroupId());
			row.put(LOGIN_LEVEL_CODE, (String)loginUser.getLevelCode());
			row.put(LOGIN_UP_MGMUSER_ID, (String)loginUser.getUpMgmuserId());
			row.put(LOGIN_UP_MGMUSER_NAME, (String)loginUser.getUpMgmuserName());
		}
	}






	
}
