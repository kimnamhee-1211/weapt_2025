package egovframework.com.cmmn.service;

import java.util.List;
import java.util.Map;


public interface CommonService {

	/**
	 * 공통 사용 조회 단건
	 */
	int selectComOneInt(Map requestMap, String daoNm, String sqlNm) throws Exception;

	/**
	 * 공통 사용 조회 단건
	 */
	String selectComOneString(Map requestMap, String daoNm, String sqlNm) throws Exception;

	/**
	 * 공통 사용 조회 리스트
	 */
	List<?> selectComList(Map requestMap, String daoNm, String sqlNm) throws Exception;

	/**
	 * 공통 저장 리스트
	 */
	void saveComList(List<Map> requestList, String daoNm, String sqlNm) throws Exception;

	/**
	 * 공통 저장 단건
	 */
	void saveComOne(Map requestMap, String daoNm, String sqlNm) throws Exception;

	/**
	 * 공통 저장 단건
	 */
	void saveComOneCUD(Map requestMap, String tbNm, String updateGbnNm, String alias) throws Exception;

	/**
	 * 테이블 복사
	 */
	void copyTableData(Map requestMap) throws Exception;

}
