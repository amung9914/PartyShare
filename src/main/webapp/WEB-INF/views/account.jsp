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
	<a href="<c:url value='/wishlist/wishlist'/>">파티 위시리스트</a>
	<a href="<c:url value='/member/post?mId=${loginMember.mid}'/>">알림</a>
	<a href="<c:url value='/member/profileModify'/>">계정설정</a>
	<a href="<c:url value='/member/report'/>">신고하기</a>
	
	
</body>
</html>