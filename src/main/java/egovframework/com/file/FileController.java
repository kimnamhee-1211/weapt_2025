package egovframework.com.file;

import egovframework.com.baseCrud.model.ApiResponse;
import egovframework.com.exception.FileFailException;
import egovframework.com.login.model.LoginVO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Map;

/**
 * @author 김남희
 * @version 1.0
 * @Class Name : FileController.java
 * @Description : File Controller Class
 * @Modification Information
 * @
 * @ 수정일          수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2026.06     김남희        최초생성
 * @see Copyright (C) by  All right reserved.
 * @since 2026.06
 */


@RequestMapping("/api/file")
@Controller
public class FileController {

    private static final String FILE_PATH = "F:\\web\\NEW_WEAPT\\upload";

    //사진 찾기
    @RequestMapping(value = "/selectPhoto/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity selectPhoto(@PathVariable("sectionId") String sectionId,
                                      @PathVariable("component") String component,
                                      @RequestParam Map<String, Object> param,
                                      @SessionAttribute("loginUser") LoginVO loginUser,
                                      @RequestAttribute(value = "PG_ID") String pgId,
                                      @RequestAttribute(value = "MENU_ID") String menuId) throws IOException {


        String fileSeq = param.get("FILE_SEQ").toString();
        String fileNm = param.get("FILE_NM").toString();
        String sysFileNm = param.get("SYS_FILE_NM").toString();

        if (fileSeq == null || fileSeq.trim().isEmpty()) {
            throw new FileFailException(
                    "FAIL NULL_DATA " + sectionId + "/" + pgId + "/" + component + " : \n" + param.toString(),
                    "사진조회 실패",
                    ApiResponse.ApiType.NULL_DATA);
        }

        File file  = new File(FILE_PATH, sysFileNm);

        if (!file .exists() || !file .isFile()) {
            throw new FileFailException(
                    "FAIL NULL_DATA " + sectionId + "/" + pgId + "/" + component + " : \n" + param.toString(),
                    "사진조회 실패",
                    ApiResponse.ApiType.NULL_DATA);
        }

        String contentType = Files.probeContentType(file.toPath());

        if (contentType == null) {
            contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
        }


        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .contentLength(file.length())
                .body(new FileSystemResource(file));

    }



    //파일 찾기
    @RequestMapping(value = "/selectFile/{sectionId}/{component}", produces = "application/json;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity selectFile(@PathVariable("sectionId") String sectionId,
                                     @PathVariable("component") String component,
                                     @RequestParam Map<String, Object> param,
                                     @SessionAttribute("loginUser") LoginVO loginUser,
                                     @RequestAttribute(value = "PG_ID") String pgId,
                                     @RequestAttribute(value = "MENU_ID") String menuId) throws IOException {


        String fileName = param.get("FILE_NAME").toString();

        if (fileName == null || fileName.trim().isEmpty()) {
            throw new FileFailException(
                    "FAIL NULL_DATA " + sectionId + "/" + pgId + "/" + component + " : \n" + param,
                    "사진조회 실패",
                    ApiResponse.ApiType.NULL_DATA);
        }

        File file  = new File(FILE_PATH, fileName);

        if (!file .exists() || !file .isFile()) {
            throw new FileFailException(
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
