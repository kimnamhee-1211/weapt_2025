package egovframework.com.common.service;


import egovframework.com.baseCrud.dao.BaseCrudMapper;
import egovframework.com.baseCrud.support.ServiceSupport;

import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("menuService")
@Transactional
public class MenuServiceImpl extends ServiceSupport implements MenuService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    // nav_aside list
    public List<Map<String, Object>> getNavAside(String menu_group,
                                                 LoginVO loginUser){


        Map<String, Object> param = new HashMap<String, Object>();
        param.put("MENU_GROUP", menu_group);
        setUserToParam(loginUser, param);
        String statement = "getNavAside";
        List<Map<String, Object>> menuList = baseCrudMapper.selectList(statement, param);

        return menuList;
    };


}
