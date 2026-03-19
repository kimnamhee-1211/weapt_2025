package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.support.BaseServiceSupport;
import egovframework.com.common.dto.ApiResponse;
import egovframework.com.exception.ApprovalAuthException;
import egovframework.com.exception.ApprovalFailException;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("ApprovalService")
@Transactional
public class ApprovalServiceImpl extends BaseServiceSupport implements ApprovalService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    //결재 직책 조회(개별)
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> getApprDuty(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        String statement = buildApprovalStatement(sectionId, component, "confirmDuty");

        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
        System.out.println(param);

        List<Map<String, Object>> result = baseCrudMapper.selectList(statement, param);

        if (result == null || result.isEmpty()) {
            throw new ApprovalAuthException(
                    "NULL_DATA " + sectionId + "/" + component + " : \n" + param,
                    "결재 권한 직책 정보가 없습니다.",
                    ApiResponse.ApiType.NULL_DATA);
        }

        return result;
    }

    //결재 직책 조회 TPM_CONFIRM_LINE
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> getApprDutyLine(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);

        List<Map<String, Object>> menuGroup = baseCrudMapper.selectList("approvalMapper.confirmLine_menuGroup", param);
        param.put("MENU_GROUP", menuGroup.get(0).get("MENU_GROUP"));

        System.out.println(param);
        String statement = buildApprovalStatement(sectionId, component, "confirmLine");

        List<Map<String, Object>> result = baseCrudMapper.selectList(statement, param);

        if (result == null || result.isEmpty()) {
            throw new ApprovalAuthException(
                    "NULL_DATA " + sectionId + "/" + component + " : \n" + param,
                    "결재 권한 직책 정보가 없습니다.",
                    ApiResponse.ApiType.NULL_DATA);
        }

        return result;
    }

    //결재 현황 조회
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> selectApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);

        List<Map<String, Object>> menuGroup = baseCrudMapper.selectList("approvalMapper.confirmLine_menuGroup", param);
        param.put("MENU_GROUP", menuGroup.get(0).get("MENU_GROUP"));

        //결재 현황 조회
        List<Map<String, Object>> resultList = getApproval(sectionId, component, param);
        System.out.println("resultList" + resultList);

        return resultList;
    }


    //결재 처리 프로세스
    @Override
    @Transactional(rollbackFor = Exception.class, noRollbackFor = ApprovalAuthException.class)
    public List<Map<String, Object>> processApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
        System.out.println("param1 : " + param);

        List<Map<String, Object>> menuGroup = baseCrudMapper.selectList("approvalMapper.confirmLine_menuGroup", param);
        param.put("MENU_GROUP", menuGroup.get(0).get("MENU_GROUP"));
        System.out.println(param);

        //결재 권한 확인
        checkApproval(sectionId, component, param, loginUser);
        //결재 처리
        approval(sectionId, component, param);

        //결재 현황 조회
        List<Map<String, Object>> result = getApproval(sectionId, component, param);

        return result;
    }

    //결재 권한 확인
    private boolean checkApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser) {

        String statement = buildApprovalStatement(sectionId, component, "getApprAuth");

        //직책별 결재 권한 정보 조회
        List<Map<String, Object>> approvalAuthority = baseCrudMapper.selectList(statement, param);
        System.out.println("approvalAuthority : " + approvalAuthority);
        if (approvalAuthority == null || approvalAuthority.isEmpty()) {
            System.out.println("????");
            throw new ApprovalAuthException(
                    "NULL_DATA " + sectionId + "/" + component + " : \n" + param,
                    "결재 권한 정보가 없습니다.",
                    ApiResponse.ApiType.NULL_DATA);
        }

        //결재 처리 여부 확인
        String confirm_date = (String) approvalAuthority.get(0).get("REAL_DATE");
        if (confirm_date != null && !confirm_date.isEmpty()) {
            throw new ApprovalAuthException(
                    "ALREADY_APPROVAL " + sectionId + "/" + component + " : \n" + param,
                    "이미 결재 처리되었습니다.",
                    ApiResponse.ApiType.APPROVAL);
        }

        String confirm_id1 = (String) approvalAuthority.get(0).get("CONFIRM_ID");
        String confirm_id2 = (String) approvalAuthority.get(0).get("CONFIRM_ID_S");

        //결재 권한 확인
        if (loginUser.getUserId().equals(confirm_id1) || loginUser.getUserId().equals(confirm_id2)) {
            return true;
        } else {
            throw new ApprovalAuthException(
                    "NO_AUTHORITY " + sectionId + "/" + component + " : \n" + param,
                    "결재 권한이 없습니다.",
                    ApiResponse.ApiType.APPROVAL);
        }
    }

    //결재 처리
    private int approval(String sectionId, String component, Map<String, Object> param) {
        String statement = buildApprovalStatement(sectionId, component, "approval");

        int result = baseCrudMapper.insertOne(statement, param);

        if (result < 1) {
            throw new ApprovalFailException(
                    "APPROVAL_FAILED " + sectionId + "/" + component + " : \n" + param,
                    "결재 실패",
                    ApiResponse.ApiType.APPROVAL);
        }
        return result;
    }

    //결재 취소 처리 프로세스
    @Override
    @Transactional(rollbackFor = Exception.class, noRollbackFor = ApprovalAuthException.class)
    public List<Map<String, Object>> processCnlApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId) {

        setLoginParam(param, loginUser);
        setPgIdParam(param, pgId, menuId);
        System.out.println(param);

        List<Map<String, Object>> menuGroup = baseCrudMapper.selectList("approvalMapper.confirmLine_menuGroup", param);
        param.put("MENU_GROUP", menuGroup.get(0).get("MENU_GROUP"));
        System.out.println(param);

        //결재 취소 권한 확인
        checkCnlApproval(sectionId, component, param, loginUser);

        //결재 취소 처리
        cancelApproval(sectionId, component, param);

        //결재 현황 조회
        List<Map<String, Object>> result = getApproval(sectionId, component, param);

        return result;
    }

    //결재 취소 권한 확인
    private boolean checkCnlApproval(String sectionId, String component, Map<String, Object> param, LoginVO loginUser) {
        System.out.println("param : " + param);
        String statement = buildApprovalStatement(sectionId, component, "getApprAuth");

        //직책별 결재 권한 정보 조회
        List<Map<String, Object>> approvalAuthority = baseCrudMapper.selectList(statement, param);
        System.out.println("approvalAuthority : " + approvalAuthority);
        if (approvalAuthority == null || approvalAuthority.isEmpty()) {
            throw new ApprovalAuthException(
                    "NULL_DATA " + sectionId + "/" + component + " : \n" + param,
                    "결재 권한 정보가 없습니다.",
                    ApiResponse.ApiType.NULL_DATA);
        }

        //결재 처리 여부 확인
        String confirm_date = (String) approvalAuthority.get(0).get("REAL_DATE");
        if (confirm_date == null && confirm_date.isEmpty()) {
            throw new ApprovalAuthException(
                    "NO_APPROVAL " + sectionId + "/" + component + " : \n" + param,
                    "취소할 결재내역이 없습니다.",
                    ApiResponse.ApiType.APPROVAL);
        }

        String confirm_userId = (String) approvalAuthority.get(0).get("REAL_USER_ID");
        String confirm_userNm = (String) approvalAuthority.get(0).get("REAL_USER_NM");

        //결재 권한 확인
        if (!loginUser.getUserId().equals(confirm_userId) || !loginUser.getUserName().equals(confirm_userNm)) {
            throw new ApprovalAuthException(
                    "NO_CANCEL_AUTHORITY " + sectionId + "/" + component + " : \n" + param,
                    "결재 취소 권한이 없습니다.",
                    ApiResponse.ApiType.APPROVAL);
        } else {
            return true;
        }
    }

    //결재 취소
    private int cancelApproval(String sectionId, String component, Map<String, Object> param) {

        String statement = buildApprovalStatement(sectionId, component, "cancelApproval");
        int result = baseCrudMapper.deleteOne(statement, param);

        if (result < 1) {
            throw new ApprovalFailException(
                    "CANCEL_APPROVAL_FAILED " + sectionId + "/" + component + " : \n" + param,
                    "결재 취소 실패",
                    ApiResponse.ApiType.APPROVAL);
        }
        return result;
    }

    //결재 현황 조회
    private List<Map<String, Object>> getApproval(String sectionId, String component, Map<String, Object> param) {

        //결재 현황 조회
        String statement = buildApprovalStatement(sectionId, component, "selectApproval");

        List<Map<String, Object>> getApproval = baseCrudMapper.selectList(statement, param);
        List<Map<String, Object>> result = new ArrayList<>();

        if (getApproval != null || !getApproval.isEmpty()) {
            Map<String, Object> resultMap = new HashMap<>();
            for (Map<String, Object> el : getApproval) {
                Object key = el.get("CONFIRM_SEQ");
                if(key != null){
                    resultMap.put(key.toString(), String.valueOf(el.get("REAL_USER_NM")));
                }
            }
            result.add(resultMap);
        } else {
            Map<String, Object> emptyRow = new HashMap<>();
            emptyRow.put("1", "");
            result.add(emptyRow);
        }
        return result;
    }


}





