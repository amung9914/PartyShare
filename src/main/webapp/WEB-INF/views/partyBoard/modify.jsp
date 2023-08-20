<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modify.jsp</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<h3>MODIFY BAORD</h3>
	<!-- model boardVO -->
	<!-- board/modify POST -->
	<form action="modify" method="POST" id="modifyForm"> <!-- action 지정이 안되어 있으면 동일한 url요청 경로에 전송방식만 POST로 요청감 -->
		<input type="hidden" name="mnum" value="${board.mnum}"/>
		<input type="hidden" name="bno" value="${board.bno}"/>
		<input type="hidden" name="writer" value="${board.writer}" />
		<input type="text" name="pnum" value="${board.pnum}"/>
		
		<table>
		<tr>
			<td>
				<select name="category" id="categorySelect" value="${board.category}">
		    		<option value="notice">공지사항</option>
		    		<option value="normal">일반</option>
	  			</select>
	  		</td>
		</tr>
		
		<tr>
			<td>제목</td>
			<td>
				<input type="text" name="title" id="title" value="${board.title}"/>
			</td>
		</tr>
		<tr>
		 	<td>CONTENT</td>
			<td><textarea name="content" id="content">${board.content}</textarea>
			</td> 
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
			$("#modifyForm").submit();
			
		});
function goBack(){
	location.href="<c:url value='/partyBoard/read?pnum=${board.pnum}&bno=${board.bno}'/>";
}		

</script>
			
		
</body>
</html>













