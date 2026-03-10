package egovframework.com.exception;

public class CrudFailException extends RuntimeException {

    public enum CrudType {
        INSERT, UPDATE, DELETE, SELECT, SAVE, CALLBEFORE, CNT, APPROVAL
    }

    private final String userMessage;
    private final CrudType crudType;  // 실패 유형

    public CrudFailException(String devMessage, String userMessage, CrudType crudType) {
        super(devMessage);
        this.userMessage = userMessage;
        this.crudType = crudType;
    }

    public String getUserMessage() {
        return userMessage;
    }

    public CrudType getCrudType() {
        return crudType;
    }


}