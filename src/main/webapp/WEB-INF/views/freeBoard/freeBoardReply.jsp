<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="loginMember" value="${sessionScope.loginMember}" />
<!-- loginMember 값이 없을 때 -->
<c:if test="${empty loginMember}">
    <script>
    	alert('로그인을 하셔야 이용가능합니다.');
    	location.href = 'login';
    </script>
</c:if>
<c:if test="${board.category ne '일반'}">
	<script>
    	alert('답변은 일반글에만 작성할 수 있습니다.');
    	history.back();
    </script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeBoardReply.jsp</title>
</head>
<body>
	<h1>답변글 작성</h1>
	<form action="${contextPath}/freeBoard/freeBoardReply" method="POST">
		<input type="hidden" name="category" value="${board.category}"/>
		<input type="hidden" name="mid" value="${loginMember.mid}"/>
		<input type="hidden" name="mnick" value="${loginMember.mnick}"/>
		<input type="hidden" name="origin" value="${board.origin}"/>
		<input type="hidden" name="depth" value="${board.depth}"/>
		<input type="hidden" name="seq" value="${board.seq}"/>
		<div>
			<label>제목</label>
			<input type="text" name="title" required />
		</div>
		<div>
			<label>내용</label>
			<textarea id="context" name="context" rows=3></textarea>
		</div>
		<div>	
			<input type="submit" value="답변 등록"/>
			<!-- <a href="freeBoard?page=${criteria.page}&perPageNum=${criteria.perPageNum}">목록</a> -->
		</div>
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