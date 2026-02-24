package egovframework.com.baseCrud.service;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.*;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.exception.BaseCrudFailException;
import egovframework.com.login.dao.LoginMapper;
import egovframework.com.login.model.LoginVO;

import static egovframework.com.util.Util.*;
import static egovframework.com.baseCrud.support.KeyGenerator.*;

@Service("baseCrudService")
public class BaseCrudServiceImpl implements BaseCrudService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;


    private String buildStatement(String sectionId, String component, String action){

        String mapper = sectionId.replaceAll("[^A-Za-z]", "") + "Mapper";
        String methodName = action +  "_" + component;
        String statement = mapper + "." + methodName;

        return statement;
    }


    //다중 검색
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> selectList(String sectionId, String component, Map<String, Object> param) {

        String statement = buildStatement(sectionId, component, "selectList");

        System.out.println(param);
        List<Map<String, Object>> result = baseCrudMapper.selectList(statement, param);

        return result;
    }

    //map 검색
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectMap(String sectionId, String component, Map<String, Object> param, String mapKey) {

        String statement = buildStatement(sectionId, component, "selectMap");

        Map<String, Object> result = baseCrudMapper.selectMap(statement, param, mapKey);

        return result;
    }

    //다중 저장
    @Override
    public int insertList(String sectionId, String component, List<Map<String, Object>> param) {

        String statement = buildStatement(sectionId, component, "insertList");

        int resultRowCount = baseCrudMapper.insertList(statement, param);

        return resultRowCount;
    }

    //단일 저장
    @Override
    public int insertOne(String sectionId, String component, Map<String, Object> param) {

        String statement = buildStatement(sectionId, component, "insertOne");

        int resultRowCount = baseCrudMapper.insertOne(statement, param);

        return resultRowCount;
    }

    //다중 수정
    @Override
    public int updateList(String sectionId, String component, List<Map<String, Object>> param) {

        String statement = buildStatement(sectionId, component, "updateList");

        int resultRowCount = baseCrudMapper.updateList(statement, param);

        return resultRowCount;
    }

    //단일 수정
    @Override
    public int updateOne(String sectionId, String component, Map<String, Object> param) {

        String statement = buildStatement(sectionId, component, "updateOne");

        int resultRowCount = baseCrudMapper.updateOne(statement, param);

        return resultRowCount;
    }


    //다중 삭제
    @Override
    public Map<String, Object> deleteList(String sectionId, String component, Map<String, Object> param) {

        String statement = buildStatement(sectionId, component, "deleteList");

        List<Map<String, Object>> deleteParam = (List<Map<String, Object>>) param.get("deleteParam");
        LoginVO loginUser = (LoginVO) param.get("loginUser");

        //사전 함수 호출
        Map<String, Object> before = (Map<String, Object>) param.get("before");
        if (before != null && !before.isEmpty()) {
            callBefore(before, loginUser, sectionId, component);
        }

        if (loginUser != null) {
            deleteParam = setUserToParam(loginUser, deleteParam);
        }

        int resultRowCount = baseCrudMapper.deleteList(statement, deleteParam);

        Map<String, Object> result = new HashMap<>();

        if (resultRowCount <= 0) {
            throw new BaseCrudFailException(
                    "FAIL DELETE " + component + " : \n" + deleteParam,
                    "삭제 실패 : " + resultRowCount + "건",
                    BaseCrudFailException.CrudType.DELETE);
        }

        result.put("O_STATUS", "SUCCESS");
        result.put("O_RESULT", resultRowCount);
        result.put("O_MSG", resultRowCount + "건이 삭제되었습니다.");
        result.put("O_TYPE", "DELETE");

        return result;
    }

    //단일 삭제
    @Override
    public int deleteOne(String sectionId, String component, Map<String, Object> param) {

        String statement = buildStatement(sectionId, component, "deleteOne");

        LoginVO loginUser = (LoginVO) param.get("loginUser");
        if (loginUser != null) {
            param = setUserToParam(loginUser, param);
        }

        int resultRowCount = baseCrudMapper.deleteOne(statement, param);

        return resultRowCount;
    }

    //다중 저장 + 수정
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> saveList(String sectionId, String component, Map<String, Object> param) {

        List<Map<String, Object>> insertParam = (List<Map<String, Object>>) param.get("insertParam");
        List<Map<String, Object>> updateParam = (List<Map<String, Object>>) param.get("updateParam");
        LoginVO loginUser = (LoginVO) param.get("loginUser");
        Object rawKey = param.get("key");

        //사전 함수 호출
        Map<String, Object> before = (Map<String, Object>) param.get("before");

        if (before != null && !before.isEmpty() && "all".equals(before.get("action"))) {
            callBefore(before, loginUser, sectionId, component);
        }

        int resultInsertRowCount = 0;
        int resultUpdateRowCount = 0;

        if (insertParam != null && !insertParam.isEmpty()) {
            if (before != null && !before.isEmpty() && "insert".equals(before.get("action"))) {
                callBefore(before, loginUser, sectionId, component);
            }
            resultInsertRowCount = processInsert(sectionId, component, loginUser, insertParam, rawKey);
        }

        if (updateParam != null && !updateParam.isEmpty()) {
            if (before != null && !before.isEmpty() && "update".equals(before.get("action"))) {
                callBefore(before, loginUser, sectionId, component);
            }
            resultUpdateRowCount = processUpdate(sectionId, component, loginUser, updateParam);
        }

        Map<String, Object> result = new HashMap<>();

        if (resultInsertRowCount <= 0 && resultUpdateRowCount <= 0) {
            throw new BaseCrudFailException(
                    "FAIL SAVE " + component + " : \n" + param,
                    "저장 실패 : " + (resultInsertRowCount + resultUpdateRowCount) + "건",
                    BaseCrudFailException.CrudType.SAVE);
        }

        result.put("O_STATUS", "SUCCESS");
        result.put("O_RESULT", (resultInsertRowCount + resultUpdateRowCount));
        result.put("O_MSG", (resultInsertRowCount + resultUpdateRowCount) + "건이 저장되었습니다.");
        result.put("O_TYPE", "SAVE");

        return result;
    }


    private int processInsert(String sectionId, String component, LoginVO loginUser, List<Map<String, Object>> insertParam, Object rawKey) {

        //pk get&set
        if (rawKey != null &&
                ((rawKey instanceof String) ||
                        (rawKey instanceof List && !((List<?>) rawKey).isEmpty()))) {
            insertParam = getKeyToParam(insertParam, rawKey, sectionId, component, loginUser);
            System.out.println("getKeyToParam : " + insertParam);
        }
        //loginUser set
        if (loginUser != null) {
            insertParam = setUserToParam(loginUser, insertParam);
        }

        System.out.println(insertParam);
        String statement = buildStatement(sectionId, component, "insertList");
        return baseCrudMapper.insertList(statement, insertParam);
    }


    private int processUpdate(String sectionId, String component, LoginVO loginUser, List<Map<String, Object>> updateParam) {
        //loginUser set
        if (loginUser != null) {
            updateParam = setUserToParam(loginUser, updateParam);
        }

        System.out.println(updateParam);
        String statement = buildStatement(sectionId, component, "updateList");
        return baseCrudMapper.updateList(statement, updateParam);
    }


    //사전 함수 호출
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int callBefore(Map<String, Object> before, LoginVO loginUser, String sectionId, String component) {

        List<Map<String, Object>> beforeParam = (List<Map<String, Object>>) before.get("beforeParam");
        if (beforeParam == null || beforeParam.isEmpty()) return 0;

        //loginUser set
        if (loginUser != null) {
            beforeParam = setUserToParam(loginUser, beforeParam);
        }

        String saveMode = (String) before.get("saveMode");

        int resultRowCount = 0;

        System.out.println(beforeParam);
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
            throw new BaseCrudFailException(
                    "FAIL CALLBEFOR " + component + " : " + saveMode,
                    "callBefore 실패",
                    BaseCrudFailException.CrudType.CALLBEFORE);
        }

        if (resultRowCount <= 0) {
            throw new BaseCrudFailException(
                    "FAIL CALLBEFORE " + component + " : \n" + beforeParam,
                    "callBefore 실패 : " + resultRowCount + "건",
                    BaseCrudFailException.CrudType.CALLBEFORE);
        }

        return resultRowCount;
    }


    //pk 채번 && param set
    @Override
    @Transactional
    public List<Map<String, Object>> getKeyToParam(List<Map<String, Object>> param, Object rawKey, String sectionId, String component, LoginVO loginUser) {

        String statement = buildStatement(sectionId, component, "getKey");

        Map<String, Object> keyParam = new HashMap<String, Object>();
        keyParam = setUserToParam(loginUser, param.get(0));
        System.out.println(keyParam);
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
    public List<Map<String, Object>> getSelectOption(String sectionId, String component, Map<String, Object> param) {

        String statement = buildStatement(sectionId, component, "getSelectOption");

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





