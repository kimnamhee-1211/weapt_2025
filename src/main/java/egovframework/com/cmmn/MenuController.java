package egovframework.com.cmmn;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;
import org.springframework.ui.Model;

/**
 * @Class Name : MenuController.java
 * @Description : MenuController Class
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

@Controller
public class MenuController {

	//메뉴 이동
	@RequestMapping(value = "/goMenu/{sectionId}/{pgId}", method = { RequestMethod.GET })
	public String goMenu(@PathVariable("sectionId") String sectionId,
						 @PathVariable("pgId") String pgId,
						 @RequestParam Map<String, Object> paramMap,
						 Model model) throws Exception {

		model.addAttribute("paramMap", paramMap);

		return "section/" + sectionId + "/" + pgId;
	}

	//팝업 이동
	@RequestMapping(value = "/goPopup/{popup}", method = { RequestMethod.GET, RequestMethod.POST })
	public String goPopup(@PathVariable("popup") String popup,
						  @RequestParam Map<String, Object> paramMap,
						  Model model) throws Exception {

		model.addAttribute("paramMap", paramMap);
		return "popup/" + popup;
	}




}
