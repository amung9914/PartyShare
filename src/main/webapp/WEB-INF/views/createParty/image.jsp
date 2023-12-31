<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="../common/header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link href="${path}/resources/css/ksg/createParty.css" rel="stylesheet"/>
<style>
	.mainImage .img_cover > label{
	display:inline-block;
	background-image:url('${path}/resources/img/plus_icon.png');
	background-size:150px;
	background-repeat:no-repeat;
	width: 150px;
	height: 150px;
	margin-top:35%;
}	

.subImage .img_cover > label{
	display:inline-block;
	background-image:url('${path}/resources/img/plus_icon.png');
	background-size:150px;
	background-repeat:no-repeat;
	width: 150px;
	height: 150px;
	margin-top:20%;	
}	
</style>

<div id="createParty_wrap">
	<h1 id="title">대표 사진 업로드</h1>
	<form action="createImage" method="POST" enctype="multipart/form-data">
    	<input type="hidden" name="host" value="${loginMember.mnum}"/>
		<input type="hidden" name="description" value="${vo.description}" />
		<input type="hidden" name="category" value="${vo.category}" />
		<input type="hidden" name="address" value="${vo.address}">
		<input type="hidden" name="sido" value="${vo.sido}">
		<input type="hidden" name="sigungu" value="${vo.sigungu}">
		<input type="hidden" name="detailAddress" value="${vo.detailAddress}">
		<input type="hidden" id="lat" name="lat" value="${mapVO.lat}">
    	<input type="hidden" id="lng" name="lng" value="${mapVO.lng}">
    	<input type="hidden" name="startDate" value="${vo.startDate}" />
		<input type="hidden" name="endDate" value="${vo.endDate}" />
		<input type="hidden" name="pname" value="${vo.pname}" />
		<input type="hidden" name="pcontext" value='${vo.pcontext}' />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		
		<div id="imgBox">
			<div class="img_wrap mainImage">
				<div class="img_cover" >
					<label for="imgInput1"></label>
					<input type="file" class="img_file" id="imgInput1" name="image1" accept=".gif, .jpg, .jpeg, .png" />
				</div>
				<img class="preview"/>
			</div>
			<div class="img_wrap subImage">
				<div class="img_cover">
					<label for="imgInput2"></label>
					<input type="file" class="img_file" id="imgInput2" name="image2" accept=".gif, .jpg, .jpeg, .png" />
				</div>
				<img class="preview" />
			</div>
			<div class="img_wrap subImage">
				<div class="img_cover">
					<label for="imgInput3"></label>
					<input type="file" class="img_file" id="imgInput3" name="image3" accept=".gif, .jpg, .jpeg, .png" />
				</div>
				<img class="preview" />
			</div>
			<!-- onchange="readURL(this)" -->
		</div>
	</form>
</div>
	<script>
	function readURL(input) {
		let previews = document.querySelectorAll(".preview");
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      if(input.id == 'imgInput1'){
		    	  previews[0].src = e.target.result;
		    	  $("#imgInput1").closest("div").children("label").css('background-image','url()');
		      }else if(input.id == 'imgInput2'){
		    	  previews[1].src = e.target.result;
		    	  $("#imgInput2").closest("div").children("label").css('background-image','url()');
		      }else{
		    	  previews[2].src = e.target.result;
		    	  $("#imgInput3").closest("div").children("label").css('background-image','url()');
		      }
		      
		    };
		    reader.readAsDataURL(input.files[0]);
		  } else {
			  if(input.id == 'imgInput1'){
		    	  previews[0].src = "";	  
		    	  $("#imgInput1").closest("div").children("label").css('background-image','url(${path}/resources/img/plus_icon.png)');
		      }else if(input.id == 'imgInput2'){
		    	  previews[1].src = "";
		    	  $("#imgInput1").closest("div").children("label").css('background-image','url(${path}/resources/img/plus_icon.png)');
		      }else{
		    	  previews[2].src = "";
		    	  $("#imgInput1").closest("div").children("label").css('background-image','url(${path}/resources/img/plus_icon.png)');
		      }
		  }
		}
		$("#imgInput1").on("change", function(){
			if(!checkImg(this)){
				alert('이미지 파일을 선택해주세요.');
				$("#imgInput1").attr('src', "");
				$(".preview").first().attr('src', "");
				$("#imgInput1").closest("div").children("label").css('background-image','url(${path}/resources/img/plus_icon.png)');
			}else{
				readURL(this);
			}
		});
		$("#imgInput2").on("change", function(){
			if(!checkImg(this)){
				alert('이미지 파일을 선택해주세요.');
				$("#imgInput2").attr('src', "");
				$(".preview").eq(1).attr('src', "");
				$("#imgInput2").closest("div").children("label").css('background-image','url(${path}/resources/img/plus_icon.png)');
			}else{
				readURL(this);
			}
		});
		$("#imgInput3").on("change", function(){
			if(!checkImg(this)){
				alert('이미지 파일을 선택해주세요.');
				$("#imgInput3").attr('src', "");
				$(".preview").last().attr('src', "");
				$("#imgInput3").closest("div").children("label").css('background-image','url(${path}/resources/img/plus_icon.png)');
			}else{
				readURL(this);
			}
		});
		
		
		function checkImg(img){
			let files = img.files;
			let imgs = ['jpg','jpeg','png','gif'];
			for(let i = 0; i < imgs.length; i++){
				if(files[0].name.toLowerCase().endsWith(imgs[i])){
					return true;		
				}
			}
			return false;
		}
</script>
<%@ include file="partyCreateFooter.jsp" %>
