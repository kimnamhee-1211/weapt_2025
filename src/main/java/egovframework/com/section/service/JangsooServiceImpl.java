package egovframework.com.section.service;

import com.sun.xml.internal.fastinfoset.util.StringArray;
import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.model.ApiResponse;
import egovframework.com.baseCrud.service.CrudAuthService;
import egovframework.com.baseCrud.service.CrudBeforeService;
import egovframework.com.baseCrud.support.ServiceSupport;
import egovframework.com.exception.BizException;
import egovframework.com.exception.CrudFailException;
import egovframework.com.login.model.LoginVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static egovframework.com.baseCrud.support.KeyGenerator.setKeyToParam;

@Service("jangsooService")
public class JangsooServiceImpl implements JangsooService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    @Autowired
    private ServiceSupport serviceSupport;

    @Autowired
    private CrudAuthService crudAuthService;


    private static final Logger LOGGER = LoggerFactory.getLogger(JangsooServiceImpl.class);

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

        int level1 = 1;
        int level2 = 0;
        String[] korean = {
                "가", "나", "다", "라", "마", "바", "사", "아", "자", "차",
                "카", "타", "파", "하"
        };
        int level3 = 1;

        for (Map<String, Object> e : result) {
            if ("1".equals(e.get("LEVEL"))) {
                e.put("CODE_NAME", level1 + "." + e.get("CODE_NAME"));
                level1++;
                level2 = 0;
                level3 = 1;
            } else if ("2".equals(e.get("LEVEL"))) {
                e.put("CODE_NAME", korean[level2] + ". " + e.get("CODE_NAME"));
                level2++;
                if(level2 > 13) level2 = 0;
                level3 = 1;
            } else if ("3".equals(e.get("LEVEL"))) {
                e.put("CODE_NAME", "(" + level3 + ") " + e.get("CODE_NAME"));
                level3++;
            }
        }
        return result;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> selectList_pop3Grid1(String sectionId,
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

        int level1 = 1;
        int level2 = 0;
        String[] korean = {
                "가", "나", "다", "라", "마", "바", "사", "아", "자", "차",
                "카", "타", "파", "하"
        };
        int level3 = 1;

        for (Map<String, Object> e : result) {
            if ("1".equals(e.get("LEVEL"))) {
                e.put("CODE_NAME", level1 + "." + e.get("CODE_NAME"));
                level1++;
                level2 = 0;
                level3 = 1;
            } else if ("2".equals(e.get("LEVEL"))) {
                e.put("CODE_NAME", korean[level2] + ". " + e.get("CODE_NAME"));
                level2++;
                if(level2 > 13) level2 = 0;
                level3 = 1;
            } else if ("3".equals(e.get("LEVEL"))) {
                e.put("CODE_NAME", "(" + level3 + ") " + e.get("CODE_NAME"));
                level3++;
            }
        }
        return result;
    }

    //다중 검색
    @Override
    @Transactional
    public Map<String, Object> change_planMonth(String sectionId,
                                                      String component,
                                                      Map<String, Object> param,
                                                      LoginVO loginUser,
                                                      String pgId,
                                                      String menuId) {

        crudAuthService.checkCrudPermission("GRD_UPDATE", loginUser.getUserId(), menuId);

        serviceSupport.setParam(param, loginUser, pgId, menuId);
        String statement = serviceSupport.buildCrudStatement(sectionId, component, "selectOne");
        Map<String, Object> updateMap = baseCrudMapper.selectOne(statement, param);

        if (updateMap == null || updateMap.isEmpty()) {
            throw new BizException(
                    "Business FAIL : " + pgId + " / " + menuId,
                    "수립조정이 존재하지 않습니다.",
                    ApiResponse.ApiType.BIZ
            );
        }

        if ("1".equals(String.valueOf(updateMap.get("CLOSE_YN")))) {
            throw new BizException(
                    "Business FAIL : " + pgId + " / " + menuId,
                    "이미 마감된 수립조정은 조정년월을 변경할 수 없습니다.",
                    ApiResponse.ApiType.BIZ
            );
        }

        int resultUpdateRowCount = 0;

        if((int)updateMap.get("ITEM_UNIT_CNT") > 0){
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_1", "updateOne");
            resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);
        }
        if((int)updateMap.get("ITEM_CODE_CNT") > 0){
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_2", "updateOne");
            resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);
        }
        if((int)updateMap.get("KIND_CODE_CNT") > 0){
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_3", "updateOne");
            resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);
        }
        if((int)updateMap.get("SUB_CODE_CNT") > 0){
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_4", "updateOne");
            resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);
        }
        if((int)updateMap.get("CODE_CNT") > 0){
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_5", "updateOne");
            resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);
        }
        statement = serviceSupport.buildCrudStatement(sectionId, component, "updateOne");
        resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);

        if (resultUpdateRowCount <= 0) {
            throw CrudFailException.updateFail(sectionId, pgId, component, param, resultUpdateRowCount);
        }


        Map<String, Object> result = new HashMap<>();
        result.put("resultRowCount", (resultUpdateRowCount));
        return result;
    }

    @Override
    @Transactional
    public Map<String, Object> copy_planMonth(String sectionId,
                                                String component,
                                                Map<String, Object> param,
                                                LoginVO loginUser,
                                                String pgId,
                                                String menuId) {

        crudAuthService.checkCrudPermission("GRD_CREATE", loginUser.getUserId(), menuId);

        if (param == null || param.isEmpty()) {
            throw CrudFailException.insertFail(
                    sectionId, pgId, component, param, 0
            );
        }
        serviceSupport.setParam(param, loginUser, pgId, menuId);
        String statement = serviceSupport.buildCrudStatement(sectionId, component, "selectOne");
        Map<String, Object> insertMap = baseCrudMapper.selectOne(statement, param);

        if (insertMap == null || insertMap.isEmpty()) {
            throw new BizException(
                    "Business FAIL : " + pgId + " / " + menuId,
                    "수립조정이 존재하지 않습니다.",
                    ApiResponse.ApiType.BIZ
            );
        }

        if (!"1".equals(String.valueOf(insertMap.get("CLOSE_YN")))) {
            throw new BizException(
                    "Business FAIL : " + pgId + " / " + menuId,
                    "마감된 수립조정만 복사할 수 있습니다.",
                    ApiResponse.ApiType.BIZ
            );
        }

        int resultInsertRowCount = 0;

        statement = serviceSupport.buildCrudStatement(sectionId, component, "insertOne");
        resultInsertRowCount += baseCrudMapper.insertOne(statement, param);

        if((int)insertMap.get("CODE_CNT") > 0){
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_1", "insertOne");
            resultInsertRowCount += baseCrudMapper.insertOne(statement, param);
        }
        if((int)insertMap.get("SUB_CODE_CNT") > 0){
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_2", "insertOne");
            resultInsertRowCount += baseCrudMapper.insertOne(statement, param);
        }
        if((int)insertMap.get("KIND_CODE_CNT") > 0){
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_3", "insertOne");
            resultInsertRowCount += baseCrudMapper.insertOne(statement, param);
        }
        if((int)insertMap.get("ITEM_CODE_CNT") > 0){
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_4", "insertOne");
            resultInsertRowCount += baseCrudMapper.insertOne(statement, param);
        }
        if((int)insertMap.get("ITEM_UNIT_CNT") > 0){
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_5", "insertOne");
            resultInsertRowCount += baseCrudMapper.insertOne(statement, param);
        }
        if (resultInsertRowCount <= 0) {
            throw CrudFailException.insertFail(sectionId, pgId, component, param, resultInsertRowCount);
        }


        Map<String, Object> result = new HashMap<>();
        result.put("resultRowCount", (resultInsertRowCount));
        return result;
    }

    @Override
    @Transactional
    public Map<String, Object> add_repairCode(String sectionId,
                                              String component,
                                              List<Map<String, Object>> param,
                                              LoginVO loginUser,
                                              String pgId,
                                              String menuId) {

        crudAuthService.checkCrudPermission("GRD_CREATE", loginUser.getUserId(), menuId);

        if (param == null || param.isEmpty()) {
            throw new BizException(
                    "Business FAIL : " + pgId + " / " + menuId,
                    "수립조정이 존재하지 않습니다.",
                    ApiResponse.ApiType.BIZ
            );
        }

        serviceSupport.setParam(param, loginUser, pgId, menuId);

        int resultDeleteRowCount = 0;
        int resultInsertRowCount = 0;
        int resultInsertRowCountToview = 0;

        String statement = "";
//        statement = serviceSupport.buildCrudStatement(sectionId, component + "_1", "deleteOne");
//        resultDeleteRowCount += baseCrudMapper.deleteOne(statement, deleteMap);
//        statement = serviceSupport.buildCrudStatement(sectionId, component + "_2", "deleteOne");
//        resultDeleteRowCount += baseCrudMapper.deleteOne(statement, deleteMap);
//        statement = serviceSupport.buildCrudStatement(sectionId, component + "_3", "deleteOne");
//        resultDeleteRowCount += baseCrudMapper.deleteOne(statement, deleteMap);
//        statement = serviceSupport.buildCrudStatement(sectionId, component + "_4", "deleteOne");
//        resultDeleteRowCount += baseCrudMapper.deleteOne(statement, deleteMap);
//        statement = serviceSupport.buildCrudStatement(sectionId, component + "_5", "deleteOne");
//        resultDeleteRowCount += baseCrudMapper.deleteOne(statement, deleteMap);

        List<Map<String, Object>> insertList1 = param.stream()
                .filter(map -> "1".equals(map.get("LEVEL")) )
                .collect(Collectors.toList());
        if(insertList1 != null && insertList1.size() > 0) {
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_1", "insertList");
            resultInsertRowCount += baseCrudMapper.insertList(statement, insertList1);
        }
        List<Map<String, Object>> insertList2 = param.stream()
                .filter(map -> "2".equals(map.get("LEVEL")))
                .collect(Collectors.toList());
        if(insertList2 != null && insertList2.size() > 0) {
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_2", "insertList");
            resultInsertRowCount += baseCrudMapper.insertList(statement, insertList2);
        }
        List<Map<String, Object>> insertList3 = param.stream()
                .filter(map -> "3".equals(map.get("LEVEL")) )
                .collect(Collectors.toList());
        if(insertList3 != null && insertList3.size() > 0) {
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_3", "insertList");
            resultInsertRowCountToview += baseCrudMapper.insertList(statement, insertList3);
            resultInsertRowCount += resultInsertRowCountToview;

            statement = serviceSupport.buildCrudStatement(sectionId, component + "_4", "selectList");
            List<Map<String, Object>> insertList4 = baseCrudMapper.selectList(statement, insertList3.get(0));

            statement = serviceSupport.buildCrudStatement(sectionId, component + "_4", "insertList");
            resultInsertRowCount += baseCrudMapper.insertList(statement, insertList4);
            statement = serviceSupport.buildCrudStatement(sectionId, component + "_5", "insertList");
            resultInsertRowCount += baseCrudMapper.insertList(statement, insertList4);
        }
        if (resultInsertRowCount <= 0) {
            throw CrudFailException.insertFail(sectionId, pgId, component, param, resultInsertRowCount);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("resultRowCount", (resultInsertRowCountToview));
        return result;
    }

    @Override
    @Transactional
    public Map<String, Object> delete_plan(String sectionId,
                                              String component,
                                              Map<String, Object> param,
                                              LoginVO loginUser,
                                              String pgId,
                                              String menuId) {

        crudAuthService.checkCrudPermission("GRD_DELETE", loginUser.getUserId(), menuId);

        serviceSupport.setParam(param, loginUser, pgId, menuId);

        int resultDeleteRowCount = 0;

        if (param == null || param.isEmpty()) {
            throw new BizException(
                    "Business FAIL : " + pgId + " / " + menuId,
                    "수립조정이 존재하지 않습니다.",
                    ApiResponse.ApiType.BIZ
            );
        }

        if ("1".equals(String.valueOf(param.get("CLOSE_YN")))) {
            throw new BizException(
                    "Business FAIL : " + pgId + " / " + menuId,
                    "이미 마감된 수립조정은 삭제할 수 없습니다.",
                    ApiResponse.ApiType.BIZ
            );
        }

        String statement = "";
        statement = serviceSupport.buildCrudStatement(sectionId, component + "_1", "deleteOne");
        resultDeleteRowCount += baseCrudMapper.deleteOne(statement, param);
        statement = serviceSupport.buildCrudStatement(sectionId, component + "_2", "deleteOne");
        resultDeleteRowCount += baseCrudMapper.deleteOne(statement, param);
        statement = serviceSupport.buildCrudStatement(sectionId, component + "_3", "deleteOne");
        resultDeleteRowCount += baseCrudMapper.deleteOne(statement, param);
        statement = serviceSupport.buildCrudStatement(sectionId, component + "_4", "deleteOne");
        resultDeleteRowCount += baseCrudMapper.deleteOne(statement, param);
        statement = serviceSupport.buildCrudStatement(sectionId, component + "_5", "deleteOne");
        resultDeleteRowCount += baseCrudMapper.deleteOne(statement, param);
        statement = serviceSupport.buildCrudStatement(sectionId, component, "deleteOne");
        resultDeleteRowCount += baseCrudMapper.deleteOne(statement, param);

        if (resultDeleteRowCount <= 0) {
            throw CrudFailException.insertFail(sectionId, pgId, component, param, resultDeleteRowCount);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("resultRowCount", (resultDeleteRowCount));
        return result;
    }






}





