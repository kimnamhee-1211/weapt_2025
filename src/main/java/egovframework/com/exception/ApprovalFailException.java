package egovframework.com.exception;

public class ApprovalFailException extends RuntimeException {

    public enum CrudType {
        NULL_DUTY, NULL_CONFIRMID, ALREADY_APPROVAL, NO_APPROVAL, NO_AUTHORITY, NO_CANCEL_AUTHORITY, APPROVAL_FAILED, CANCEL_APPROVAL_FAILED
    }

    private final String userMessage;
    private final CrudType crudType;  // 실패 유형

    public ApprovalFailException(String devMessage, String userMessage, CrudType crudType) {
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