<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>Home</title>
</head>
<body>

<a href="location/regist">등록하기</a><br/>
<a href="login">로그인하기</a><br/>
<a href="<c:url value='/member/profileModify?page=1'/>">modify</a>
<a href="<c:url value='/party/partyList'/>">partyList</a>
<a href="<c:url value='/party/partyHost?pnum=496'/>">partyMemberList</a>
<a href="<c:url value='/party/createParty'/>">파티생성</a>
<%@ include file="home/partyList.jsp" %>
</body>
</html>
