<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
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
<style>
 .detailBox{
 border: 1px solid black;}
 .card li label{
     cursor: pointer;}
</style>
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
	    <!-- 나중에 label에 프로필 사진 추가할 예정 -->
		   	<li class="list-group-item ${list.fto}">
		   		<label class="detailLoad" data-mnum="${list.fto}" data-mid="${list.mid}" >${list.mid} / ${list.mnick}</label>
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
<div class="card" id="ongoingView" style="display:none;">
</div>
<div class="card" id="previousView" style="display:none;">
</div>
<script>
$(".detailLoad").on("click",function(){
	const mnum = $(this).attr('data-mnum');
	const mid = $(this).attr('data-mid');
	ongoingParty();
	previousParty();
	
	// 친구의 진행중인 파티정보를 가져온다
	function ongoingParty(){
		let url="friend/ongoingParty/"+mnum;
		$.getJSON(url,function(data){
			
			$("#ongoingView").toggle("slow");
			let str = "";
			
			if(data.length != 0){
				// 반복문으로 검색결과를 페이지에 표시
				// 버튼에 data-mnum속성으로 mnum을 넣어줍니다. 
				str += mid+"님이 참여중인 파티 <br/>";
				 $(data).each(function(){
					
					 //String을 date로 변환
					const startToDate = new Date(this.startDate);
					const endToDate = new Date(this.endDate);
					// 년월일 포맷으로 변환
					const koDF = new Intl.DateTimeFormat("ko", {dateStyle: "long"});
					const startDate = koDF.format(startToDate);
					const endDate = koDF.format(endToDate);
					
					$("#ongoingView").empty();
					
					str +="<div data-pnum='"+this.pnum+"' class='detailBox'>";
					str += "<img src='upload/party/"+this.partyImage1+"' />";
					str += "파티이름 : "+this.pname+"<br/>";
					str += "날짜 : "+startDate+" ~ "+endDate+"<br/>";					
					str += "장소 : "+this.sido;
					str +="</div>"
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
		let url="friend/previousParty/"+mnum;
		$.getJSON(url,function(data){
			
			$("#previousView").toggle("slow");
			let str = "";
			
			if(data.length != 0){
				// 반복문으로 검색결과를 페이지에 표시
				// 버튼에 data-mnum속성으로 mnum을 넣어줍니다. 
				str += mid+"님이 참여했던 파티<br/>";
				 $(data).each(function(){
					 $("#previousView").empty();
					 //String을 date로 변환
					const startToDate = new Date(this.startDate);
					const endToDate = new Date(this.endDate);
					// 년월일 포맷으로 변환
					const koDF = new Intl.DateTimeFormat("ko", {dateStyle: "long"});
					const startDate = koDF.format(startToDate);
					const endDate = koDF.format(endToDate);
					
					
					str +="<div data-pnum='"+this.pnum+"' class='detailBox'>";
					str += "<img src='upload/party/"+this.partyImage1+"' />";
					str += "파티이름 : "+this.pname+"<br/>";
					str += "날짜 : "+startDate+" ~ "+endDate+"<br/>";					
					str += "장소 : "+this.sido;
					str +="</div>"
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

// 파티정보 클릭 이벤트 - 상세페이지로 이동 
$(".card").on("click",".detailBox",function(){
	const pnum = $(this).attr('data-pnum');
	const href= "/partyshare/partyBoard/listPage?pnum="+pnum;
	window.open(href);
});

// 친구삭제 처리
$(".btn.btn-warning").on("click",function(){
	const mnum = $(this).attr('id');
	const area = document.getElementsByClassName(mnum);
	
	$.ajax({
		type : "DELETE",
		url : "friend/deleteFriend/"+mnum,
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
</body>
</html>