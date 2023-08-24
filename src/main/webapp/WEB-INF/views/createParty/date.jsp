<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<style>
	#dateBox{
		margin-left: 35%;
		margin-top: 10%;
	}
	h1{
		margin-left:38%;
	}
</style>
</head>
<body>
	<h1>날짜를 선택하세요</h1>
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
			시작날짜 : <input type="text" name="startDate" class="reqInput" required/>	~	끝 날짜 : <input type="date" name="endDate" required/> <br/>
		</form>
	</div>
	<input type="date" id="demo" name="dates" value="" />
	<%@ include file="partyCreateFooter.jsp" %>
	
</body>
</html>