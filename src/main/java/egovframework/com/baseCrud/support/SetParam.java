package egovframework.com.baseCrud.support;

import egovframework.com.login.model.LoginVO;

import java.util.List;
import java.util.Map;

public class SetParam {

	private SetParam() {}

	public static final String LOGINUSER_ID = "LOGINUSER_ID";
	public static final String LOGINUSER_NAME = "LOGINUSER_NAME";
	public static final String LOGINUSER_EMP_NO = "LOGINUSER_EMP_NO";
	public static final String LOGINUSER_OFFICE_CODE = "LOGINUSER_OFFICE_CODE";
	public static final String LOGINUSER_COMP_CODE = "LOGINUSER_COMP_CODE";
	public static final String LOGINUSER_USERGROUP_ID = "LOGINUSER_USERGROUP_ID";
	public static final String LOGINUSER_MGMCOMP_CODE = "LOGINUSER_MGMCOMP_CODE";
	public static final String LOGINUSER_MGM_CODE = "LOGINUSER_MGM_CODE";
	public static final String LOGINUSER_WORK_GROUP_ID = "LOGINUSER_WORK_GROUP_ID";
	public static final String LOGINUSER_LEVEL_CODE = "LOGINUSER_LEVEL_CODE";
	public static final String LOGINUSER_UP_MGMUSER_ID = "LOGINUSER_UP_MGMUSER_ID";
	public static final String LOGINUSER_UP_MGMUSER_NAME = "LOGINUSER_UP_MGMUSER_NAME";


	//loginUser param set
	public static void setUserToParam(LoginVO loginUser, Map<String, Object> param){
		param.put(LOGINUSER_ID, (String)loginUser.getUserId());
		param.put(LOGINUSER_NAME, (String)loginUser.getUserName());
		param.put(LOGINUSER_EMP_NO, (String)loginUser.getEmpNo());
		param.put(LOGINUSER_OFFICE_CODE, (String)loginUser.getOfficeCode());
		param.put(LOGINUSER_COMP_CODE, (String)loginUser.getCompCode());
		param.put(LOGINUSER_USERGROUP_ID, (String)loginUser.getUsergroupId());
		param.put(LOGINUSER_MGMCOMP_CODE, (String)loginUser.getMgmcompCode());
		param.put(LOGINUSER_MGM_CODE, (String)loginUser.getMgmCode());
		param.put(LOGINUSER_WORK_GROUP_ID, (String)loginUser.getWorkGroupId());
		param.put(LOGINUSER_LEVEL_CODE, (String)loginUser.getLevelCode());
		param.put(LOGINUSER_UP_MGMUSER_ID, (String)loginUser.getUpMgmuserId());
		param.put(LOGINUSER_UP_MGMUSER_NAME, (String)loginUser.getUpMgmuserName());

	}

	public static void setUserToParam(LoginVO loginUser, List<Map<String, Object>> param){
		for (Map<String, Object> row : param) {
			row.put(LOGINUSER_ID, (String)loginUser.getUserId());
			row.put(LOGINUSER_NAME, (String)loginUser.getUserName());
			row.put(LOGINUSER_EMP_NO, (String)loginUser.getEmpNo());
			row.put(LOGINUSER_OFFICE_CODE, (String)loginUser.getOfficeCode());
			row.put(LOGINUSER_COMP_CODE, (String)loginUser.getCompCode());
			row.put(LOGINUSER_USERGROUP_ID, (String)loginUser.getUsergroupId());
			row.put(LOGINUSER_MGMCOMP_CODE, (String)loginUser.getMgmcompCode());
			row.put(LOGINUSER_MGM_CODE, (String)loginUser.getMgmCode());
			row.put(LOGINUSER_WORK_GROUP_ID, (String)loginUser.getWorkGroupId());
			row.put(LOGINUSER_LEVEL_CODE, (String)loginUser.getLevelCode());
			row.put(LOGINUSER_UP_MGMUSER_ID, (String)loginUser.getUpMgmuserId());
			row.put(LOGINUSER_UP_MGMUSER_NAME, (String)loginUser.getUpMgmuserName());
		}
	}






	
}
