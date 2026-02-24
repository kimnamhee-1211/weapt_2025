/**
 *
 */
package egovframework.com.cmmn.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
/**
 * EgovComAbstractDAO.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 23.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 23.   서준식        최초 생성
 *   2016. 5. 11.   장동한        myBatis 방식 적용
 * </pre>
 */
@Repository("commonDAO")
public class CommonDAO extends EgovAbstractMapper{
	
	private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
	
	/**
	 * pk조회
	 */
	public List<?> commonSchemaTbPk(Map requestMap) throws Exception {
		return selectList("commonDAO.commonSchemaTbPk", requestMap);
	}

	/**
	 * col조회
	 */
	public List<?> commonSchemaTbCol(Map requestMap) throws Exception {
		return selectList("commonDAO.commonSchemaTbCol", requestMap);
	}

	/**
	 * 공통조회
	 */
	public int selectComOneInt(Map requestMap, String daoNm, String sqlNm) throws Exception {
		return selectMap(daoNm+"."+sqlNm, requestMap);
	}

	/**
	 * 공통조회
	 */
	public String selectComOneString(Map requestMap, String daoNm, String sqlNm) throws Exception {
		return selectMap(daoNm+"."+sqlNm, requestMap);
	}

	/**
	 * 공통조회
	 */
	public List<?> selectComList(Map requestMap, String daoNm, String sqlNm) throws Exception {
		return selectList(daoNm+"."+sqlNm, requestMap);
	}
	/**
	 * 공통update
	 */
	public void updateCommonList(Map requestMap, String daoNm, String sqlNm) throws Exception {
		update(daoNm+"."+sqlNm, requestMap);
	}
	/**
	 * 공통insert
	 */
	public void insertCommonList(Map requestMap, String daoNm, String sqlNm) throws Exception {
		insert(daoNm+"."+sqlNm, requestMap);
	}
	/**
	 * 공통delete
	 */
	public void deleteCommonList(Map requestMap, String daoNm, String sqlNm) throws Exception {
		delete(daoNm+"."+sqlNm, requestMap);
	}
	/**
	 * 공통 단건 저장
	 */
	public void saveComOne(Map requestMap, String daoNm, String sqlNm) throws Exception {
		update(daoNm+"."+sqlNm, requestMap);
	}

	/**
	 * 테이블 정보 조회
	 */
	public List<?> commonTableInfo(Map requestMap) throws Exception {
		return selectList("commonDAO.commonTableInfo", requestMap);
	}

	/**
	 * 테이블 데이터 복사
	 */
	public void commonExecSql(Map requestMap) throws Exception {
		selectList("commonDAO.commonExecSql", requestMap);
	}

	/**
	 * 테이블 데이터 복사
	 */
	public List<?> commonExecSqlList(Map requestMap) throws Exception {
		return selectList("commonDAO.commonExecSqlList", requestMap);
	}
}
