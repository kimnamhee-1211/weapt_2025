package egovframework.com.common.service;

import egovframework.com.login.model.LoginVO;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

public interface MenuService {

    public List<Map<String, Object>> getNavAside(String menu_group,
                                                 LoginVO loginUser);


}
