/**
 * 2025.09
 *
 * 스크립스 작성용 공통 js
 *
 * function getToday(format) : 오늘 날짜
 *        format : "yyyy-MM-dd", "yyyy/MM/dd", "yyyyMMdd", "yyyy.MM.dd", "kor", "yyyy", "MM", "dd"
 * function isNull(object) : null 체크
 * function dateFormat(obj) : text 날짜 포멧
 * function strToDate(obj) : text 날짜 - Date 변환
 * function  dateToStr(date, format) : Date - text 날짜 변환
 * function stripHtml(html) : HTML 태그 제거-순수 텍스트 추출
 * function nextAlpha(str) : 알파벳 조합 최대값 구하기
 *
 *
 *
 * const DS_MONTH : [{DS_MONTH_CD, DS_MONTH}]
 *
 */

//날짜 return String
function getToday(format) {
    const today = new Date();
    const todayYr = today.getFullYear();        // 2025
    const todayMonth = String(today.getMonth() + 1).padStart(2, '0');
    const todayDay = String(today.getDate()).padStart(2, '0');

    switch (format) {
        case "yyyy-MM-dd"    :
            return `${todayYr}-${todayMonth}-${todayDay}`;
        case "yyyy/MM/dd"    :
            return `${todayYr}/${todayMonth}/${todayDay}`;
        case "yyyyMMdd"        :
            return `${todayYr}${todayMonth}${todayDay}`;
        case "yyyy.MM.dd"    :
            return `${todayYr}.${todayMonth}.${todayDay}`;
        case "kor"            :
            return `${todayYr}년 ${todayMonth}월 ${todayDay}일`;
        case "yyyy"            :
            return `${todayYr}`;
        case "MM"            :
            return `${todayMonth}`;
        case "dd"            :
            return `${todayDay}`;
        default                :
            return `${todayYr}-${todayMonth}-${todayDay}`;
    }
}

//null 체크
function isNull(object) {
    if (Array.isArray(object)) {
        if (object == null || object.length < 1) return true;
    } else {
        if (object == null || object == undefined || object.trim() == '' || object.trim() == "") return true;
    }
    return false;
}

//text 날짜 포멧
function dateFormat(obj) {
    let result = obj.replace(/[^0-9]/g, '');
    if (!isNull(result) && result.length == 8) {
        result = String(result);
        result = result.slice(0, 4) + '-' + result.slice(4, 6) + '-' + result.slice(6);
        return result;
    }
}

function strToDate(obj) {
    let result = obj.replace(/[^0-9]/g, '');
    let year = result.substring(0, 4);
    let month = result.substring(4, 6);
    let day = result.substring(6, 8);
    let date = new Date(year, month - 1, day);
    return date;
}

function dateToStr(date, format) {
    const y = date.getFullYear();
    const m = String(date.getMonth() + 1).padStart(2, '0');
    const d = String(date.getDate()).padStart(2, '0');

    switch (format) {
        case "yyyy-MM-dd" :
            return `${y}-${m}-${d}`;
        case "yyyy/MM/dd" :
            return `${y}/${m}/${d}`;
        case "yyyyMMdd" :
            return `${y}${m}${d}`;
        case "yyyy.MM.dd" :
            return `${y}.${m}.${d}`;
        case "kor" :
            return `${y}년 ${m}월 ${d}일`;
        case "yyyy" :
            return `${y}`;
        case "MM" :
            return `${m}`;
        case "dd" :
            return `${d}`;
        default :
            return `${y}-${m}-${d}`;
    }
}


//HTML 태그 제거-순수 텍스트 추출
function stripHtml(html) {
    const hasTags = /<\/?[a-z][\s\S]*>/i.test(html);
    if (!hasTags) {
        return html;
    }
    const tempDiv = document.createElement("div");
    tempDiv.innerHTML = html;
    return tempDiv.textContent || tempDiv.innerText || "";
}

// 알파벳 조합 최대값 구하기
function nextAlpha(str) {
    let chars = (str.slice(0, 2)).split('');
    let carry = 1;
    for (let i = chars.length - 1; i >= 0; i--) {
        if (carry === 0) break;
        let code = chars[i].charCodeAt(0) + carry;
        if (code > 122) { // 'z'를 넘으면 a로 돌리고 캐리
            code = 97;
            carry = 1;
        } else {
            carry = 0;
        }
        chars[i] = String.fromCharCode(code);
    }
    return chars.join('');
}

const DS_MONTH = [
    {DS_MONTH_CD: "01", DS_MONTH: "1월"},
    {DS_MONTH_CD: "02", DS_MONTH: "2월"},
    {DS_MONTH_CD: "03", DS_MONTH: "3월"},
    {DS_MONTH_CD: "04", DS_MONTH: "4월"},
    {DS_MONTH_CD: "05", DS_MONTH: "5월"},
    {DS_MONTH_CD: "06", DS_MONTH: "6월"},
    {DS_MONTH_CD: "07", DS_MONTH: "7월"},
    {DS_MONTH_CD: "08", DS_MONTH: "8월"},
    {DS_MONTH_CD: "09", DS_MONTH: "9월"},
    {DS_MONTH_CD: "10", DS_MONTH: "10월"},
    {DS_MONTH_CD: "11", DS_MONTH: "11월"},
    {DS_MONTH_CD: "12", DS_MONTH: "12월"}
];



    	


  