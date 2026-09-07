package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.model.ApiResponse;
import egovframework.com.baseCrud.support.ServiceSupport;
import egovframework.com.exception.CrudFailException;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("crudBeforeService")
public class CrudBeforeServiceImpl extends ServiceSupport implements CrudBeforeService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    @Override
    public void callBeforeIfAction(Map<String, Object> before,
                                   LoginVO loginUser,
                                   String sectionId,
                                   String component,
                                   String pgId,
                                   String menuId,
                                   String action){

        if (before == null || before.isEmpty()) return;


        if (!action.equals(before.get("action"))) return;

        if(action.equals(before.get("action"))){
            List<Map<String, Object>> beforeParam = (List<Map<String, Object>>) before.get("beforeParam");
            if (beforeParam == null || beforeParam.isEmpty()) return;
            String saveMode = (String) before.get("saveMode");
            if (saveMode == null) return;
            callBefore(beforeParam,
                    saveMode,
                    loginUser,
                    sectionId,
                    component,
                    pgId,
                    menuId);
        }
    }


    //사전 함수 호출
    private void callBefore(List<Map<String, Object>> beforeParam,
                            String saveMode,
                            LoginVO loginUser,
                          String sectionId,
                          String component,
                          String pgId,
                          String menuId) {

        //loginUser set
        setParam(beforeParam, loginUser, pgId, menuId);
        System.out.println(beforeParam);

        int resultRowCount = 0;
        if ("I".equals(saveMode)) {
            String statement = buildCrudStatement(sectionId, component, "beforeInsert");
            resultRowCount = baseCrudMapper.insertList(statement, beforeParam);
        } else if ("U".equals(saveMode)) {
            String statement = buildCrudStatement(sectionId, component, "beforeUpdate");
            resultRowCount = baseCrudMapper.updateList(statement, beforeParam);
            System.out.println(resultRowCount);
        } else if ("D".equals(saveMode)) {
            String statement = buildCrudStatement(sectionId, component, "beforeDelete");
            resultRowCount = baseCrudMapper.deleteList(statement, beforeParam);
        } else {
            throw CrudFailException.callBeforeFail(sectionId, pgId, component, beforeParam, resultRowCount);
        }

        if (resultRowCount <= 0) {
            throw CrudFailException.callBeforeFail(sectionId, pgId, component, beforeParam, resultRowCount);
        }
    }

}
