<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	const message = '${message}';
	if(message != ''){
		alert(message);
	}
</script>
<body>
	<h1>partyDetail</h1>
	<h3>party : ${party}</h3>
	<a href="<c:url value='/chat?pnum=${party.pnum}'/>">채팅창</a>
</body>
</html>
