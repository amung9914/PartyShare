<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../common/header.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="${contextPath}/resources/css/jinlee/siteMap.css" rel="stylesheet">
<body>
	<div id="siteMap">
		<h1>사이트맵</h1>
		<br/>
		<hr/>
		<table id="siteMap">
			<tr>
				<td><a href="${contextPath}">홈</a></td>
				<td><a href="${contextPath}/user/party/createParty">파티생성</a></td>
				<td><a href="${contextPath}/freeBoard/freeBoard">자유게시판</a></td>
				<td><a href="${contextPath}/policy">개인정보 처리방침</a></td>
				<td><a href="${contextPath}/admin/admin">관리자 페이지</a></td>
			</tr>
			<tr>
				<td><a href="${contextPath}/member/goJoin">회원가입</a></td>
				<td><a href="${contextPath}/host/party/hostingList">개설한 파티 관리</a></td>
				<td>파티상세페이지</td>
				<td><a href="${contextPath}/policy2">이용약관</a></td>
				<td></td>
			</tr>
			<tr>
				<td><a href="${contextPath}/member/login">로그인</a></td>
				<td><a href="${contextPath}/user/party/myParty">참여중인 파티</a></td>
				<td>파티 게시판</td>
				<td><a href="${contextPath}/infomation">세부정보</a></td>
				<td></td>
			</tr>
			<tr>
				<td><a href="${contextPath}/location/map">지도확인</a></td>
				<td><a href="${contextPath}/user/wishlist/wishlist">위시리스트</a></td>
				<td><a href="${contextPaht}/user/chat">파티 채팅</a></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><a href="${contextPath}/member/post">알림</a></td>
				<td>파티 참여하기</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><a href="${contextPath}/user/profileModify">계정 설정</a></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><a href="${contextPath}/member/report">신고하기</a></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><a href="${contextPath}/user/friend">친구 리스트</a></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
	</div>
<%@ include file="../common/fixFooter.jsp" %>