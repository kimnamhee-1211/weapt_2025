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

    private static final Logger LOGGER = LoggerFactory.getLogger(BaseCrudServiceImpl.class);

    private Map<String, Object> getCrudPermission(String userId, String menuId) {

        Map<String, Object> data = crudAuthService.getCrudAuth(userId, menuId);

        if(data == null){
            throw new CrudFailException(
                    "GRD Permission Denied : " + String.valueOf(data),
                    "권한정보가 없습니다.",
                    ApiResponse.ApiType.GRD
            );
        }
        if ( !"1".equals(data.get("FORM_USE"))) {
            throw new CrudFailException(
                    "USE Permission Denied : " + String.valueOf(data),
                    "사용 권한이 없습니다.",
                    ApiResponse.ApiType.FORM_USE
            );
        }
        return data;
    }

    private void checkCrudPermission(String userId, String menuId, String type){

        Map<String, Object> data = getCrudPermission(userId, menuId);

        LOGGER.info("CRUD AUTH {} : {}", type, data);

        if (!"1".equals(data.get(type))) {
            throw new CrudFailException(
                    type + " Permission Denied : " + String.valueOf(data),
                    getPermissionMessage(type),
                    getApiType(type)
            );
        }

    }

    private void checkCrudPermission(String type, Map<String, Object> data){

        LOGGER.info("CRUD AUTH {} : {}", type, data);

        if (!"1".equals(data.get(type))) {
            throw new CrudFailException(
                    type + " Permission Denied : " + String.valueOf(data),
                    getPermissionMessage(type),
                    getApiType(type)
            );
        }

    }

    private String getPermissionMessage(String type) {
        switch (type) {
            case "GRD_READ": return "조회 권한이 없습니다.";
            case "GRD_CREATE": return "추가 권한이 없습니다.";
            case "GRD_UPDATE": return "수정 권한이 없습니다.";
            case "GRD_DELETE": return "삭제 권한이 없습니다.";
            case "GRD_EXCEL": return "엑셀 권한이 없습니다.";
            default: return "권한정보가 없습니다.";
        }
    }

    private ApiResponse.ApiType getApiType(String type) {
        switch (type) {
            case "GRD_READ": return ApiResponse.ApiType.GRD_READ;
            case "GRD_CREATE": return ApiResponse.ApiType.GRD_CREATE;
            case "GRD_UPDATE": return ApiResponse.ApiType.GRD_UPDATE;
            case "GRD_DELETE": return ApiResponse.ApiType.GRD_DELETE;
            case "GRD_EXCEL": return ApiResponse.ApiType.GRD_EXCEL;
            default: return ApiResponse.ApiType.GRD;
        }
    }

    //다중 검색
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> selectList(String sectionId,
                                                String component,
                                                Map<String, Object> param,
                                                LoginVO loginUser,
                                                String pgId,
                                                String menuId) {
        checkCrudPermission(loginUser.getUserId(), menuId, "GRD_READ");

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
    public Map<String, Object> selectMap(String sectionId,
                                         String component,
                                         Map<String, Object> param,
                                         String mapKey,
                                         LoginVO loginUser,
                                         String pgId,
                                         String menuId) {
        checkCrudPermission(loginUser.getUserId(), menuId, "GRD_READ");

        String statement = buildCrudStatement(sectionId, component, "selectMap");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
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
        checkCrudPermission(loginUser.getUserId(), menuId, "GRD_CREATE");

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
    public int insertOne(String sectionId,
                         String component,
                         Map<String, Object> param,
                         LoginVO loginUser,
                         String pgId,
                         String menuId) {
        checkCrudPermission(loginUser.getUserId(), menuId, "GRD_CREATE");

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
    public int updateList(String sectionId,
                          String component,
                          List<Map<String, Object>> param,
                          LoginVO loginUser,
                          String pgId,
                          String menuId) {
        checkCrudPermission(loginUser.getUserId(), menuId, "GRD_UPDATE");

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
    public int updateOne(String sectionId,
                         String component,
                         Map<String, Object> param,
                         LoginVO loginUser,
                         String pgId,
                         String menuId) {
        checkCrudPermission(loginUser.getUserId(), menuId, "GRD_UPDATE");

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
    @Transactional
    public int deleteList(String sectionId,
                          String component,
                          Map<String, Object> param,
                          LoginVO loginUser,
                          String pgId,
                          String menuId) {
        checkCrudPermission(loginUser.getUserId(), menuId, "GRD_DELETE");

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
    public int deleteOne(String sectionId,
                         String component,
                         Map<String, Object> param,
                         LoginVO loginUser,
                         String pgId,
                         String menuId) {
        checkCrudPermission(loginUser.getUserId(), menuId, "GRD_DELETE");

        String statement = buildCrudStatement(sectionId, component, "deleteOne");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
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

        Map<String, Object> data = getCrudPermission(loginUser.getUserId(), menuId);

        if (insertParam != null && !insertParam.isEmpty()) {
            checkCrudPermission("GRD_CREATE", data);
        }
        if (updateParam != null && !updateParam.isEmpty()) {
            checkCrudPermission("GRD_UPDATE", data);
        }

        //사전 함수 호출
        Map<String, Object> before = (Map<String, Object>) param.get("before");
        if (before != null && !before.isEmpty() && "all".equals(before.get("action"))) {
            callBefore(before, loginUser, sectionId, component, pgId, menuId);
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
            callBefore(before,
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
            callBefore(before,
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
        setLoginParam(insertParam, loginUser);
        setPgIdParam(insertParam, pgId, menuId);
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
        setLoginParam(updateParam, loginUser);
        setPgIdParam(updateParam, pgId, menuId);
        System.out.println(updateParam);
        String statement = buildCrudStatement(sectionId, component, "updateList");
        return baseCrudMapper.updateList(statement, updateParam);
    }


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





