<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../common/header.jsp" %>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
html, body {
    height: 90%
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
}
b{
	font-size: larger;
}
</style>

	<div class="menu">
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/host/party/hostingList'/>">
		<b>개설한 파티 관리</b>
		<div class="form-text" id="basic-addon4">호스트중인 파티 목록으로 이동합니다</div>
		</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/user/party/myParty'/>">
		<b>참여중인 파티</b>
		<div class="form-text" id="basic-addon4">파티 일정을 확인해보세요</div>
		</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/wishlist/wishlist'/>">
		<b>파티 위시리스트</b>
		<div class="form-text" id="basic-addon4">참여하고 싶은 공간을 확인해보세요</div>
		</a>
		<br/>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/user/post?mId=${loginMember.mid}'/>">
		<b>알림</b>
		<div class="form-text" id="basic-addon4">서비스 공지사항을 확인해보세요</div>
		</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/user/profileModify'/>">
		<b>계정설정</b>
		<div class="form-text" id="basic-addon4">계정 정보를 변경할 수 있습니다</div>
		</a>
		<a class="btn btn-outline-dark" role="button" href="<c:url value='/user/report'/>">
		<b>신고하기</b>
		<div class="form-text" id="basic-addon4">불쾌감을 주는 사용자를 신고할 수 있습니다</div>
		</a>
	</div>

<%@ include file="../common/fixFooter.jsp" %>