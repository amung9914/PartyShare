<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개설한 파티 관리</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style>
 img{
 	height: 100px;
    width: fit-content;
 }
</style>
</head>
<body>
	<h3>파티 관리</h3>
	
	<div class="col">
    <div class="card">
      <img src="${path}/party/printImg?fileName=${party.partyImage1}" />
      <div class="card-body">
     
        <h5 class="card-title">파티이름 : ${party.pname}</h5>
        	<p class="card-text">
       
        	날짜 : 
        	${party.formatStartDate} ~ ${party.formatEndDate} <br/>
        	장소 : ${party.address}
        	<c:if test="${!empty party.detailAddress}">
        	,${party.detailAddress}
        	</c:if>
        	
        	</p>
        	
        <a href="<c:url value='/party/updateParty?pnum=${party.pnum}'/>">파티 정보 수정</a>
      </div>
    </div>
  </div>
  
	
	<div>파티원 관리</div>
	<div>파티끝</div>
	
	<script>
	var result = '${result}';
	if(result != null && result != ''){
	alert(result);
	}
	</script>
</body>
</html>