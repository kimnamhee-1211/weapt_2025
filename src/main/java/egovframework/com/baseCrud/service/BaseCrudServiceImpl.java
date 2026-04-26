package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.support.BaseServiceSupport;
import egovframework.com.common.dto.ApiResponse;
import egovframework.com.exception.CrudFailException;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

import static egovframework.com.baseCrud.support.KeyGenerator.setKeyToParam;

@Service("baseCrudService")
public class BaseCrudServiceImpl extends BaseServiceSupport implements BaseCrudService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;


    //다중 검색
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> selectList(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        String statement = buildCrudStatement(sectionId, component, "selectList");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
        System.out.println(param);
        List<Map<String, Object>> result = baseCrudMapper.selectList(statement, param);

        return result;
    }

    //map 검색
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectMap(String sectionId, String component, Map<String, Object> param, String mapKey, LoginVO loginUser, String pgId, String menuId) {

        String statement = buildCrudStatement(sectionId, component, "selectMap");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
        Map<String, Object> result = baseCrudMapper.selectMap(statement, param, mapKey);

        return result;
    }

    //다중 저장
    @Override
    @Transactional
    public int insertList(String sectionId, String component, List<Map<String, Object>> param, LoginVO loginUser, String pgId, String menuId) {

        String statement = buildCrudStatement(sectionId, component, "insertList");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
        int resultRowCount = baseCrudMapper.insertList(statement, param);
        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL INSERT " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                    "저장 실패 : " + (resultRowCount) + "건",
                    ApiResponse.ApiType.INSERT);
        }
        return resultRowCount;
    }

    //단일 저장
    @Override
    @Transactional
    public int insertOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        String statement = buildCrudStatement(sectionId, component, "insertOne");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
        int resultRowCount = baseCrudMapper.insertOne(statement, param);
        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL INSERT " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                    "저장 실패 : " + (resultRowCount) + "건",
                    ApiResponse.ApiType.INSERT);
        }
        return resultRowCount;
    }

    //다중 수정
    @Override
    @Transactional
    public int updateList(String sectionId, String component, List<Map<String, Object>> param, LoginVO loginUser, String pgId, String menuId) {

        String statement = buildCrudStatement(sectionId, component, "updateList");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
        int resultRowCount = baseCrudMapper.updateList(statement, param);
        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL INSERT " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                    "저장 실패 : " + (resultRowCount) + "건",
                    ApiResponse.ApiType.UPDATE);
        }
        return resultRowCount;
    }

    //단일 수정
    @Override
    @Transactional
    public int updateOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        String statement = buildCrudStatement(sectionId, component, "updateOne");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
        int resultRowCount = baseCrudMapper.updateOne(statement, param);
        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL INSERT " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                    "저장 실패 : " + (resultRowCount) + "건",
                    ApiResponse.ApiType.UPDATE);
        }
        return resultRowCount;
    }


    //다중 삭제
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteList(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        String statement = buildCrudStatement(sectionId, component, "deleteList");
        List<Map<String, Object>> deleteParam = (List<Map<String, Object>>) param.get("deleteParam");
        setLoginParam(deleteParam, loginUser);
        setPgIdParam(deleteParam, pgId, menuId);

        //사전 함수 호출
        Map<String, Object> before = (Map<String, Object>) param.get("before");
        if (before != null && !before.isEmpty()) {
            callBefore(before, loginUser, sectionId, component, pgId, menuId);
        }

        int resultRowCount = baseCrudMapper.deleteList(statement, deleteParam);
        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL DELETE " + sectionId + "/" + pgId + "/" + component + " : \n" + deleteParam,
                    "삭제 실패 : " + resultRowCount + "건",
                    ApiResponse.ApiType.DELETE);
        }
        return resultRowCount;
    }

    //단일 삭제
    @Override
    @Transactional
    public int deleteOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        String statement = buildCrudStatement(sectionId, component, "deleteOne");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
        int resultRowCount = baseCrudMapper.deleteOne(statement, param);
        return resultRowCount;
    }

    //다중 저장 + 수정
    @Override
    @Transactional
    public int saveList(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        List<Map<String, Object>> insertParam = (List<Map<String, Object>>) param.get("insertParam");
        List<Map<String, Object>> updateParam = (List<Map<String, Object>>) param.get("updateParam");
        Object rawKey = param.get("key");

        //사전 함수 호출
        Map<String, Object> before = (Map<String, Object>) param.get("before");

        if (before != null && !before.isEmpty() && "all".equals(before.get("action"))) {
            callBefore(before, loginUser, sectionId, component, pgId, menuId);
        }

        //insert
        int resultInsertRowCount = 0;
        if (insertParam != null && !insertParam.isEmpty()) {
            //사전 함수 호출
            if (before != null && !before.isEmpty() && "insert".equals(before.get("action"))) {
                callBefore(before, loginUser, sectionId, component, pgId, menuId);
            }
            if (rawKey != null &&
                    ((rawKey instanceof String) ||
                            (rawKey instanceof List && !((List<?>) rawKey).isEmpty()))) {
                insertParam = getKeyToParam(insertParam, rawKey, sectionId, component, loginUser);
                System.out.println("getKeyToParam : " + insertParam);
            }

            resultInsertRowCount = processInsert(sectionId, component, loginUser, insertParam, rawKey, pgId, menuId);

            if (resultInsertRowCount <= 0) {
                throw new CrudFailException(
                        "FAIL INSERT " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                        "저장 실패 : " + (resultInsertRowCount) + "건",
                        ApiResponse.ApiType.INSERT);
            }
        }

        //update
        int resultUpdateRowCount = 0;
        if (updateParam != null && !updateParam.isEmpty()) {
            //사전 함수 호출
            if (before != null && !before.isEmpty() && "update".equals(before.get("action"))) {
                callBefore(before, loginUser, sectionId, component, pgId, menuId);
            }

            resultUpdateRowCount = processUpdate(sectionId, component, loginUser, updateParam, pgId, menuId);

            if (resultUpdateRowCount <= 0) {
                throw new CrudFailException(
                        "FAIL UPDATE " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                        "저장 실패 : " + (resultUpdateRowCount) + "건",
                        ApiResponse.ApiType.UPDATE);
            }
        }
        return (resultInsertRowCount + resultUpdateRowCount);
    }


    private int processInsert(String sectionId, String component, LoginVO loginUser, List<Map<String, Object>> insertParam, Object rawKey, String pgId, String menuId) {

        //loginUser set
        setLoginParam(insertParam, loginUser);
        setPgIdParam(insertParam, pgId, menuId);
        System.out.println(insertParam);
        String statement = buildCrudStatement(sectionId, component, "insertList");
        return baseCrudMapper.insertList(statement, insertParam);
    }


    private int processUpdate(String sectionId, String component, LoginVO loginUser, List<Map<String, Object>> updateParam, String pgId, String menuId) {
        //loginUser set
        setLoginParam(updateParam, loginUser);
        setPgIdParam(updateParam, pgId, menuId);
        System.out.println(updateParam);
        String statement = buildCrudStatement(sectionId, component, "updateList");
        return baseCrudMapper.updateList(statement, updateParam);
    }


    //사전 함수 호출
    @Override
    public int callBefore(Map<String, Object> before, LoginVO loginUser, String sectionId, String component, String pgId, String menuId) {

        List<Map<String, Object>> beforeParam = (List<Map<String, Object>>) before.get("beforeParam");
        if (beforeParam == null || beforeParam.isEmpty()) return 0;

        //loginUser set
        setLoginParam(beforeParam, loginUser);
        setPgIdParam(beforeParam, pgId, menuId);
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


    //pk 채번 && param set
    @Override
    @Transactional
    public List<Map<String, Object>> getKeyToParam(List<Map<String, Object>> param, Object rawKey, String sectionId, String component, LoginVO loginUser) {

        String statement = buildCrudStatement(sectionId, component, "getKey");

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
    public List<Map<String, Object>> getSelectOption(String sectionId, String component, Map<String, Object> param, LoginVO loginUser) {

        String statement = buildCrudStatement(sectionId, component, "getSelectOption");
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





