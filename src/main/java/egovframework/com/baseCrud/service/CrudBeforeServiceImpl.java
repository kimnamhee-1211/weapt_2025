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

    //사전 함수 호출
    @Override
    public int callBefore(Map<String, Object> before,
                          LoginVO loginUser,
                          String sectionId,
                          String component,
                          String pgId,
                          String menuId) {

        List<Map<String, Object>> beforeParam = (List<Map<String, Object>>) before.get("beforeParam");
        if (beforeParam == null || beforeParam.isEmpty()) return 0;

        //loginUser set
        setParam(beforeParam, loginUser, pgId, menuId);
        System.out.println(beforeParam);

        String saveMode = (String) before.get("saveMode");

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
            throw new CrudFailException(
                    "FAIL CALLBEFOR " + sectionId + "/" + pgId + "/" + component + "/" + saveMode,
                    "callBefore 실패",
                    ApiResponse.ApiType.CALLBEFORE);
        }

        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL CALLBEFORE " + sectionId + "/" + pgId + "/" + component + "/" + saveMode + " : \n" + beforeParam,
                    "callBefore 실패 : " + resultRowCount + "건",
                    ApiResponse.ApiType.CALLBEFORE);
        }

        return resultRowCount;
    }

}
