package egovframework.com.exception;

public class BaseCrudFailException extends RuntimeException {

    public enum CrudType {
        INSERT, UPDATE, DELETE, SELECT, SAVE, CALLBEFORE, CNT
    }

    private final String userMessage;
    private final CrudType crudType;  // 실패 유형

    public BaseCrudFailException(String devMessage, String userMessage, CrudType crudType) {
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