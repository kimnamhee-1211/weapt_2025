package egovframework.com.exception;

import egovframework.com.baseCrud.model.ApiResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;


@Order(Ordered.HIGHEST_PRECEDENCE)
@RestControllerAdvice
public class ExceptionController {

    private static final Logger LOGGER = LoggerFactory.getLogger(ExceptionController.class);


    @ExceptionHandler(CrudFailException.class)
    public ResponseEntity<ApiResponse<Void>>  handleCrudFailException(CrudFailException ex) {

        LOGGER.error("CRUD FAIL : {}", ex.getMessage(), ex);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("FAIL");
        result.setO_RESULT(-1);
        result.setO_MSG(ex.getUserMessage());
        result.setO_TYPE(ex.getApiType());

        return ResponseEntity
                .status(HttpStatus.OK)
                .contentType(MediaType.APPLICATION_JSON)
                .body(result);
    }

    @ExceptionHandler(ApprovalAuthException.class)
    public ResponseEntity<ApiResponse<Void>> handleApprovalAuthException(ApprovalAuthException ex) {

        LOGGER.error("CRUD FAIL : {}", ex.getMessage(), ex);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("FAIL");
        result.setO_RESULT(-1);
        result.setO_MSG(ex.getUserMessage());
        result.setO_TYPE(ex.getApiType());

        return ResponseEntity
                .status(HttpStatus.OK)
                .contentType(MediaType.APPLICATION_JSON)
                .body(result);
    }

    @ExceptionHandler(ApprovalFailException.class)
    public ResponseEntity<ApiResponse<Void>> handleApprovalFailException(ApprovalFailException ex) {

        LOGGER.error("CRUD FAIL : {}", ex.getMessage(), ex);

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("FAIL");
        result.setO_RESULT(-1);
        result.setO_MSG(ex.getUserMessage());
        result.setO_TYPE(ex.getApiType());

        return ResponseEntity
                .status(HttpStatus.OK)
                .contentType(MediaType.APPLICATION_JSON)
                .body(result);

    }


    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiResponse<Void>> handleException(Exception ex) {

        ApiResponse<Void> result = new ApiResponse<>();
        result.setO_STATUS("FAIL");
        result.setO_RESULT(-1);
        result.setO_MSG("처리 중 오류가 발생하였습니다.");

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .contentType(MediaType.APPLICATION_JSON)
                .body(result);
    }





}
