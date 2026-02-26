package egovframework.com.cmmn;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Arrays;
import java.util.List;
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
						 @RequestParam(required = false) String title,
						 @RequestParam Map<String, Object> paramMap,
						 Model model) throws Exception {

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("pgId", pgId);
		model.addAttribute("title", title);
		System.out.println("pgId :" + pgId + "/" + title);
		String goPgId = setPgId(sectionId, pgId);

		return "section/" + sectionId + "/" + goPgId;
	}

	//팝업 이동
	@RequestMapping(value = "/goPopup/{popup}", method = { RequestMethod.GET, RequestMethod.POST })
	public String goPopup(@PathVariable("popup") String popup,
						  @RequestParam Map<String, Object> paramMap,
						  Model model) throws Exception {

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("popupId", popup);

		return "popup/" + popup;
	}

	private String setPgId(String sectionId, String pgId) {
		String goPgId = "";
		if(sectionId.equals("danche")){
			//회의단체 명단
			List<String> pgIdList1 = Arrays.asList(
					"dan01010", "dan02010", "dan05010", "dan06010", "dan07010", "dan08010", "dan09010"
			);
			if (pgIdList1.contains(pgId)) {
				goPgId = "dan01010";
			}
			//회의단체 전임명단
			List<String> pgIdList2 = Arrays.asList(
					"dan01030", "dan02030", "dan05030", "dan06030", "dan07030", "dan08030", "dan09030"
			);
			if (pgIdList2.contains(pgId)) {
				goPgId = "dan01030";
			}
			//위원회 명단
			List<String> pgIdList3 = Arrays.asList(
					"dan03010", "dan04010", "dan10010", "dan11010", "dan12010", "dan13010"
			);
			if (pgIdList3.contains(pgId)) {
				goPgId = "dan03010";
			}
			//위원회 전임명단
			List<String> pgIdList4 = Arrays.asList(
					"dan03030", "dan04030", "dan10030", "dan11030", "dan12030", "dan13030"
			);
			if (pgIdList4.contains(pgId)) {
				goPgId = "dan03030";
			}
			//회의록
			List<String> pgIdList5 = Arrays.asList(
					"dan01020", "dan02020", "dan03020", "dan04020", "dan09020", "dan10020", "dan11020", "dan12020", "dan13020"
			);
			if (pgIdList5.contains(pgId)) {
				goPgId = "dan01020";
			}
		}else goPgId = pgId;


		return goPgId;
	}


}
