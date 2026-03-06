<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <!--fullcalendar-->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.14/locales/ko.global.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!--툴팁용-->
    <script src='https://unpkg.com/popper.js/dist/umd/popper.min.js'></script>
    <script src='https://unpkg.com/tooltip.js/dist/umd/tooltip.min.js'></script>
    <!--공휴일 표시용-->
    <script src='fullcalendar/dist/index.global.js'></script>


</head>
<body>
    <div id="calendar"></div>
    <jsp:include page="/WEB-INF/jsp/section/iljung/pop_iljung.jsp" />
</body>
<style>
    /* 일요일 컬러 */
    .fc-day-sun a {
        color: red;
    }
    /* 토요일 컬러 */
    .fc-day-sat a {
        color: red;
    }
    /* 공휴일 컬러 */
    .fc-daygrid-day:has(.holiday) .fc-daygrid-day-number { color:red; }
    /* 이벤트 박스 */
    .fc-daygrid-event {
        background: none !important;
        border: none !important;
    }
    .fc-daygrid-event::before {
        content: "• ";
        margin-right: 4px;
        color: currentColor;
    }
    /* 이벤트 color */
    .fc-event.holiday {
        color: red;
    }
    .fc-event.absent {
        color: black;
    }


</style>
<script>
    let parentPgId;
    let querySet;
    let calendarEl;
    let calendar;
    let initialView;
    let selectEvent = [];

    /* json 데이터
     * id(MST_NO)
     * seq(SEQ)
     * sch_gbn(SCH_GBN)
     * className : css 제어용 holiday/absent/SCH_GBN
     * title(TITLE)
     * start(SC_DATE)
     * */
    function search_calendar1_onclick(info, successCallback, failureCallback) {
        $.ajax({
            url: ctx + "/selectList/" + sectionId + "/" + querySet + "_calendar",
            type: 'GET',
            data: {
                start: info.startStr.substring(0, 10),
                end: info.endStr.substring(0, 10)
            },
            headers: {
                "X-PG-ID": parentPgId,
            },
            success: res => successCallback(res),
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
            eventDidMount: function(info) {
                //이벤트 마우스 hover
                //info.el.title = info.event.title;
                let tooltip = new Tooltip(info.el, {
                    title: info.event.title,
                    placement: 'top',
                    trigger: 'hover',
                    container: 'body'
                });
                //주간 보기 시 UI 설정
                if (info.view.type === 'listWeek') {
                    const timeEl = info.el.querySelector('.fc-list-event-time');
                    if (timeEl) {
                        timeEl.innerHTML = `<b>${info.event.extendedProps.gbn_name}</b>`;
                    }
                }

            },
            //일정 불러오기
            eventSources: [
                {
                    events: function (info, successCallback, failureCallback) {
                        search_calendar1_onclick(info, successCallback, failureCallback);
                    }
                },{
                    googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
                    className: 'holiday'
                }
            ],
            //날짜 클릭 -> 일정 추가
            selectable: true,
            dateClick: function(info) {
                let pop_item = {
                    pgId : pgId,
                    saveKey : "I",
                    addItem : {
                        SC_DATE : info.dateStr.replace(/-g/,""),
                        MST_MONTH : info.dateStr.substring(5, 7),
                    },
                };
                pop_onload(pop_item);
                //팝업 열기 이벤트
                popupOpen(popupId);
            },
            //이벤트 클릭 -> 일정 조회/수정/삭제
            eventClick: function(info) {
                if(!info.extendedProps.holiday == "Y"){
                    let pop_item = {
                        pgId : pgId,
                        saveKey : "U",
                        searchItem : {
                            MST_NO : info.id,
                            SC_DATE : info.dateStr.replace(/-g/,""),
                            MST_MONTH : info.dateStr.substring(5, 7),
                            SEQ : info.extendedProps.seq
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

    function pop_onload(pop_item){
        parentPgId = isNull(pop_item.pgId) ? "" : pop_item.pgId;
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
