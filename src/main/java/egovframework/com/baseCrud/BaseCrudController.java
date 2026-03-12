package egovframework.com.baseCrud;


import egovframework.com.baseCrud.service.BaseCrudService;
import egovframework.com.common.dto.ApiResponse;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

import static egovframework.com.baseCrud.support.SetParam.setUserToParam;

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
public class BaseCrudController {

    @Resource(name = "baseCrudService")
    protected BaseCrudService baseCrudService;


    //다중 검색
    @RequestMapping(value = "/selectList/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ApiResponse<List<Map<String, Object>>> selectList(@PathVariable("sectionId") String sectionId,
                                                             @PathVariable("component") String component,
                                                             @RequestParam Map<String, Object> param,
                                                             @SessionAttribute("loginUser") LoginVO loginUser,
                                                             @RequestAttribute(value = "PG_ID") String pgId,
                                                             @RequestAttribute(value = "MENU_ID") String menuId) {

        List<Map<String, Object>> resultList = baseCrudService.selectList(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<List<Map<String, Object>>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultList.size());
        result.setO_MSG(resultList.size() + "건이 조회되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SELECT);
        result.setDATA(resultList);
        return result;
    }

    //map 검색
    @RequestMapping(value = "/selectMap/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ApiResponse<Map<String, Object>> selectMap(@PathVariable("sectionId") String sectionId,
                                                      @PathVariable("component") String component,
                                                      @RequestParam Map<String, Object> param,
                                                      @RequestParam String mapKey,
                                                      @SessionAttribute("loginUser") LoginVO loginUser,
                                                      @RequestAttribute(value = "PG_ID") String pgId,
                                                      @RequestAttribute(value = "MENU_ID") String menuId) {

        Map<String, Object> resultMap = baseCrudService.selectMap(sectionId, component, param, mapKey, loginUser, pgId, menuId);

        ApiResponse<Map<String, Object>> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultMap.size());
        result.setO_MSG(resultMap.size() + "건이 조회되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SELECT);
        result.setDATA(resultMap);
        return result;
    }


    //다중 저장
    @RequestMapping(value = "/insertList/{sectionId}/{component}", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Void> insertList(@PathVariable("sectionId") String sectionId,
                                        @PathVariable("component") String component,
                                        @RequestBody List<Map<String, Object>> param,
                                        @SessionAttribute("loginUser") LoginVO loginUser,
                                        @RequestAttribute(value = "PG_ID") String pgId,
                                        @RequestAttribute(value = "MENU_ID") String menuId) {

        int resultRowCount = baseCrudService.insertList(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultRowCount);
        result.setO_MSG(resultRowCount + "건이 저장되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.INSERT);
        return result;
    }


    //단일 저장
    @RequestMapping(value = "/insertOne/{sectionId}/{component}", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Void> insertList(@PathVariable("sectionId") String sectionId,
                                        @PathVariable("component") String component,
                                        @RequestBody Map<String, Object> param,
                                        @SessionAttribute("loginUser") LoginVO loginUser,
                                        @RequestAttribute(value = "PG_ID") String pgId,
                                        @RequestAttribute(value = "MENU_ID") String menuId) {

        int resultRowCount = baseCrudService.insertOne(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultRowCount);
        result.setO_MSG(resultRowCount + "건이 저장되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.INSERT);
        return result;
    }


    //다중 수정
    @RequestMapping(value = "/updateList/{sectionId}/{component}", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Void> updateList(@PathVariable("sectionId") String sectionId,
                                        @PathVariable("component") String component,
                                        @RequestBody List<Map<String, Object>> param,
                                        @SessionAttribute("loginUser") LoginVO loginUser,
                                        @RequestAttribute(value = "PG_ID") String pgId,
                                        @RequestAttribute(value = "MENU_ID") String menuId) {

        int resultRowCount = baseCrudService.updateList(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultRowCount);
        result.setO_MSG(resultRowCount + "건이 저장되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.UPDATE);
        return result;
    }


    //단일 수정
    @RequestMapping(value = "/updateOne/{sectionId}/{component}", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Void> updateOne(@PathVariable("sectionId") String sectionId,
                                       @PathVariable("component") String component,
                                       @RequestBody Map<String, Object> param,
                                       @SessionAttribute("loginUser") LoginVO loginUser,
                                       @RequestAttribute(value = "PG_ID") String pgId,
                                       @RequestAttribute(value = "MENU_ID") String menuId) {

        int resultRowCount = baseCrudService.updateOne(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultRowCount);
        result.setO_MSG(resultRowCount + "건이 저장되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.UPDATE);
        return result;
    }

    //다중 삭제
    @RequestMapping(value = "/deleteList/{sectionId}/{component}", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Void> deleteList(@PathVariable("sectionId") String sectionId,
                                        @PathVariable("component") String component,
                                        @RequestBody Map<String, Object> param,
                                        @SessionAttribute("loginUser") LoginVO loginUser,
                                        @RequestAttribute(value = "PG_ID") String pgId,
                                        @RequestAttribute(value = "MENU_ID") String menuId) {

        int resultRowCount = baseCrudService.deleteList(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultRowCount);
        result.setO_MSG(resultRowCount + "건이 삭제되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.DELETE);
        return result;
    }


    //단일 삭제
    @RequestMapping(value = "/deleteOne/{sectionId}/{component}", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Void> deleteOne(@PathVariable("sectionId") String sectionId,
                                       @PathVariable("component") String component,
                                       @RequestBody Map<String, Object> param,
                                       @SessionAttribute("loginUser") LoginVO loginUser,
                                       @RequestAttribute(value = "PG_ID") String pgId,
                                       @RequestAttribute(value = "MENU_ID") String menuId) {

        int resultRowCount = baseCrudService.deleteOne(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultRowCount);
        result.setO_MSG(resultRowCount + "건이 삭제되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.DELETE);
        return result;
    }


    //다중 저장 + 수정
    @RequestMapping(value = "/saveList/{sectionId}/{component}", method = RequestMethod.POST)
    @ResponseBody
    public ApiResponse<Void> saveList(@PathVariable("sectionId") String sectionId,
                                      @PathVariable("component") String component,
                                      @RequestBody Map<String, Object> param,
                                      @SessionAttribute("loginUser") LoginVO loginUser,
                                      @RequestAttribute(value = "PG_ID") String pgId,
                                      @RequestAttribute(value = "MENU_ID") String menuId) {

        int resultRowCount = baseCrudService.saveList(sectionId, component, param, loginUser, pgId, menuId);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("SUCCESS");
        result.setO_RESULT(resultRowCount);
        result.setO_MSG(resultRowCount + "건이 저장되었습니다.");
        result.setO_TYPE(ApiResponse.ApiType.SAVE);
        return result;
    }


    //공통코드 검색
    @RequestMapping(value = "/getCode/{CODEDV_NO}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getCode(@PathVariable("CODEDV_NO") String CODEDV_NO) {

        List<Map<String, Object>> result = baseCrudService.getCode(CODEDV_NO);

        return result;
    }


    // selectOption 검색
    @RequestMapping(value = "/getSelectOption/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getSelectOption(@PathVariable("sectionId") String sectionId,
                                                                  @PathVariable("component") String component,
                                                                  @RequestParam Map<String, Object> param,
                                                                  @SessionAttribute("loginUser") LoginVO loginUser) {

        List<Map<String, Object>> result = baseCrudService.getSelectOption(sectionId, component, param, loginUser);

        return result;
    }


    @RequestMapping(value = "/getUsergroupId", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getUsergroupId() {

        List<Map<String, Object>> result = baseCrudService.getUsergroupId();

        return result;
    }

}



























