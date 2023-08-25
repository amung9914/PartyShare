<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<style>
	#dateBox{
		margin-left: 30%;
		margin-top: 20%;
	}
	#title{
		margin-left:32%;
		margin-top:5%;
		cursor: pointer;
	}
	#startDate, #endDate{
		border:none;
		outline: none;
		border-bottom: 2px solid black;
		text-align: center;
		width: 300px;
		font-size: 30px;
	}
</style>
</head>
<body>
	
	<h1 id="title">짜릿한 하루를 선택해주세요</h1>
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
	    	<input type="text" name="startDate" id="startDate" /> ~
	    	<input type="text" name="endDate" id="endDate" />
		</form>
		
	</div>
	<script>
	$('h1').daterangepicker({
	    "locale": {
	        "format": "YYYY-MM-DD",
	        "applyLabel": "확인",
	        "cancelLabel": "취소",
	        "weekLabel": "W",
	        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	        "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	    },
	    "singleDatePicker": true,
	    "startDate": new Date(),
	    "drops": "down"
	}, function (start) {
	    $("#startDate").val(start.format('YYYY-MM-DD'));
	    $("#endDate").val(start.format('YYYY-MM-DD'));
	});
	$("h1").click();
	</script>
	<%@ include file="partyCreateFooter.jsp" %>
</body>
</html>