/**
 * 2025.09
 *
 * CRUD 공통 function
 *
 * async function we_select : 공통 select 함수
 * async function we_insert : 공통 insert 함수
 * async function we_update : 공통 update 함수
 * async function we_delete : 공통 delete 함수
 * async function we_save : 공통 save 함수
 *
 * async function we_boardSelect : 공통 게시글 select 함수
 * async function we_boardSavs : 공통 게시글 save 함수
 * async function we_boardDeleteOne : 공통 게시글 delete 함수
 *
 * async function we_checkCrudPermission : crud 권한 데이터 select 함수
 *
 *
 **/


//공통 select 함수
async function we_select(data, {successSelect} = {}, timeout = 60_000) {

    //로딩시작
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const query = new URLSearchParams(data.param)
        let method = "/selectList/";

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
            alert("조회 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("조회에 실패하였습니다");
        }
        throw err;

    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}

/* 사용법
  //그리드 조회
  function select_grid1_onclick(){

      //검색데이터
      let param = {
          menuName : document.querySelector("#menuName").value,
      }

      //파라미터
      let selectData = {
          sectionId :  sectionId,
          component : pgId + "_grid1",
          param: param,
      }

      we_select( selectData,{
          successSelect : (json) => {
             let data = json.DATA;
              //그리드 데이터 세팅
              AUIGrid.setGridData(grid1, data)
              //포커스 : 첫 조회시 첫 행 / 수정 시 수정 행
              AUIGrid.setSelectionByIndex(grid1, grid1_focus);
              grid1_focus = 0;
          }
      });
  }
*/

//공통 insert 함수
async function we_insert(data, {successInsert} = {}, timeout = 60_000) {

    //로딩시작

    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const param = JSON.stringify(data.param);
        let method = "";
        if (Array.isArray(data.param)) {
            method = "/insertList/";
        } else {
            method = "/insertOne/";
        }

        const res = await fetch(
            ctx + apiPrefix + method + sectionId + "/" + component,
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
        if (typeof successInsert === "function") await successInsert(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("저장 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("저장에 실패하였습니다");
        }
        throw err;
    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}

/* 사용법

*/

//공통 update 함수
async function we_update(data, {successUpdate} = {}, timeout = 60_000) {

    //로딩시작

    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const param = JSON.stringify(data.param)
        let method = "";
        if (Array.isArray(data.param)) {
            method = "/updateList/";
        } else {
            method = "/updateOne/";
        }

        const res = await fetch(
            ctx + apiPrefix + method + sectionId + "/" + component,
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
        if (typeof successUpdate === "function") await successUpdate(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("저장 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("저장에 실패하였습니다");
        }
        throw err;
    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}

/* 사용법

*/

//공통 delete 함수
async function we_delete(data, {successDelete} = {}, timeout = 60_000) {

    //로딩시작

    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const param = JSON.stringify(data.param);
        let method = "/deleteList/";

        const res = await fetch(
            ctx + apiPrefix + method + sectionId + "/" + component,
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
        if (typeof successDelete === "function") await successDelete(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("삭제 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("삭제에 실패하였습니다");
        }
        throw err;
    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}

/* 사용법

   //그리드 삭제 함수
  function delete_grid1_onclick(){
      //검증
      const checkedItems = AUIGrid.getCheckedRowItems(grid1);

      // 체크된 행 삭제 처리
      AUIGrid.removeCheckedRows(grid1);

      // 삭제된 행 아이템들(배열) -> 삭제 데이터
      let param = {
         deleteParam : AUIGrid.getRemovedItems(grid1);
      }

      //공통 저장 트렌젝션용 데이터
      let deleteData = {
          sectionId :  sectionId,
          component : pgId + "_grid1",
          param : param,
      }

      we_delete(deleteData,{
          successDelete : (data) => {
              if(itemCount == data) {
                  alert("총 " + data + "건을 삭제하였습니다.");
                  search_grid1_onclick();
              }
          }
      });
  }

*/

//공통 save 함수
async function we_save(data, {successSave} = {}, timeout = 60_000) {

    //로딩시작
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const param = JSON.stringify(data.param);
        let method = "/saveList/"

        const res = await fetch(
            ctx + apiPrefix + method + sectionId + "/" + component,
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
        if (typeof successSave === "function") await successSave(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("저장 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("저장에 실패하였습니다");
        }
        throw err;
    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}

/*사용법
   function save_grid1_onclick(){
      //저장 데이터

      let param = {
          insertParam : addedRowItems,
          updateParam : editedRowItems,
          key : ["key"],
          before : { saveMode : "I",
                     beforeParam : beforeParam}
      }

      //파라미터
      let saveData  = {
          sectionId :  sectionId,
          component : pgId + "_grid1",
          param: param,
      }

      we_save( saveData ,{
          successSave : (data) => {
              if(data == itemCount){
                  alert("총" + data + "건의 변경사항을 저장하였습니다.");
              }
              select_grid1_onclick()
          }
      });
   }
 */


//공통 게시글 select 함수
async function we_boardSelect(data, {successBoardSelect} = {}, timeout = 60_000) {

    //로딩시작
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const query = new URLSearchParams(data.param)
        let method = "/boardSelectOne/";

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
        if (typeof successBoardSelect === "function") await successBoardSelect(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("조회 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("조회에 실패하였습니다");
        }
        throw err;

    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}

/* 사용법
  //그리드 조회
  function search_board1_onclick(){

      //검색데이터
      let param = {
         BOARD_DIV : board_div,
         BOARD_NO : AUIGrid.getSelectedRows(grid1)[0].BOARD_NO
         cnt : "Y"
      }

      //파라미터
      let boardSelectData = {
          sectionId :  sectionId,
          component : pgId + "_board1",
          param: param,
      }

      we_boardSelect( boardSelectData,{
          successBoardSelect : (json) => {
                let data = json.DATA;

             dataToInput(data[0], write_popup);
             AUIGrid.setGridData(file_grid, data);
          }
      });
  }
*/

//공통 save 함수
async function we_boardSave(data, {successBoardSave} = {}, timeout = 60_000) {

    //로딩시작
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const param = JSON.stringify(data.param);
        let method = "/boardSave/";

        const res = await fetch(
            ctx + apiPrefix + method + sectionId + "/" + component,
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
        if (typeof successBoardSave === "function") await successBoardSave(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("저장 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("저장에 실패하였습니다");
        }
        throw err;
    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}

/*사용법
   function save_board1_onclick(){

     let addItem = null;
     let editItem = null;

     let item = {
         BOARD_TITLE : board_title.value,
         BOARD_WRITER : board_writer.value,
         BOARD_DATE : board_date.value,
         BOARD_CONTENT : board_content.value,
         BOARD_DIV : board_div,
         BOARD_NO : board_no.value
     };

     if(saveKey == "U") {
         editItem = item;
     }else{
         addItem  = item;
     }

     //저장 데이터
     let saveParam = {
         insertParam : addItem,
         updateParam : editItem,
     }

     //파라미터
     let boardSaveData  = {
         sectionId : sectionId,
         component : pgId + "_board1",
         param: saveParam,
     }

      we_boardSave( boardSaveData ,{
          successBoardSave : (data) => {
              if(data == itemCount){
                  alert("총" + data + "건의 게시글을 저장하였습니다.");
              }
              search_board1_onclick()
          }
      });
   }
 */


//공통 delete 함수
async function we_boardDeleteOne(data, {successboardDeleteOne} = {}, timeout = 60_000) {

    //로딩시작

    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    try {
        const sectionId = encodeURIComponent(data.sectionId);
        const component = encodeURIComponent(data.component);
        const param = JSON.stringify(data.param);
        let method = "/boardDeleteOne/";

        const res = await fetch(
            ctx + apiPrefix + method + sectionId + "/" + component,
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
        if (typeof successboardDeleteOne === "function") await successboardDeleteOne(json);

    } catch (err) {
        if (err.name === "AbortError") {
            console.error("요청 타임아웃");
            alert("삭제 시간이 초과되었습니다");
        } else {
            console.error(err);
            alert("삭제에 실패하였습니다");
        }
        throw err;
    } finally {
        clearTimeout(timer);
        //로딩종료
    }
}

/* 사용법

*/






  