<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register.jsp</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <!-- Editor's Style -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<style>
#title{
    border: 1px solid white;
    border-bottom: 1px solid black;
}

</style>
</head>
<body>
	<form action="reply" method="POST" id="registerForm"> <!-- action 지정이 안되어 있으면 동일한 url요청 경로에 전송방식만 POST로 요청감 -->
		<input type="hidden" name="mnum" value="${loginMember.mnum}"/>
		<input type="hidden" name="writer" value="${loginMember.mnick}" />
		<input type="hidden" name="pnum" value="${board.pnum}"/>
		<input type="hidden" name="bno" value="${board.bno}"/>
		<input type="hidden" name="category" value="reply"/>
		<!-- 답글에 필요한 속성 추가 -->
		<input type="hidden" name="origin" value="${board.origin}"/>
		<input type="hidden" name="depth" value="${board.depth+1}"/>
		<input type="hidden" name="seq" value="${board.seq+1}"/>
		
		<table>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" name="title" id="title"/>
			</td>
		</tr>
		<tr>
		 	<td>CONTENT</td>
			<td><textarea name="content" id="content"></textarea></td> 
		</tr>		
		<tr>
			<th colspan="2">		
				<input type="button" id="saveBtn" value="완료"/>
				<input type="button" onclick="goBack();" value="뒤로가기"/>
			</th>
			</table>	
		</form>
<script src="https://cdn.tiny.cloud/1/ogpnruhgbsh51awvrblkrooy38miyp3g61qzu5jw81jnacn6/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>		
<script>
	let plugins = ["link","image"];
	let edit_toolbar = "link image forecolor backcolor"
    tinymce.init({
		language: "ko_KR",
      	selector: '#content',
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
<script>


$("#saveBtn").click(function(){
			let content = tinymce.activeEditor.getContent();
			console.log(content);
			$("#registerForm").submit();
			
		});
function goBack(){
	location.href="<c:url value='/partyBoard/read?pnum=${board.pnum}&bno=${board.bno}'/>";
}
</script>
</body>
</html>

  








