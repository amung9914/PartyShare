<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정관리</title>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style>
.menu{
	text-align:center;
	margin:30px;
}
.btn-outline-dark{
	margin:20px;
    width: 200px;
    padding: 20px 0px;
}
</style>
</head>
<body>
	<div class="menu">
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/party/hostingList'/>">개설한 파티 관리</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/party/myParty'/>">참여중인 파티</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/wishlist/wishlist'/>">파티 위시리스트</a>
		<br/>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/member/post?mId=${loginMember.mid}'/>">알림</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/member/profileModify'/>">계정설정</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/member/report'/>">신고하기</a>
	</div>
	
</body>
</html>