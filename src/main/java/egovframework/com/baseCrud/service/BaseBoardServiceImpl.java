package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.support.BaseServiceSupport;
import egovframework.com.exception.CrudFailException;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Service("baseBoardService")
public class BaseBoardServiceImpl extends BaseServiceSupport implements BaseBoardService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    //게시글 검색
    @Override
    @Transactional
    public Map<String, Object> boardSelectOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId) {

        String statement = buildCrudStatement(sectionId, component, "boardSelectOne");
        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId);
        System.out.println(param);

        Map<String, Object> result = baseCrudMapper.selectOne(statement, param);
        if(result == null || result.isEmpty()) {
            throw new CrudFailException(
                    "FAIL BOARD SLELECT " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                    "게시글 조회 실패",
                    CrudFailException.CrudType.SELECT);
        }

        if ("Y".equals(param.get("cnt")) && param.get("LOGINUSER_ID") != result.get("USER_ID")) {
            String cntUpStatement = buildCrudStatement(sectionId, component, "boardCntUp");
            int cntUp = baseCrudMapper.updateOne(cntUpStatement, param);
            if (cntUp <= 0) {
                throw new CrudFailException(
                        "FAIL CNT " + component,
                        "조회수 증가 실패 : " + cntUp + "건",
                        CrudFailException.CrudType.CNT);
            }
        }
        return result;
    }

    //게시글 저장 + 수정
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> boardSave(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId) {

        Map<String, Object> insertParam = (Map<String, Object>) param.get("insertParam");
        Map<String, Object> updateParam = (Map<String, Object>) param.get("updateParam");

        int resultInsertRowCount = 0;
        int resultUpdateRowCount = 0;

        if (insertParam != null && !insertParam.isEmpty()) {
            resultInsertRowCount = processInsert(sectionId, component, loginUser, insertParam, pgId);
            if (resultInsertRowCount <= 0) {
                throw new CrudFailException(
                        "FAIL INSERT " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                        "저장 실패 : " + (resultInsertRowCount) + "건",
                        CrudFailException.CrudType.INSERT);
            }
        }

        if (updateParam != null && !updateParam.isEmpty()) {
            resultUpdateRowCount = processUpdate(sectionId, component, loginUser, updateParam, pgId);
            if (resultUpdateRowCount <= 0) {
                throw new CrudFailException(
                        "FAIL UPDATE " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                        "저장 실패 : " + (resultUpdateRowCount) + "건",
                        CrudFailException.CrudType.UPDATE);
            }
        }

        Map<String, Object> result = new HashMap<>();

        result.put("O_STATUS", "SUCCESS");
        result.put("O_RESULT", (resultInsertRowCount + resultUpdateRowCount));
        result.put("O_MSG", resultInsertRowCount + resultUpdateRowCount + "건이 저장되었습니다.");
        result.put("O_TYPE", "SAVE");

        return result;
    }

    private int processInsert(String sectionId, String component, LoginVO loginUser, Map<String, Object> insertParam, String pgId) {
        //loginUser set
        setLoginParam(insertParam, loginUser);
        setPgIdParam(insertParam, pgId);
        System.out.println(insertParam);
        String statement = buildCrudStatement(sectionId, component, "insertList");
        return baseCrudMapper.insertOne(statement, insertParam);
    }


    private int processUpdate(String sectionId, String component, LoginVO loginUser, Map<String, Object> updateParam, String pgId) {
        //loginUser set
        setLoginParam(updateParam, loginUser);
        setPgIdParam(updateParam, pgId);
        System.out.println(updateParam);
        String statement = buildCrudStatement(sectionId, component, "boardUpdateOne");
        return baseCrudMapper.updateOne(statement, updateParam);
    }


    //게시글 삭제
    @Override
    @Transactional
    public Map<String, Object> boardDeleteOne(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId) {

        String statement = buildCrudStatement(sectionId, component, "boardDeleteOne");
        Map<String, Object> deleteParam = (Map<String, Object>) param.get("deleteParam");
        setLoginParam(deleteParam, loginUser);
        setPgIdParam(deleteParam, pgId);

        int resultRowCount = baseCrudMapper.deleteOne(statement, deleteParam);

        Map<String, Object> result = new HashMap<>();

        if (resultRowCount <= 0) {
            throw new CrudFailException(
                    "FAIL DELETE " + sectionId + "/" + pgId + "/" + component + " : \n" + deleteParam,
                    "삭제 실패 : " + resultRowCount + "건",
                    CrudFailException.CrudType.DELETE);
        }

        result.put("O_STATUS", "SUCCESS");
        result.put("O_RESULT", resultRowCount);
        result.put("O_MSG", resultRowCount + "건이 삭제되었습니다.");
        result.put("O_TYPE", "DELETE");

        return result;
    }

}





