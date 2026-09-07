package egovframework.com.exception;

import egovframework.com.baseCrud.model.ApiResponse;

import java.util.Map;

public class CrudAuthFailException extends RuntimeException {
    private final String userMessage;
    private final ApiResponse.ApiType apiType;

    public static final String DATA_NOT_FOUND = "DATA_NOT_FOUND";
    public static final String FORM_USE = "FORM_USE";
    public static final String GRD_READ = "GRD_READ";
    public static final String GRD_CREATE = "GRD_CREATE";
    public static final String GRD_UPDATE = "GRD_UPDATE";
    public static final String GRD_DELETE = "GRD_DELETE";
    public static final String GRD_EXCEL = "GRD_EXCEL";

    private CrudAuthFailException(String devMessage, String userMessage, ApiResponse.ApiType apiType) {
        super(devMessage);
        this.userMessage = userMessage;
        this.apiType = apiType;
    }

    public String getUserMessage() { return userMessage; }
    public ApiResponse.ApiType getApiType() { return apiType; }

    public static CrudAuthFailException noData(String userId, String menuId) {
        return new CrudAuthFailException(
                DATA_NOT_FOUND + " : " + userId + "/" + menuId,
                getPermissionMessage(DATA_NOT_FOUND),
                getApiType(DATA_NOT_FOUND));
    }

    public static CrudAuthFailException denied(String type, Map<String, Object> data) {
        return new CrudAuthFailException(
                type + " DENIED : " + data.toString(),
                getPermissionMessage(type),
                getApiType(type));
    }


    private static String getPermissionMessage(String type) {
        switch (type) {
            case DATA_NOT_FOUND: return "권한정보가 없습니다.";
            case FORM_USE: return "사용 권한이 없습니다.";
            case GRD_READ: return "조회 권한이 없습니다.";
            case GRD_CREATE: return "추가 권한이 없습니다.";
            case GRD_UPDATE: return "수정 권한이 없습니다.";
            case GRD_DELETE: return "삭제 권한이 없습니다.";
            case GRD_EXCEL: return "엑셀 권한이 없습니다.";
            default: return "권한정보가 없습니다.";
        }
    }

    private static ApiResponse.ApiType getApiType(String type) {
        switch (type) {
            case DATA_NOT_FOUND: return ApiResponse.ApiType.GRD;
            case FORM_USE: return ApiResponse.ApiType.FORM_USE;
            case GRD_READ: return ApiResponse.ApiType.GRD_READ;
            case GRD_CREATE: return ApiResponse.ApiType.GRD_CREATE;
            case GRD_UPDATE: return ApiResponse.ApiType.GRD_UPDATE;
            case GRD_DELETE: return ApiResponse.ApiType.GRD_DELETE;
            case GRD_EXCEL: return ApiResponse.ApiType.GRD_EXCEL;
            default: return ApiResponse.ApiType.GRD;
        }
    }


}