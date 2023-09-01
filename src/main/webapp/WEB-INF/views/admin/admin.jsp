<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%@ include file="../common/header.jsp" %>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="${path}/resources/css/in/admin/admin.css" rel="stylesheet"/>
<div id="wrap">
	<%-- <a href="<c:url value='/admin/notice'/>">SIGN UP </a> <br/>
	<a href="<c:url value='/admin/notice'/>"> 공지 쓰러가기 </a> <br/>
	<a href="/project/admin/notice">이걸로 공지 쓰러가기</a> --%>
	<%-- <a href="<c:url value='/admin/admin_notice'/>">공지쓰러가기</a> --%>
	<!-- <div id="dateModal">나중에 date관리창이 modal로 출력됨</div> -->
	
	<button class="btn btn-outline-dark" id="modifySearchOpt">검색엔진 관리하기</button>
	
	<button class="btn btn-outline-dark" id="notice">알림 페이지</button>
	
	<button class="btn btn-outline-dark" id="reportPage">신고 페이지</button>
	 
	<br/>

	<button class="btn btn-outline-dark" id="home">홈화면</button>
	<button class="btn btn-outline-dark" id="user_list">모든 유저 목록</button>
	
	<button class="btn btn-outline-dark" id="blackList">블랙리스트 페이지</button>
	</div>
	
	<!-- 유저목록 테이블 생성  -->
	
	
	
	<script>
	/* READY OPTION */
	$(document).ready(function () {
	
		
		$("#user_list").click(function () {
			location.href = '<c:url value="/admin/user_list"/>';
		});
		
		$("#home").click(function(){
			location.href = '<c:url value="/"/>';
		})
		
		$("#modifySearchOpt").click(function () {
			location.href = '<c:url value="/admin/modifySearchOpt"/>';
		});
		
		$("#notice").click(function () {
			location.href = '<c:url value="/admin/notice"/>';
		});
		
		$("#reportPage").click(function () {
			location.href = '<c:url value="/admin/admin_report"/>';
		});
		
		$("#blackList").click(function () {
			location.href = '<c:url value="/admin/blacklist"/>';
		});
		
		$("#modifyInterval").click(function () {
			window.location.href = '<c:url value="/search/modifyInterval"/>';
		});
		
	
	}); // docu
	</script>
</div>
<%@ include file="../common/footer.jsp" %>