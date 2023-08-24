<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://unpkg.com/scrollreveal@4.0.0/dist/scrollreveal.min.js"></script>
<title>Insert title here</title>
<style>
	h1{
		margin-left:38%;
	}
	
	#wrap{
		width: 50%;
		margin-left: 25%;
		margin-top: 10%;
	}
	
	.widget-list {
	  display: flex;
	  flex-wrap:wrap;
	  list-style: none;
	  margin: 0;
	  padding: 0;
	  border-radius: 8px;
	}
	
	.widget {
	  width: 20%;
	  height: 300px;
	  flex: auto;
	  margin: 0.5rem;
	  background: white;
	  border:1px black solid;
	  box-shadow:1px 1px 1px;
	  line-height: 300px;
	  text-align: center;
	  border-radius: 4px;
	}
	
	/* extension */
	html.sr .widget {
	  visibility: hidden;
	}
	#period{
		visibility: hidden;
	}
</style>
	
</head>
<body>
	<h1>어떤 만남을 추구하시나요?</h1>
	<div id="wrap">
		<ul class="widget-list">
			<li class="widget">짜릿한 일회성 만남</li>
			<li class="widget">오래 보고싶은 인연을 만나고 싶으세요?</li>
		</ul>
	</div>

	<form action="choosePeriod" method="post"> 
		<input type="hidden" name="host" value="${loginMember.mnum}"/>
		<input type="hidden" name="description" value="${vo.description}" />
		<input type="hidden" name="category" value="${vo.category}" />
		<input type="hidden" name="address" value="${vo.address}">
		<input type="hidden" name="sido" value="${vo.sido}">
		<input type="hidden" name="sigungu" value="${vo.sigungu}">
		<input type="hidden" name="detailAddress" value="${vo.detailAddress}">
		<input type="hidden" id="lat" name="lat" value="${mapVO.lat}">
    	<input type="hidden" id="lng" name="lng" value="${mapVO.lng}">
    	<input type="text" id="period" name="period" class="reqInput" required/>
	</form>
<script>
	ScrollReveal().reveal('.widget', { interval: 200 });
	const divs = document.querySelectorAll(".widget");
	divs.forEach((target) => target.addEventListener("click", handleConcept));
	function handleConcept(e){
		for(let i=0; i<divs.length; i++){
			divs[i].style.backgroundColor = "white";
		}
		let value = e.target.innerText;
		$("#period").val(value);
		e.target.style.backgroundColor = "#FF385C";
	}
	
</script>
<%@ include file="partyCreateFooter.jsp" %>
</body>
</html>