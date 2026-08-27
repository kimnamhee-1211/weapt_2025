/**
 * 2025.09
 *
 * 스크립스 작성용 공통 js
 *
 *
 * function btnMaker(search = false, add = false, del = false, save = false, print = false) : 공통버튼 만들기
 * function btnHidden(div, btnDivId) : 버튼 숨기기
 * function btnPermission(data) : crud 권한별 공통버튼 제어
 *
 * -----------------------------------------------------------------------
 * function selectOptionMaker(CODEDV_NO, selectId, all, short = false) : 공통코드 select 태그 option 설정
 * function selectUsergroupId : UsergroupId select 태그 option 설정
 *
 * --------------------------------------------------------------
 * function inputDateFormat(obj) : 입력부 text 날짜 포멧
 * function inputNumFormat(obj) : 입력부 text 슷자 포멧
 * function inputTelFormat(obj) : 입력부 text 전화번호 포멧
 * function inputBRNFormat(obj) : 입력부 text 사업자번호 포멧
 * function inputMoneyFormat(obj) : 입력부 text 금액 포멧
 *
 * -----------------------------------------------------------------------
 * function dataToInput(data, inputDivId) : data-input 태그 바인딩
 * function gridToInput(grid, inputDivId) : 그리그-input 태그 바인딩
 * function inputToGrid(grid, inputDivId) : input-그리드 태그 바인딩
 * function inputToGrid(inputDivId) : input-object 태그 바인딩
 *
 * function clearInput(inputDivId) : input clear
 * function clearInput(disableInput) : disabled input
 *
 * ----------------------------------------------------------------
 * function popupOpen(popupTagId) : 팝업 열기 이벤트
 * function popupClose(popupTagId) : 팝업 닫기 이벤트
 *
 *
 *
 */

function btnMaker({
                      tag = "#section1_btn",
                      grid = 1,
                      search = false,
                      add = false,
                      del = false,
                      save = false,
                      print = false
                  } = {}) {
    let btns = '';

    if (search) {
        btns += `<button id="search_btn_${grid}" class="btn_left3" onclick="search_${grid}_onclick()">검색</button>`;
    }
    if (add) {
        btns += `<button id="add_btn_${grid}" class="btn_left3" onclick="add_${grid}_onclick()">추가</button>`;
    }
    if (del) {
        btns += `<button id="delete_btn_${grid}" class="btn_left3" onclick="delete_${grid}_onclick()">삭제</button>`;
    }
    if (save) {
        btns += `<button id="save_btn_${grid}" class="btn_left3"  onclick="save_${grid}_onclick()">저장</button>`;
    }
    if (print) {
        btns += `<button id="print_btn_${grid}" class="btn_left3" onclick="" class="print_btn">인쇄</button>`;
    }

    const btnTag = document.querySelector(tag);
    if (!btnTag) {
        console.warn(tag + "컨테이너가 없습니다.");
        return;
    }
    btnTag.innerHTML = btns;
}

/* function btnHidden
 * @description : 틀정버튼 숨기기
 * @param btnIds ([str]) : 숨길 버튼 id
 * @param btnDivId (str) : 태그 id
 * @return : null
 */
function btnHidden(btnIds, btnDivId) {
    const btnDiv = document.querySelector("#" + btnDivId);
    const btnTags = btnDiv.querySelectorAll("button");
    for (let btnTag of btnTags) {
        if (btnIds.includes(btnTag.id)) {
            btnTag.hidden = true;
        }
    }
}

/* function btnEnable
 * @description : 버튼 활성화 제어
 * @param data ({}) : 권한 data
 * @return : null
 */
function btnEnable({   grid = 1,
                       search = true,
                       add = true,
                       del = true,
                       save = true,
                       print = true
                   } = {}) {

    const btnTags = document.querySelectorAll("button");
    for (let btnTag of btnTags) {
        let btnId = btnTag.id;
        let btn_type = btnId.split("_")[0]
        let btn_grid =  btnId.split("_")[2]
        if(grid == btn_grid){
            if (btn_type === "search") {
                btnTag.disabled = !search;
            }
            if (btn_type === "add") {
                btnTag.disabled = !add;
            }
            if (btn_type === "delete") {
                btnTag.disabled = !del;
            }
            if (btn_type === "save") {
                btnTag.disabled = !save;
            }
            if (btn_type === "print") {
                btnTag.disabled = !print;
            }
        }
    }
}


/* function btnPermission
 * @description : crud 권한별 버튼 제어
 * @param data ({}) : 권한 data
 * @return : null
 */
function btnPermission(data) {
    const btn = {
        GRD_READ: '#search_btn',
        GRD_CREATE: '#add_btn',
        GRD_DELETE: '#delete_btn',
        GRD_UPDATE: '#save_btn',
        GRD_EXCEL: '#print_btn',
    };
    Object.entries(btn).forEach(([key, sel]) => {
        const el = document.querySelector(sel);
        if (el) {
            if (data?.[key] !== "1") {
                el.hidden = true;
            }
        }
    });
}

/* function selectOptionMaker
 * @description : 공통코드 select 태그 option 설정
 * @param CODEDV_NO (str) : 공통코드
 * @param selectId (obj) : select 태그
 * @param all (str) : "전체"(필수 아님) / "" (필수)
 * @param short (boolean) : true 약어명 / false 상세명
 * @return : null
 */
async function selectOptionMaker(CODEDV_NO, selectId, all, short = false) {
    let selectOptions = await we_getCode(CODEDV_NO);
    if (selectOptions) {
        let select = selectId;
        if (!isNull(all)) {
            select.insertAdjacentHTML("afterbegin", "<option value=''>" + all + "</option>");  //필요시
        }
        if (short) {
            selectOptions.forEach(row => {
                select.insertAdjacentHTML("beforeend",
                    `<option value="${row.CODE_NO}">${row.SHORT_NM}</option>`);
            })
        } else {
            selectOptions.forEach(row => {
                select.insertAdjacentHTML("beforeend",
                    `<option value="${row.CODE_NO}">${row.CODEDTL_NM}</option>`);
            })

        }
    }
    selectId.selectedIndex = 0;
}


/* function inputDateFormat
 * @description : 입력부 text 날짜(yyyy-DD-mm) 형식으로 변환
 * @param obj (obj) : input 태그
 * @return : null
 */
function inputDateFormat(obj) {
    let date = obj.value;
    if (!/^[0-9]*$/.test(date)) {
        obj.value = "";
        return;
    }
    if (!isNull(date) && date.length == 8) {
        date = date.slice(0, 4) + '-' + date.slice(4, 6) + '-' + date.slice(6);
        obj.value = date;
    }
}


/* function inputNumFormat
 * @description : 입력부 text 숫자 형식으로 변환
 * @param obj (obj) : input 태그
 * @return : null
 */
function inputNumFormat(obj) {
    let num = obj.value;
    if (!/^[0-9]*$/.test(num)) {
        obj.value = "";
        return;
    }
}


/* function inputTelFormat
 * @description : 입력부 text 전화번호 형식으로 변환
 * @param obj (obj) : input 태그
 * @return : null
 */
function inputTelFormat(obj) {
    let tel = obj.value.replace(/-/g, '');

    let formatted = "";
    if (!/^[0-9]*$/.test(tel)) {
        obj.value = "";
        return;
    }
    if (tel.length == 9) {
        formatted = tel.slice(0, 2) + '-' + tel.slice(2, 5) + '-' + tel.slice(5);
    } else if (tel.length == 10) {
        if (tel.slice(0, 2) == "02") {
            formatted = tel.slice(0, 2) + '-' + tel.slice(2, 6) + '-' + tel.slice(6);
        } else {
            formatted = tel.slice(0, 3) + '-' + tel.slice(3, 6) + '-' + tel.slice(6);
        }
    } else if (tel.length == 11) {
        formatted = tel.slice(0, 3) + '-' + tel.slice(3, 7) + '-' + tel.slice(7);
    } else {
        formatted = tel; // 포맷 불가 상태 유지
    }
    obj.value = formatted;
}


/* function inputBRNFormat
 * @description : 입력부 text 사업자번호 형식으로 변환
 * @param obj (obj) : input 태그
 * @return : null
 */
function inputBRNFormat(obj) {
    let num = obj.value.replace(/-/g, '');
    let formatted = "";

    if (!/^[0-9]*$/.test(num)) {
        obj.value = "";
        return;
    }
    if (num.length == 10) {
        formatted = num.slice(0, 3) + '-' + num.slice(3, 5) + '-' + num.slice(5);
    } else {
        formatted = num; // 포맷 불가 상태 유지
    }
    obj.value = formatted;
}

/* function inputMoneyFormat
 * @description : 입력부 text 금액 형식으로 변환
 * @param obj (obj) : input 태그
 * @return : null
 */
function inputMoneyFormat(obj) {
    let num = obj.value.replace(/,/g, "");  // 기존 콤마 제거

    // 숫자가 아닐 경우 초기화
    if (!/^[0-9]*$/.test(num)) {
        obj.value = "";
        return;
    }

    // 숫자를 3자리 단위로 콤마 추가
    if (num !== "") {
        obj.value = Number(num).toLocaleString('ko-KR');
    } else {
        obj.value = "";
    }
}

/* function dataToInput
 * @description : data{} input[name] 태그 바인딩
 * @param data ({}) : data
 * @param inputDivId (str) : 태그 id
 * @return : null
 */
function dataToInput(data, inputDivId) {
    const inputDiv = document.querySelector("#" + inputDivId);
    const namedElements = inputDiv.querySelectorAll('[name]');
    for (let el of namedElements) {
        let key = el.name;
        if (data.hasOwnProperty(key)) {
            if (el.dataset.format === "date") {
                el.value = "";
                if(!isNull(data[key])){
                    el.value = dateFormat(data[key]) ?? '';
                }
            } else if (el.dataset.format === "html") {
                el.value = "";
                if(!isNull(data[key])){
                    el.value = stripHtml(data[key]) ?? '';
                }
            }else if (el.type === "checkbox") {
                el.checked = false;
                if(!isNull(data[key])){
                    el.checked = (el.value == data[key]);
                }
            }else if (el.type === "radio") {
                el.checked = false;
                if(!isNull(data[key])){
                    el.checked = (el.value == data[key]);
                }
            }else {
                el.value = "";
                el.value = data[key] ?? '';
            }
        }
    }
}

/* function gridToInput
 * @description : 그리드 아이템 input[name] 태그 바인딩
 * @param grid (obj) : grid
 * @param inputDivId (str) : 태그 id
 * @return : null
 */
function gridToInput(grid, inputDivId) {
    let selectedRow = AUIGrid.getSelectedRows(grid)[0];

    const inputDiv = document.querySelector("#" + inputDivId);
    const namedElements = inputDiv.querySelectorAll('[name]');
    for (let el of namedElements) {
        let key = el.name;
        if (selectedRow.hasOwnProperty(key)) {
            if (el.dataset.format === "date") {
                el.value = "";
                el.value = dateFormat(selectedRow[key]) ?? '';
            }else if (el.type === "checkbox") {
                el.checked = false;
                el.checked = (el.value == selectedRow[key]);
            }else if (el.type === "radio") {
                el.checked = false;
                el.checked = (el.value == selectedRow[key]);
            }else {
                el.value = "";
                el.value = selectedRow[key] ?? '';
            }
        }
    }
}

/* function inputToGrid
 * @description : input[name] 태그 key(name)-value 그리드 바인딩
 * @param grid (obj) :  grid
 * @param inputDivId (str) :  태그 id
 * @return : null
 */
function inputToGrid(grid, inputDivId) {
    const inputDiv = document.querySelector("#" + inputDivId);
    const namedElements = inputDiv.querySelectorAll('[name]');
    let item = {};
    for (let el of namedElements) {
        let key = el.name;
        let value = "";
        if (el.dataset.format === "date") {
            value = el.value.replace(/\D/g, '');
        }else if (el.dataset.format === "licenseNo") {
            value = el.value.replace(/\D/g, '');
        }else if (el.type === "checkbox") {
            value = el.checked ? el.value : "";
        }else if (el.type === "radio") {
            if (el.checked) {
                value = el.value;
            }
        } else {
            value = el.value;
        }
        item[key] = value;
    }
    AUIGrid.updateRow(grid, item, "selectedIndex");
}


/* function inputToData
 * @description : input[name] 태그 key(name)-value 객체로 내보내기
 * @param inputDivId (str) :  태그 id
 * @return : {}
 */
function inputToData(inputDivId) {
    const inputDiv = document.querySelector("#" + inputDivId);
    const namedElements = inputDiv.querySelectorAll('[name]');
    let item = {};
    for (let el of namedElements) {
        let key = el.name;
        let value = "";
        if (el.dataset.format === "date") {
            value = el.value.replace(/\D/g, '');
        }else if (el.dataset.format === "licenseNo") {
            value = el.value.replace(/\D/g, '');
        }else if (el.type === "checkbox") {
            value = el.checked ? el.value : "";
        }else if (el.type === "radio") {
            if (el.checked) {
                value = el.value;
            }
        } else {
            value = el.value;
        }
        item[key] = value;
    }
    return item;
}


/* function clearInput
 * @description : input[name] 태그 clear
 * @param inputDivId (str) :  태그 id
 * @return : null
 */
function clearInput(inputDivId) {
    const inputDiv = document.querySelector("#" + inputDivId);
    const namedElements = inputDiv.querySelectorAll('[name]');
    for (let el of namedElements) {
        if (el.type === "checkbox" || el.type === "radio") {
            el.checked = false;
        } else {
            el.value = "";
        }
    }
}

/* function disableInput
 * @description : input[name] 태그 disable 처리하기
 * @param inputDivId (str) :  태그 id
 * @return : null
 */
function disableInput(inputDivId) {
    const inputDiv = document.querySelector("#" + inputDivId);
    const namedElements = inputDiv.querySelectorAll('[name]');
    for (let el of namedElements) {
        el.disabled = true;
    }
}



/* function popupOpen
 * @description : 팝업 열기 이벤트
 * @param popupTagId (str) : 팝업 id
 * @return : null
 */
function popupOpen(popupTagId) {
    const popupTag = document.querySelector("#" + popupTagId);
    popupTag.style.display = 'block';
}


/* function popupClose
 * @description : 팝업 닫기 이벤트
 * @param popupTagId (str) : 팝업 id
 * @return : null
 */
function popupClose(popupTagId) {
    const popupTag = document.querySelector("#" + popupTagId);
    popupTag.style.display = 'none';
}



  