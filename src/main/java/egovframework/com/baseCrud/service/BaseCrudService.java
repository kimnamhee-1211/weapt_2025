package egovframework.com.baseCrud.service;

import egovframework.com.login.model.LoginVO;

import java.util.List;
import java.util.Map;

public interface BaseCrudService {
	
	public List<Map<String, Object>> selectList(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

	public Map<String, Object> selectMap(String sectionId, String component,  Map<String, Object> param, String mapKey, LoginVO loginUser, String pgId, String menuId);

	public int insertList(String sectionId, String component, List<Map<String, Object>> param, LoginVO loginUser, String pgId, String menuId);

	public int insertOne(String sectionId, String component,  Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

	public int updateList(String sectionId, String component, List<Map<String, Object>> param, LoginVO loginUser, String pgId, String menuId);

	public int updateOne(String sectionId, String component,  Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

	public Map<String, Object> deleteList(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

	public int deleteOne(String sectionId, String component,  Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);
	
	public Map<String, Object> saveList(String sectionId, String component, Map<String, Object> param, LoginVO loginUser, String pgId, String menuId);

	public int callBefore(Map<String, Object> before, LoginVO loginUser, String sectionId, String component, String pgId, String menuId);

	public List<Map<String, Object>> getKeyToParam(List<Map<String, Object>> insertParam, Object rawKey, String mapper, String component, LoginVO loginUser);

	public List<Map<String, Object>> getCode(String CODEDV_NO);

	public List<Map<String, Object>> getSelectOption(String sectionId, String component, Map<String, Object> param, LoginVO loginUser);

	public List<Map<String, Object>> getUsergroupId();

}
