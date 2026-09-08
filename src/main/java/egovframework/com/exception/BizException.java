package egovframework.com.exception;

import egovframework.com.baseCrud.model.ApiResponse;

import java.util.Map;

public class BizException extends RuntimeException {
    private final String userMessage;
    private final ApiResponse.ApiType apiType;

    public BizException(String devMessage, String userMessage, ApiResponse.ApiType apiType) {
        super(devMessage);
        this.userMessage = userMessage;
        this.apiType = apiType;
    }

    public String getUserMessage() { return userMessage; }
    public ApiResponse.ApiType getApiType() { return apiType; }

}