<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bookingParty.jsp</title>
<link href="${contextPath}/resources/css/jinlee/bookingParty.css" rel="stylesheet">
</head>
<body>
	<div id="bookingParty">
		<div class="bookingParty-title">
			<h1>파티 참여하기</h1>
			<img src="${contextPath}/image/printPartyImage?fileName=${f:replace(vo.partyImage1, 's_', '')}" style="width: 95%;"/>
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
			<input type="submit" id="bookingBtn" value="참여하기" onclick="checkLoginAndSubmit()" />
			<input type="button" id="backBtn" value="뒤로가기" onclick="history.back()" />
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