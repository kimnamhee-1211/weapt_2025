package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.model.ApiResponse;
import egovframework.com.exception.CrudFailException;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;

@Service("crudAuthService")
@Transactional
public class CrudAuthService {

    @Autowired
    private CrudAuthCacheService crudAuthCacheService;

    private static final Logger LOGGER = LoggerFactory.getLogger(crudAuthService.class);


    public Map<String, Object> getCrudPermission(String userId, String menuId) {

        Map<String, Object> data = crudAuthCacheService.getCrudAuth(userId, menuId);

        if(data == null){
            throw new CrudFailException(
                    "GRD Permission Denied : " + String.valueOf(data),
                    "권한정보가 없습니다.",
                    ApiResponse.ApiType.GRD
            );
        }
        if ( !"1".equals(data.get("FORM_USE"))) {
            throw new CrudFailException(
                    "USE Permission Denied : " + String.valueOf(data),
                    "사용 권한이 없습니다.",
                    ApiResponse.ApiType.FORM_USE
            );
        }
        return data;
    }


    public void checkCrudPermission(String userId, String menuId, String type){

        Map<String, Object> data = getCrudPermission(userId, menuId);

        checkCrudPermission(type, data);

    }

    public void checkCrudPermission(String type, Map<String, Object> data){

        LOGGER.info("CRUD AUTH {} : {}", type, data);

        if (!"1".equals(data.get(type))) {
            throw new CrudFailException(
                    type + " Permission Denied : " + String.valueOf(data),
                    getPermissionMessage(type),
                    getApiType(type)
            );
        }

    }

    private String getPermissionMessage(String type) {
        switch (type) {
            case "GRD_READ": return "조회 권한이 없습니다.";
            case "GRD_CREATE": return "추가 권한이 없습니다.";
            case "GRD_UPDATE": return "수정 권한이 없습니다.";
            case "GRD_DELETE": return "삭제 권한이 없습니다.";
            case "GRD_EXCEL": return "엑셀 권한이 없습니다.";
            default: return "권한정보가 없습니다.";
        }
    }

    private ApiResponse.ApiType getApiType(String type) {
        switch (type) {
            case "GRD_READ": return ApiResponse.ApiType.GRD_READ;
            case "GRD_CREATE": return ApiResponse.ApiType.GRD_CREATE;
            case "GRD_UPDATE": return ApiResponse.ApiType.GRD_UPDATE;
            case "GRD_DELETE": return ApiResponse.ApiType.GRD_DELETE;
            case "GRD_EXCEL": return ApiResponse.ApiType.GRD_EXCEL;
            default: return ApiResponse.ApiType.GRD;
        }
    }


}
