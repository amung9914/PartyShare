<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

<style>
	#footerDiv{
		margin:0;
		padding:0;
		width: 100%;
		display: flex;
		justify-content: space-between;
		height:100px;
		position: fixed;
		bottom: 0;
		border-top: 2px black solid;
		padding:20px;
	}
	#footerDiv button{
		width: 150px;
	}
</style>

<div id="footerDiv">
	<button type="button" id="prevBtn" class="btn btn-dark">이전</button>
	<button type="button" id="nextBtn" class="btn btn-dark">다음</button>
</div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$("#nextBtn").click(function(){
		let value = $(".reqInput").val();
		if(value != ''){
			$("form").submit();	
		}else{
			alert('선택해주세요');
		}
	});
	$("#prevBtn").click(function(){
		history.go(-1);
	});
	
</script>
</body>
</html>