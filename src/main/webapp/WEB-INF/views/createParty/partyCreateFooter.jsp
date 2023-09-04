<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link href="${path}/resources/css/ksg/createPartyFooter.css" rel="stylesheet"/>
<div id="footerDiv">
	<button type="button" id="prevBtn" class="btn btn-dark">이전</button>
	<button type="button" id="nextBtn" class="btn btn-dark">다음</button>
</div>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$("#nextBtn").click(function(){
		let value = $(".reqInput").val();
		if(value != ''){
			$("form").submit();	
		}else{
			alert('필수 항목을 선택 또는 입력해주세요.');
		}
	});
	$("#prevBtn").click(function(){
		history.go(-1);
	});
	
</script>
</body>
</html>