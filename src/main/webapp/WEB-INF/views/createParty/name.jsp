<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#formBox{
		width: 50%;
		margin-left: 25%;
		margin-top: 20%;
	}
	
	#pname{
		border:none;
		border-bottom: 2px solid black;
		width: 100%;
		font-size: 50px;
		outline: none;
		text-align: center;
	}
</style>
</head>
<body>
	<div id="formBox">
		<form action="createName" method="post">
			<input type="hidden" name="host" value="${loginMember.mnum}"/>
			<input type="hidden" name="description" value="${vo.description}" />
			<input type="hidden" name="category" value="${vo.category}" />
			<input type="hidden" name="address" value="${vo.address}">
			<input type="hidden" name="sido" value="${vo.sido}">
			<input type="hidden" name="sigungu" value="${vo.sigungu}">
			<input type="hidden" name="detailAddress" value="${vo.detailAddress}">
			<input type="hidden" id="lat" name="lat" value="${mapVO.lat}">
	    	<input type="hidden" id="lng" name="lng" value="${mapVO.lng}">
	    	<input type="hidden" name="startDate" value="${vo.startDate}" />
			<input type="hidden" name="endDate" value="${vo.endDate}" />
			
			<input type="text" name="pname" id="pname" class="reqInput" placeholder="파티 이름은 무엇인가요?"/><br/>
		</form>
	</div>
	
	<%@ include file="partyCreateFooter.jsp" %>
</body>
</html>