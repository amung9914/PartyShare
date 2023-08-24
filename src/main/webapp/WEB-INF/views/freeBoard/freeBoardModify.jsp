<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="loginMember" value="${sessionScope.loginMember}" />
<!-- 작성자와 수정하려는 사용자의 회원정보가 다를 때 -->
<c:if test="${loginMember.mid ne freeBoardVO.mid}">
    <script>
    	alert('게시물 작성자만 수정이 가능합니다.');
    	history.back();
    </script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeBoardModify.jsp</title>
</head>
<body>
	<h1>게시글 수정</h1>
	<form action="${contextPath}/freeBoard/freeBoardModify" method="POST">
		<input type="hidden" name="bno" value="${freeBoardVO.bno}"/>
		<input type="hidden" name="page" value="${criteria.page}"/>
		<input type="hidden" name="perPageNum" value="${criteria.perPageNum}"/>
		<div>
			<label>제목</label>
			<input type="text" name="title" value="${freeBoardVO.title}" />
		</div>
		<div>
			<label>내용</label>
			<textarea id="context" name="context" rows=3>${freeBoardVO.context}</textarea>
		</div>
		<div>	
			<input type="submit" value="수정 완료"/>
			<a href="${contextPath}/freeBoard/freeBoard?page=${criteria.page}&perPageNum=${criteria.perPageNum}">목록</a>
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