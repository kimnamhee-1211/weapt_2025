package egovframework.com.baseCrud.service;

import egovframework.com.login.model.LoginVO;

import java.util.Map;

public interface CrudBeforeService {

    public void callBeforeIfAction(Map<String, Object> before,
                           LoginVO loginUser,
                           String sectionId,
                           String component,
                           String pgId,
                           String menuId,
                           String action);

}
