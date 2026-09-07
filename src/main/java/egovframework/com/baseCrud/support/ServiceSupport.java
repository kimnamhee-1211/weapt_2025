package egovframework.com.baseCrud.support;

import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class ServiceSupport {

    private static final String LOGIN_ID = "LOGIN_ID";
    private static final String LOGIN_NAME = "LOGIN_NAME";
    private static final String LOGIN_EMP_NO = "LOGIN_EMP_NO";
    private static final String LOGIN_OFFICE_CODE = "LOGIN_OFFICE_CODE";
    private static final String LOGIN_COMP_CODE = "LOGIN_COMP_CODE";
    private static final String LOGIN_USERGROUP_ID = "LOGIN_USERGROUP_ID";
    private static final String LOGIN_MGMCOMP_CODE = "LOGIN_MGMCOMP_CODE";
    private static final String LOGIN_MGM_CODE = "LOGIN_MGM_CODE";
    private static final String LOGIN_WORK_GROUP_ID = "LOGIN_WORK_GROUP_ID";
    private static final String LOGIN_LEVEL_CODE = "LOGIN_LEVEL_CODE";
    private static final String LOGIN_UP_MGMUSER_ID = "LOGIN_UP_MGMUSER_ID";
    private static final String LOGIN_UP_MGMUSER_NAME = "LOGIN_UP_MGMUSER_NAME";
    private static final String CALL_PG_ID = "CALL_PG_ID";
    private static final String CALL_MENU_ID = "CALL_MENU_ID";

    //loginUser param set
    public void setUserToParam(LoginVO loginUser, Map<String, Object> param){
        if (loginUser == null) {
            throw new IllegalStateException("로그인 정보가 없습니다.");
        }

        param.put(LOGIN_ID, loginUser.getUserId());
        param.put(LOGIN_NAME, loginUser.getUserName());
        param.put(LOGIN_EMP_NO, loginUser.getEmpNo());
        param.put(LOGIN_OFFICE_CODE, loginUser.getOfficeCode());
        param.put(LOGIN_COMP_CODE, loginUser.getCompCode());
        param.put(LOGIN_USERGROUP_ID, loginUser.getUsergroupId());
        param.put(LOGIN_MGMCOMP_CODE, loginUser.getMgmcompCode());
        param.put(LOGIN_MGM_CODE, loginUser.getMgmCode());
        param.put(LOGIN_WORK_GROUP_ID, loginUser.getWorkGroupId());
        param.put(LOGIN_LEVEL_CODE, loginUser.getLevelCode());
        param.put(LOGIN_UP_MGMUSER_ID, loginUser.getUpMgmuserId());
        param.put(LOGIN_UP_MGMUSER_NAME, loginUser.getUpMgmuserName());
    }

    public void setUserToParam(LoginVO loginUser, List<Map<String, Object>> param){
        if (loginUser == null) {
            throw new IllegalStateException("로그인 정보가 없습니다.");
        }
        for (Map<String, Object> row : param) {
            setUserToParam(loginUser, row);
        }
    }

    public void setPgIdParam(Map<String, Object> param, String pgId, String menuId){
        param.put(CALL_PG_ID, pgId);
        param.put(CALL_MENU_ID, menuId);
    }

    public void setPgIdParam(List<Map<String, Object>> param, String pgId, String menuId){

        for(Map<String, Object> row : param){
            setPgIdParam(row, pgId, menuId);
        }

    }

    // 필수 정보 주입(LoginVO, pgId, menuId)
    public void setParam(Map<String, Object> param, LoginVO loginUser, String pgId, String menuId){

        if (loginUser == null) {
            throw new IllegalStateException("로그인 정보가 없습니다.");
        }

        setUserToParam(loginUser, param);
        setPgIdParam(param, pgId, menuId);
    }

    //필수 정보 주입 List<Map<String, Object>>
    public void setParam(List<Map<String, Object>> param, LoginVO loginUser, String pgId, String menuId){

        if (loginUser == null) {
            throw new IllegalStateException("로그인 정보가 없습니다.");
        }

        for(Map<String, Object> row : param) {
            setParam(row, loginUser, pgId, menuId);
        }
    }

    //mapper id 만들기(CRUD)
    public String buildCrudStatement(String sectionId, String component, String action){

        String mapper = sectionId.replaceAll("[^A-Za-z]", "") + "Mapper";
        String statement = mapper + "." + action +  "_" + component;

        return statement;
    }

    //mapper id 만들기(Approval)
    public String buildApprovalStatement(String sectionId, String pgId, String action){

        String statement = "approvalMapper." + action +  "_" + sectionId + "_" + pgId;

        return statement;
    }


}
