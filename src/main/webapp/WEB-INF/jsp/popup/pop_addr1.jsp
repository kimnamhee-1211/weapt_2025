<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript">
// opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("팝업API 호출 소스"도 동일하게 적용시켜야 합니다.)
//document.domain = "abc.go.kr";

function addrPopup(addrDivId){
    const addrDiv = document.querySelector("#" + addrDivId);
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(pop_addr2.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var pop = window.open(ctx + "/goPopup/pop_addr2","pop","width=570,height=420, scrollbars=yes, resizable=yes");

	var checkResult = setInterval(function () {
		if (!isNull(addrResult)) {
			addrDiv.querySelector('[name=ZIP]').value = addrResult.ZIP;
			addrDiv.querySelector('[name=ADDR1]').value = addrResult.ADDR1;
			addrDiv.querySelector('[name=ADDR2]').value = addrResult.ADDR2;
			clearInterval(checkResult);
			addrResult = null;
		}
	}, 200);
}

let addrResult;

function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
	let item = {
		ZIP: zipNo,
		ADDR1: roadFullAddr,
		ADDR2: addrDetail
	};
	addrResult = item;
}

</script>
<title>주소 입력</title>
</head>
<body>
</body>
</html>