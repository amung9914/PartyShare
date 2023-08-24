<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#successBox{
		text-align: center;
		width: 500px;
		margin-left:35%;
		margin-top:15%;
	}
	#successBox a{
		display:inline-block;
		line-height: 50px;
		text-decoration: none;
		width: 100px;
		height: 50px;
		color: white;
		box-shadow: 2px 2px 2px;
		background-color: black;
		
	}
</style>
</head>
<body>
	<div id="successBox">
		<h1>축하합니다.</h1>
		<h1>새로운 파티가 생성되었습니다.</h1>
		<a href="<c:url value='/party/partyList'/>">목록으로</a>
	</div>
	
</body>
</html>