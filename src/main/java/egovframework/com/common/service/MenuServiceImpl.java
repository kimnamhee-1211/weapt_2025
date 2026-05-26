package egovframework.com.common.service;


import egovframework.com.baseCrud.support.ServiceSupport;
import egovframework.com.common.dao.MenuMapper;
import egovframework.com.login.model.LoginVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("menuService")
@Transactional
public class MenuServiceImpl extends ServiceSupport implements MenuService {

    @Resource(name = "menuMapper")
    private MenuMapper menuMapper;

    // nav_aside list
    public List<Map<String, Object>> getNavAside(String menu_group,
                                                 LoginVO loginUser){


        Map<String, Object> param = new HashMap<String, Object>();
        param.put("MENU_GROUP", menu_group);
        setLoginParam(param, loginUser);
        String statement = "getNavAside";
        List<Map<String, Object>> menuList = menuMapper.selectList(statement, param);

        return menuList;
    };


}
