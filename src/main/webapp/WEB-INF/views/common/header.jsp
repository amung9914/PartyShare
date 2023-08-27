<!-- header.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<style>
	#headerBox{
		width: 100%;
		height: 100px;
		background-color: lightgrey;
		display: flex;
		flex-wrap: wrap;
	}
	#logBox{
		width: 10%;
		height: 100px;
		background-color: blue;
		margin-left: 3%;
	}
	#searchBox{
		width: 20%;
		height: 100px; 
		background-color: green;
		margin-left: 25%;
	}
	#header_freeBoardDiv{
		width: 10%;
		height: 100px;
		background-color: yellow;
		margin-left: 10%;
	}
	#header_menuDiv{
		width:3%;
		height: 100px;
		background-color: pink;
		margin-left: 15%;
		line-height: 100px;
	}
	#menuBtn{
		width: 100%;
	}
	#dropDownBtn{
		background-color: white;
	}
</style>
<title>partyShare</title>
</head>
<body>
	<div id="headerBox">
		<div id="logBox">
		
		</div>
		<div id="searchBox">
			
		</div>
		<div id="header_freeBoardDiv">
			<a href="${path}/freeboard/freeboard">자유게시판</a>
			<%@ include file="../member/login.jsp" %>
		</div>
		<div id="header_menuDiv">
			<div class="dropdown">
			  <button class="btn btn-secondary dropdown-toggle" id="dropDownBtn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    <img id="menuBtn" src="${path}/resources/img/menu.png"/>
			  </button>
			  <ul class="dropdown-menu">
			  	
			    <li></li>
			    <li><a class="dropdown-item" href="#">Another action</a></li>
			    <li><a class="dropdown-item" href="#">Something else here</a></li>
			  </ul>
			</div>
		</div>
		
	</div>
<br/>
<script>
	/* 로그인 해제 */
	const invalidate = '${invalidate}';
	if(invalidate != ''){
		alert(invalidate);
		location.href='<c:url value="/user/signOut"/>';
	}
</script>

