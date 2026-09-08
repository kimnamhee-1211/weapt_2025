package egovframework.com.section.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.model.ApiResponse;
import egovframework.com.baseCrud.service.CrudAuthService;
import egovframework.com.baseCrud.service.CrudBeforeService;
import egovframework.com.baseCrud.support.ServiceSupport;
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

@Service("baseCrudService")
public class JangsooServiceImpl extends ServiceSupport implements JangsooService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    @Autowired
    private CrudAuthService crudAuthService;

    @Autowired
    private CrudBeforeService crudBeforeService;

    private static final Logger LOGGER = LoggerFactory.getLogger(JangsooServiceImpl.class);

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

        String statement = buildCrudStatement(sectionId, component, "selectOne");
        setParam(param, loginUser, pgId, menuId);
        Map<String, Object> updateList = baseCrudMapper.selectOne(statement, param);

        int resultUpdateRowCount = 0;
        if(updateList.get("CLOSE_YN") != "1"){
            if((int)updateList.get("ITEM_UNIT_CNT") > 0){
                statement = buildCrudStatement(sectionId, component + "_1", "updateOne");
                resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);
            }
            if((int)updateList.get("ITEM_CODE_CNT") > 0){
                statement = buildCrudStatement(sectionId, component + "_2", "updateOne");
                resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);
            }
            if((int)updateList.get("KIND_CODE_CNT") > 0){
                statement = buildCrudStatement(sectionId, component + "_3", "updateOne");
                resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);
            }
            if((int)updateList.get("SUB_CODE_CNT") > 0){
                statement = buildCrudStatement(sectionId, component + "_4", "updateOne");
                resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);
            }
            if((int)updateList.get("CODE_CNT") > 0){
                statement = buildCrudStatement(sectionId, component + "_5", "updateOne");
                resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);
            }
            statement = buildCrudStatement(sectionId, component, "updateOne");
            resultUpdateRowCount += baseCrudMapper.updateOne(statement, param);
        }

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

        crudAuthService.checkCrudPermission("GRD_INSERT", loginUser.getUserId(), menuId);

        String statement = buildCrudStatement(sectionId, component, "selectOne");
        setParam(param, loginUser, pgId, menuId);
        Map<String, Object> insertMap = baseCrudMapper.selectOne(statement, param);

        int resultInsertRowCount = 0;

        if(insertMap.get("CLOSE_YN") == "1"){
            statement = buildCrudStatement(sectionId, component, "insertOne");
            resultInsertRowCount += baseCrudMapper.insertOne(statement, param);

            if((int)insertMap.get("CODE_CNT") > 0){
                statement = buildCrudStatement(sectionId, component + "_1", "insertOne");
                resultInsertRowCount += baseCrudMapper.insertOne(statement, param);
            }
            if((int)insertMap.get("SUB_CODE_CNT") > 0){
                statement = buildCrudStatement(sectionId, component + "_2", "insertOne");
                resultInsertRowCount += baseCrudMapper.insertOne(statement, param);
            }
            if((int)insertMap.get("KIND_CODE_CNT") > 0){
                statement = buildCrudStatement(sectionId, component + "_3", "insertOne");
                resultInsertRowCount += baseCrudMapper.insertOne(statement, param);
            }
            if((int)insertMap.get("ITEM_CODE_CNT") > 0){
                statement = buildCrudStatement(sectionId, component + "_4", "insertOne");
                resultInsertRowCount += baseCrudMapper.insertOne(statement, param);
            }
            if((int)insertMap.get("ITEM_UNIT_CNT") > 0){
                statement = buildCrudStatement(sectionId, component + "_5", "insertOne");
                resultInsertRowCount += baseCrudMapper.insertOne(statement, param);
            }

        };

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

        crudAuthService.checkCrudPermission("GRD_INSERT", loginUser.getUserId(), menuId);

        setParam(param, loginUser, pgId, menuId);

        int resultDeleteRowCount = 0;
        int resultInsertRowCount = 0;
        Map<String, Object> deleteMap = param.get(0);
        if(deleteMap.get("CLOSE_YN") == "1"){
            String statement = "";
            statement = buildCrudStatement(sectionId, component + "_1", "deleteOne");
            resultDeleteRowCount += baseCrudMapper.deleteOne(statement, deleteMap);
            statement = buildCrudStatement(sectionId, component + "_2", "deleteOne");
            resultDeleteRowCount += baseCrudMapper.deleteOne(statement, deleteMap);
            statement = buildCrudStatement(sectionId, component + "_3", "deleteOne");
            resultDeleteRowCount += baseCrudMapper.deleteOne(statement, deleteMap);
            statement = buildCrudStatement(sectionId, component + "_4", "deleteOne");
            resultDeleteRowCount += baseCrudMapper.deleteOne(statement, deleteMap);
            statement = buildCrudStatement(sectionId, component + "_5", "deleteOne");
            resultDeleteRowCount += baseCrudMapper.deleteOne(statement, deleteMap);

            List<Map<String, Object>> insertList1 = param.stream()
                    .filter(map -> "1".equals(map.get("LEVEL")) )
                    .collect(Collectors.toList());
            if(insertList1 != null && insertList1.size() > 0) {
                statement = buildCrudStatement(sectionId, component + "_1", "insertList");
                resultInsertRowCount += baseCrudMapper.insertList(statement, insertList1);
            }
            List<Map<String, Object>> insertList2 = param.stream()
                    .filter(map -> "2".equals(map.get("LEVEL")))
                    .collect(Collectors.toList());
            if(insertList2 != null && insertList2.size() > 0) {
                statement = buildCrudStatement(sectionId, component + "_2", "insertList");
                resultInsertRowCount += baseCrudMapper.insertList(statement, insertList2);
            }
            List<Map<String, Object>> insertList3 = param.stream()
                    .filter(map -> "3".equals(map.get("LEVEL")) )
                    .collect(Collectors.toList());
            if(insertList3 != null && insertList3.size() > 0) {
                statement = buildCrudStatement(sectionId, component + "_3", "insertList");
                resultInsertRowCount += baseCrudMapper.insertList(statement, insertList3);
            }
        }

        if (resultInsertRowCount <= 0) {
            throw CrudFailException.insertFail(sectionId, pgId, component, param, resultInsertRowCount);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("resultRowCount", (resultInsertRowCount));
        return result;
    }


}





