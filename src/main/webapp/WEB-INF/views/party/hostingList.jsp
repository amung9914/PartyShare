<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개설한 파티 목록</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
</head>
<body>
<h3>${loginMember}</h3>
	개설한 파티 목록
	
<div class="row row-cols-1 row-cols-md-2 g-4">

<c:forEach items="${list}" var="party">
  <div class="col">
    <div class="card">
      <img src="..." class="card-img-top" alt="...">
      <div class="card-body">
      	<a href="partyDetail?pnum=${party.pnum}">
        <h4 class="card-title">파티이름 : ${party.pname}</h4>
        	<p class="card-text">
       
        	날짜 : 
        	${party.formatStartDate} ~ ${party.formatEndDate} <br/>
        	장소 : ${party.address}
        	<c:if test="${!empty party.detailAddress}">
        	,${party.detailAddress}
        	</c:if>
        	
        	</p>
        </a>
        <a href="partyHost?pnum=${party.pnum}">파티관리</a>
      </div>
    </div>
  </div>
  </c:forEach>
  
</div>	
</body>
</html>