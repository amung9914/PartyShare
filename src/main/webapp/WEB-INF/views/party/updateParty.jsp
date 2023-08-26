<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <!-- Editor's Style -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style>
body{
margin:30px;
}

</style>
</head>
<body>
<h3>파티정보</h3>
<hr/>
<form method="POST" enctype="multipart/form-data" id="updateForm">
<input type="hidden" name="pnum" value="${party.pnum}"/> 
<table class="table">
	<tr>
		<td>파티명</td>
		<td><input type="text" class="form-control" name="pname" value="${party.pname}"/></td>
	</tr>
	<tr>
		<td rowspan="2">파티장소</td>
		<td><input type="text" class="form-control"  onclick="cDaumPostcode()" name="address" id="address" value="${party.address}"/></td>
	</tr>
	<tr>
		<td>
			<div class="input-group">
				<input type="text" class="form-control" aria-label="First name"  name="detailAddress" id="detailAddress" value="${party.detailAddress}"/>
				<input type="text" class="form-control" aria-label="Last name" id="extraAddress" placeholder="참고항목"><br/>
			</div>
			<div class="form-text" id="basic-addon4">상세주소</div>
		</td>
	<tr>
		<td>시작일</td>
		<td><input type="date" name="startDate" value="${party.startDate}" id="startDateInput"/></td>
	</tr>
	<tr>
		<td>종료일</td>
		<td><input type="date" name="endDate" value="${party.endDate}"/></td>
	</tr>
	<tr>
		<td>주제</td>
		<td>
			<select class="form-select" name="description" >
			    <option value="${party.description}">${party.description}</option>
			
				<c:forEach items="${description}" var="description">    
			    <option value="${description}">${description}</option>
			    </c:forEach>
		  	</select>
		  	<div class="form-text" id="basic-addon4">이 파티와 어울리는 주제를 선택해주세요</div>
		</td>
	</tr>
	<tr>
		<td>카테고리</td>
		<td>
		<select class="form-select" name="category" >
			<option value="${party.category}">${party.category}</option>
			<c:forEach items="${category}" var="category">    
		    <option value="${category}">${category}</option>
		    </c:forEach>
		</select>
		</td>
	</tr>
	<tr>
		<td>소개글</td>
		<td><textarea name="pcontext" id="content">${party.pcontext}</textarea></td>
	</tr>	
	
	<!-- 파티 사진 수정 페이지 -->
	<%@ include file="partyimg.jsp" %>
</table>
<!-- 우편번호프로그램으로 얻어지늗 값 -->
		<input type="hidden" id="sido" name="sido" value="${party.address}"/>
		<input type="hidden" id="sigungu" name="sigungu" value="${party.sigungu}"/>
		<input type="hidden" id="lat" name="lat" value="${map.lat}"/>
    	<input type="hidden" id="lng" name="lng" value="${map.lng}">

	
	<br/>
	<input type="button" class="btn btn-dark" id="saveBtn" value="완료"/>
	<input type="button" class="btn btn-light" onclick="goBack();" value="뒤로가기"/>
	</form>
	
<script>
	function goBack(){
		history.go(-1);
	}
</script>
<!-- 주소정보 script -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey}&libraries=services"></script>
<script>
//사용자가 선택한 주소로 위도와 경도를 구해와서 지도에 추가해줍니다.
    function cDaumPostcode() {
        new daum.Postcode({
        	oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
               
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };  

                //주소-좌표 변환 객체를 생성합니다
                var geocoder = new kakao.maps.services.Geocoder();

                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value = addr;
                document.getElementById("sido").value = data.sido;
                document.getElementById("sigungu").value = data.sigungu;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
                
             // 주소로 좌표를 검색합니다
                geocoder.addressSearch(addr, function(result, status) {

                    // 정상적으로 검색이 완료됐으면 
                     if (status === kakao.maps.services.Status.OK) {

                        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                        
                        document.getElementById('lat').value = result[0].y;
                        document.getElementById('lng').value = result[0].x;
                        console.log(result[0].y,result[0].x);
                    }
                });
            }
        }).open();
    }
</script>
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
			$("#updateForm").submit();
			
		});
</script>		
		
</body>
</html>