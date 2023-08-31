<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link href="${path}/resources/css/ksg/createParty.css" rel="stylesheet"/>
<div id="createParty_wrap">
	<div id="calBox">
		<h1 id="title">날짜를 선택하세요</h1>
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
	    	<input type="text" name="startDate" id="dateOne_startDate" /> 
	    	<input type="hidden" name="endDate" id="endDate" />
	    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		</form>
	</div>
</div>
	<script>
	$("#dateOne_startDate").val(today());
	$("#endDate").val(today());
	$('#calBox').daterangepicker({
	    "locale": {
	        "format": "YYYY-MM-DD",
	        "separator": " ~ ",
	        "applyLabel": "확인",
	        "cancelLabel": "취소",
	        "fromLabel": "From",
	        "toLabel": "To",
	        "customRangeLabel": "Custom",
	        "weekLabel": "W",
	        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	        "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	    },
	    "dateOne_startDate": new Date(),
	    "endDate": new Date(),
	    "drops": "down"
	}, function (start, end, label) {
	    $("#dateOne_startDate").val(start.format('YYYY-MM-DD'));
	    $("#endDate").val(start.format('YYYY-MM-DD'));
	});
	$("#calBox").click();
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
