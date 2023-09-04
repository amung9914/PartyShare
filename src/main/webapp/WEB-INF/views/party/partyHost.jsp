<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<link href="${path}/resources/css/sy/partyHost.css" rel="stylesheet"/>
<%@ include file="../common/header.jsp" %>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>


  <div id="wrap">
  <div class="card mb-3" style="max-width: 540px;">
  <div class="row g-0">
    <div class="col-md-4">
      <img src="${path}/party/printImg?fileName=${party.partyImage1}" class="img-fluid rounded-start" >
    </div>
    <div class="col-md-8">
      <div class="card-body">
	        <h5 class="card-title">
	        ${party.pname}
	        <c:if test="${party.finish eq 'Y'}">
	        <div class="endParty"><small>(종료)</small></div>
	        </c:if>
	        </h5>
	        <p class="card-text">${party.address}
        	<c:if test="${!empty party.detailAddress}">
        	,${party.detailAddress}
        	</c:if>
        	</p>
	        <p class="card-text"><small class="text-body-secondary">${party.formatStartDate} ~ ${party.formatEndDate} </small></p>
	      
	      <a href="<c:url value='/host/party/updateParty?pnum=${party.pnum}'/>" class="btn btn-dark">파티 정보 수정</a>
      </div>
    </div>
  </div>
</div>
	<%@ include file="partyAdmin.jsp" %>

	<!-- 파티 강퇴자를 위한 알림 -->
	<script>
	var result = '${result}';
	if(result != null && result != ''){
	alert(result);
	}
	</script>
</div>	
<%@ include file="../common/footer.jsp" %>