package egovframework.com.baseCrud.service;

import egovframework.com.baseCrud.dao.BaseCrudMapper;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Service("crudAuthCacheService")
@Transactional(readOnly = true)
public class CrudAuthCacheService {

    @Resource(name = "baseCrudMapper")
    private BaseCrudMapper baseCrudMapper;

    @Cacheable(
            cacheNames = "crudAuth",
            key = "#userId + ':' + #menuId",
            unless = "#result == null"
    )
    public  Map<String, Object> getCrudAuth(String userId,
                                           String menuId){

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("LOGIN_ID", userId);
        param.put("MENU_ID", menuId);
        String statement = "authMapper.getCrudAuth";
        Map<String, Object> result = baseCrudMapper.selectOne(statement, param);

        return result;
    };

    @CacheEvict(
            cacheNames = "crudAuth",
            allEntries = true
    )
    public void clearCrudAuthCache() {
    }
}
