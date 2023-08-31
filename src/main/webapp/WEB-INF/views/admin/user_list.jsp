<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="${path}/resources/css/in/admin/user_list.css" rel="stylesheet"/>
<%@ include file="../common/header.jsp" %>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<div id="wrap">
	<button class="btn btn-dark" id="memberList">모든 유저 목록</button>
	
	 <br/>
	<div id="memberModal">
	<ul id="memberUl">
	
	</ul>
	</div>
	
	
	<script>
	var page = 1;
	var firstPage = 1;
	var lastPage = 10;  //총 멤버 숫자로 
	
	
	$("#memberList").click(function list() {
	 	   var requestUrl = "${path}/admin/memberList/"+page;
			$("#memberModal").show();
			console.log("page : "+page);
			 $.getJSON(requestUrl, function(data) {
			        // data는 JSON으로 받은 멤버 리스트
			        console.log(data);
			        console.log(page);
			        
			        let str = "";
			        str += `<table class="table member-table">`;
			        	str += `<tr>`;
			        	str += `<th>번호</th>`; //1
			        	str += `<th>ID</th>`;	//2
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
			        	str += `<td>\${member.mnum}</td>`;	
			        	str += `<td>\${member.mid}</td>`;
			        	str += `<td>\${member.mname}</td>`;
			        	str += `<td>\${member.mnick}</td>`; //5
			        	str += `<td>\${member.mage}</td>`;
			        	str += `<td>\${member.mgender}</td>`;
			        	str += `<td>\${member.memail}</td>`;
			        	str += `<td>\${member.mbanCnt}</td>`;
			        	str += `<td>\${member.maddr}</td>`;    // 10
			        	str += `<td>\${member.mjoinCnt}</td>`;
			        	str += `<td>\${member.mblackYN}</td>`;
			        	str += `<td>\${member.withdraw}</td>`;
			        	str += `</tr>`;
			        
			            console.log("id: " + member.mid);
			        });
			    	str += `<tr>`;
			    	str += `<td colspan='13'>`;
			    	str += `<button id='previous' class="btn btn-light" onclick="previous(page)">&lt;</button>`;
				    str += '&nbsp;&nbsp;&nbsp;';
				    str += `<button id='next' class="btn btn-light" onclick="next(page)">&gt;</button>`;
			    	str += `</td>`;
			    	str += `</tr>`;
			        str += `</table>`;
			        $("#memberUl").html(str);
			    });
		});
		
	
	function next(page){
 		if(page != lastPage){
 			page += 1;
 		console.log(page);
 		 $("#memberList").click();
 		}
 	}
	
 	function previous(page){
 		if(page != 1){
 			page += -1;
 		console.log(page);
 		$("#memberList").click();
 		}
 	//	disableP();
 	}
	
	</script>
</div>
<%@ include file="../common/footer.jsp" %>