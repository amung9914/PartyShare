<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<c:set var="loginMember" value="${sessionScope.loginMember}" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- loginMember 값이 없을 때 -->
<c:if test="${empty loginMember}">
    <script>
    	alert('로그인을 하셔야 이용가능합니다.');
    	location.href = '${contextPath}/login';
    </script>
</c:if>
<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeBoardWrite.jsp</title> -->
<style>
	@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100&family=Noto+Sans+KR:wght@300&display=swap');
    * {margin: 0; padding: 0; font-family: 'Hahmlet', serif; font-family: 'Noto Sans KR', sans-serif;}

	form {
		margin: 0 auto;
		margin-bottom: 160px;
		width: 679px;
	}
	
	#title {
		width: 100%;
		height: 35px;
		padding: 32px 15px;
		margin-top: 20px;
		margin-bottom: 20px;
		border: none;
		border-bottom: 1px solid lightgray;
		font-size: 30px;
		outline: none;
	}
	
	#context {
		width: 100%;
	}
	
	.container {
	    display: flex; 
	    width: 100%;
	    justify-content: space-between; 
	    align-items: center; 
	}
	
	 .write {
    	width: 100px;
	    height: 35px;
	    border-radius: 10px;
	    font-weight: bold;
	    border: none;
	    background-color: #FF385C;
	    color: white;
	    cursor: pointer;
	    font-size: 16px;
    }
    
    .write:hover {
    	background-color: #FF6666;
    }
    
    .back {
   		width: 100px;
	    height: 35px;
	    border-radius: 10px;
	    font-weight: bold;
	    border: none;
	    background-color: #F5F5F5;
	    color: black;
	    cursor: pointer;
	    font-size: 16px;
    }
    
    .back:hover {
    	background-color: #DADADA;
    }
</style>
</head>
<body>
	<form action="${contextPath}/user/freeBoard/freeBoardWrite" method="POST">
		<input type="hidden" name="mnick" value="${loginMember.mnick}" />
		<input type="hidden" name="mid" value="${loginMember.mid}" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<!-- <input type="hidden" name="viewCnt" value=0 /> -->
		<c:choose>
			<c:when test="${loginMember.mid eq 'admin'}">
				카테고리 : <input type="radio" name="category" value="공지" checked/> 공지
						 <input type="radio" name="category" value="일반" /> 일반 <br/>
			</c:when>
			<c:otherwise>
				카테고리 : <input type="radio" name="category" value="공지" disabled/> 공지
						 <input type="radio" name="category" value="일반" checked/> 일반 <br/>
			</c:otherwise>
		</c:choose>
		<input id="title" type="text" name="title" placeholder="제목을 입력하세요." required/> <br/>
		<textarea id="context" name="context" cols="100" rows="10"></textarea> <br/>
		<div class="container">
			<input class="back" onclick="back()" type="button" value="뒤로가기"/>
			<input type="submit" class="write" value="글 작성"/>
		</div>
	</form>
	<script>
		function back(){
			history.back();
		}
	</script>
	<script src="https://cdn.tiny.cloud/1/av7h5dlwrzjn7ho0gzec0tvmepza55h6sfs7attnmohrhwhd/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
	<script>
		let plugins = ["link", "image"];
		let edit_toolbar = "link image forecolor backcolor";
	
	    tinymce.init({
	      language : "ko_KR",
	      selector: '#context',
	      width : 681,
	      height : 500,
	      menubar : false,
	      plugins: plugins,
	      toolbar: edit_toolbar,
	      /* enable title field in the Image dialog*/
	      image_title: true,
	      /* enable automatic uploads of images represented by blob or data URIs*/
	      automatic_uploads: true,
	      /*
	        URL of our upload handler (for more details check: https://www.tiny.cloud/docs/configure/file-image-upload/#images_upload_url)
	        images_upload_url: 'postAcceptor.php',
	        here we add custom filepicker only to Image dialog
	      */
	      file_picker_types: 'image',
	      /* and here's our custom image picker*/
	      file_picker_callback: (cb, value, meta) => {
	        const input = document.createElement('input');
	        input.setAttribute('type', 'file');
	        input.setAttribute('accept', 'image/*');

	        input.addEventListener('change', (e) => {
	          const file = e.target.files[0];

	          const reader = new FileReader();
	          reader.addEventListener('load', () => {
	            /*
	              Note: Now we need to register the blob in TinyMCEs image blob
	              registry. In the next release this part hopefully won't be
	              necessary, as we are looking to handle it internally.
	            */
	            const id = 'blobid' + (new Date()).getTime();
	            const blobCache =  tinymce.activeEditor.editorUpload.blobCache;
	            const base64 = reader.result.split(',')[1];
	            const blobInfo = blobCache.create(id, file, base64);
	            blobCache.add(blobInfo);

	            /* call the callback and populate the Title field with the file name */
	            cb(blobInfo.blobUri(), { title: file.name });
	          });
	          reader.readAsDataURL(file);
	        });

	        input.click();
	      },
	      content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:16px }'
	    });
  	</script>
<!-- </body>
</html> -->
<%@ include file="../common/fixFooter.jsp" %>