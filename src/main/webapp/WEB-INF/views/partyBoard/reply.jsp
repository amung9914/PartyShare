<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../common/header.jsp" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <!-- Editor's Style -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style>

html, body {
    height: 90%
}
#wrap {
    min-height: 100%;
    position: relative;
    padding-bottom: 100px;
    margin:30px;
}
</style>
<div id="wrap">
	<form action="${path}/user/partyBoard/reply" method="POST" id="registerForm"> <!-- action 지정이 안되어 있으면 동일한 url요청 경로에 전송방식만 POST로 요청감 -->
		<input type="hidden" name="mnum" value="${loginMember.mnum}"/>
		<input type="hidden" name="writer" value="${loginMember.mnick}" />
		<input type="hidden" name="pnum" value="${board.pnum}"/>
		<input type="hidden" name="bno" value="${board.bno}"/>
		<input type="hidden" name="category" value="reply"/>
		<!-- 답글에 필요한 속성 추가 -->
		<input type="hidden" name="origin" value="${board.origin}"/>
		<input type="hidden" name="depth" value="${board.depth}"/>
		<input type="hidden" name="seq" value="${board.seq}"/>
		
		<table class="table">
			<tr>
				<td>제목</td>
				<td>
					<input type="text" class="form-control" name="title" id="title" placeholder="답글 제목을 입력하세요"/>
				</td>
			</tr>
			<tr>
			 	<td>CONTENT</td>
				<td><textarea name="content" id="content"></textarea></td> 
			</tr>		
				
		</table>	
		<input type="button" class="btn btn-dark" id="saveBtn" value="완료"/>
		<input type="button" class="btn btn-light" onclick="goBack();" value="뒤로가기"/>
	</form>
<script src="https://cdn.tiny.cloud/1/ogpnruhgbsh51awvrblkrooy38miyp3g61qzu5jw81jnacn6/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>		
<script>
	let plugins = ["link","image"];
	let edit_toolbar = "link image forecolor backcolor"
    tinymce.init({
		language: "ko_KR",
      	selector: '#content',
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
	location.href="<c:url value='/user/partyBoard/read?pnum=${board.pnum}&bno=${board.bno}'/>";
}
</script>
</div>	
<%@ include file="../common/footer.jsp" %>

  








