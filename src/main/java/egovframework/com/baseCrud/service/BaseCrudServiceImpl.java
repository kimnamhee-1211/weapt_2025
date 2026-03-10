package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.support.BaseServiceSupport;
import egovframework.com.exception.CrudFailException;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static egovframework.com.baseCrud.support.KeyGenerator.setKeyToParam;

@Service("baseCrudService")
public class BaseCrudServiceImpl extends BaseServiceSupport implements BaseCrudService  {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;


    //다중 검색
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> selectList(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId) {

        String statement = buildStatement(sectionId, component, "selectList");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId);
        System.out.println(param);
        List<Map<String, Object>> result = baseCrudMapper.selectList(statement, param);

        return result;
    }

    //map 검색
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectMap(String sectionId, String component, Map<String, Object> param, String mapKey, LoginVO loginUser, String pgId) {

        String statement = buildStatement(sectionId, component, "selectMap");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId);
        Map<String, Object> result = baseCrudMapper.selectMap(statement, param, mapKey);

        return result;
    }

    //다중 저장
    @Override
    @Transactional
    public int insertList(String sectionId, String component, List<Map<String, Object>> param, LoginVO loginUser, String pgId) {

        String statement = buildStatement(sectionId, component, "insertList");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId);
        int resultRowCount = baseCrudMapper.insertList(statement, param);

        return resultRowCount;
    }

    //단일 저장
    @Override
    @Transactional
    public int insertOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId) {

        String statement = buildStatement(sectionId, component, "insertOne");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId);
        int resultRowCount = baseCrudMapper.insertOne(statement, param);

        return resultRowCount;
    }

    //다중 수정
    @Override
    @Transactional
    public int updateList(String sectionId, String component, List<Map<String, Object>> param, LoginVO loginUser, String pgId) {

        String statement = buildStatement(sectionId, component, "updateList");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId);
        int resultRowCount = baseCrudMapper.updateList(statement, param);

        return resultRowCount;
    }

    //단일 수정
    @Override
    @Transactional
    public int updateOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId) {

        String statement = buildStatement(sectionId, component, "updateOne");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId);
        int resultRowCount = baseCrudMapper.updateOne(statement, param);

        return resultRowCount;
    }


    //다중 삭제
    @Override
    @Transactional
    public Map<String, Object> deleteList(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId) {

        String statement = buildStatement(sectionId, component, "deleteList");
        List<Map<String, Object>> deleteParam = (List<Map<String, Object>>) param.get("deleteParam");
        setLoginParam(deleteParam, loginUser);
        setPgIdParam(deleteParam, pgId);

        //사전 함수 호출
        Map<String, Object> before = (Map<String, Object>) param.get("before");
        if (before != null && !before.isEmpty()) {
            callBefore(before, loginUser, sectionId, component, pgId);
        }

        int resultRowCount = baseCrudMapper.deleteList(statement, deleteParam);

        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL DELETE " + component + " : \n" + deleteParam,
                    "삭제 실패 : " + resultRowCount + "건",
                    CrudFailException.CrudType.DELETE);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("O_STATUS", "SUCCESS");
        result.put("O_RESULT", resultRowCount);
        result.put("O_MSG", resultRowCount + "건이 삭제되었습니다.");
        result.put("O_TYPE", "DELETE");

        return result;
    }

    //단일 삭제
    @Override
    @Transactional
    public int deleteOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId) {

        String statement = buildStatement(sectionId, component, "deleteOne");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId);
        int resultRowCount = baseCrudMapper.deleteOne(statement, param);

        return resultRowCount;
    }

    //다중 저장 + 수정
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> saveList(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId) {

        List<Map<String, Object>> insertParam = (List<Map<String, Object>>) param.get("insertParam");
        List<Map<String, Object>> updateParam = (List<Map<String, Object>>) param.get("updateParam");
        Object rawKey = param.get("key");

        //사전 함수 호출
        Map<String, Object> before = (Map<String, Object>) param.get("before");

        if (before != null && !before.isEmpty() && "all".equals(before.get("action"))) {
            callBefore(before, loginUser, sectionId, component, pgId);
        }

        //insert
        int resultInsertRowCount = 0;
        if (insertParam != null && !insertParam.isEmpty()) {
            //사전 함수 호출
            if (before != null && !before.isEmpty() && "insert".equals(before.get("action"))) {
                callBefore(before, loginUser, sectionId, component, pgId);
            }
            resultInsertRowCount = processInsert(sectionId, component, loginUser, insertParam, rawKey, pgId);

            if (resultInsertRowCount <= 0) {
                throw new CrudFailException(
                        "FAIL INSERT " + component + " : \n" + param,
                        "저장 실패 : " + (resultInsertRowCount) + "건",
                        CrudFailException.CrudType.INSERT);
            }
        }

        //update
        int resultUpdateRowCount = 0;
        if (updateParam != null && !updateParam.isEmpty()) {
            //사전 함수 호출
            if (before != null && !before.isEmpty() && "update".equals(before.get("action"))) {
                callBefore(before, loginUser, sectionId, component, pgId);
            }
            resultUpdateRowCount = processUpdate(sectionId, component, loginUser, updateParam, pgId);
            if (resultUpdateRowCount <= 0) {
                throw new CrudFailException(
                        "FAIL UPDATE " + component + " : \n" + param,
                        "저장 실패 : " + (resultUpdateRowCount) + "건",
                        CrudFailException.CrudType.UPDATE);
            }
        }

        Map<String, Object> result = new HashMap<>();

        result.put("O_STATUS", "SUCCESS");
        result.put("O_RESULT", (resultInsertRowCount + resultUpdateRowCount));
        result.put("O_MSG", (resultInsertRowCount + resultUpdateRowCount) + "건이 저장되었습니다.");
        result.put("O_TYPE", "SAVE");

        return result;
    }


    private int processInsert(String sectionId, String component, LoginVO loginUser, List<Map<String, Object>> insertParam, Object rawKey, String pgId) {
        //pk get&set
        if (rawKey != null &&
                ((rawKey instanceof String) ||
                        (rawKey instanceof List && !((List<?>) rawKey).isEmpty()))) {
            insertParam = getKeyToParam(insertParam, rawKey, sectionId, component, loginUser);
            System.out.println("getKeyToParam : " + insertParam);
        }
        //loginUser set
        setLoginParam(insertParam, loginUser);
        setPgIdParam(insertParam, pgId);
        System.out.println(insertParam);
        String statement = buildStatement(sectionId, component, "insertList");
        return baseCrudMapper.insertList(statement, insertParam);
    }


    private int processUpdate(String sectionId, String component, LoginVO loginUser, List<Map<String, Object>> updateParam, String pgId) {
        //loginUser set
        setLoginParam(updateParam, loginUser);
        setPgIdParam(updateParam, pgId);
        System.out.println(updateParam);
        String statement = buildStatement(sectionId, component, "updateList");
        return baseCrudMapper.updateList(statement, updateParam);
    }


    //사전 함수 호출
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int callBefore(Map<String, Object> before, LoginVO loginUser, String sectionId, String component, String pgId) {

        List<Map<String, Object>> beforeParam = (List<Map<String, Object>>) before.get("beforeParam");
        if (beforeParam == null || beforeParam.isEmpty()) return 0;

        //loginUser set
        setLoginParam(beforeParam, loginUser);
        setPgIdParam(beforeParam, pgId);
        System.out.println(beforeParam);

        String saveMode = (String) before.get("saveMode");

        int resultRowCount = 0;
        if ("I".equals(saveMode)) {
            String statement = buildStatement(sectionId, component, "beforeInsert");
            resultRowCount = baseCrudMapper.insertList(statement, beforeParam);
        } else if ("U".equals(saveMode)) {
            String statement = buildStatement(sectionId, component, "beforeUpdate");
            resultRowCount = baseCrudMapper.updateList(statement, beforeParam);
            System.out.println(resultRowCount);
        } else if ("D".equals(saveMode)) {
            String statement = buildStatement(sectionId, component, "beforeDelete");
            resultRowCount = baseCrudMapper.deleteList(statement, beforeParam);
        } else {
            throw new CrudFailException(
                    "FAIL CALLBEFOR " + component + " : " + saveMode,
                    "callBefore 실패",
                    CrudFailException.CrudType.CALLBEFORE);
        }

        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL CALLBEFORE " + component + " : \n" + beforeParam,
                    "callBefore 실패 : " + resultRowCount + "건",
                    CrudFailException.CrudType.CALLBEFORE);
        }

        return resultRowCount;
    }


    //pk 채번 && param set
    @Override
    @Transactional
    public List<Map<String, Object>> getKeyToParam(List<Map<String, Object>> param, Object rawKey, String sectionId, String component, LoginVO loginUser) {

        String statement = buildStatement(sectionId, component, "getKey");

        Map<String, Object> keyParam = param.get(0);
        setLoginParam(keyParam, loginUser);
        Map<String, Object> keyValues = baseCrudMapper.selectOne(statement, keyParam);
        System.out.println(keyValues);

        param = setKeyToParam(param, rawKey, keyValues);

        return param;
    }


    //공통코드 검색
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> getCode(String CODEDV_NO) {

        List<Map<String, Object>> result = baseCrudMapper.getCode(CODEDV_NO);

        return result;
    }

    //selectOption 검색
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> getSelectOption(String sectionId, String component, Map<String, Object> param,  LoginVO loginUser) {

        String statement = buildStatement(sectionId, component, "getSelectOption");
        setLoginParam(param, loginUser);
        List<Map<String, Object>> result = baseCrudMapper.getSelectOption(statement, param);
        return result;
    }

    //공통코드 검색
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> getUsergroupId() {

        List<Map<String, Object>> result = baseCrudMapper.getUsergroupId();

        return result;
    }


}





