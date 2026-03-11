/**
 * 2025.09
 *
 *  공용 조회 function
 *
 * async function we_getCode : 공통 코드 조회 함수
 * async function we_getSelectOption : select 태그 option 조회 함수
 * async function we_getUsergroupId : usergroupId 조회 함수
 *
 *
 **/

   //공통 코드 조회 함수
   async function we_getCode(CODEDV_NO, timeout = 60_000) {

      const controller = new AbortController();
      const timer = setTimeout(() => controller.abort(), timeout);

      try {
         const res = await fetch(
             ctx + apiPrefix + "/getCode/" + CODEDV_NO,
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
   
         if(!res.ok) throw new Error(`서버 오류: ${res.status}`);

         const json = await res.json();
         return json;

      }catch (err) {
         if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("공통코드 조회 시간이 초과되었습니다");
         }else{
            console.error(err);
            alert("공통코드 조회에 실패하였습니다");
         }
         throw err;
      }finally{
         clearTimeout(timer);
      }
   }
   /*사용법
        //공통코드 가져오기
        function getCode(){
            let selectOptions = we_getCode(CODEDV_NO);
        }
    */



   // select 태그 option 조회 함수
   async function we_getSelectOption(data, timeout = 60_000) {

      //로딩시작
      const controller = new AbortController();
      const timer = setTimeout(() => controller.abort(), timeout);

      try {
         let url = "";
         let method = "";
         let query = "";
         const sectionId = encodeURIComponent(data.sectionId);
         const component = encodeURIComponent(data.component);

         method = "/getSelectOption/";
         query = new URLSearchParams(data.param).toString();
         url = ctx + apiPrefix + method + sectionId + "/" + component + "?" + query;

         const res = await fetch(
             url,
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

         if (!res.ok) throw new Error(`서버 오류: ${res.status}`);

         const json = await res.json();
         return json;

      }catch (err) {
         if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("조회 시간이 초과되었습니다");
         }else{
            console.error(err);
            alert("조회에 실패하였습니다");
         }
         throw err;

      }finally{
         clearTimeout(timer);
         //로딩종료
      }
   }

   //usergroupId 조회 함수
   async function we_getUsergroupId(timeout = 60_000) {

      const controller = new AbortController();
      const timer = setTimeout(() => controller.abort(), timeout);

      try {
         const res = await fetch(
             ctx + apiPrefix + "/getUsergroupId",
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

         if(!res.ok) throw new Error(`서버 오류: ${res.status}`);

         const json = await res.json();
         return json;

      }catch (err) {
         if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("공통코드 조회 시간이 초과되었습니다");
         }else{
            console.error(err);
            alert("공통코드 조회에 실패하였습니다");
         }
         throw err;
      }finally{
         clearTimeout(timer);
      }
   }
   /*사용법
        //공통코드 가져오기
        function getUsergroupId(){
            let usergroupId = we_getSelectCode();
        }
    */











  