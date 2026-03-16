package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.support.BaseServiceSupport;
import egovframework.com.common.dto.ApiResponse;
import egovframework.com.exception.CrudFailException;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Map;

@Service("baseBoardService")
public class BaseBoardServiceImpl extends BaseServiceSupport implements BaseBoardService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    //게시글 검색
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> boardSelectOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        String statement = buildCrudStatement(sectionId, component, "boardSelectOne");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
        System.out.println(param);

        Map<String, Object> result = baseCrudMapper.selectOne(statement, param);
        if (result == null || result.isEmpty()) {
            throw new CrudFailException(
                    "FAIL BOARD SLELECT " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                    "게시글 조회 실패",
                    ApiResponse.ApiType.SELECT);
        }

        if ("Y".equals(param.get("cnt")) && param.get("LOGINUSER_ID") != result.get("USER_ID")) {
            String cntUpStatement = buildCrudStatement(sectionId, component, "boardCntUp");
            int cntUp = baseCrudMapper.updateOne(cntUpStatement, param);
            if (cntUp <= 0) {
                throw new CrudFailException(
                        "FAIL CNT " + component,
                        "조회수 증가 실패 : " + cntUp + "건",
                        ApiResponse.ApiType.CNT);
            }
        }

        return result;
    }

    //게시글 저장 + 수정
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int boardSave(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        Map<String, Object> insertParam = (Map<String, Object>) param.get("insertParam");
        Map<String, Object> updateParam = (Map<String, Object>) param.get("updateParam");

        int resultInsertRowCount = 0;
        int resultUpdateRowCount = 0;

        if (insertParam != null && !insertParam.isEmpty()) {
            resultInsertRowCount = processInsert(sectionId, component, loginUser, insertParam, pgId, menuId);
            if (resultInsertRowCount <= 0) {
                throw new CrudFailException(
                        "FAIL INSERT " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                        "저장 실패 : " + (resultInsertRowCount) + "건",
                        ApiResponse.ApiType.INSERT);
            }
        }

        if (updateParam != null && !updateParam.isEmpty()) {
            resultUpdateRowCount = processUpdate(sectionId, component, loginUser, updateParam, pgId, menuId);
            if (resultUpdateRowCount <= 0) {
                throw new CrudFailException(
                        "FAIL UPDATE " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                        "저장 실패 : " + (resultUpdateRowCount) + "건",
                        ApiResponse.ApiType.UPDATE);
            }
        }

        return resultInsertRowCount + resultUpdateRowCount;
    }

    private int processInsert(String sectionId, String component, LoginVO loginUser, Map<String, Object> insertParam, String pgId, String menuId) {
        //loginUser set
        setLoginParam(insertParam, loginUser);
        setPgIdParam(insertParam, pgId, menuId);
        System.out.println(insertParam);
        String statement = buildCrudStatement(sectionId, component, "insertList");
        return baseCrudMapper.insertOne(statement, insertParam);
    }


    private int processUpdate(String sectionId, String component, LoginVO loginUser, Map<String, Object> updateParam, String pgId, String menuId) {
        //loginUser set
        setLoginParam(updateParam, loginUser);
        setPgIdParam(updateParam, pgId, menuId);
        System.out.println(updateParam);
        String statement = buildCrudStatement(sectionId, component, "boardUpdateOne");
        return baseCrudMapper.updateOne(statement, updateParam);
    }


    //게시글 삭제
    @Override
    @Transactional
    public int boardDeleteOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        String statement = buildCrudStatement(sectionId, component, "boardDeleteOne");
        Map<String, Object> deleteParam = (Map<String, Object>) param.get("deleteParam");
        setLoginParam(deleteParam, loginUser);
        setPgIdParam(deleteParam, pgId, menuId);

        int resultRowCount = baseCrudMapper.deleteOne(statement, deleteParam);

        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL DELETE " + sectionId + "/" + pgId + "/" + component + " : \n" + deleteParam,
                    "삭제 실패 : " + resultRowCount + "건",
                    ApiResponse.ApiType.DELETE);
        }

        return resultRowCount;
    }

}





