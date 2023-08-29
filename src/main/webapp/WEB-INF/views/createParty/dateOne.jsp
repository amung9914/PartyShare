<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<style>
	#dateBox{
		margin-top: 14%;
	}
	#startDate{
		border:none;
		outline: none;
		border-bottom: 2px solid black;
		text-align: center;
		width: 600px;
		font-size: 30px;
	}
	#calenderBox{
		width: 300px;
		height:  100px;
		text-align: left;
		display:flex;
		flex-direction: column;
		flex-wrap: wrap;
		position: relative;
		right: 50px;
		cursor: pointer;
	}
	#calenderBox p{
		font-size: 40px;
		width: 400px;
		
	}
	#calenderBox img{
		width : 70px;
		height: 70px;
	}
</style>
<div id="createParty_wrap">
	
	<div id="calenderBox">
		<img src="${pageContext.request.contextPath}/resources/img/calendar.png"/>
		<p id="title">날짜를 선택하세요</p>
	</div>
	<div id="dateBox">
		<form action="createDate" method="post">
			<input type="hidden" name="host" value="${loginMember.mnum}"/>
			<input type="hidden" name="description" value="${vo.description}" />
			<input type="hidden" name="category" value="${vo.category}" />
			<input type="hidden" name="address" value="${vo.address}">
			<input type="hidden" name="sido" value="${vo.sido}">
			<input type="hidden" name="sigungu" value="${vo.sigungu}">
			<input type="hidden" name="detailAddress" value="${vo.detailAddress}">
			<input type="hidden" id="lat" name="lat" value="${mapVO.lat}">
	    	<input type="hidden" id="lng" name="lng" value="${mapVO.lng}">
	    	<input type="text" name="startDate" id="startDate" /> 
	    	<input type="hidden" name="endDate" id="endDate" />
		</form>
	</div>
</div>
	<script>
	
	 $('#calenderBox').daterangepicker({
		 	"locale": {
		        "format": "YYYY-MM-DD",
		        "applyLabel": "확인",
		        "cancelLabel": "취소",
		        "weekLabel": "W",
		        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
		        "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
		    },
		    singleDatePicker: true
		  }, function(start, end, label) {
			  $("#startDate").val(start.format('YYYY-MM-DD'));
			  $("#endDate").val(start.format('YYYY-MM-DD'));
		  });
	$("#startDate").val(today());
	$("#endDate").val(today());
	$("#calenderBox").click();
	function today(){
		let date = new Date();
		let yyyy = date.getFullYear();
		let mm = date.getMonth() + 1;
		mm = mm >= 10 ? mm : '0'+mm;
		let dd = date.getDate();
		dd = dd >= 10 ? dd : '0'+dd;
		return yyyy+'-'+mm+'-'+dd;
	}
	</script>
	<%@ include file="partyCreateFooter.jsp" %>
