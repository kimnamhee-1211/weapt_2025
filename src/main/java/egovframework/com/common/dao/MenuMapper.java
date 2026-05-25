package egovframework.com.common.dao;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository("menuMapper")
public class MenuMapper extends EgovAbstractMapper{

	//다중 검색
	public List<Map<String, Object>> selectList(String statement, Map<String, Object> param){
		List<Map<String, Object>> result = super.selectList(statement, param);
		return result;
	}

	//map 검색
	public Map<String, Object> selectMap(String statement, Map<String, Object> param, String mapKey){
		
		Map<String, Object> result = super.selectMap(statement, param, mapKey);
		return result;
	}

	//단일 검색
	public Map<String, Object> selectOne(String statement, Map<String, Object> param){

		Map<String, Object> result = super.selectOne(statement, param);
		return result;
	}


}
