<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<meta charset="UTF-8">
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8">
<title>admin.jsp</title>

<style type="text/css">
	#dateModal{
	display: none;
	position: fixed;
	overflow: auto;
	}
	
	
	div{
	display: inline-block;
	}
</style>
</head>
<body>
<c:set var="path" value="${pageContext.request.contextPath}"/>
	<h1>${serverTime}. admin</h1>
	<%-- <a href="<c:url value='/admin/notice'/>">SIGN UP </a> <br/>
	<a href="<c:url value='/admin/notice'/>"> 공지 쓰러가기 </a> <br/>
	<a href="/project/admin/notice">이걸로 공지 쓰러가기</a> --%>
	<%-- <a href="<c:url value='/admin/admin_notice'/>">공지쓰러가기</a> --%>
	<div id="dateModal">나중에 date관리창이 modal로 출력됨</div>
	
	<div>
	<button id="modifySearchOpt">검색엔진 관리하기</button>
	</div>
	
	<div>  
	<button id="notice">알림 페이지</button>
	</div>
	
	<div>  
	<button id="reportPage">신고 페이지</button>
	</div>
	 

	<div> <br/>
	<button id="home">홈화면</button>
	<button id="user_list">모든 유저 목록</button>
	</div>
	
	<div>  
	<button id="blackList">블랙리스트 페이지</button>
	</div>
	<br/>
	
	<!-- 유저목록 테이블 생성  -->
	
	
	
	<script>
	/* READY OPTION */
	$(document).ready(function () {
	
		
		$("#user_list").click(function () {
			console.log('되는데?');
			location.href = '<c:url value="/admin/user_list"/>';
			console.log('안되노?');
		});
		
		$("#home").click(function(){
			location.href = '<c:url value="/"/>';
		})
		
		$("#modifySearchOpt").click(function () {
			console.log('되는데?');
			location.href = '<c:url value="/admin/modifySearchOpt"/>';
			console.log('안되노?');
		});
		
		$("#notice").click(function () {
			console.log('되는데?');
			location.href = '<c:url value="/admin/notice"/>';
			console.log('안되노?');
		});
		
		$("#reportPage").click(function () {
			console.log('되는데?');
			location.href = '<c:url value="/admin/admin_report"/>';
			console.log('안되노?');
		});
		
		$("#blackList").click(function () {
			console.log('되는데?');
			location.href = '<c:url value="/blacklist"/>';
			console.log('안되노?');
		});
		
		$("#modifyInterval").click(function () {
			console.log('되는데?');
			window.location.href = '<c:url value="/search/modifyInterval"/>';
			console.log('안되노?');
		});
		
	
	}); // docu
	</script>
</body>
</html>