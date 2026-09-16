package egovframework.com.section;


import egovframework.com.baseCrud.model.ApiResponse;
import egovframework.com.baseCrud.service.BaseCrudService;
import egovframework.com.login.model.LoginVO;
import egovframework.com.section.service.JangsooService;
import org.springframework.beans.factory.annotation.Autowired;
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


    //다중 검색
    @RequestMapping(value = "/selectList/jangsoo/soo02010_grid2", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ApiResponse<List<Map<String, Object>>> selectList(@RequestParam Map<String, Object> param,
                                                             @SessionAttribute("loginUser") LoginVO loginUser,
                                                             @RequestAttribute(value = "PG_ID") String pgId,
                                                             @RequestAttribute(value = "MENU_ID") String menuId) {

        List<Map<String, Object>> resultList = jangsooService.selectList("jangsoo", "soo02010_grid2", param, loginUser, pgId, menuId);

        ApiResponse<List<Map<String, Object>>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultList.size());
        result.setO_MSG(resultList.size() + "건이 조회되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SELECT);
        result.setDATA(resultList);
        return result;
    }

    @RequestMapping(value = "/updateOne/jangsoo/soo02010_change", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Map<String, Object>> change_planMonth( @RequestBody Map<String, Object> param,
                                      @SessionAttribute("loginUser") LoginVO loginUser,
                                      @RequestAttribute(value = "PG_ID") String pgId,
                                      @RequestAttribute(value = "MENU_ID") String menuId) {

        Map<String, Object> resultMap = jangsooService.change_planMonth("jangsoo", "soo02010_change", param, loginUser, pgId, menuId);

        ApiResponse<Map<String, Object>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT((Integer) resultMap.get("resultRowCount"));
        result.setO_MSG( "조정년월이 변경되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SAVE);
        return result;
    }

    @RequestMapping(value = "/insertOne/jangsoo/soo02010_copy", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Map<String, Object>> copy_planMonth(@RequestBody Map<String, Object> param,
                                                           @SessionAttribute("loginUser") LoginVO loginUser,
                                                           @RequestAttribute(value = "PG_ID") String pgId,
                                                           @RequestAttribute(value = "MENU_ID") String menuId) {

        Map<String, Object> resultMap = jangsooService.copy_planMonth("jangsoo", "soo02010_copy", param, loginUser, pgId, menuId);

        ApiResponse<Map<String, Object>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT((Integer) resultMap.get("resultRowCount"));
        result.setO_MSG( "수립조정기준이 복사되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SAVE);
        return result;
    }

    @RequestMapping(value = "/selectList/jangsoo/soo02010_pop3Grid1", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ApiResponse<List<Map<String, Object>>> selectList_pop3Grid1(@RequestParam Map<String, Object> param,
                                                             @SessionAttribute("loginUser") LoginVO loginUser,
                                                             @RequestAttribute(value = "PG_ID") String pgId,
                                                             @RequestAttribute(value = "MENU_ID") String menuId) {

        List<Map<String, Object>> resultList = jangsooService.selectList_pop3Grid1("jangsoo", "soo02010_pop3Grid1", param, loginUser, pgId, menuId);

        ApiResponse<List<Map<String, Object>>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultList.size());
        result.setO_MSG(resultList.size() + "건이 조회되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SELECT);
        result.setDATA(resultList);
        return result;
    }

    @RequestMapping(value = "/insertList/jangsoo/soo02010_add", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Map<String, Object>> add_repairCode(@RequestBody List<Map<String, Object>> param,
                                                           @SessionAttribute("loginUser") LoginVO loginUser,
                                                           @RequestAttribute(value = "PG_ID") String pgId,
                                                           @RequestAttribute(value = "MENU_ID") String menuId) {


        Map<String, Object> resultMap = jangsooService.add_repairCode("jangsoo", "soo02010_add", param, loginUser, pgId, menuId);

        ApiResponse<Map<String, Object>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT((Integer) resultMap.get("resultRowCount"));
        result.setO_MSG( (Integer) resultMap.get("resultRowCount") +  "건이 저장되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SAVE);
        return result;
    }

    @RequestMapping(value = "/deleteOne/jangsoo/soo02010_grid1", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Map<String, Object>> delete_plan(@RequestBody Map<String, Object> param,
                                                           @SessionAttribute("loginUser") LoginVO loginUser,
                                                           @RequestAttribute(value = "PG_ID") String pgId,
                                                           @RequestAttribute(value = "MENU_ID") String menuId) {

        Map<String, Object> resultMap = jangsooService.delete_plan("jangsoo", "soo02010_grid1", param, loginUser, pgId, menuId);

        ApiResponse<Map<String, Object>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT((Integer) resultMap.get("resultRowCount"));
        result.setO_MSG( (Integer) resultMap.get("resultRowCount") +  "건이 삭제되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SAVE);
        return result;
    }


}



























