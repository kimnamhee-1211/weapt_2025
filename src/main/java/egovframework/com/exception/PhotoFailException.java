package egovframework.com.exception;

import egovframework.com.common.model.ApiResponse;

public class PhotoFailException extends RuntimeException {

    private final String userMessage;
    private ApiResponse.ApiType apiType;

    public PhotoFailException(String devMessage, String userMessage, ApiResponse.ApiType apiType) {
        super(devMessage);
        this.userMessage = userMessage;
        this.apiType = apiType;
    }

    public String getUserMessage() {
        return userMessage;
    }

    public ApiResponse.ApiType getApiType() {return apiType;}


}