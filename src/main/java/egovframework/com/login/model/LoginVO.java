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
	public String getPassword() {
		return password;
	}
	public String getUserName() {
		return userName;
	}
	public String getEmpNo() {
		return empNo;
	}
	public String getUseYn() {
		return useYn;
	}
	public String getOfficeCode() { return officeCode; }
	public String getOfficeName() {
		return officeName;
	}
	public String getHpNo() {
		return hpNo;
	}
	public String getAuthCode() {
		return authCode;
	}
	public String getUsergroupId() {
		return usergroupId;
	}
	public String getUsergroupNm() {
		return usergroupNm;
	}
	public String getWorkGroupId() {
		return workGroupId;
	}
	public String getMgmcompCode() {
		return mgmcompCode;
	}
	public String getMgmcompNm() {
		return mgmcompNm;
	}
	public String getWorkGroupNm() {
		return workGroupNm;
	}
	public String getStatus() {
		return status;
	}
	public String getMgmCode() {
		return mgmCode;
	}
	public String getStatusNm() {
		return statusNm;
	}
	public String getUpMgmuserId() {
		return upMgmuserId;
	}
	public String getUpMgmuserName() {
		return upMgmuserName;
	}
	public String getLevelCode() {return levelCode;}
	public String getTel() {
		return tel;
	}
	public String getCompCode() {
		return compCode;
	}
	public String getCompName() {
		return compName;
	}

	private String trim(String value) {
		return value == null ? null : value.trim();
	}
	public void setUserId(String userId) {
		this.userId = trim(userId);
	}
	public void setPassword(String password) {
		this.password = trim(password);
	}
	public void setUserName(String userName) {
		this.userName = trim(userName);
	}
	public void setEmpNo(String empNo) {
		this.empNo = trim(empNo);
	}
	public void setUseYn(String useYn) {
		this.useYn = trim(useYn);
	}
	public void setOfficeCode(String officeCode) {
		this.officeCode = trim(officeCode);
	}
	public void setOfficeName(String officeName) {
		this.officeName = trim(officeName);
	}
	public void setHpNo(String hpNo) {
		this.hpNo = trim(hpNo);
	}
	public void setAuthCode(String authCode) {
		this.authCode = trim(authCode);
	}
	public void setUsergroupId(String usergroupId) {
		this.usergroupId = trim(usergroupId);
	}
	public void setUsergroupNm(String usergroupNm) {
		this.usergroupNm = trim(usergroupNm);
	}
	public void setWorkGroupId(String workGroupId) {
		this.workGroupId = trim(workGroupId);
	}
	public void setMgmcompCode(String mgmcompCode) {
		this.mgmcompCode = trim(mgmcompCode);
	}
	public void setMgmcompNm(String mgmcompNm) {
		this.mgmcompNm = trim(mgmcompNm);
	}
	public void setWorkGroupNm(String workGroupNm) {
		this.workGroupNm = trim(workGroupNm);
	}
	public void setStatus(String status) {
		this.status = trim(status);
	}
	public void setMgmCode(String mgmCode) {
		this.mgmCode = trim(mgmCode);
	}
	public void setStatusNm(String statusNm) {
		this.statusNm = trim(statusNm);
	}
	public void setUpMgmuserId(String upMgmuserId) {
		this.upMgmuserId = trim(upMgmuserId);
	}
	public void setUpMgmuserName(String upMgmuserName) {
		this.upMgmuserName = trim(upMgmuserName);
	}
	public void setLevelCode(String levelCode) {
		this.levelCode = trim(levelCode);
	}
	public void setTel(String tel) {
		this.tel = trim(tel);
	}
	public void setCompCode(String compCode) {
		this.compCode = trim(compCode);
	}
	public void setCompName(String compName) {
		this.compName = trim(compName);
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
