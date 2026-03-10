/**
 * 2025.09
 *
 * approval 공통 function
 *
 * async function we_approval : 결제 처리용 함수
 *
 *
 **/

   //crud 권한 데이터 select 함수
   async function we_approval(data, { successApp } = {}, timeout = 60_000) {

      const controller = new AbortController();
      const timer = setTimeout(() => controller.abort(), timeout);

      let query = new UrlSearchParams(data.param).toString();
      try {
         const res = await fetch(
             ctx + apiPrefix + "/approval/" + pgId + ? ,
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

         if (typeof successPer === "function") await successPer(json);

      }catch (err) {
         if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("권한 조회 시간이 초과되었습니다");
         }else{
            console.error(err);
            alert("권한 조회에 실패하였습니다");
         }
         throw err;
      }finally{
         clearTimeout(timer);
      }
   }
   /*사용법

      //crud 권한 처리 호출 함수
      function checkCrudPermission(pgId){
         we_checkCrudPermission(pgId,{
            successPer : (data) => {
               //권한에 따라 버튼 숨김
               btnPermission(data)
            }
         });
      }
    */





