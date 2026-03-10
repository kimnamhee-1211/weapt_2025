package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.support.BaseServiceSupport;
import egovframework.com.exception.CrudFailException;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("ApprovalService")
@Transactional
public class ApprovalServiceImpl extends BaseServiceSupport implements ApprovalService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    //결제직책 검색
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> getApprovalDuty(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId) {

        String statement = "approvalMapper." + "confirmDuty_" + sectionId + "_" + pgId;

        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId);
        System.out.println(param);

        List<Map<String, Object>> result = baseCrudMapper.selectList(statement, param);

        return result;
    }


    //다중 검색
    @Override
    @Transactional
    public Map<String, String> processApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId) {

        String statement = "approvalMapper." + "getApproval_" + sectionId + "_" + pgId;

        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId);
        System.out.println(param);

        //직책에 등록된 결제 권한자
        List<Map<String, Object>> approvalAuthority = baseCrudMapper.selectList(statement, param);

        if (approvalAuthority == null || approvalAuthority.isEmpty()) {

        }
        
        String confirm_id1 = (String) approvalAuthority.get(0).get("CONFIRM_ID");
        String confirm_id2 = (String) approvalAuthority.get(0).get("CONFIRM_ID_S");
        String confirm_seq = (String) approvalAuthority.get(0).get("CONFIRM_SEQ");

        int insertResult = 0;
        if(loginUser.getUserId().equals(confirm_id1) || loginUser.getUserId().equals(confirm_id2)){
            String statement2 = "approvalMapper." + "insertApproval_" + sectionId + "_" + pgId;
            insertResult = baseCrudMapper.insertOne(statement2, param);
        }

        Map<String,String> result = new HashMap<>();
        if(insertResult > 0){
            result.put(confirm_seq, loginUser.getUserName());
        }
        return result;
    }

    public boolean ckeckApproval(String sectionId, String component, Map<String, Object> param){

        return false;
    }

}





