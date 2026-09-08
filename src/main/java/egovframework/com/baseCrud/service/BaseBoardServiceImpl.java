package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.support.ServiceSupport;
import egovframework.com.baseCrud.model.ApiResponse;
import egovframework.com.exception.CrudFailException;
import egovframework.com.login.model.LoginVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Map;

@Service("baseBoardService")
public class BaseBoardServiceImpl implements BaseBoardService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    @Autowired
    private CrudAuthService crudAuthService;

    @Autowired
    private ServiceSupport serviceSupport;


    //게시글 검색
    @Override
    @Transactional
    public Map<String, Object> boardSelectOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        crudAuthService.checkCrudPermission("GRD_READ", loginUser.getUserId(), menuId);

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "boardSelectOne");
        serviceSupport.setParam(param, loginUser, pgId, menuId);
        System.out.println(param);

        Map<String, Object> result = baseCrudMapper.selectOne(statement, param);

        if ("Y".equals(param.get("cnt")) && param.get("LOGIN_ID") != result.get("USER_ID")) {
            String cntUpStatement = serviceSupport.buildCrudStatement(sectionId, component, "boardCntUp");
            int cntUp = baseCrudMapper.updateOne(cntUpStatement, param);
            if (cntUp <= 0) {
                throw CrudFailException.cntFail(sectionId, pgId, component, param, cntUp);
            }
        }

        return result;
    }

    //게시글 저장 + 수정
    @Override
    @Transactional
    public int boardSave(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        Map<String, Object> insertParam = (Map<String, Object>) param.get("insertParam");
        Map<String, Object> updateParam = (Map<String, Object>) param.get("updateParam");

        int resultInsertRowCount = 0;
        int resultUpdateRowCount = 0;

        if (insertParam != null && !insertParam.isEmpty()) {
            resultInsertRowCount = processInsert(sectionId, component, loginUser, insertParam, pgId, menuId);
            if (resultInsertRowCount <= 0) {
                throw CrudFailException.insertFail(sectionId, pgId, component, insertParam, resultInsertRowCount);
            }
        }

        if (updateParam != null && !updateParam.isEmpty()) {
            resultUpdateRowCount = processUpdate(sectionId, component, loginUser, updateParam, pgId, menuId);
            if (resultUpdateRowCount <= 0) {
                throw CrudFailException.updateFail(sectionId, pgId, component, updateParam, resultUpdateRowCount);
            }
        }

        return resultInsertRowCount + resultUpdateRowCount;
    }

    private int processInsert(String sectionId, String component, LoginVO loginUser, Map<String, Object> insertParam, String pgId, String menuId) {

        crudAuthService.checkCrudPermission("GRD_CREATE", loginUser.getUserId(), menuId);

        //loginUser set
        serviceSupport.setParam(insertParam, loginUser, pgId, menuId);
        System.out.println(insertParam);
        String statement = serviceSupport.buildCrudStatement(sectionId, component, "insertList");
        return baseCrudMapper.insertOne(statement, insertParam);
    }


    private int processUpdate(String sectionId, String component, LoginVO loginUser, Map<String, Object> updateParam, String pgId, String menuId) {

        crudAuthService.checkCrudPermission("GRD_UPDATE", loginUser.getUserId(), menuId);

        //loginUser set
        serviceSupport.setParam(updateParam, loginUser, pgId, menuId);
        System.out.println(updateParam);
        String statement = serviceSupport.buildCrudStatement(sectionId, component, "boardUpdateOne");
        return baseCrudMapper.updateOne(statement, updateParam);
    }


    //게시글 삭제
    @Override
    @Transactional
    public int boardDeleteOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        crudAuthService.checkCrudPermission("GRD_DELETE", loginUser.getUserId(), menuId);

        String statement = serviceSupport.buildCrudStatement(sectionId, component, "boardDeleteOne");
        Map<String, Object> deleteParam = (Map<String, Object>) param.get("deleteParam");
        serviceSupport.setParam(deleteParam, loginUser, pgId, menuId);
        int resultRowCount = baseCrudMapper.deleteOne(statement, deleteParam);

        if (resultRowCount <= 0) {
            throw CrudFailException.deleteFail(sectionId, pgId, component, deleteParam, resultRowCount);
        }

        return resultRowCount;
    }

}





