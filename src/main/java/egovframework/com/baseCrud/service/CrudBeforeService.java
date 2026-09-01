package egovframework.com.baseCrud.service;

import egovframework.com.login.model.LoginVO;

import java.util.Map;

public interface CrudBeforeService {

    public int callBefore(Map<String, Object> before,
                          LoginVO loginUser,
                          String sectionId,
                          String component,
                          String pgId,
                          String menuId);
}
