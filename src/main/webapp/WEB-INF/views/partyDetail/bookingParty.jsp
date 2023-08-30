<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bookingParty.jsp</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100&family=Noto+Sans+KR:wght@300&display=swap');
    * {margin: 0; padding: 0; font-family: 'Hahmlet', serif; font-family: 'Noto Sans KR', sans-serif;}
    
    #bookingParty{
    	margin: 50px auto;
    	width: 45%;
    	text-align: center;
    	border: 1px solid rgb(221, 221, 221);
    	border-radius: 12px;
    	padding: 24px;
    	background-color: white;
    	box-shadow: rgba(0, 0, 0, 0.12) 0px 6px 16px;
    }
    
    #bookingBtn {
		width : 50%;
		margin: 0 auto;
		margin-bottom: 20px;
		height: 50px;
		color: white;
		background-color: #FF385C;
		border: none;
		font-size: 16px;
		font-weight: bold;
		text-decoration: none;
		border-radius: 5px;
		text-align: center;
		line-height: 50px;
	}
	
	#bookingBtn:hover {
		cursor: pointer;
		background-color: #FF6666;
	}
	
	.bookingParty-title{
		padding: 20px;
	}
	
	.bookingParty-title h1{
		margin-bottom: 20px;
	}
	
	.bookingParty-title h3{
		margin-top: 10px;
	}
	
	.bookingParty-content {
		padding: 20px;
		margin-top: 20px;
		margin-bottom: 20px;
		text-align: left;
	}
</style>
</head>
<body>
	<div id="bookingParty">
		<div class="bookingParty-title">
			<h1>파티 참여하기</h1>
			<%-- <img src="${contextPath}/upload/party${vo.partyImage1}"/>  --%>
			<img src="${contextPath}/image/printPartyImage?fileName=${vo.partyImage1}"/>
			<h3>${vo.pname}</h3>
		</div>
		<hr/>
		<div class="bookingParty-content">
			<b>날짜 | </b>
			${startDate}
			<c:if test="${endDate ne null}">
				- ${endDate}
			</c:if><br/>
			<b>장소 | </b>
			${vo.sido} ${vo.sigungu} ${vo.address} ${vo.detailAddress}
		</div>
		<form action="${contextPath}/partyDetail/bookingComplete" method="POST">
			<input type="hidden" name="pNum" value="${vo.pnum}" /> 
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<input type="submit" id="bookingBtn" value="예약하기" onclick="checkLoginAndSubmit()" />
		</form>
	</div>
	
	<script>
		function checkLoginAndSubmit() {
		    var loginMember = <%= session.getAttribute("loginMember") %>;
		    
		    if (loginMember === null) {
		        alert("로그인한 멤버만 파티에 참여할 수 있습니다.");
		        history.back();
		    }
		}
	</script>
</body>
</html>