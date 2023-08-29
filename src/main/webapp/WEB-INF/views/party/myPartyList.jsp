<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
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

<style>
body{
	text-align: -webkit-center;
}

 img{
    width: fit-content;
 }
 .card.mb-3{
 cursor: pointer;
 text-align: left;
 }
 .endParty{
 	color:red;
 }
 .img-fluid.rounded-start{
 	height:100%;
 }
 #menu{
 	float : left;
 	margin: 0px 30px;
 }
</style>
</head>
<body>
<div id="menu"> 	
	<h3>참여 중인 파티</h3>
<c:forEach items="${list}" var="party">
<div class="card mb-3" data-pnum="${party.pnum}" style="max-width: 540px;">
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
	      
        <a href="<c:url value='/partyBoard/listPage?pnum=${party.pnum}'/>" class="btn btn-dark">팀게시판</a>
        <button class="btn btn-light withdraw" data-pnum='${party.pnum}' data-host='${party.host}'>파티 나가기</button>
      </div>
    </div>
  </div>
</div>
</c:forEach>
</div>
<%@ include file="calender.jsp" %>
<script>

$(".card.mb-3").on("click",function(){
	const pnum = $(this).attr("data-pnum");
	location.href="<c:url value='/partyDetail/detailOfParty?pNum="+pnum+"'/>";
});

$(".endParty").closest(".card.mb-3").css("background-color","lightgray");
</script>

<script>
//파티탈퇴요청
$(".withdraw").click(function(e){
	e.preventDefault();
	// pnum가지고 오기
	const pnum = $(this).attr("data-pnum");
	const host = $(this).attr("data-host");
	console.log()
	
	let conf = confirm("정말로 파티를 나가시겠습니까?");
	if(conf){

	// 호스트는 탈퇴할 수 없음
	if(host == ${loginMember.mnum}){
		alert("호스트는 탈퇴할 수 없습니다.");
		$(".card.mb-3").remove();
		location.href="<c:url value='/party/myParty'/>";		
	}else{

		//ajax 통신
		$.ajax({
			type : "DELETE",
			url : "${path}/party/withdraw/"+pnum,
			dataType:"text",
			success : function(result){
				alert(result);
				location.href="<c:url value='/party/myParty'/>";
			},
			error: function(result){
				alert("실패하였습니다");
			}	
			
		});	
	}
	
	}
	
});
</script>

</body>
</html>