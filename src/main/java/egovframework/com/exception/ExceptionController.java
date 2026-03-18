package egovframework.com.exception;

import egovframework.com.common.dto.ApiResponse;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@Order(1)
@RestControllerAdvice
public class ExceptionController {

    @ExceptionHandler(CrudFailException.class)
    public ResponseEntity<ApiResponse<Void>>  handleCrudFailException(CrudFailException ex) {

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("FAIL");
        result.setO_RESULT(-1);
        result.setO_MSG(ex.getUserMessage());
        result.setO_TYPE(ex.getApiType());

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(result);
    }

    @ExceptionHandler(ApprovalFailException.class)
    public ResponseEntity<ApiResponse<Void>> handleApprovalFailException(ApprovalFailException ex) {

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("FAIL");
        result.setO_RESULT(-1);
        result.setO_MSG(ex.getUserMessage());
        result.setO_TYPE(ex.getApiType());

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(result);

    }




}
