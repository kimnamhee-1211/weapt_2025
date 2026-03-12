package egovframework.com.baseCrud;

import egovframework.com.baseCrud.service.BaseBoardService;
import egovframework.com.common.dto.ApiResponse;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Map;

/**
 * @author 김남희
 * @version 1.0
 * @Class Name : LoginController.java
 * @Description : Login Controller Class
 * @Modification Information
 * @
 * @ 수정일          수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2025.09     김남희        최초생성
 * @see Copyright (C) by  All right reserved.
 * @since 2025.09
 */

@RequestMapping("/api")
@Controller
public class BaseBoardController {

    @Resource(name = "baseBoardService")
    protected BaseBoardService baseBoardService;


    //게시글 검색
    @RequestMapping(value = "/boardSelectOne/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ApiResponse<Map<String, Object>> boardSelectOne(@PathVariable("sectionId") String sectionId,
                                                           @PathVariable("component") String component,
                                                           @RequestParam Map<String, Object> param,
                                                           @SessionAttribute("loginUser") LoginVO loginUser,
                                                           @RequestAttribute(value = "PG_ID") String pgId,
                                                           @RequestAttribute(value = "MENU_ID") String menuId) {

        Map<String, Object> resultMap = baseBoardService.boardSelectOne(sectionId, component, param, loginUser, pgId, menuId);
        ApiResponse<Map<String, Object>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultMap.size());
        result.setO_MSG(resultMap.size() + "건이 조회되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SELECT);
        result.setDATA(resultMap);
        return result;
    }

    //게시글 저장 + 수정
    @RequestMapping(value = "/boardSave/{sectionId}/{component}", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Void> boardSave(@PathVariable("sectionId") String sectionId,
                                       @PathVariable("component") String component,
                                       @RequestBody Map<String, Object> param,
                                       @SessionAttribute("loginUser") LoginVO loginUser,
                                       @RequestAttribute(value = "PG_ID") String pgId,
                                       @RequestAttribute(value = "MENU_ID") String menuId) {

        int resultRowCount = baseBoardService.boardSave(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultRowCount);
        result.setO_MSG(resultRowCount + "건이 저장되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SAVE);
        return result;
    }

    //게시글 삭제
    @RequestMapping(value = "/boardDeleteOne/{sectionId}/{component}", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Void> boardDeleteOne(@PathVariable("sectionId") String sectionId,
                                            @PathVariable("component") String component,
                                            @RequestBody Map<String, Object> param,
                                            @SessionAttribute("loginUser") LoginVO loginUser,
                                            @RequestAttribute(value = "PG_ID") String pgId,
                                            @RequestAttribute(value = "MENU_ID") String menuId) {

        int resultRowCount = baseBoardService.boardDeleteOne(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultRowCount);
        result.setO_MSG(resultRowCount + "건이 삭제되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.DELETE);
        return result;
    }


}



























