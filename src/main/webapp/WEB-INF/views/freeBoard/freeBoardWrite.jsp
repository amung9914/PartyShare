<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="loginMember" value="${sessionScope.loginMember}" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- loginMember 값이 없을 때 -->
<c:if test="${empty loginMember}">
    <script>
    	alert('로그인을 하셔야 이용가능합니다.');
    	location.href = '${contextPath}/login';
    </script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeBoardWrite.jsp</title>
</head>
<body>
	<h1>글 작성</h1>
	<form action="${contextPath}/freeBoard/freeBoardWrite" method="POST">
		<input type="hidden" name="mnick" value="${loginMember.mnick}" />
		<input type="hidden" name="mid" value="${loginMember.mid}" />
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
		제목 : <input type="text" name="title" /> <br/>
		내용 : <textarea id="context" name="context" cols="30" rows="10"></textarea> <br/>
		<input type="submit" value="글 작성">
	</form>
	<script src="https://cdn.tiny.cloud/1/av7h5dlwrzjn7ho0gzec0tvmepza55h6sfs7attnmohrhwhd/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
	<script>
		let plugins = ["link", "image"];
		let edit_toolbar = "link image forecolor backcolor";
	
	    tinymce.init({
	      language : "ko_KR",
	      selector: '#context',
	      width : 600,
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
</body>
</html>