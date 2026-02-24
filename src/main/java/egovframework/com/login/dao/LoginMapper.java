/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
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
package egovframework.com.login.dao;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.com.login.model.LoginVO;

/**
 * login에 관한 데이터처리 매퍼 클래스
 *
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2025.09.09		김남희          최초생성
 *
 * @author 김남희
 * @since 2025.09.09
 * @version 1.0
 * @see
 *
 * </pre>
 */
@Mapper("loginMapper")
public interface LoginMapper {

	/**
	 * loginUser를 조회한다.
	 * @param vo - 조회할 정보가 담긴 LoginVO
	 * @return loginUser
	 * @exception Exception
	 */
	LoginVO selectLoginUser(LoginVO vo) throws Exception;


//	/**
//	 * 글을 등록한다.
//	 * @param vo - 등록할 정보가 담긴 SampleVO
//	 * @return 등록 결과
//	 * @exception Exception
//	 */
//	void insertSample(SampleVO vo) throws Exception;
//
//	/**
//	 * 글을 수정한다.
//	 * @param vo - 수정할 정보가 담긴 SampleVO
//	 * @return void형
//	 * @exception Exception
//	 */
//	void updateSample(SampleVO vo) throws Exception;
//
//	/**
//	 * 글을 삭제한다.
//	 * @param vo - 삭제할 정보가 담긴 SampleVO
//	 * @return void형
//	 * @exception Exception
//	 */
//	void deleteSample(SampleVO vo) throws Exception;
//
//
//	/**
//	 * 글 목록을 조회한다.
//	 * @param searchVO - 조회할 정보가 담긴 VO
//	 * @return 글 목록
//	 * @exception Exception
//	 */
//	List<?> List(SampleDefaultVO searchVO) throws Exception;
//
//	/**
//	 * 글 총 갯수를 조회한다.
//	 * @param searchVO - 조회할 정보가 담긴 VO
//	 * @return 글 총 갯수
//	 * @exception
//	 */
//	int selectSampleListTotCnt(SampleDefaultVO searchVO);
	

}
