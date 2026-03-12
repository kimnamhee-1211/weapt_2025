package egovframework.com.common.dto;

import java.util.List;
import java.util.Map;

public class ApiResponse<T> {

    public enum ApiType {
        SELECT,
        SAVE,
        DELETE,
        INSERT,
        UPDATE,
        APPROVAL
    }

    private String O_STATUS;
    private int O_RESULT;
    private String O_MSG;
    private ApiType O_TYPE;
    private T DATA;

    public String getO_STATUS() {
        return O_STATUS;
    }

    public void setO_STATUS(String o_STATUS) {
        O_STATUS = o_STATUS;
    }

    public int getO_RESULT() {
        return O_RESULT;
    }

    public void setO_RESULT(int o_RESULT) {
        O_RESULT = o_RESULT;
    }

    public String getO_MSG() {
        return O_MSG;
    }

    public void setO_MSG(String o_MSG) {
        O_MSG = o_MSG;
    }

    public ApiType getO_TYPE() {
        return O_TYPE;
    }

    public void setO_TYPE(ApiType o_TYPE) {
        O_TYPE = o_TYPE;
    }

    public T getDATA() {
        return DATA;
    }

    public void setDATA(T DATA) {
        this.DATA = DATA;
    }
}
