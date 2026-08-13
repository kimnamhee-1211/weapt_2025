package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.support.ServiceSupport;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Service("crudAuthService")
@Transactional
public class CrudAuthServiceImpl extends ServiceSupport implements CrudAuthService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;


    public Map<String, Object> getCrudAuth(String userid,
                                           String menuId){


        Map<String, Object> param = new HashMap<String, Object>();
        param.put("LOGIN_ID", userid);
        param.put("MENU_ID", menuId);
        String statement = "authMapper.getCrudAuth";
        Map<String, Object> result = baseCrudMapper.selectOne(statement, param);

        return result;
    };


}