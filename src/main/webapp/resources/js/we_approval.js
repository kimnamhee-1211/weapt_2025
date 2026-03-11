/**
 * 2025.09
 *
 * approval 공통 function
 *
 * async function we_approval : 결제 처리용 함수
 *
 *
 **/

    //결재 직책 검색
    async function we_getApprovalDuty(data, { successGet } = {}, timeout = 60_000) {
        const controller = new AbortController();
        const timer = setTimeout(() => controller.abort(), timeout);

        try {
            const sectionId = encodeURIComponent(data.sectionId);
            const component = encodeURIComponent(data.component);
            const query = new UrlSearchParams(data.param)
            let method = "/getApprovalDuty/";

            const res = await fetch(
                ctx + apiPrefix + method  + sectionId + "/" + component + "?" +  query,
            {
                    method: "GET",
                    headers: {
                       "Accept": "application/json",
                       "X-PG-ID": pgId,
                    },
                    credentials: "include",
                    signal: controller.signal
                });

            if(!res.ok) throw new Error(`서버 오류: ${res.status}`);
            const json = await res.json();

            if (typeof successGet === "function") await successGet(json);

        }catch (err) {
            if (err.name === "AbortError") {
                console.error("요청 타임아웃");
                alert("결재 직책 조회 시간이 초과되었습니다");
            }else{
                console.error(err);
                alert("결재 직책 조회에 실패하였습니다");
            }
            throw err;
        }finally{
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
    async function we_selectApproval(data, { successSelect } = {}, timeout = 60_000) {
        const controller = new AbortController();
        const timer = setTimeout(() => controller.abort(), timeout);

        try {
            const sectionId = encodeURIComponent(data.sectionId);
            const component = encodeURIComponent(data.component);
            const query = new UrlSearchParams(data.param)
            let method = "/selectApproval/";

            const res = await fetch(
                ctx + apiPrefix + method  + sectionId + "/" + component + "?" +  query,
            {
                    method: "GET",
                    headers: {
                       "Accept": "application/json",
                       "X-PG-ID": pgId,
                    },
                    credentials: "include",
                    signal: controller.signal
                });

            if(!res.ok) throw new Error(`서버 오류: ${res.status}`);
            const json = await res.json();

            if (typeof successSelect === "function") await successSelect(json);

        }catch (err) {
            if (err.name === "AbortError") {
                console.error("요청 타임아웃");
                alert("결재 현황 조회 시간이 초과되었습니다");
            }else{
                console.error(err);
                alert("결재 현황 조회에 실패하였습니다");
            }
            throw err;
        }finally{
            clearTimeout(timer);
        }
    }

    /*사용법

      //crud 권한 처리 호출 함수
      function selectApproval(pgId){

         we_selectApproval(data,{
            successSelect : (data) => {

            }
         });
      }
    */


   //결재 처리 함수
   async function we_approval(data, { successAppr } = {}, timeout = 60_000) {

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
                },
                body: param,
                signal: controller.signal,
                credentials: 'include'
             });

         if(!res.ok) throw new Error(`서버 오류: ${res.status}`);

         const json = await res.json();
         if (typeof successAppr === "function") await successAppr(json);

      }catch (err) {
         if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("결재 시간이 초과되었습니다");
         }else{
            console.error(err);
            alert("결재에 실패하였습니다");
         }
         throw err;
      }finally{
         clearTimeout(timer);
         //로딩종료
      }
   }







