package egovframework.com.exception;

import egovframework.com.common.dto.ApiResponse;

public class CrudFailException extends RuntimeException {

    private final String userMessage;
    private ApiResponse.ApiType apiType;

    public CrudFailException(String devMessage, String userMessage, ApiResponse.ApiType apiType) {
        super(devMessage);
        this.userMessage = userMessage;
        this.apiType = apiType;
    }

    public String getUserMessage() {
        return userMessage;
    }

    public ApiResponse.ApiType getApiType() {return apiType;}


}