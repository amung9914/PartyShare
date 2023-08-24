<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bookingParty.jsp</title>
</head>
<body>
	<h1>파티 예약하기</h1>
	<h3>파티 정보</h3>
	<h5>파티 이름</h5>
	${vo.pname}
	<h5>날짜</h5>
	${startDate}
	<c:if test="${endDate ne null}">
		- ${endDate}
	</c:if>
	<h5>장소</h5>
	${vo.sido} ${vo.sigungu} ${vo.address} ${vo.detailAddress}
	<br/><br/><br/><br/>
	<form action="${contextPath}/partyDetail/bookingComplete" method="POST">
		<input type="hidden" name="pNum" value="${vo.pnum}" /> 
		<input type="submit" value="예약하기" onclick="checkLoginAndSubmit()" />
	</form>
	
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