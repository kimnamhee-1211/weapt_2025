package egovframework.com.baseCrud.dao;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;


@Repository("baseCrudMapper")
public class BaseCrudMapper extends EgovAbstractMapper{

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

	//다중 저장
	public int insertList(String statement, List<Map<String, Object>> param){
		int result = super.insert(statement, param);
		return result;
	}

	//단일 저장
	public int insertOne(String statement, Map<String, Object> param){

		int result = super.insert(statement, param);
		return result;
	}

	//다중 수정
	public int updateList(String statement, List<Map<String, Object>> param){

		int result = super.update(statement, param);
		return result;
	}

	//단일 수정
	public int updateOne(String statement, Map<String, Object> param){

		int result = super.update(statement, param);
		return result;
	}

	//다중 삭제
	public int deleteList(String statement, List<Map<String, Object>> param){

		int result = super.delete(statement, param);
		return result;
	}

	//단일 삭제
	public int deleteOne(String statement, Map<String, Object> param){

		int result = super.delete(statement, param);
		return result;
	}

	//공통코드 검색
	public List<Map<String, Object>> getCode(String CODEDV_NO){

		List<Map<String, Object>> result = super.selectList("sojangMapper.getCode", CODEDV_NO);
		return result;
	}

	//selectOption 검색
	public List<Map<String, Object>> getSelectOption(String statement, Map<String, Object> param){
		List<Map<String, Object>> result = super.selectList(statement, param);
		return result;
	}

	//공통코드 검색
	public List<Map<String, Object>> getUsergroupId(){

		List<Map<String, Object>> result = super.selectList("sojangMapper.getUsergroupId");
		return result;
	}

}
