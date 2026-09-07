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
public class BaseCrudServiceImpl implements BaseCrudService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    @Autowired
    private CrudAuthService crudAuthService;

    @Autowired
    private CrudBeforeService crudBeforeService;

    @Autowired
    private ServiceSupport serviceSupport;

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

        crudAuthService.checkCrudPermission("GRD_READ", loginUser.getUserId(), menuId);

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "selectList");
        serviceSupport.setParam(param, loginUser, pgId, menuId);
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

        crudAuthService.checkCrudPermission("GRD_READ",loginUser.getUserId(), menuId);

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "selectMap");
        serviceSupport.setParam(param, loginUser, pgId, menuId);
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

        crudAuthService.checkCrudPermission("GRD_CREATE", loginUser.getUserId(), menuId);

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "insertList");
        serviceSupport.setParam(param, loginUser, pgId, menuId);
        int resultRowCount = baseCrudMapper.insertList(statement, param);
        if (resultRowCount <= 0) {
            throw CrudFailException.insertFail(sectionId, pgId, component, param, resultRowCount);
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

        crudAuthService.checkCrudPermission("GRD_CREATE", loginUser.getUserId(), menuId);

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "insertOne");
        serviceSupport.setParam(param, loginUser, pgId, menuId);
        int resultRowCount = baseCrudMapper.insertOne(statement, param);
        if (resultRowCount <= 0) {
            throw CrudFailException.insertFail(sectionId, pgId, component, param, resultRowCount);
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

        crudAuthService.checkCrudPermission("GRD_UPDATE", loginUser.getUserId(), menuId);

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "updateList");
        serviceSupport.setParam(param, loginUser, pgId, menuId);
        int resultRowCount = baseCrudMapper.updateList(statement, param);
        if (resultRowCount <= 0) {
            throw CrudFailException.updateFail(sectionId, pgId, component, param, resultRowCount);
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

        crudAuthService.checkCrudPermission("GRD_UPDATE", loginUser.getUserId(), menuId);

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "updateOne");
        serviceSupport.setParam(param, loginUser, pgId, menuId);
        int resultRowCount = baseCrudMapper.updateOne(statement, param);
        if (resultRowCount <= 0) {
            throw CrudFailException.updateFail(sectionId, pgId, component, param, resultRowCount);
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

        crudAuthService.checkCrudPermission("GRD_DELETE", loginUser.getUserId(), menuId);

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "deleteList");
        List<Map<String, Object>> deleteParam = (List<Map<String, Object>>) param.get("deleteParam");
        serviceSupport.setParam(deleteParam, loginUser, pgId, menuId);

        //사전 함수 호출
        crudBeforeService.callBeforeIfAction((Map<String, Object>) param.get("before"),
                loginUser,
                sectionId,
                component,
                pgId,
                menuId, "delete");

        int resultRowCount = baseCrudMapper.deleteList(statement, deleteParam);
        if (resultRowCount <= 0) {
            throw CrudFailException.deleteFail(sectionId, pgId, component, deleteParam, resultRowCount);
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

        crudAuthService.checkCrudPermission("GRD_DELETE", loginUser.getUserId(), menuId);

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "deleteOne");
        serviceSupport.setParam(param, loginUser, pgId, menuId);
        int resultRowCount = baseCrudMapper.deleteOne(statement, param);
        if (resultRowCount <= 0) {
            throw CrudFailException.deleteFail(sectionId, pgId, component, param, resultRowCount);
        }
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
        Map<String, Object> beforeMap = (Map<String, Object>) param.get("before");
        crudBeforeService.callBeforeIfAction(beforeMap,
                loginUser,
                sectionId,
                component,
                pgId,
                menuId, "all");

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
                                    beforeMap,
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
                                            beforeMap,
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
        crudBeforeService.callBeforeIfAction(before,
                loginUser,
                sectionId,
                component,
                pgId,
                menuId, "insert");

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

        serviceSupport.setParam(insertParam, loginUser, pgId, menuId);
        System.out.println(insertParam);
        String statement = serviceSupport.buildCrudStatement(sectionId, component, "insertList");
        int resultInsertRowCount = baseCrudMapper.insertList(statement, insertParam);

        if (resultInsertRowCount <= 0) {
            throw CrudFailException.insertFail(sectionId, pgId, component, insertParam, resultInsertRowCount);
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
        crudBeforeService.callBeforeIfAction(before,
                loginUser,
                sectionId,
                component,
                pgId,
                menuId, "update");


        serviceSupport.setParam(updateParam, loginUser, pgId, menuId);
        System.out.println(updateParam);
        String statement = serviceSupport.buildCrudStatement(sectionId, component, "updateList");
        int resultUpdateRowCount = baseCrudMapper.updateList(statement, updateParam);

        if (resultUpdateRowCount <= 0) {
            throw CrudFailException.updateFail(sectionId, pgId, component, updateParam, resultUpdateRowCount);
        }

        return resultUpdateRowCount;
    }

    //pk 채번 && param set
    @Override
    @Transactional
    public List<Map<String, Object>> getKeyToParam(List<Map<String, Object>> param,
                                                   Map<String, Object> rawKey,
                                                   String sectionId,
                                                   String component,
                                                   LoginVO loginUser) {

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "getKey");

        Map<String, Object> keyParam = param.get(0);
        serviceSupport.setUserToParam(loginUser, keyParam);
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

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "getSelect");
        serviceSupport.setUserToParam(loginUser, param);
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





