<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<link href="${path}/resources/css/sy/updateParty.css" rel="stylesheet"/>
<!-- form태그 내부입니다. -->
	<!-- 사진 선택 안했을 경우 이전값 전달 -->
	<input type="hidden" name="partyImage1" value="${party.partyImage1}"> 
	<input type="hidden" name="partyImage2" value="${party.partyImage2}"> 
	<input type="hidden" name="partyImage3" value="${party.partyImage3}"> 
	
	
	
		<tr>
			<td class="tdStyle" rowspan="2">대표사진</td>
			<td><img src="${path}/party/printImg?fileName=${party.partyImage1}" id="img1"/></td>
		</tr>
		<tr>
			<td>
			<div class="input-group">
			  <input type="file" class="form-control" name="image1" accept=".gif, .jpg, .jpeg, .png" id="partyImage1" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
			  <button class="btn btn-outline-secondary" type="button" id="reset1">reset</button>
			</div>
			</td>
		</tr>
		<tr>
			<td class="tdStyle" rowspan="2">사진1</td>
			<td><img src="${path}/party/printImg?fileName=${party.partyImage2}" id="img2"/></td>
		</tr>
		<tr>
			<td>
			<div class="input-group">
			  <input type="file" class="form-control" name="image2" accept=".gif, .jpg, .jpeg, .png" id="partyImage2" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
			  <button class="btn btn-outline-secondary" type="button" id="reset2">reset</button>
			</div>
			</td>
		</tr>
		<tr>
			<td class="tdStyle" rowspan="2">사진2</td>
			<td><img src="${path}/party/printImg?fileName=${party.partyImage3}" id="img3"/></td>
		</tr>
		<tr>
			<td>
			<div class="input-group">
			  <input type="file" class="form-control" name="image3" accept=".gif, .jpg, .jpeg, .png" id="partyImage3" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
			  <button class="btn btn-outline-secondary" type="button" id="reset3">reset</button>
			</div>
			</td>
		</tr>
		
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
	        $("#img1").attr("src", "${path}/party/printImg?fileName=${party.partyImage1}");
	        $("#partyImage1").val("");
	    });

	    $("#reset2").on("click", function(event) {
	    	event.preventDefault();
	        $("#img2").attr("src", "${path}/party/printImg?fileName=${party.partyImage2}");
	        $("#partyImage2").val("");
	    });

	    $("#reset3").on("click", function(event) {
	    	event.preventDefault();
	        $("#img3").attr("src", "${path}/party/printImg?fileName=${party.partyImage3}");
	        $("#partyImage3").val("");
	    });
	}); 
		
</script>
