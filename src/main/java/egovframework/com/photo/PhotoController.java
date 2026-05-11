package egovframework.com.photo;

import egovframework.com.common.model.ApiResponse;
import egovframework.com.exception.PhotoFailException;
import egovframework.com.login.model.LoginVO;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Map;

@RequestMapping("/api")
@Controller
public class PhotoController {

    private static final String PHOTO_PATH = "F:\\web\\NEW_WEAPT\\upload";

    //다중 검색
    @RequestMapping(value = "/selectPhoto/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity selectList(@PathVariable("sectionId") String sectionId,
                                                             @PathVariable("component") String component,
                                                             @RequestParam Map<String, Object> param,
                                                             @SessionAttribute("loginUser") LoginVO loginUser,
                                                             @RequestAttribute(value = "PG_ID") String pgId,
                                                             @RequestAttribute(value = "MENU_ID") String menuId) throws IOException {


        String fileName = param.get("FILE_NAME").toString();

        if (fileName == null || fileName.trim().isEmpty()) {
            throw new PhotoFailException(
                    "FAIL NULL_DATA " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                    "사진조회 실패",
                    ApiResponse.ApiType.NULL_DATA);
        }

        File file  = new File(PHOTO_PATH, fileName);

        if (!file .exists() || !file .isFile()) {
            throw new PhotoFailException(
                    "FAIL NULL_DATA " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                    "사진조회 실패",
                    ApiResponse.ApiType.NULL_DATA);

        }

        String contentType = Files.probeContentType(file.toPath());
        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_TYPE, contentType);
        headers.add(HttpHeaders.CACHE_CONTROL, "max-age=86400");

        return ResponseEntity
                .ok()
                .headers(headers)
                .body(resource);

    }




}
