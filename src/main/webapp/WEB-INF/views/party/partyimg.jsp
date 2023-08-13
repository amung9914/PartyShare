<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<!-- form태그 내부입니다. -->
	<!-- 사진 선택 안했을 경우 이전값 전달 -->
	<input type="hidden" name="partyImage1" value="${party.partyImage1}"> 
	<input type="hidden" name="partyImage2" value="${party.partyImage2}"> 
	<input type="hidden" name="partyImage3" value="${party.partyImage3}"> 
	<h2>파티 사진 수정</h2>
		<div>
			<img src="upload/${party.partyImage1}" id="img1"/>
			<br/>
			<input type="file" name="image1" id="partyImage1" accept=".gif, .jpg, .jpeg, .png"/>
			<button id="reset1">reset</button>
			
		</div>
		<div>
			<img src="upload/${party.partyImage2}" id="img2"/>
			<br/>
			<input type="file" name="image2" id="partyImage2" accept=".gif, .jpg, .jpeg, .png"/>
			<button id="reset2">reset</button>
		</div>
		<div>
			<img src="upload/${party.partyImage3}" id="img3"/>
			<br/>
			<input type="file" name="image3" id="partyImage3" accept=".gif, .jpg, .jpeg, .png"/>
			<button id="reset3">reset</button>
		</div> 
		
	
<script>
	// 사진 미리보기 구현
	<c:forEach var="i" begin="1" end="3">
	$("#partyImage${i}").on("change",function(){
		let files = this.files;
		let file = files[0];
		// 사용자 컴퓨터에서 사용자가 선택한 파일이 저장된 실제 위치 정보를 문자열로 반환
		let path = window.URL.createObjectURL(file);
		// 사용자 컴퓨터에 저장된 이미지 경로로 img 태그 소스 위치 정보를 수정
		$("#img${i}").attr("src",path);
	});
	</c:forEach>
	
	//다시 원래 파일로 바꾸기. 실제 처리는 controller에서 진행	
	$(document).ready(function() {
	    $("#reset1").on("click", function(event) {
	        event.preventDefault();
	        $("#img1").attr("src", "upload/${party.partyImage1}");
	    });

	    $("#reset2").on("click", function(event) {
	    	event.preventDefault();
	        $("#img2").attr("src", "upload/${party.partyImage2}");
	    });

	    $("#reset3").on("click", function(event) {
	    	event.preventDefault();
	        $("#img3").attr("src", "upload/${party.partyImage2}");
	    });
	}); 
		
</script>
</body>
</html>