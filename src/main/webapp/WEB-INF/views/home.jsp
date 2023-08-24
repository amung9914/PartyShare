<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<a href="<c:url value='/member/login'/>">로그인</a>
<a href="<c:url value='/member/profileModify?page=1'/>">프로필modify</a>
<a href="<c:url value='/party/partyList'/>">partyList</a>
<a href="<c:url value='/party/partyHost?pnum=496'/>">partyMemberList</a>
<a href="<c:url value='/party/createParty'/>">파티생성</a>
<a href="<c:url value='/freeBoard/freeBoard'/>">자유게시판</a>


<%@ include file="home/partyList.jsp" %>
</body>
</html>
