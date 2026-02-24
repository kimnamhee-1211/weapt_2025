package egovframework.com.baseCrud.support;

import egovframework.com.login.model.LoginVO;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class SetParam {

	//loginUser param set
	public static Map<String, Object> setUserToParam(LoginVO loginUser, Map<String, Object> param){
		if (param instanceof Map) {
			Map<String, Object> map = (Map<String, Object>) param;
			map.put("LOGINUSER_ID", (String)loginUser.getUserId());
			map.put("LOGINUSER_NAME", (String)loginUser.getUserName());
			map.put("LOGINUSER_EMP_NO", (String)loginUser.getEmpNo());
			map.put("LOGINUSER_OFFICE_CODE", (String)loginUser.getOfficeCode());
			map.put("LOGINUSER_COMP_CODE", (String)loginUser.getCompCode());
			map.put("LOGINUSER_USERGROUP_ID", (String)loginUser.getUsergroupId());
			map.put("LOGINUSER_MGMCOMP_CODE", (String)loginUser.getMgmcompCode());
			map.put("LOGINUSER_MGM_CODE", (String)loginUser.getMgmCode());
			map.put("LOGINUSER_WORK_GROUP_ID", (String)loginUser.getWorkGroupId());
			map.put("LOGINUSER_LEVEL_CODE", (String)loginUser.getLevelCode());
			map.put("LOGINUSER_UP_MGMUSER_ID", (String)loginUser.getUpMgmuserId());
			map.put("LOGINUSER_UP_MGMUSER_NAME", (String)loginUser.getUpMgmuserName());
			return map;
		} else{
			return param;
		}

	}

	public static List<Map<String, Object>> setUserToParam(LoginVO loginUser, List<Map<String, Object>> param){

		if (param instanceof List) {
			List<Map<String, Object>> list = (List<Map<String, Object>>) param;
			for (Map<String, Object> row : list) {
				row.put("LOGINUSER_ID", (String)loginUser.getUserId());
				row.put("LOGINUSER_NAME", (String)loginUser.getUserName());
				row.put("LOGINUSER_EMP_NO", (String)loginUser.getEmpNo());
				row.put("LOGINUSER_OFFICE_CODE", (String)loginUser.getOfficeCode());
				row.put("LOGINUSER_COMP_CODE", (String)loginUser.getCompCode());
				row.put("LOGINUSER_USERGROUP_ID", (String)loginUser.getUsergroupId());
				row.put("LOGINUSER_MGMCOMP_CODE", (String)loginUser.getMgmcompCode());
				row.put("LOGINUSER_MGM_CODE", (String)loginUser.getMgmCode());
				row.put("LOGINUSER_WORK_GROUP_ID", (String)loginUser.getWorkGroupId());
				row.put("LOGINUSER_LEVEL_CODE", (String)loginUser.getLevelCode());
				row.put("LOGINUSER_UP_MGMUSER_ID", (String)loginUser.getUpMgmuserId());
				row.put("LOGINUSER_UP_MGMUSER_NAME", (String)loginUser.getUpMgmuserName());
			}
			return list;
		}else{
			return param;
		}
	}



	
}
