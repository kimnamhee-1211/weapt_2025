package egovframework.com.baseCrud.service;


import egovframework.com.exception.CrudAuthFailException;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



@Service("crudAuthService")
@Transactional(readOnly = true)
public class CrudAuthService {

    @Autowired
    private CrudAuthCacheService crudAuthCacheService;

    private static final Logger LOGGER = LoggerFactory.getLogger(CrudAuthService.class);


    public Map<String, Object> getCrudPermission(String userId, String menuId) {

        Map<String, Object> data = crudAuthCacheService.getCrudAuth(userId, menuId);

        if (data == null) {
            throw CrudAuthFailException.noData(userId, menuId);
        }
        if (!"1".equals(data.get(CrudAuthFailException.FORM_USE))) {
            throw CrudAuthFailException.denied(CrudAuthFailException.FORM_USE, data);
        }
        return data;
    }


    public void checkCrudPermission(String type, String userId, String menuId) {

        Map<String, Object> data = getCrudPermission(userId, menuId);

        checkCrudPermission(type, data);

    }

    public void checkCrudPermission(String type, Map<String, Object> data) {

        LOGGER.info("CRUD AUTH {} : {}", type, data);

        if (!"1".equals(data.get(type))) {
            throw CrudAuthFailException.denied(type, data);
        }

    }

}

