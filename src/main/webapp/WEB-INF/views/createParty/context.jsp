<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h1{
		margin-left:35%;
	}
	#contentBox{
		margin-left: 35%;
		margin-top: 5%;
	}
	
	
</style>
</head>
<body>
	<h1>파티의 자세한 소개를 작성해주세요</h1>
	<div id="contentBox">
		<form action="createContext" method="post">
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
			<textarea rows="10" cols="100" name="pcontext" id="content"></textarea> <br/>
		</form>	
	</div>
	
	
	<script src="https://cdn.tiny.cloud/1/3namak8ojm8wwt7yzd2any1fyz4o6twi4gqqxlcgkc6lp22l/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
	<script>
	let plugins = ['link', 'image'];
	let edit_toolbar = "link image forecolor backcolor";
	
    tinymce.init({
      language : "ko_KR",
      selector: '#content',
      skin: 'oxide-dark',
      width : 600,
      height: 500,
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
  <%@ include file="partyCreateFooter.jsp" %>
</body>
</html>