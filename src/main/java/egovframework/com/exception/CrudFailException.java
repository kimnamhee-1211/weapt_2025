package egovframework.com.exception;

import egovframework.com.baseCrud.model.ApiResponse;

public class CrudFailException extends RuntimeException {

    private final String userMessage;
    private final ApiResponse.ApiType apiType;

    private CrudFailException(String devMessage, String userMessage, ApiResponse.ApiType apiType) {
        super(devMessage);
        this.userMessage = userMessage;
        this.apiType = apiType;
    }

    public String getUserMessage() { return userMessage; }
    public ApiResponse.ApiType getApiType() { return apiType; }

     public static CrudFailException insertFail(String sectionId, String pgId, String component,
                                               Object param, int rowCount) {
        return of("INSERT", "저장", ApiResponse.ApiType.INSERT, sectionId, pgId, component, param, rowCount);
    }

    public static CrudFailException updateFail(String sectionId, String pgId, String component,
                                               Object param, int rowCount) {
        return of("UPDATE", "저장", ApiResponse.ApiType.UPDATE, sectionId, pgId, component, param, rowCount);
    }

    public static CrudFailException deleteFail(String sectionId, String pgId, String component,
                                               Object param, int rowCount) {
        return of("DELETE", "삭제", ApiResponse.ApiType.DELETE, sectionId, pgId, component, param, rowCount);
    }

    public static CrudFailException callBeforeFail(String sectionId, String pgId, String component,
                                               Object param, int rowCount) {
        return of("CALLBEFOR", "callBefore", ApiResponse.ApiType.CALLBEFORE, sectionId, pgId, component, param, rowCount);
    }

    public static CrudFailException cntFail(String sectionId, String pgId, String component,
                                                   Object param, int rowCount) {
        return of("CNT", "조회수 증가", ApiResponse.ApiType.CNT, sectionId, pgId, component, param, rowCount);
    }


    private static CrudFailException of(String action, String verb, ApiResponse.ApiType type,
                                        String sectionId, String pgId, String component,
                                        Object param, int rowCount) {
        return new CrudFailException(
                "FAIL " + action + " " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                verb + " 실패 : " + rowCount + "건",
                type);
    }


}