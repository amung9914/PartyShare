<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100&family=Noto+Sans+KR:wght@300&display=swap');
    * {margin: 0; padding: 0; font-family: 'Hahmlet', serif; font-family: 'Noto Sans KR', sans-serif;}

	#siteMap {
		margin: 30px auto;
		width: 80%;
	}

	#siteMap {
	    border-collapse: separate;
	    border-spacing: 8px; /* 원하는 간격 크기로 조정 */
	}
	
	#siteMap td {
	    padding: 15px; /* 셀 내부 여백 설정 (선택 사항) */
	    font-weight: bold;
	}
	
	#siteMap td a {
	    text-decoration: none;
	    color: black;
	}
	
	#siteMap td a:hover {
		color: #FF385C;
	}
	
</style>
</head>
<body>
	<%@ include file="../member/login.jsp" %>
	<div id="siteMap">
		<h1>사이트맵</h1>
		<br/>
		<hr/>
		<table id="siteMap">
			<tr>
				<td><a href="${contextPath}">홈</a></td>
				<td><a href="${contextPath}/party/createParty">파티생성</a></td>
				<td><a href="${contextPath}/freeBoard/freeBoard">자유게시판</a></td>
				<td><a href="${contextPath}/policy">개인정보 처리방침</a></td>
				<td><a href="${contextPath}/admin/admin">관리자 페이지</a></td>
			</tr>
			<tr>
				<td><a href="${contextPath}/member/goJoin">회원가입</a></td>
				<td><a href="${contextPath}/party/hostingList">개설한 파티 관리</a></td>
				<td>파티상세페이지</td>
				<td><a href="${contextPath}/policy2">이용약관</a></td>
				<td></td>
			</tr>
			<tr>
				<td><a href="${contextPath}" onclick="loginModalShow();">로그인</a></td>
				<td><a href="${contextPath}/party/myParty">참여중인 파티</a></td>
				<td>파티 게시판</td>
				<td><a href="${contextPath}/infomation">세부정보</a></td>
				<td></td>
			</tr>
			<tr>
				<td><a href="${contextPath}/location/map">지도확인</a></td>
				<td><a href="${contextPath}/wishlist/wishlist">위시리스트</a></td>
				<td>파티 채팅</td>
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
				<td><a href="${contextPath}/member/profileModify">계정 설정</a></td>
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
				<td><a href="${contextPath}/friend">친구 리스트</a></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
	</div>
<script>
	function loginModalShow(){
		$("#loginModal").modal("show");
	}
</script>
</body>
</html>