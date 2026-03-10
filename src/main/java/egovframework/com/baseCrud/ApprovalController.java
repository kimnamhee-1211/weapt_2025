package egovframework.com.baseCrud;


import egovframework.com.baseCrud.service.ApprovalService;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @Class Name : ApprovalController.java
 * @Description : Approval Controller Class
 * @Modification Information
 * @
 * @  수정일          수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2026.03     김남희        최초생성
 *
 * @author 김남희
 * @since 2026.03
 * @version 1.0
 * @see
 *
 *  Copyright (C) by  All right reserved.
 */

@RequestMapping("/api")
@Controller
public class ApprovalController {

	@Resource(name = "ApprovalService")
	protected ApprovalService approvalService;


	//결제직책 조회
	@RequestMapping(value = "/getApprovalDuty/{sectionId}/{component}", produces="application/json;charset=UTF-8", method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> getApprovalDuty(@PathVariable("sectionId") String sectionId,
										@PathVariable("component") String component,
										@RequestParam Map<String, Object> param,
										@SessionAttribute("loginUser") LoginVO loginUser,
										@RequestAttribute(value="PG_ID") String pgId){



		List<Map<String, Object>> result = approvalService.getApprovalDuty(sectionId, component, param, loginUser, pgId);

		return result;
	}

	@RequestMapping(value = "/approval/{sectionId}/{component}", produces="application/json;charset=UTF-8", method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> processApproval(@PathVariable("sectionId") String sectionId,
													 @PathVariable("component") String component,
													 @RequestParam Map<String, Object> param,
													 @SessionAttribute("loginUser") LoginVO loginUser,
													 @RequestAttribute(value="PG_ID") String pgId){

		Map<String, String> result = approvalService.processApproval(sectionId, component, param, loginUser, pgId);

		return null;
	}

}



























