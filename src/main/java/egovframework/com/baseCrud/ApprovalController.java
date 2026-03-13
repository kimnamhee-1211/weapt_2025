package egovframework.com.baseCrud;


import egovframework.com.baseCrud.service.ApprovalService;
import egovframework.com.common.dto.ApiResponse;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @author 김남희
 * @version 1.0
 * @Class Name : ApprovalController.java
 * @Description : Approval Controller Class
 * @Modification Information
 * @
 * @ 수정일          수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2026.03     김남희        최초생성
 * @see Copyright (C) by  All right reserved.
 * @since 2026.03
 */

@RequestMapping("/api")
@Controller
public class ApprovalController {

    @Resource(name = "ApprovalService")
    protected ApprovalService approvalService;


    //결재 직책 조회(개별)
    @RequestMapping(value = "/getApprDuty/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ApiResponse<List<Map<String, Object>>> getApprDuty(@PathVariable("sectionId") String sectionId,
                                                              @PathVariable("component") String component,
                                                              @RequestParam Map<String, Object> param,
                                                              @SessionAttribute("loginUser") LoginVO loginUser,
                                                              @RequestAttribute(value = "PG_ID") String pgId,
                                                              @RequestAttribute(value = "MENU_ID") String menuId) {

        List<Map<String, Object>> resultList = approvalService.getApprDuty(sectionId, component, param, loginUser, pgId, menuId);
        ApiResponse<List<Map<String, Object>>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultList.size());
        result.setO_MSG(resultList.size() + "건이 조회되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SELECT);
        result.setDATA(resultList);
        return result;
    }

    //결재 직책 조회 TPM_CONFIRM_LINE
    @RequestMapping(value = "/getApprDutyLine/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ApiResponse<List<Map<String, Object>>> getApprDutyLine(@PathVariable("sectionId") String sectionId,
                                                                  @PathVariable("component") String component,
                                                                  @RequestParam Map<String, Object> param,
                                                                  @SessionAttribute("loginUser") LoginVO loginUser,
                                                                  @RequestAttribute(value = "PG_ID") String pgId,
                                                                  @RequestAttribute(value = "MENU_ID") String menuId) {

        List<Map<String, Object>> resultList = approvalService.getApprDutyLine(sectionId, component, param, loginUser, pgId, menuId);
        ApiResponse<List<Map<String, Object>>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultList.size());
        result.setO_MSG(resultList.size() + "건이 조회되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SELECT);
        result.setDATA(resultList);
        return result;
    }


    //결재 현황 조회
    @RequestMapping(value = "/selectApproval/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ApiResponse<List<Map<String, Object>>> selectApproval(@PathVariable("sectionId") String sectionId,
                                                                 @PathVariable("component") String component,
                                                                 @RequestParam Map<String, Object> param,
                                                                 @SessionAttribute("loginUser") LoginVO loginUser,
                                                                 @RequestAttribute(value = "PG_ID") String pgId,
                                                                 @RequestAttribute(value = "MENU_ID") String menuId) {

        List<Map<String, Object>> resultList = approvalService.selectApproval(sectionId, component, param, loginUser, pgId, menuId);
        ApiResponse<List<Map<String, Object>>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultList.size());
        result.setO_MSG(resultList.size() + "건이 조회되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SELECT);
        result.setDATA(resultList);
        return result;
    }


    //결재 처리
    @RequestMapping(value = "/approval/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ApiResponse<List<Map<String, Object>>> processApproval(@PathVariable("sectionId") String sectionId,
                                                                  @PathVariable("component") String component,
                                                                  @RequestParam Map<String, Object> param,
                                                                  @SessionAttribute("loginUser") LoginVO loginUser,
                                                                  @RequestAttribute(value = "PG_ID") String pgId,
                                                                  @RequestAttribute(value = "MENU_ID") String menuId) {

        List<Map<String, Object>> resultList = approvalService.processApproval(sectionId, component, param, loginUser, pgId, menuId);
        ApiResponse<List<Map<String, Object>>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultList.size());
        result.setO_MSG("결재 처리되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.APPROVAL);
        result.setDATA(resultList);
        return result;
    }

    //결재 취소 처리
    @RequestMapping(value = "/cancelApproval/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ApiResponse<List<Map<String, Object>>> processCnlApproval(@PathVariable("sectionId") String sectionId,
                                                                        @PathVariable("component") String component,
                                                                        @RequestParam Map<String, Object> param,
                                                                        @SessionAttribute("loginUser") LoginVO loginUser,
                                                                        @RequestAttribute(value = "PG_ID") String pgId,
                                                                        @RequestAttribute(value = "MENU_ID") String menuId) {

        List<Map<String, Object>> resultList = approvalService.processCnlApproval(sectionId, component, param, loginUser, pgId, menuId);
        ApiResponse<List<Map<String, Object>>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultList.size());
        result.setO_MSG("결재 취소 처리되었습니다");
        result.setO_TYPE(ApiResponse.ApiType.APPROVAL);
        result.setDATA(resultList);
        return result;
    }


}



























