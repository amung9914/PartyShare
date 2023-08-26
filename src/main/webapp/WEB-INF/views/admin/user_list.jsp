<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
#memberModal{
	display: none;
	position: fixed;
	overflow: auto;
	}
	
	.member-table {
 	 border-collapse: collapse;
 	 width: 100%;
	}

	.member-table th, .member-table td {
 	 border: 1px solid black;
	  padding: 8px;
	  text-align: center;
	}
</style>
</head>
<body>
	<button id="memberList">모든 유저 목록</button>
	
	 <br/>
	<div id="memberModal">
	<ul id="memberUl">
	
	</ul>
	</div>
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	var page = 1;
	var firstPage = 1;
	var lastPage = 1;
	
	$(document).ready(function () {

	$("#memberList").click(function list() {
			$("#memberModal").toggle("slow");
			 $.getJSON("${path}/admin/memberList/"+page, function(data) {
			        // data는 JSON으로 받은 멤버 리스트
			        console.log(data);
			        let str = "";
			        str += `<table class="member-table">`;
			        	str += `<tr>`;
			        	str += `<th>번호</th>`; //1
			        	str += `<th>ID</th>`;	//2
			        	str += `<th>pw</th>`;	//3
			        	str += `<th>이름</th>`;	//4
			        	str += `<th>닉네임</th>`;
			        	str += `<th>나이</th>`;
			        	str += `<th>성별</th>`;
			        	str += `<th>email</th>`;
			        	str += `<th>신고횟수</th>`;
			        	str += `<th>주소</th>`;
			        	str += `<th>참여</th>`;
			        	str += `<th>블랙리스트</th>`;
			        	str += `<th>탈퇴</th>`;
			        	str += `</tr>`;
			        	
			        // 받은 JSON을 객체로 사용하기 위한 처리
			        // 예를 들어, 각 멤버의 이름을 출력하는 예제
			        data.forEach(function(member) {
			        	
			        	str += `<tr>`;
			        	// 페이지 number는 각 멤버가 가진 mNum과 통일할 것
			        	str += `<td>NO:\${member.mnum}</td>`;	
			        	str += `<td>ID:\${member.mid}</td>`;
			        	str += `<td>pw:\${member.mpw}</td>`;
			        	str += `<td>이름:\${member.mname}</td>`;
			        	str += `<td>닉네임:\${member.mnick}</td>`; //5
			        	str += `<td>나이:\${member.mage}</td>`;
			        	str += `<td>성별:\${member.mgender}</td>`;
			        	str += `<td>email:\${member.memail}</td>`;
			        	str += `<td>신고횟수:\${member.mbanCnt}</td>`;
			        	str += `<td>주소:\${member.maddr}</td>`;    // 10
			        	str += `<td>참여:\${member.mjoinCnt}</td>`;
			        	str += `<td>블랙리스트:|\${member.mblackYN}</td>`;
			        	str += `<td>탈퇴:\${member.withdraw}</td>`;
			        	str += `</tr>`;
			        
			            console.log("id: " + member.mid);
			        });
			    	str += `<tr>`;
			    	str += `<td colspan='13'>`;
			    	str += `<button id='previous' onclick="previous(page)">&lt;</button>`;
				    str += '&nbsp;&nbsp;&nbsp;';
				    str += `<button id='next' onclick="next(page)">&gt;</button>`;
			    	str += `</td>`;
			    	str += `</tr>`;
			        str += `</table>`;
			        $("#memberUl").html(str);
			    });
		});
	});
		
	
	function next(page){
 		if(page != lastPage){
 			page += 1;
 		console.log(page);
 		list(page);
 		}
 		console.log(page);
 		//disableN();
 	}
 	function previous(page){
 		if(page != 1){
 			page += -1;
 		console.log(page);
 		printDescription();
 		}
 	//	disableP();
 	}
	
	</script>
</body>
</html>