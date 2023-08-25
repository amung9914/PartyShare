<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<meta charset="UTF-8">
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8">
<title>admin.jsp</title>

<style type="text/css">
	#dateModal{
	display: none;
	position: fixed;
	overflow: auto;
	}
	
	#memberModal{
	display: none;
	position: fixed;
	overflow: auto;
	}
</style>
</head>
<body>
<c:set var="path" value="${pageContext.request.contextPath}"/>
	<h1>${serverTime}. admin</h1>
	<%-- <a href="<c:url value='/admin/notice'/>">SIGN UP </a> <br/>
	<a href="<c:url value='/admin/notice'/>"> 공지 쓰러가기 </a> <br/>
	<a href="/project/admin/notice">이걸로 공지 쓰러가기</a> --%>
	<%-- <a href="<c:url value='/admin/admin_notice'/>">공지쓰러가기</a> --%>
	<div id="dateModal">나중에 date관리창이 modal로 출력됨</div>
	
	<div>
	<button id="modifySearchOpt">검색엔진 관리하기</button>
	</div>
	
	<div>  
	<button id="reportPage">신고 페이지</button>
	</div>

	 
	<div> 
	<button id="modifyInterval">날짜단위 수정</button> 
	</div> 

	<div> 
	<button id="map">지도수정</button>
	
	</div>
	<div> <br/>
	<button id="memberList">모든 유저 목록</button>
	<button id="home">홈화면</button>
	
	</div> <br/>
	<div id="memberModal">
	<ul id="memberUl">
	
	</ul>
	</div>
	<br/>
	
	<!-- 유저목록 테이블 생성  -->
	<h5>공지 쓰기  현재 시간:<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="formattedTime" /> </h5> <br/>
	<form>
		<textarea id="context"></textarea> <br/>
		<button type="button" id="registPost">공지 올리기</button>
	</form>
	
	
	<script>
	/* READY OPTION */
	$(document).ready(function () {
		$("#registPost").click(function () {
			let context = $("#context").val();
			$.ajax({
				url:'${path}/notice/sendPost',
				type: 'post',
				data:{context : context},
				dataType: 'text',
				success: function (response) {
					alert(response);
					 $("#context").val("");
				},
				error: function (err) {
					alert(err);
				}
				
			});
		});
		
		$("#home").click(function(){
			location.href = '<c:url value="/"/>';
		})
		
		$("#modifySearchOpt").click(function () {
			console.log('되는데?');
			location.href = '<c:url value="/search/modifySearchOpt"/>';
			console.log('안되노?');
		});
		
		$("#reportPage").click(function () {
			console.log('되는데?');
			location.href = '<c:url value="/report/admin_report"/>';
			console.log('안되노?');
		});
		
		
		$("#modifyInterval").click(function () {
			console.log('되는데?');
			window.location.href = '<c:url value="/search/modifyInterval"/>';
			console.log('안되노?');
		});
		
		$("#memberList").click(function () {
			$("#memberModal").toggle("slow");
			 $.getJSON("${path}/admin/memberList", function(data) {
			        // data는 JSON으로 받은 멤버 리스트
			        console.log(data);
			        let str = "";
			        
			        // 받은 JSON을 객체로 사용하기 위한 처리
			        // 예를 들어, 각 멤버의 이름을 출력하는 예제
			        data.forEach(function(member) {
			        	// 페이지 number는 각 멤버가 가진 mNum과 통일할 것
			        	str += `<li>NO:\${member.mnum}|ID:\${member.mid}|pw:\${member.mpw}|이름:\${member.mname}|`;
			        	str += `닉네임:\${member.mnick}|나이:\${member.mage}|성별:\${member.mgender}|`;
			        	str += `email:\${member.memail}|신고횟수:\${member.mbanCnt}|주소:\${member.maddr}|참여:\${member.mjoinCnt}`;
			        	str += `블랙리스트:|\${member.mblackYN}|탈퇴:\${member.withdraw}</li>`;
			            console.log("id: " + member.mid);
			        });
			        $("#memberUl").html(str);
			    });
		});
	}); // docu
	</script>
</body>
</html>