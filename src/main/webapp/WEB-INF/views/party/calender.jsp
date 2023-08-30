<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<style>
	#calendar{
		width : 45%;
		margin: 30px 30px 200px 30px;
	}
	a{
	text-decoration: none;
    color: black;
	}
	
	
@media (max-width: 1240px) {
   #calendar{
 	width : 80%
   }
}
</style>

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
	    editable: false,
	    dayMaxEvents: true, // allow "more" link when too many events
	    events: [
	    	<c:forEach items="${list}" var="party">
	    	{
	            title: '${party.pname}',
	            start: '${party.startDate}',
	            end: '${party.endDate}',
	        	url: '${path}/partyDetail/detailOfParty?pNum=${party.pnum}',
	          },
	    	</c:forEach>
	    	]
	    		
	  });

	  
	  calendar.render();
	});

    </script>
