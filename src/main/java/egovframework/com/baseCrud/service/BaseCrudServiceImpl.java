package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.support.ServiceSupport;
import egovframework.com.baseCrud.model.ApiResponse;
import egovframework.com.exception.CrudFailException;
import egovframework.com.login.model.LoginVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static egovframework.com.baseCrud.support.KeyGenerator.setKeyToParam;

@Service("baseCrudService")
public class BaseCrudServiceImpl extends ServiceSupport implements BaseCrudService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    @Autowired
    private CrudAuthService crudAuthService;

    @Autowired
    private CrudBeforeService crudBeforeService;

    private static final Logger LOGGER = LoggerFactory.getLogger(BaseCrudServiceImpl.class);

    //다중 검색
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> selectList(String sectionId,
                                                String component,
                                                Map<String, Object> param,
                                                LoginVO loginUser,
                                                String pgId,
                                                String menuId) {

        crudAuthService.checkCrudPermission(loginUser.getUserId(), menuId, "GRD_READ");

        String statement = buildCrudStatement(sectionId, component, "selectList");
        setParam(param, loginUser, pgId, menuId);
        System.out.println(param);
        List<Map<String, Object>> result = baseCrudMapper.selectList(statement, param);

        return result;
    }

    //map 검색
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectMap(String sectionId,
                                         String component,
                                         Map<String, Object> param,
                                         String mapKey,
                                         LoginVO loginUser,
                                         String pgId,
                                         String menuId) {

        crudAuthService.checkCrudPermission(loginUser.getUserId(), menuId, "GRD_READ");

        String statement = buildCrudStatement(sectionId, component, "selectMap");
        setParam(param, loginUser, pgId, menuId);
        Map<String, Object> result = baseCrudMapper.selectMap(statement, param, mapKey);

        return result;
    }

    //다중 저장
    @Override
    @Transactional
    public int insertList(String sectionId,
                          String component,
                          List<Map<String, Object>> param,
                          LoginVO loginUser,
                          String pgId,
                          String menuId) {

        crudAuthService.checkCrudPermission(loginUser.getUserId(), menuId, "GRD_CREATE");

        String statement = buildCrudStatement(sectionId, component, "insertList");
        setParam(param, loginUser, pgId, menuId);
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
    public int insertOne(String sectionId,
                         String component,
                         Map<String, Object> param,
                         LoginVO loginUser,
                         String pgId,
                         String menuId) {

        crudAuthService.checkCrudPermission(loginUser.getUserId(), menuId, "GRD_CREATE");

        String statement = buildCrudStatement(sectionId, component, "insertOne");
        setParam(param, loginUser, pgId, menuId);
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
    public int updateList(String sectionId,
                          String component,
                          List<Map<String, Object>> param,
                          LoginVO loginUser,
                          String pgId,
                          String menuId) {

        crudAuthService.checkCrudPermission(loginUser.getUserId(), menuId, "GRD_UPDATE");

        String statement = buildCrudStatement(sectionId, component, "updateList");
        setParam(param, loginUser, pgId, menuId);
        int resultRowCount = baseCrudMapper.updateList(statement, param);
        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL UPDATE " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                    "저장 실패 : " + (resultRowCount) + "건",
                    ApiResponse.ApiType.UPDATE);
        }
        return resultRowCount;
    }

    //단일 수정
    @Override
    @Transactional
    public int updateOne(String sectionId,
                         String component,
                         Map<String, Object> param,
                         LoginVO loginUser,
                         String pgId,
                         String menuId) {

        crudAuthService.checkCrudPermission(loginUser.getUserId(), menuId, "GRD_UPDATE");

        String statement = buildCrudStatement(sectionId, component, "updateOne");
        setParam(param, loginUser, pgId, menuId);
        int resultRowCount = baseCrudMapper.updateOne(statement, param);
        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL UPDATE " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                    "저장 실패 : " + (resultRowCount) + "건",
                    ApiResponse.ApiType.UPDATE);
        }
        return resultRowCount;
    }


    //다중 삭제
    @Override
    @Transactional
    public int deleteList(String sectionId,
                          String component,
                          Map<String, Object> param,
                          LoginVO loginUser,
                          String pgId,
                          String menuId) {

        crudAuthService.checkCrudPermission(loginUser.getUserId(), menuId, "GRD_DELETE");

        String statement = buildCrudStatement(sectionId, component, "deleteList");
        List<Map<String, Object>> deleteParam = (List<Map<String, Object>>) param.get("deleteParam");
        setParam(deleteParam, loginUser, pgId, menuId);

        //사전 함수 호출
        Map<String, Object> before = (Map<String, Object>) param.get("before");
        if (before != null && !before.isEmpty()) {
            crudBeforeService.callBefore(before, loginUser, sectionId, component, pgId, menuId);
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
    public int deleteOne(String sectionId,
                         String component,
                         Map<String, Object> param,
                         LoginVO loginUser,
                         String pgId,
                         String menuId) {

        crudAuthService.checkCrudPermission(loginUser.getUserId(), menuId, "GRD_DELETE");

        String statement = buildCrudStatement(sectionId, component, "deleteOne");
        setParam(param, loginUser, pgId, menuId);
        int resultRowCount = baseCrudMapper.deleteOne(statement, param);
        return resultRowCount;
    }

    //다중 저장 + 수정
    @Override
    @Transactional
    public Map<String, Object> saveList(String sectionId,
                                        String component,
                                        Map<String, Object> param,
                                        LoginVO loginUser,
                                        String pgId,
                                        String menuId) {

        List<Map<String, Object>> insertParam = (List<Map<String, Object>>) param.get("insertParam");
        List<Map<String, Object>> updateParam = (List<Map<String, Object>>) param.get("updateParam");

        Map<String, Object> data = crudAuthService.getCrudPermission(loginUser.getUserId(), menuId);

        if (insertParam != null && !insertParam.isEmpty()) {
            crudAuthService.checkCrudPermission("GRD_CREATE", data);
        }
        if (updateParam != null && !updateParam.isEmpty()) {
            crudAuthService.checkCrudPermission("GRD_UPDATE", data);
        }

        //사전 함수 호출
        Map<String, Object> before = (Map<String, Object>) param.get("before");
        if (before != null && !before.isEmpty() && "all".equals(before.get("action"))) {
            crudBeforeService.callBefore(before, loginUser, sectionId, component, pgId, menuId);
        }

        //insert
        Map<String, Object> resultInsert = new HashMap<>();
        int resultInsertRowCount = 0;
        List<Map<String, Object>> key = new ArrayList<Map<String, Object>>();
        if (insertParam != null && !insertParam.isEmpty()) {

            Map<String, Object> rawKey = (Map<String, Object>) param.get("key");
            resultInsert = saveInsert(sectionId,
                                    component,
                                    insertParam,
                                    rawKey,
                                    before,
                                    loginUser, pgId, menuId);
            resultInsertRowCount = (Integer) resultInsert.get("resultInsertRowCount");
            key = (List<Map<String, Object>>) resultInsert.get("key");
        }

        //update
        int resultUpdateRowCount = 0;
        if (updateParam != null && !updateParam.isEmpty()) {
            resultUpdateRowCount = saveUpdate(sectionId,
                                            component,
                                            updateParam,
                                            before,
                                            loginUser, pgId, menuId);
        }
        Map<String, Object> result = new HashMap<>();
        result.put("resultRowCount", (resultInsertRowCount + resultUpdateRowCount));
        result.put("key", key);

        return result;
    }


    //다중 저장 (분기 처리)
    private Map<String, Object> saveInsert(String sectionId,
                                           String component,
                                           List<Map<String, Object>> insertParam,
                                           Map<String, Object> rawKey,
                                           Map<String, Object> before,
                                           LoginVO loginUser,
                                           String pgId,
                                           String menuId) {

        //사전 함수 호출
        if (before != null && !before.isEmpty() && "insert".equals(before.get("action"))) {
            crudBeforeService.callBefore(before,
                        loginUser,
                        sectionId,
                        component,
                        pgId,
                        menuId);
        }

        //pk 생성
        List<Map<String, Object>> key = new ArrayList<Map<String, Object>>();
        if (rawKey != null && !rawKey.isEmpty()) {

            insertParam = getKeyToParam(insertParam, rawKey, sectionId, component, loginUser);
            System.out.println("getKeyToParam : " + insertParam);

            List<String> column = (List<String>)rawKey.get("column");
            //return할 key값 구하기
            for ( Map<String, Object> map : insertParam){
                Map<String, Object> keyMap =  new HashMap<>();
                for ( String keyStr  : column){
                    keyMap.put(keyStr, map.get(keyStr));
                }
                key.add(keyMap);
            }
        }

        int resultInsertRowCount = processInsert(sectionId,
                                                component,
                                                loginUser,
                                                insertParam,
                                                rawKey,
                                                pgId,
                                                menuId);

        if (resultInsertRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL INSERT " + sectionId + "/" + pgId + "/" + component + " : \n" + insertParam,
                    "저장 실패 : " + (resultInsertRowCount) + "건",
                    ApiResponse.ApiType.INSERT);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("key", key);
        result.put("resultInsertRowCount", resultInsertRowCount);

        return result;
    }

    //다중 수정 (분기 처리)
    private int saveUpdate(String sectionId,
                           String component,
                           List<Map<String, Object>> updateParam,
                           Map<String, Object> before,
                           LoginVO loginUser,
                           String pgId,
                           String menuId) {

        //사전 함수 호출
        if (before != null && !before.isEmpty() && "update".equals(before.get("action"))) {
            crudBeforeService.callBefore(before,
                    loginUser,
                    sectionId,
                    component,
                    pgId,
                    menuId);
        }

        int resultUpdateRowCount = processUpdate(sectionId, component, loginUser, updateParam, pgId, menuId);

        if (resultUpdateRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL UPDATE " + sectionId + "/" + pgId + "/" + component + " : \n" + updateParam,
                    "저장 실패 : " + (resultUpdateRowCount) + "건",
                    ApiResponse.ApiType.UPDATE);
        }

        return resultUpdateRowCount;
    }


    private int processInsert(String sectionId,
                              String component,
                              LoginVO loginUser,
                              List<Map<String, Object>> insertParam,
                              Object rawKey,
                              String pgId,
                              String menuId) {

        //loginUser set
        setParam(insertParam, loginUser, pgId, menuId);
        System.out.println(insertParam);
        String statement = buildCrudStatement(sectionId, component, "insertList");
        return baseCrudMapper.insertList(statement, insertParam);
    }


    private int processUpdate(String sectionId,
                              String component,
                              LoginVO loginUser,
                              List<Map<String, Object>> updateParam,
                              String pgId,
                              String menuId) {
        //loginUser set
        setParam(updateParam, loginUser, pgId, menuId);
        System.out.println(updateParam);
        String statement = buildCrudStatement(sectionId, component, "updateList");
        return baseCrudMapper.updateList(statement, updateParam);
    }

    //pk 채번 && param set
    @Override
    @Transactional
    public List<Map<String, Object>> getKeyToParam(List<Map<String, Object>> param,
                                                   Map<String, Object> rawKey,
                                                   String sectionId,
                                                   String component,
                                                   LoginVO loginUser) {

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
    public List<Map<String, Object>> getSelect(String sectionId,
                                                     String component,
                                                     Map<String, Object> param,
                                                     LoginVO loginUser) {

        String statement = buildCrudStatement(sectionId, component, "getSelect");
        setLoginParam(param, loginUser);
        List<Map<String, Object>> result = baseCrudMapper.getSelect(statement, param);
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





