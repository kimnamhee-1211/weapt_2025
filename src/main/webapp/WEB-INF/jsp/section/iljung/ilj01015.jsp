<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>fullcalendar</title>
    <!--fullcalendar-->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.14/locales/ko.global.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!--툴팁용-->
    <script src='https://unpkg.com/popper.js/dist/umd/popper.min.js'></script>
    <script src='https://unpkg.com/tooltip.js/dist/umd/tooltip.min.js'></script>


</head>
<body>
    <div id="calendar"></div>
    <jsp:include page="/WEB-INF/jsp/section/iljung/pop_iljung.jsp" />
</body>
<style>
    /* 일요일 컬러 */
    .fc-day-sun a {color: red;}
    /* 토요일 컬러 */
    .fc-day-sat a {color: red;}
    /* 공휴일 컬러 */
    .fc-daygrid-day:has(.holiday) .fc-daygrid-day-number { color:red; }
    /* 지정 공휴일 */
    .fc-daygrid-day-top{
        display:flex !important;
        align-items:center;
        flex-direction: row !important;
    }
    .holiday-label{
        color:red;
        font-size:14px;
        margin-left:5px !important;
    }
    .fc-daygrid-day-number{
        float:none !important;
        position:static !important;
        margin-left:auto !important;
        order:2 !important;
    }
    .fc-event.holiday .fc-event-title {
        display: none;
    }

    /* 이벤트 박스 */
    .fc-daygrid-event {
        background: none !important;
        border: none !important;
        margin: 0 !important;
        padding: 0 !important;
        text-align: left !important;
        font-size: 13px !important;
    }
    .fc-event-title::before {
        content: "• ";
        color: currentColor;
    }
    /* 이벤트 color */
    .fc-event-title {
        color: black !important;
        margin: 0 !important;
        padding-left: 5px !important;
        text-align: left !important;
    }
    .fc-event.STATUS_CD120001 .fc-event-title {
        color: blue !important;
    }

    /* tooltip */
    .fc-tooltip {
        font-size: 12px;
        line-height: 1.4;
    }
    .fc-tooltip-title {
        margin-bottom: 0px;
    }
    .tooltip-inner {
        background: #2c3e50;
        color: #fff;
        padding: 4px 5px;
        border-radius: 4px;
        max-width: 260px;
        text-align: left;
    }
    .tooltip.bs-tooltip-top .tooltip-arrow::before {
        border-top-color: #2c3e50;
    }
    .tooltip {
        z-index: 9999;
    }
    /* listWeek */
    .fc-list-event-graphic {
        display: none !important;
    }


</style>
<script>
    let parentPgId;
    let parentMenuId;
    let querySet;
    let calendarEl;
    let calendar;
    let initialView;
    let selectEvent = [];

    /* json 데이터
     * id(MST_NO)
     * seq(SEQ)
     * className(STATUS_CD / absent / holiday)
     * title(TITLE)
     * start(SC_DATE)
     * end(SC_DATE)
     * */
    function search_calendar1_onclick(info, successCallback, failureCallback) {
        $.ajax({
            url: ctx + "/api/selectList/" + sectionId + "/" + querySet + "_calendar",
            type: 'GET',
            data: {
                start: info.startStr.substring(0, 10).replace(/-/g,""),
                end: info.endStr.substring(0, 10).replace(/-/g,""),
            },
            headers: {
                "X-PG-ID": parentPgId,
                "X-MENU-ID": parentMenuId,
            },
            success: res => successCallback(res.DATA),
            error: err => failureCallback(err)
        });
    }

    function initializeCalendar(){

        let headerToolbar = {
            left: 'prevYear,prev',
            center: 'title',
            end: 'today next,nextYear'
        };

        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: initialView,
            headerToolbar: headerToolbar,
            fixedWeekCount : false,
            height: 658,
            locale: 'ko',
            dayMaxEventRows: true,
            eventDidMount: function(info) {
                let tooltip = new Tooltip(info.el, {
                    title: info.event.title,
                    placement: 'top',
                    trigger: 'hover',
                    container: 'body'
                });
                if (info.view.type == 'dayGridMonth') {
                    if (info.event.classNames.includes("holiday")) {
                        const dayTop = info.el
                            .closest(".fc-daygrid-day")
                            ?.querySelector(".fc-daygrid-day-top");

                        if(dayTop && !dayTop.querySelector(".holiday-label")){
                            const span = document.createElement("span");
                            span.className = "holiday-label";
                            span.textContent = info.event.title;
                            const dayNum = dayTop.querySelector(".fc-daygrid-day-number");
                            if(dayNum){
                                dayNum.before(span);
                            }
                        }
                    }
                }
                //주간보기 UI
                if (info.view.type == 'listWeek') {
                    const timeEl = info.el.querySelector('.fc-list-event-time');
                    if (timeEl) {
                        timeEl.innerHTML = info.event.extendedProps.gbn_name ?? "";
                    }
                    // 공휴일 날짜 색 변경
                    if (info.event.classNames.includes("holiday")) {
                        const date = info.event.startStr;
                        const dateEl1 = calendarEl.querySelector(
                            `.fc-list-day[data-date="` + date + `"] .fc-list-day-side-text`
                        );
                        const dateEl2 = calendarEl.querySelector(
                            `.fc-list-day[data-date="` + date + `"] .fc-list-day-text`
                        );
                        const dateEl3 = calendarEl.querySelector(
                            `.holiday .fc-list-event-time`
                        );
                        const dateEl4 = calendarEl.querySelector(
                            `.holiday .fc-list-event-title`
                        );
                        if (dateEl1) dateEl1.style.color = "red";
                        if (dateEl2) dateEl2.style.color = "red";
                        if (dateEl3) dateEl3.style.color = "red";
                        if (dateEl4) dateEl4.style.color = "red";

                    }
                }
            },
            //일정 불러오기
            eventSources: [
                {
                    events: function (info, successCallback, failureCallback) {
                        search_calendar1_onclick(info, successCallback, failureCallback);
                    }
                }
            ],
            //날짜 클릭 -> 일정 추가
            selectable: true,
            dateClick: function(info) {
                let pop_item = {
                    pgId : pgId,
                    querySet : querySet,
                    saveKey : "I",
                    addItem : {
                        SC_DATE : info.dateStr.replace(/-/g,""),
                        MST_MONTH : info.dateStr.substring(0, 7).replace(/-/g,''),
                    },
                };
                pop_onload(pop_item);
                //팝업 열기 이벤트
                popupOpen(popupId);
            },
            //이벤트 클릭 -> 일정 조회/수정/삭제
            eventClick: function(info) {
                const event = info.event;
                if(!event.classNames.includes("absent") && !event.classNames.includes("holiday")){
                    let pop_item = {
                        pgId : pgId,
                        querySet : querySet,
                        saveKey : "U",
                        searchItem : {
                            MST_NO : event.id,
                            SC_DATE : event.startStr.replace(/-/g,''),
                            MST_MONTH : event.startStr.substring(0, 7).replace(/-/g,''),
                            SEQ : event.extendedProps.seq
                        },
                    };
                    pop_onload(pop_item);
                    //팝업 열기 이벤트
                    popupOpen(popupId);
                }
            },
        });
        calendar.render();
    }

    function calendar_onload(pop_item){
        parentPgId = isNull(pop_item.pgId) ? "" : pop_item.pgId;
        parentMenuId = isNull(pop_item.menuId) ? "" : pop_item.menuId;
        querySet = isNull(pop_item.querySet) ? pop_item.pgId : pop_item.querySet;
        initialView = pop_item.initialView ? pop_item.initialView : 'dayGridMonth';

        if(initialView){
            calendarEl = document.getElementById('calendar');
            //로드 시 캘린더 바로 조회
            initializeCalendar();
        }
    }


</script>
</html>
