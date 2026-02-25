package egovframework.com.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class ExceptionController {

    @ExceptionHandler(BaseCrudFailException.class)
    public ResponseEntity<Map<String, Object>> handleBaseCrudFailException(BaseCrudFailException ex) {

        // enum 값 가져오기
        BaseCrudFailException.CrudType type = ex.getCrudType();

        Map<String, Object> errorResponse = new HashMap<>();

        errorResponse.put("O_STATUS", "FAIL");
        errorResponse.put("O_RESULT", -1);
        errorResponse.put("O_MSG", ex.getUserMessage());
        errorResponse.put("O_TYPE", ex.getCrudType().name());

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(errorResponse);
    }

}
