package egovframework.com.baseCrud.support;

import egovframework.com.login.model.LoginVO;

import java.util.List;
import java.util.Map;

import static egovframework.com.baseCrud.support.SetParam.setUserToParam;

public abstract class ServiceSupport {

    //로그인 정보 주입 Map<String, Object>
    protected void setLoginParam(Map<String, Object> param, LoginVO loginUser){

        if(loginUser != null){
            setUserToParam(loginUser, param);
        }
    }

    //로그인 정보 주입 List<Map<String, Object>>
    protected void setLoginParam(List<Map<String, Object>> param, LoginVO loginUser){

        if(loginUser != null){
            setUserToParam(loginUser, param);
        }
    }

    protected void setPgIdParam(List<Map<String, Object>> param, String pgId, String menuId){

        for(Map<String, Object> row : param){
            row.put("CALL_PG_ID", pgId);
            row.put("CALL_MENU_ID", menuId);
        }

    }

    protected void setPgIdParam(Map<String, Object> param, String pgId, String menuId){
            param.put("CALL_PG_ID", pgId);
            param.put("CALL_MENU_ID", menuId);
    }


    //mapper id 만들기(CRUD)
    protected String buildCrudStatement(String sectionId, String component, String action){

        String mapper = sectionId.replaceAll("[^A-Za-z]", "") + "Mapper";
        String methodName = action +  "_" + component;
        String statement = mapper + "." + methodName;

        return statement;
    }

    //mapper id 만들기(Approval)
    protected String buildApprovalStatement(String sectionId, String pgId, String action){
        
        String methodName = action +  "_" + sectionId + "_" + pgId;
        String statement = "approvalMapper." + methodName;

        return statement;
    }


}
