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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<style>

	#headerBox{
		width: 100%;
		height: 80px;
		display: flex;
		flex-wrap: wrap;
	}
	#logoBox{
		width: 10%;
		height: 80px;
		margin-left: 3%;
	}
	
	#logoBox img{
		width: 80px;
		height: 80px;
		cursor: pointer;
	}
	
	#header_searchBox{
		width: 300px;
		height: 80px;
		margin-left: 25%;
		text-align: center;
		margin-top:1%;
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
		text-align: center;
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
		margin-top:1%;
	}
	#header_loginBox{
		width: 10%;
		height: 80px;
		margin-left: 10%;
		margin-top:1%;
		
	}
	#header_menuDiv{
		width:3%;
		height: 80px;
		margin-left: 2%;
		margin-top: 1%;
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
	#searchImg{
		cursor: pointer;
	}
	
</style>
<title>partyShare</title>
</head>
<body>
	<div id="headerBox">
		<div id="logoBox">
			<img src="${path}/resources/img/redHeart.png" onclick="location.href='${path}/'"/>
		</div>
		<div id="header_searchBox">
			<div class="searchContainer">
			<!-- oninput="keywordSearch()"> -->
		      <input type="text" id="searchKeyword" />  
		      <img src="${path}/resources/img/search.png" id="searchImg" onclick="goListPage();"/>
		    </div>
		</div>
		<div id="header_freeBoardDiv">
			<button type="button" class="btn btn-outline-secondary" onclick="location.href='${path}/freeBoard/freeBoard';">자유게시판</button>
		</div>
		<div id="header_loginBox">
			<%@ include file="../member/login.jsp" %>	
		</div>
		
		<div id="header_menuDiv">
			<div class="dropdown-center">
			  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" id="menuBtn" aria-expanded="false">
			  		<img src="${path}/resources/img/menu.png"/>
			  </button>
			  <ul class="dropdown-menu">

				  <c:choose>
				  	<c:when test="${!empty loginMember}">
                 <c:if test="${loginMember.mid eq 'admin'}">
			    	<li><a class="dropdown-item" href="${path}/admin/admin">관리자페이지</a></li>
			    </c:if>
				  		<li><a class="dropdown-item" href="${path}/member/account">계정관리</a></li>
              <li><a class="dropdown-item" href="${path}/member/bonpost">확인한 알림</a></li>
				  		<li><a class="dropdown-item" href="${path}/member/logout">로그아웃</a></li>
				  	</c:when>
				  	<c:otherwise>
				  		<li><a class="dropdown-item" href="#" onclick="loginModalShow();">로그인</a></li>
					    <li><a class="dropdown-item" href="${path}/member/goJoin">회원가입</a></li>
				  	</c:otherwise>
			  	</c:choose>

			  </ul>
			</div>
		</div>
	</div>
	<hr/>
<br/>
<c:if test="${!empty searchValue}">
	<script>
		$("#searchKeyword").val('${searchValue}');
		console.log($("#searchKeyword").val());
	</script>
</c:if>

<script>
	function goListPage(){
		const keyword = $("#searchKeyword").val();
		location.href='${path}/party/partyList?keyword='+keyword;
	}
	var page = 1;
	
	headerSearchTitle(page);
	
	function headerSearchTitle(page){
		const value= $("#searchKeyword").val();
		$.ajax({
			type:"GET",
			url:"${path}/party/searchPartyList/"+page,
			data:{
				keyword:value
			},
			success: function(data){
				searchPrintList(data);
			}
		});
	}
	function searchPrintList(data){
		let str = "";
		let wishlistPnum = [];
		if(data.wishlist != null){
			$(data.wishlist).each(function(){
				let wishPnum = this.pnum;
				wishlistPnum.push(wishPnum);
			});	
		}
		
		$(data.list).each(function(){
			let pname = this.pname;
			let address = this.address;
			let date = this.formatStartDate +"~"+ this.formatEndDate;		
			let pnum = this.pnum;
			let path = this.partyImage1;
			let detailAddress = this.detailAddress;
			
			str += '<li>';
			// wishList 받아서 fullHeart.png로 출력
			if(data.wishlist != null){
				if(wishlistPnum.indexOf(pnum) < 0){
					str += "<img src='${path}/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
				}else{
					str += "<img src='${path}/resources/img/redHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
				}
			}else{
				str += "<img src='${path}/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
			}
			str += '<img src="${path}/image/printPartyImage?fileName='+path+'" class="partyImg" onclick="partyDetail('+pnum+');">';
			str += "<hr/>";
			str += "<strong onclick='partyDetail("+pnum+");' style='cursor: pointer;'>"+pname+"</strong><br/>";
			str += address+" "+detailAddress+"<br/>";
			str += date;
			str += "</li>";
		});
		$("#partys").html(str);
	}
	$("#searchKeyword").keydown(function(event) {
	    if (event.which === 13) {
	        event.preventDefault();
	        $("#searchImg").click();
	    }
	});
	
	function loginModalShow(){
		$("#loginModal").modal("show");
	}
</script>