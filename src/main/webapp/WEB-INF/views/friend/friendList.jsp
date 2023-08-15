<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>

</head>
<body>
<jsp:include page="findFriend.jsp"/>

<a href="friend/responseList">받은요청</a>
<a href="friend/requestList">보낸요청</a>
<h3>[친구 목록]</h3>	
<div class="card" style="width: 18rem;">
  <ul class="list-group list-group-flush">
  	<c:choose>
  	<c:when test="${!empty list}">
	    <c:forEach var="list" items="${list}">
		   	 <li class="list-group-item ${list.fto}">${list.mid} / ${list.mnick}
		    	<button type="button" class="btn btn-warning" id="${list.fto}">친구삭제</button>
		   	 </li>
	    </c:forEach>
    </c:when>
    <c:otherwise>
    	<li class="list-group-item">아직 친구가 없습니다.</li>
    </c:otherwise>
    </c:choose>
  </ul>
</div>

</body>
</html>