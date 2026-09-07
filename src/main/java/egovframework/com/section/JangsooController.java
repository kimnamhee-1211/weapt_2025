package egovframework.com.section;


import egovframework.com.baseCrud.model.ApiResponse;
import egovframework.com.baseCrud.service.BaseCrudService;
import egovframework.com.login.model.LoginVO;
import egovframework.com.section.service.JangsooService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @author 김남희
 * @version 1.0
 * @Class Name : JangsooController.java
 * @Description : Jangsoo Controller Class
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
public class JangsooController {

    @Resource(name = "jangsooService")
    protected JangsooService jangsooService;


    //다중 삭제
    @RequestMapping(value = "/deleteList/jangsoo/soo02010_grid1", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Void> deleteList(@PathVariable("sectionId") String sectionId,
                                        @PathVariable("component") String component,
                                        @RequestBody Map<String, Object> param,
                                        @SessionAttribute("loginUser") LoginVO loginUser,
                                        @RequestAttribute(value = "PG_ID") String pgId,
                                        @RequestAttribute(value = "MENU_ID") String menuId) {

        //int resultRowCount = jangsooService.deleteList(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
//        result.setO_RESULT(resultRowCount);
//        result.setO_MSG(resultRowCount + "건이 삭제되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.DELETE);
        return result;
    }


    @RequestMapping(value = "/saveList/jangsoo/soo02010_change", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Map<String, Object>> change_planMonth(@PathVariable("sectionId") String sectionId,
                                      @PathVariable("component") String component,
                                      @RequestBody Map<String, Object> param,
                                      @SessionAttribute("loginUser") LoginVO loginUser,
                                      @RequestAttribute(value = "PG_ID") String pgId,
                                      @RequestAttribute(value = "MENU_ID") String menuId) {

        Map<String, Object> resultMap = jangsooService.change_planMonth(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Map<String, Object>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT((Integer) resultMap.get("resultRowCount"));
        result.setO_MSG( (Integer) resultMap.get("resultRowCount") +  "건이 저장되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SAVE);
        return result;
    }

    @RequestMapping(value = "/saveList/jangsoo/soo02010_copy", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Map<String, Object>> copy_planMonth(@PathVariable("sectionId") String sectionId,
                                                           @PathVariable("component") String component,
                                                           @RequestBody Map<String, Object> param,
                                                           @SessionAttribute("loginUser") LoginVO loginUser,
                                                           @RequestAttribute(value = "PG_ID") String pgId,
                                                           @RequestAttribute(value = "MENU_ID") String menuId) {

        Map<String, Object> resultMap = jangsooService.copy_planMonth(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Map<String, Object>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT((Integer) resultMap.get("resultRowCount"));
        result.setO_MSG( (Integer) resultMap.get("resultRowCount") +  "건이 저장되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SAVE);
        return result;
    }

}



























