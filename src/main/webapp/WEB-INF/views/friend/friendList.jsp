<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="../common/header.jsp" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style>
html, body {
    height: 100%
}

#wrap {
    min-height: 100%;
    position: relative;
    padding-bottom: 93px;
    margin: 0px 0px 100px 0px;
}
main{
	float:left;
	margin: 30px 0px 0px 100px; 
}
aside{
	float:left;
	margin : 30px;
}
 .delBtn{
 	float:right;
 }
 .card li label{
     cursor: pointer;}
 .profileImg{
 		width:100px;
		height:100px;
		border-radius:50px;
		border:1px solid #ccc;
	}
 .cardBox{
 	display: inline-flex;
    align-items: center;
    margin:10px;
 }
  div.info{
    margin:10px;
 }
 .detailLoad{
 	cursor:pointer;
 }
 #previousView{
 margin: 10px 10px 200px 10px;
 }
 .result{
 margin: 0px 0px 200px 0px;
 }
 
 body img{
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
 .partyView{
 	margin: 10px;
 }
 h5 .btn-close{
 	float:right;
 }
</style>
</head>
<body>
<div id="wrap">
<div class="mainBox">
<main>
<h3>친구 목록</h3>
<hr/>	
<div class="card" style="width: 420px;">
  <ul class="list-group list-group-flush">
  	<c:choose>
  	<c:when test="${!empty list}">
	    <c:forEach var="list" items="${list}">

		   	<li class="list-group-item ${list.fto}">
		   		<div class="cardBox detailLoad" data-mnum="${list.fto}" data-mid="${list.mid}" >
			   		<img class="profileImg" src="${path}/user/friend/printImg?fileName=${list.profileImageName}" />
			   		<div class="info">
			   			<h5>${list.mnick}</h5>
			   			<p class="card-text">${list.mid}</p>
			   		</div>
		   		</div>
		  		 <button type="button" class="btn btn-light delBtn" id="${list.fto}">친구삭제</button>
		   	</li>
	    </c:forEach>
    </c:when>
    <c:otherwise>
    	<li class="list-group-item">아직 친구가 없습니다.</li>
    </c:otherwise>
    </c:choose>
  </ul>
</div>
<div class="partyView" id="ongoingView" style="display:none;">
</div>
<div class="partyView" id="previousView" style="display:none;">
</div>
<script>

// 파티정보 화면 닫기버튼
$(".partyView").on("click",".btn-close",function(){
	$("#ongoingView").toggle("slow");
	$("#previousView").toggle("slow");
})

// 친구목록에 있는 친구 정보 클릭시 상대방의 파티정보를 출력합니다.
$(".detailLoad").on("click",function(){
	const mnum = $(this).attr('data-mnum');
	const mid = $(this).attr('data-mid');
	ongoingParty();
	previousParty();
	
	// 친구의 진행중인 파티정보를 가져온다
	function ongoingParty(){
		let url="${path}/user/friend/ongoingParty/"+mnum;
		$.getJSON(url,function(data){
			
			$("#ongoingView").toggle("slow");
			let str = "";
			
			if(data.length != 0){
				// 반복문으로 검색결과를 페이지에 표시
				// 버튼에 data-mnum속성으로 mnum을 넣어줍니다. 
				str += "<h5>"+mid+"님이 참여중인 공간입니다<button type='button' class='btn-close' aria-label='Close'></button></h5>";
				 $(data).each(function(){
					
					 //String을 date로 변환
					const startToDate = new Date(this.startDate);
					const endToDate = new Date(this.endDate);
					// 년월일 포맷으로 변환
					const koDF = new Intl.DateTimeFormat("ko", {dateStyle: "long"});
					const startDate = koDF.format(startToDate);
					const endDate = koDF.format(endToDate);
					
					$("#ongoingView").empty();
					
					str +="<div class='card mb-3' style='max-width: 400px;'>";
					str +=	"<div class='row g-0 detailBox' data-pnum='"+this.pnum+"' >";
					str +=		"<div class='col-md-4'>";
					str +=			"<img src='${path}/party/printImg?fileName="+this.partyImage1+"' class='img-fluid rounded-start' >";
					str +=		"</div>";
					str +=		"<div class='col-md-8'>";
					str +=			"<div class='card-body'>";
					str +=				"<h5 class='card-title'>"+this.pname+"</h5>";
					str +=				"<p class='card-text'>"+this.sido+"</p>";
					str +=				"<p class='card-text'><small class='text-body-secondary'>"+startDate+"~"+endDate+"</small></p>";
					str +=			"</div>";
					str +=		"</div>";
					str +=	"</div>";
					str +="</div>";
					
					$("#ongoingView").append(str);
				});
				 
			}else{ // 결과가 없는 경우
				$("#ongoingView").empty();
				str = "참여중인 파티가 없습니다.";
				$("#ongoingView").append(str);
			}
		});
	} // end ongoingParty()
	
	//DB에서 친구의 파티정보를 가져온다
	function previousParty(){
		let url="${path}/user/friend/previousParty/"+mnum;
		$.getJSON(url,function(data){
			
			$("#previousView").toggle("slow");
			let str = "";
			
			if(data.length != 0){
				// 반복문으로 검색결과를 페이지에 표시
				// 버튼에 data-mnum속성으로 mnum을 넣어줍니다. 
				str += "<h5>"+mid+"님이 함께했던 공간입니다</h5>";
				 $(data).each(function(){
					 $("#previousView").empty();
					 //String을 date로 변환
					const startToDate = new Date(this.startDate);
					const endToDate = new Date(this.endDate);
					// 년월일 포맷으로 변환
					const koDF = new Intl.DateTimeFormat("ko", {dateStyle: "long"});
					const startDate = koDF.format(startToDate);
					const endDate = koDF.format(endToDate);
					
					str +="<div class='card mb-3' style='max-width: 400px;'>";
					str +=	"<div class='row g-0 detailBox' data-pnum='"+this.pnum+"' >";
					str +=		"<div class='col-md-4'>";
					str +=			"<img src='${path}/party/printImg?fileName="+this.partyImage1+"' class='img-fluid rounded-start' >";
					str +=		"</div>";
					str +=		"<div class='col-md-8'>";
					str +=			"<div class='card-body'>";
					str +=				"<h5 class='card-title'>"+this.pname+"</h5>";
					str +=				"<p class='card-text'>"+this.sido+"</p>";
					str +=				"<p class='card-text'><small class='text-body-secondary'>"+startDate+"~"+endDate+"</small></p>";
					str +=			"</div>";
					str +=		"</div>";
					str +=	"</div>";
					str +="</div>";
					
					$("#previousView").append(str);
					
				 });
			}else{ // 결과가 없는 경우
				$("#previousView").empty();
				str = "참여한 파티가 없습니다.";
				$("#previousView").append(str);
			}	
			
		});
	}
}); // label 클릭 이벤트 끝 

// 파티정보 클릭 이벤트 - 상세페이지로 새창열기 
$(".partyView").on("click",".detailBox",function(){
	const pnum = $(this).attr('data-pnum');
	const href= "<c:url value='/partyDetail/detailOfParty?pNum="+pnum+"'/>";
	window.open(href);
});

// 친구삭제 처리
$(".delBtn").on("click",function(){
	const mnum = $(this).attr('id');
	const area = document.getElementsByClassName(mnum);
	
	$.ajax({
		type : "DELETE",
		url : "${path}/user/friend/deleteFriend/"+mnum,
		dataType: "text",
		success : function(result){
			alert(result);
			area[0].remove();
		},
		error : function(result){
			alert(result);
		}
	});
	
});

</script>
</main>
<aside>
<h3> 새로운 친구를 등록해 보세요 </h3>
<%@ include file="findFriend.jsp" %>  
<hr/>
<%@ include file="requestList.jsp" %>
<hr/>
<div class="result">
<%@ include file="responseList.jsp" %>
</div>
</aside>
</div>
</div>
<%@ include file="../common/fixFooter.jsp" %>