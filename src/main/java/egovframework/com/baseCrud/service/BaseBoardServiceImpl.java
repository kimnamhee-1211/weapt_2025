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


@Service("baseBoardService")
public class BaseBoardServiceImpl implements BaseBoardService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    //게시글 검색
    @Override
    @Transactional
    public Map<String, Object> boardSelectOne(String sectionId, String component, Map<String, Object> param) {

        String mapper = sectionId.replaceAll("[^A-Za-z]", "") + "Mapper";
        String methodName = "boardSelectOne_" + component;
        String statement = mapper + "." + methodName;

        LoginVO loginUser = (LoginVO) param.get("loginUser");
        if (loginUser != null) {
            param = setUserToParam(loginUser, param);
        }
        System.out.println(param);

        Map<String, Object> result = baseCrudMapper.selectOne(statement, param);

        if ("Y".equals(param.get("cnt")) && param.get("LOGINUSER_ID") != result.get("USER_ID")) {
            String cntUpStatement = mapper + ".boardCntUp_" + component;
            int cntUp = baseCrudMapper.updateOne(cntUpStatement, param);
            if (cntUp <= 0) {
                throw new BaseCrudFailException(
                        "FAIL CNT " + component,
                        "조회수 증가 실패 : " + cntUp + "건",
                        BaseCrudFailException.CrudType.CNT);
            }
        }
        return result;
    }

    //게시글 저장 + 수정
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> boardSave(String sectionId, String component, Map<String, Object> param) {

        String mapper = sectionId.replaceAll("[^A-Za-z]", "") + "Mapper";
        String methodName = "";

        Map<String, Object> insertParam = (Map<String, Object>) param.get("insertParam");
        Map<String, Object> updateParam = (Map<String, Object>) param.get("updateParam");
        LoginVO loginUser = (LoginVO) param.get("loginUser");

        int resultInsertRowCount = 0;
        int resultUpdateRowCount = 0;

        if (insertParam != null && !insertParam.isEmpty()) {
            if (loginUser != null) {
                insertParam = setUserToParam(loginUser, insertParam);
            }
            System.out.println(insertParam);

            methodName = "boardInsertOne_" + component;
            String statement = mapper + "." + methodName;
            resultInsertRowCount = baseCrudMapper.insertOne(statement, insertParam);
        }

        if (updateParam != null && !updateParam.isEmpty()) {
            if (loginUser != null) {
                updateParam = setUserToParam(loginUser, updateParam);
            }
            System.out.println(updateParam);

            methodName = "boardUpdateOne_" + component;
            String statement = mapper + "." + methodName;

            resultUpdateRowCount = baseCrudMapper.updateOne(statement, updateParam);
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
        result.put("O_MSG", resultInsertRowCount + resultUpdateRowCount + "건이 저장되었습니다.");
        result.put("O_TYPE", "SAVE");

        return result;
    }

    //게시글 삭제
    @Override
    public Map<String, Object> boardDeleteOne(String sectionId, String component, Map<String, Object> param) {

        String mapper = sectionId.replaceAll("[^A-Za-z]", "") + "Mapper";
        String methodName = "boardDeleteOne_" + component;
        String statement = mapper + "." + methodName;

        Map<String, Object> deleteParam = (Map<String, Object>) param.get("deleteParam");
        LoginVO loginUser = (LoginVO) param.get("loginUser");

        if (loginUser != null) {
            deleteParam = setUserToParam(loginUser, deleteParam);
        }

        int resultRowCount = baseCrudMapper.deleteOne(statement, deleteParam);

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

}





