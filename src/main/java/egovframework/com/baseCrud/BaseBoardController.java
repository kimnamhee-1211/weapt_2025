package egovframework.com.baseCrud;

import egovframework.com.baseCrud.service.BaseBoardService;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Map;

/**
 * @Class Name : LoginController.java
 * @Description : Login Controller Class
 * @Modification Information
 * @
 * @  수정일          수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2025.09     김남희        최초생성
 *
 * @author 김남희
 * @since 2025.09
 * @version 1.0
 * @see
 *
 *  Copyright (C) by  All right reserved.
 */

@RequestMapping("/api")
@Controller
public class BaseBoardController {

	@Resource(name = "baseBoardService")
	protected BaseBoardService baseBoardService;


	//게시글 검색
	@RequestMapping(value = "/boardSelectOne/{sectionId}/{component}", produces="application/json;charset=UTF-8", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> boardSelectOne(@PathVariable("sectionId") String sectionId,
											  @PathVariable("component") String component,
											  @RequestParam Map<String, Object> param,
											  @SessionAttribute("loginUser") LoginVO loginUser,
											  @RequestAttribute(value="PG_ID") String pgId,
											  @RequestAttribute(value="MENU_ID") String menuId){

		Map<String, Object> result = baseBoardService.boardSelectOne(sectionId, component, param, loginUser, pgId, menuId);
		return result;
	}

	//게시글 저장 + 수정
	@RequestMapping(value = "/boardSave/{sectionId}/{component}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> boardSave(@PathVariable("sectionId") String sectionId,
										 @PathVariable("component") String component,
										 @RequestBody Map<String, Object> param,
										 @SessionAttribute("loginUser") LoginVO loginUser,
										 @RequestAttribute(value="PG_ID") String pgId,
										 @RequestAttribute(value="MENU_ID") String menuId){

		Map<String, Object> result = baseBoardService.boardSave(sectionId, component, param, loginUser, pgId, menuId);
		return result;
	}

	//게시글 삭제
	@RequestMapping(value = "/boardDeleteOne/{sectionId}/{component}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> boardDeleteOne(@PathVariable("sectionId") String sectionId,
											  @PathVariable("component") String component,
											  @RequestBody Map<String, Object> param,
											  @SessionAttribute("loginUser") LoginVO loginUser,
											  @RequestAttribute(value="PG_ID") String pgId,
											  @RequestAttribute(value="MENU_ID") String menuId){

		Map<String, Object> result = baseBoardService.boardDeleteOne(sectionId, component, param, loginUser, pgId, menuId);

		return result ;
	}


}



























