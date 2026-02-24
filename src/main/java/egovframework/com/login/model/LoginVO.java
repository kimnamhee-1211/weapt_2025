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
package egovframework.com.login.model;

/**
 * @Class Name : LoginVO.java
 * @Description : LoginVO Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2025.09.09		김남희          최초생성
 *
 * @author 김남희
 * @since 2025.09.09
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */
public class LoginVO{

	private static final long serialVersionUID = 1L;

	/** 아이디 */
	private String userId;

	/** 비밀번호 */
	private String password;

	/** 이름 */
	private String userName;

	/** 사번 */
	private String empNo;

	/** 사용여부 */
	private String useYn;

	/** 관리소코드 */
	private String officeCode;

	/** 관리소명 */
	private String officeName;

	/** 휴대전화 */
	private String hpNo;

	/** 인증코드 */
	private String authCode;

	/** 사용자그룹ID */
	private String usergroupId;

	/** 사용자그룹설명 */
	private String usergroupNm;

	/** 작업그룹ID */
	private String workGroupId;

	/** 작업그룹이름 */
	private String workGroupNm;

	/** 전산회사코드 */
	private String mgmcompCode;

	/** 전산회사이름 */
	private String mgmcompNm;

	/** 현재상태 */
	private String status;

	/** 현재상태명 */
	private String statusNm;

	/** 관리자코드 */
	private String mgmCode;

	/** 상위관리자ID */
	private String upMgmuserId;

	/** 상위관리자명 */
	private String upMgmuserName;

	/** 레벨코드 */
	private String levelCode;

	/** 전화번호 */
	private String tel;

	/** 회사코드 */
	private String compCode;

	/** 회사코드 */
	private String compName;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getOfficeCode() { return officeCode; }

	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}

	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}

	public String getHpNo() {
		return hpNo;
	}

	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}

	public String getAuthCode() {
		return authCode;
	}

	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}

	public String getUsergroupId() {
		return usergroupId;
	}

	public void setUsergroupId(String usergroupId) {
		this.usergroupId = usergroupId;
	}

	public String getUsergroupNm() {
		return usergroupNm;
	}

	public void setUsergroupNm(String usergroupNm) {
		this.usergroupNm = usergroupNm;
	}

	public String getWorkGroupId() {
		return workGroupId;
	}

	public void setWorkGroupId(String workGroupId) {
		this.workGroupId = workGroupId;
	}

	public String getMgmcompCode() {
		return mgmcompCode;
	}

	public void setMgmcompCode(String mgmcompCode) {
		this.mgmcompCode = mgmcompCode;
	}

	public String getMgmcompNm() {
		return mgmcompNm;
	}

	public void setMgmcompNm(String mgmcompNm) {
		this.mgmcompNm = mgmcompNm;
	}

	public String getWorkGroupNm() {
		return workGroupNm;
	}

	public void setWorkGroupNm(String workGroupNm) {
		this.workGroupNm = workGroupNm;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMgmCode() {
		return mgmCode;
	}

	public void setMgmCode(String mgmCode) {
		this.mgmCode = mgmCode;
	}

	public String getStatusNm() {
		return statusNm;
	}

	public void setStatusNm(String statusNm) {
		this.statusNm = statusNm;
	}

	public String getUpMgmuserId() {
		return upMgmuserId;
	}

	public void setUpMgmuserId(String upMgmuserId) {
		this.upMgmuserId = upMgmuserId;
	}

	public String getUpMgmuserName() {
		return upMgmuserName;
	}

	public void setUpMgmuserName(String upMgmuserName) {
		this.upMgmuserName = upMgmuserName;
	}

	public String getLevelCode() {return levelCode;}

	public void setLevelCode(String levelCode) {
		this.levelCode = levelCode;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getCompCode() {
		return compCode;
	}

	public void setCompCode(String compCode) {
		this.compCode = compCode;
	}

	public String getCompName() {
		return compName;
	}

	public void setCompName(String compName) {
		this.compName = compName;
	}

	@java.lang.Override
	public java.lang.String toString() {
		return "LoginVO{" +
				"userId='" + userId + '\'' +
				", password='" + password + '\'' +
				", userName='" + userName + '\'' +
				", empNo='" + empNo + '\'' +
				", useYn='" + useYn + '\'' +
				", officeCode='" + officeCode + '\'' +
				", hpNo='" + hpNo + '\'' +
				", authCode='" + authCode + '\'' +
				", usergroupId='" + usergroupId + '\'' +
				", usergroupNm='" + usergroupNm + '\'' +
				", workGroupId='" + workGroupId + '\'' +
				", workGroupNm='" + workGroupNm + '\'' +
				", mgmcompCode='" + mgmcompCode + '\'' +
				", mgmcompNm='" + mgmcompNm + '\'' +
				", status='" + status + '\'' +
				", statusNm='" + statusNm + '\'' +
				", mgmCode='" + mgmCode + '\'' +
				", upMgmuserId='" + upMgmuserId + '\'' +
				", upMgmuserName='" + upMgmuserName + '\'' +
				", levelCode='" + levelCode + '\'' +
				", tel='" + tel + '\'' +
				", compCode='" + compCode + '\'' +
				'}';
	}
}
