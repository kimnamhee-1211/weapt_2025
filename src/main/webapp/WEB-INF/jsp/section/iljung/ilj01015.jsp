<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.14/locales/ko.global.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div id="calendar"></div>
</body>
<style>
    .fc .fc-header-toolbar {
        padding: 10px;
    }
    .fc .fc-button{
        line-height: 1.2;
    }
    .fc .fc-prev-button,
    .fc .fc-next-button,
    .fc .fc-prevYear-button,
    .fc .fc-prevNext-button{
    }
    .fc-day-sun a { /* 일요일 컬러 */

    }
    .fc-day-sat a { /* 토요일 컬러 */

    }


</style>
<script>
    let querySet;
    let calendarEl;
    let calendar;
    let initialView;
    let selectEvent = [];


    function search_calendar1_onclick(info, successCallback, failureCallback) {
        $.ajax({
            url: ctx + "/selectList/" + sectionId + "/" + querySet + "_calendar",
            type: 'GET',
            data: {
                start: info.startStr.substring(0, 10),
                end: info.endStr.substring(0, 10)
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
            eventSources: [
                {
                    events: function (info, successCallback, failureCallback) {
                        search_calendar1_onclick(info, successCallback, failureCallback);
                    },
                    color: '#B7DECD',
                    textColor: 'white'
                }
            ],
            selectable: true,
            dateClick: function(info) {
                alert('Clicked on: ' + info.dateStr);
                alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
                alert('Current view: ' + info.view.type);
                info.dayEl.style.backgroundColor = 'red';
            },
        });
        calendar.render();
    }

    function pop_onload(pop_item){
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
