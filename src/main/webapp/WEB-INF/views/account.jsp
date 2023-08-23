<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>${loginMember}</h3>
	<a href="<c:url value='/party/hostingList'/>">개설한 파티 관리</a>
	<a href="<c:url value='/party/myParty'/>">참여중인 파티</a>
	<a href="<c:url value='/friend'/>">친구리스트</a>
	
</body>
</html>