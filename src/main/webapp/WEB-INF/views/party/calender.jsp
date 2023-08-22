<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
</head>
<body>
 <div id='calendar'></div>
  <script>
  document.addEventListener('DOMContentLoaded', function() {
	  
	  var calendarEl = document.getElementById('calendar');

	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    headerToolbar: {
	      left: 'prev,next today',
	      center: 'title',
	      right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
	    },
	    locale: 'ko',
	    buttonIcons: false, // show the prev/next text
	    weekNumbers: true,
	    navLinks: true, // can click day/week names to navigate views
	    editable: true,
	    dayMaxEvents: true, // allow "more" link when too many events
	    events: [
	    	<c:forEach items="${list}" var="party">
	    	{
	            title: '${party.pname}',
	            start: '${party.startDate}',
	            end: '${party.endDate}',
	        	url: '${path}/party/partyDetail?pnum=${party.pnum}',
	          },
	    	</c:forEach>
	    	]
	    		
	  });

	  
	  calendar.render();
	});

    </script>
</body>
</html>