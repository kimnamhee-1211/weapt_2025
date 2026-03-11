package egovframework.com.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class ExceptionController {

    @ExceptionHandler(CrudFailException.class)
    public ResponseEntity<Map<String, Object>> handleCrudFailException(CrudFailException ex) {

        // enum 값 가져오기
        CrudFailException.CrudType type = ex.getCrudType();

        Map<String, Object> errorResponse = new HashMap<>();

        errorResponse.put("O_STATUS", "FAIL");
        errorResponse.put("O_RESULT", -1);
        errorResponse.put("O_MSG", ex.getUserMessage());
        errorResponse.put("O_TYPE", ex.getCrudType().name());

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(errorResponse);
    }

    @ExceptionHandler(ApprovalFailException.class)
    public ResponseEntity<Map<String, Object>> handleApprovalFailException(ApprovalFailException ex) {

        // enum 값 가져오기
        ApprovalFailException.CrudType type = ex.getCrudType();

        Map<String, Object> errorResponse = new HashMap<>();

        errorResponse.put("O_MSG", ex.getUserMessage());
        errorResponse.put("O_TYPE", ex.getCrudType().name());

        if(type == ApprovalFailException.CrudType.NULL_DUTY || type == ApprovalFailException.CrudType.NULL_CONFIRMID) {
            errorResponse.put("O_STATUS", "NULL_DATA");
            errorResponse.put("O_RESULT", -1);

            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(errorResponse);

        }else if(type == ApprovalFailException.CrudType.ALREADY_APPROVAL) {
            errorResponse.put("O_STATUS", "ALREADY_APPROVAL");
            errorResponse.put("O_RESULT", -1);

            return ResponseEntity
                    .status(HttpStatus.CONFLICT)
                    .body(errorResponse);
        }else if(type == ApprovalFailException.CrudType.NO_AUTHORITY) {
            errorResponse.put("O_STATUS", "FORBIDDEN");
            errorResponse.put("O_RESULT", -1);

            return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .body(errorResponse);
        }else{
            errorResponse.put("O_STATUS", "FAIL");
            errorResponse.put("O_RESULT", -1);

            return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .body(errorResponse);
        }

    }




}
