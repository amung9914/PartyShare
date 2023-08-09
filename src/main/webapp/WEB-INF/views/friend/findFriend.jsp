<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style type="text/css">
	.findResult{
		display: none;
	}
</style>
</head>
<body>

<a class="btn btn-primary" data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample">
  친구찾기
</a>

<!-- offcanvas 출력 -->
<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="offcanvasExampleLabel">친구찾기</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
    <div>
      추가하고 싶은 상대방의 아이디 혹은 닉네임을 입력해주세요.
    </div>
    <br/>
    
    <!-- 검색 찾기 폼 -->
    <form>
	    <div class="input-group mb-3">
	    <select class="form-select" id="inputGroupSelect02">
		    <option value="1">아이디</option>
		    <option value="2">닉네임</option>
	  	</select>
	 	 <input type="text" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2" required>
	 	 <button class="btn btn-outline-secondary" type="submit" id="selectButton">찾기</button>
		</div>
	</form>
    <!-- selectButton 제이쿼리로 클릭이벤트 -> find-result 보이게 출력 (완료)-->
    <!-- form태그로 submit 하면 ajax로 결과 받아와서 결과출력란에 보일 수 있도록! 구현하기 -->
    <div class="findResult">
	    <!-- 검색 결과 출력 -->
		  <div class="form-check">
			  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
			  <label class="form-check-label" for="flexRadioDefault1">
			    찾은 아이디 결과 1
			  </label>
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" checked>
			  <label class="form-check-label" for="flexRadioDefault2">
			    찾은 아이디 결과 2
			  </label>
			</div>
	    
	    <!-- 친구 추가 실행 -->
	    <!-- 라디오 버튼 선택하면 해당 내용 자동으로 input박스에 들어가게 click event 설정필요 -->
	    <div class="input-group">
		  	<input type="text" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username with two button addons">
	 	 	<button class="btn btn-outline-secondary" type="button">친구 요청</button>
		</div>
    </div> <!-- findResult end-->
    
  </div>
</div> <!-- end off-canvas -->

<script>
$("#selectButton").on("click",function(){
	$(".findResult").toggle();
})

</script>

</body>
</html>