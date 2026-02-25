package egovframework.com.baseCrud.support;

import egovframework.com.login.model.LoginVO;

import java.util.List;
import java.util.Map;

import static egovframework.com.baseCrud.support.SetParam.setUserToParam;

public abstract class BaseServiceSupport {

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

    protected void setPgIdParam(List<Map<String, Object>> param, String pgId){
        if(pgId != null){
            for(Map<String, Object> row : param){
                row.put("PG_ID", pgId);
            }
        }
    }

    protected void setPgIdParam(Map<String, Object> param, String pgId){
        if(pgId != null){
            param.put("PG_ID", pgId);
        }
    }


    //mapper id 만들기
    protected String buildStatement(String sectionId, String component, String action){

        String mapper = sectionId.replaceAll("[^A-Za-z]", "") + "Mapper";
        String methodName = action +  "_" + component;
        String statement = mapper + "." + methodName;

        return statement;
    }

}
