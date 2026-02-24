/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.com.cmmn.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmmn.dao.CommonDAO;
import egovframework.com.util.Util;

/**
 * @Class Name : EgovSampleServiceImpl.java
 * @Description : Sample Business Implement Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Service("commonService")
public class CommonServiceImpl extends EgovAbstractServiceImpl implements CommonService {

	private static final Logger LOGGER = LoggerFactory.getLogger(CommonServiceImpl.class);

	/** SampleDAO */
	// TODO ibatis 사용
	//@Resource(name = "sampleDAO")
	//private SampleDAO sampleDAO;
	// TODO mybatis 사용
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;

	@Override
	public int selectComOneInt(Map requestMap, String daoNm, String sqlNm) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.selectComOneInt(requestMap, daoNm, sqlNm);
	}

	@Override
	public String selectComOneString(Map requestMap, String daoNm, String sqlNm) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.selectComOneString(requestMap, daoNm, sqlNm);
	}

	@Override
	public List<?> selectComList(Map requestMap, String daoNm, String sqlNm) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.selectComList(requestMap, daoNm, sqlNm);
	}

	@Override
	public void saveComList(List<Map> requestList, String daoNm, String sqlNm) throws Exception {
		System.out.println("공통저장 in!!");
		for( int i=0; i<requestList.size(); i++) {

			if( "update".equals(requestList.get(i).get("updateGbn"))) {
				System.out.println("공통저장 update >> "+requestList.get(i));
				commonDAO.updateCommonList(requestList.get(i), daoNm, "update"+sqlNm);
			}else if( "insert".equals(requestList.get(i).get("updateGbn"))) {
				System.out.println("공통저장 insert >> "+requestList.get(i));
				commonDAO.insertCommonList(requestList.get(i), daoNm, "insert"+sqlNm);
			}else if( "delete".equals(requestList.get(i).get("updateGbn"))) {
				System.out.println("공통저장 delete >> "+requestList.get(i));
				commonDAO.deleteCommonList(requestList.get(i), daoNm, "delete"+sqlNm);
			}
		}
		// TODO Auto-generated method stub
	}

	@Override
	public void saveComOne(Map requestMap, String daoNm, String sqlNm) throws Exception {

		commonDAO.saveComOne(requestMap, daoNm, sqlNm);
		// TODO Auto-generated method stub
	}

	@Override
	public void copyTableData(Map requestMap) throws Exception {
		// TODO Auto-generated method stub
		List<?> comDataList = commonDAO.commonTableInfo(requestMap);

		String cols = "";
		for( int i=0; i<comDataList.size(); i++) {
			EgovMap ev = new EgovMap();
			ev = (EgovMap)comDataList.get(i);
			//System.out.println(ev.get("columnName").toString());
			cols += (i==0?" ":",")+ev.get("columnName").toString();
		}

		String sql = "INSERT INTO "+requestMap.get("tbNm").toString()+" ";
		sql += "("+cols+") ";
		sql += "SELECT "+cols.replace(requestMap.get("tbPreCol").toString(), requestMap.get("tbCurCol").toString())+" ";
		sql += "FROM "+requestMap.get("tbNm").toString()+" ";
		sql += "WHERE "+requestMap.get("tbWhere").toString();

		//System.out.println("sql ~~>>> "+sql);

		requestMap.put("sql", sql);


		commonDAO.commonExecSql(requestMap);

	}

	@Override
	public void saveComOneCUD(Map requestMap, String tbNm, String updateGbnNm, String alias) throws Exception {
		// TODO Auto-generated method stub
		requestMap.put("schemaTbNm", tbNm);

		List<EgovMap> listPk = (List<EgovMap>) commonDAO.commonSchemaTbPk(requestMap);
		List<EgovMap> listCol = (List<EgovMap>) commonDAO.commonSchemaTbCol(requestMap);

		String sqlBody = "";
		String sqlWhere = "";
		boolean flag = true;

		if( "I".equals(requestMap.get(updateGbnNm)) || "i".equals(requestMap.get(updateGbnNm)) || "insert".equals(requestMap.get(updateGbnNm)) || "Insert".equals(requestMap.get(updateGbnNm)) ) {
			sqlBody += " INSERT INTO "+tbNm;
			sqlBody += " (";
			for( int i=0; i<listCol.size(); i++) {
				sqlBody += " "+(i==0?"":",") + listCol.get(i).get("columnName");
			}
			sqlBody += " ) VALUES( ";
			for( int i=0; i<listCol.size(); i++) {
				sqlBody += " "+(i==0?"":",") + "'"+Util.nvlString(requestMap.get(alias+listCol.get(i).get("camel")))+"'";
			}
			sqlBody += " ) ";

		}else if( "U".equals(requestMap.get(updateGbnNm)) || "u".equals(requestMap.get(updateGbnNm)) || "update".equals(requestMap.get(updateGbnNm)) || "Update".equals(requestMap.get(updateGbnNm)) ) {
			sqlBody += " UPDATE "+tbNm;
			sqlBody += " SET ";
			sqlWhere += " WHERE 1=1 ";
			int setCnt = 0;
			for( int i=0; i<listCol.size(); i++) {
				flag = true;

				for( int j=0; j<listPk.size(); j++) {
					if( listPk.get(j).get("columnName").equals(listCol.get(i).get("columnName"))) {
						sqlWhere += " AND "+listCol.get(i).get("columnName") +" = '"+Util.nvlString(requestMap.get(alias+listCol.get(i).get("camel")))+"'";
						flag = false;
						break;
					}
				}

				if(flag) {
					sqlBody += " "+(setCnt==0?"":",") + listCol.get(i).get("columnName") +" = '"+Util.nvlString(requestMap.get(alias+listCol.get(i).get("camel")))+"'";
					setCnt++;
				}
			}

			sqlBody += sqlWhere;

		}else if( "D".equals(requestMap.get(updateGbnNm)) || "d".equals(requestMap.get(updateGbnNm)) || "delete".equals(requestMap.get(updateGbnNm)) || "Delete".equals(requestMap.get(updateGbnNm)) ) {
			sqlBody += " DELETE "+tbNm;
			sqlWhere += " WHERE 1=1 ";
			for( int i=0; i<listCol.size(); i++) {
				for( int j=0; j<listPk.size(); j++) {
					if( listPk.get(j).get("columnName").equals(listCol.get(i).get("columnName"))) {
						sqlWhere += " AND "+listCol.get(i).get("columnName") +" = '"+Util.nvlString(requestMap.get(alias+listCol.get(i).get("camel")))+"'";
						flag = false;
						break;
					}
				}
			}

			sqlBody += sqlWhere;
		}

		requestMap.put("sql", sqlBody);
		commonDAO.commonExecSql(requestMap);

	}

}
