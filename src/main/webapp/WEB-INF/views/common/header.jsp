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
		height: 80px;
		display: flex;
		flex-wrap: wrap;
		margin-top:2%;
	}
	#logoBox{
		width: 10%;
		height: 80px;
		margin-left: 3%;
	}
	#header_searchBox{
		width: 300px;
		height: 80px;
		margin-left: 25%;
		text-align: center;
		line-height: 80px;
	}
	#header_searchBox .searchContainer{
		display: flex;
		flex-wrap: wrap;
	}
	#header_searchBox #searchKeyword{
		width: 80%;
		height: 50px;
		outline: none;
		border: 1px solid black;
		border-radius: 50px;
	}
	#searchImg{
		width: 50px;
		height:50px;
		border-radius: 25px;
	}
	#header_freeBoardDiv{
		width: 7%;
		height: 80px;
		margin-left: 7%;
		line-height: 50px;
	}
	#header_loginBox{
		width: 10%;
		height: 80px;
		margin-left: 10%;
		
	}
	#header_menuDiv{
		width:3%;
		height: 80px;
		margin-left: 2%;
		line-height: 50px;
	}
	#menuBtn{
		border: none;
		background-color: white;
	}
	
	#menuBtn, #menuBtn img{
		width: 30px;
		height : 30px;
	}
	#menuBtn img{
		position: relative;
		right: 12px;
		bottom: 5px;
	}
</style>
<title>partyShare</title>
</head>
<body>
	<div id="headerBox">
		<div id="logoBox">
		
		</div>
		<div id="header_searchBox">
			<div class="searchContainer">
		      <input type="text" id="searchKeyword"  oninput="keywordSearch()">
		      <img src="${path}/resources/img/search.png" id="searchImg"/>
		    </div>
		</div>
		<div id="header_freeBoardDiv">
			<button type="button" class="btn btn-outline-dark" onclick="location.href='${path}/freeboard/fredboard';">자유게시판</button>
		</div>
		<div id="header_loginBox">
			
		</div>
		
		<div id="header_menuDiv">
			<div class="dropdown-center">
			  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" id="menuBtn" aria-expanded="false">
			  		<img src="${path}/resources/img/menu.png"/>
			  </button>
			  <ul class="dropdown-menu">
			    <li><%@ include file="../member/login.jsp" %></li>
			    <li><a class="dropdown-item" href="#">Another action</a></li>
			    <li><a class="dropdown-item" href="#">Something else here</a></li>
			  </ul>
			</div>
		</div>
	</div>
	<hr/>
<br/>

<%@ include file="search.jsp" %>