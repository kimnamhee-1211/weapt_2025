package egovframework.com.baseCrud.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ApiResponse<T> {

    public enum ApiType {
        SELECT,
        SAVE,
        DELETE,
        INSERT,
        UPDATE,
        CALLBEFORE,
        CNT,
        APPROVAL,
        NULL_DATA,

    }

    private String O_STATUS;
    private int O_RESULT;
    private String O_MSG;
    private ApiType O_TYPE;
    private T DATA;

    @JsonProperty("O_STATUS")
    public String getO_STATUS() {
        return O_STATUS;
    }

    public void setO_STATUS(String O_STATUS) {
        this.O_STATUS = O_STATUS;
    }

    @JsonProperty("O_RESULT")
    public int getO_RESULT() {
        return O_RESULT;
    }

    public void setO_RESULT(int O_RESULT) {
        this.O_RESULT = O_RESULT;
    }

    @JsonProperty("O_MSG")
    public String getO_MSG() {
        return O_MSG;
    }

    public void setO_MSG(String O_MSG) {
        this.O_MSG = O_MSG;
    }

    @JsonProperty("O_TYPE")
    public ApiType getO_TYPE() {
        return O_TYPE;
    }

    public void setO_TYPE(ApiType O_TYPE) {
        this.O_TYPE = O_TYPE;
    }

    @JsonProperty("DATA")
    public T getDATA() {return DATA;}

    public void setDATA(T DATA) {
        this.DATA = DATA;
    }
}
