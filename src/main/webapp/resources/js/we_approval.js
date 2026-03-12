/**
 * 2025.09
 *
 * approval 공통 function
 *
 * async function we_approval : 결제 처리용 함수
 *
 *
 **/

//결재 직책 조회(개별)
async function we_getApprDuty(data, {successGet} = {}, timeout = 60_000) {
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const query = new UrlSearchParams(data.param)
        let method = "/getApprDuty/";

        const res = await fetch(
            ctx + apiPrefix + method + sectionId + "/" + component + "?" + query,
            {
                method: "GET",
                headers: {
                    "Accept": "application/json",
                    "X-PG-ID": pgId,
                    "X-MENU-ID": menuId,
                },
                credentials: "include",
                signal: controller.signal
            });

        const json = await res.json();
        if (!res.ok) {
            alert(json.O_MSG);
            return;
        }

        if (typeof successGet === "function") await successGet(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("결재 직책 조회 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("결재 직책 조회에 실패하였습니다");
        }
        throw err;
    } finally {
        clearTimeout(timer);
    }
}

/*사용법

  //crud 권한 처리 호출 함수
  function getApprovalDuty_gridAppr1(pgId){

     we_getApprovalDuty(data,{
        successGet : (data) => {

        }
     });
  }
*/

//결재 직책 조회 TPM_CONFIRM_LINE
async function we_getApprDutyLine(data, {successGet} = {}, timeout = 60_000) {
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const query = new UrlSearchParams(data.param)
        let method = "/getApprDutyLine/";

        const res = await fetch(
            ctx + apiPrefix + method + sectionId + "/" + component + "?" + query,
            {
                method: "GET",
                headers: {
                    "Accept": "application/json",
                    "X-PG-ID": pgId,
                    "X-MENU-ID": menuId,
                },
                credentials: "include",
                signal: controller.signal
            });
        const json = await res.json();
        if (!res.ok) {
            alert(json.O_MSG);
            return;
        }
        if (typeof successGet === "function") await successGet(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("결재 직책 조회 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("결재 직책 조회에 실패하였습니다");
        }
        throw err;
    } finally {
        clearTimeout(timer);
    }
}

/*사용법

  //crud 권한 처리 호출 함수
  function getApprovalDuty_gridAppr1(pgId){

     we_getApprovalDuty(data,{
        successGet : (data) => {

        }
     });
  }
*/

//결재 현황 검색
async function we_selectApproval(data, {successSelect} = {}, timeout = 60_000) {
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const query = new UrlSearchParams(data.param)
        let method = "/selectApproval/";

        const res = await fetch(
            ctx + apiPrefix + method + sectionId + "/" + component + "?" + query,
            {
                method: "GET",
                headers: {
                    "Accept": "application/json",
                    "X-PG-ID": pgId,
                    "X-MENU-ID": menuId,
                },
                credentials: "include",
                signal: controller.signal
            });
        const json = await res.json();
        if (!res.ok) {
            alert(json.O_MSG);
            return;
        }

        if (typeof successSelect === "function") await successSelect(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("결재 현황 조회 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("결재 현황 조회에 실패하였습니다");
        }
        throw err;
    } finally {
        clearTimeout(timer);
    }
}

/*사용법

  //crud 권한 처리 호출 함수
  function selectApproval(pgId){

     we_selectApproval(data,{
        successSelect : (json) => {
            let data = json.DATA;

        }
     });
  }
*/


//결재 처리 함수
async function we_approval(data, {successAppr} = {}, timeout = 60_000) {

    //로딩시작
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const param = JSON.stringify(data.param);

        const res = await fetch(
            ctx + apiPrefix + "/approval/" + sectionId + "/" + component,
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-PG-ID": pgId,
                    "X-MENU-ID": menuId,
                },
                body: param,
                signal: controller.signal,
                credentials: 'include'
            });
        const json = await res.json();
        if (!res.ok) {
            alert(json.O_MSG);
            return;
        }

        if (typeof successAppr === "function") await successAppr(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("결재 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("결재에 실패하였습니다");
        }
        throw err;
    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}


//결재 취소 처리 함수
async function we_cancApproval(data, {successCancAppr} = {}, timeout = 60_000) {

    //로딩시작
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const param = JSON.stringify(data.param);

        const res = await fetch(
            ctx + apiPrefix + "/cancelApproval/" + sectionId + "/" + component,
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-PG-ID": pgId,
                    "X-MENU-ID": menuId,
                },
                body: param,
                signal: controller.signal,
                credentials: 'include'
            });
        const json = await res.json();
        if (!res.ok) {
            alert(json.O_MSG);
            return;
        }
        if (typeof successCancAppr === "function") await successCancAppr(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("결재 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("결재에 실패하였습니다");
        }
        throw err;
    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}





