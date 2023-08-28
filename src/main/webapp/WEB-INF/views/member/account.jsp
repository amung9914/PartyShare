<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../common/header.jsp" %>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style>
html, body {
    height: 90%
}
#wrap {
    min-height: 100%;
    position: relative;
    padding-bottom: 100px;
}
	
.menu{
	text-align:center;
	margin:30px;
}
.btn-outline-dark{
	margin:20px;
    padding: 20px 0px;
    box-shadow: rgba(0, 0, 0, 0.12) 0px 6px 16px;
    border-color: rgb(221,221,221);
    border: 1px solid rgb(221,221,221);
    width: 300px;
    height: 100px;
    line-height: 55px;
}
</style>
<div id="wrap">
	<div class="menu">
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/party/hostingList'/>">개설한 파티 관리</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/party/myParty'/>">참여중인 파티</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/wishlist/wishlist'/>">파티 위시리스트</a>
		<br/>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/member/post?mId=${loginMember.mid}'/>">알림</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/member/profileModify'/>">계정설정</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/member/report'/>">신고하기</a>
	</div>
</div>	
<%@ include file="../common/footer.jsp" %>