<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://unpkg.com/scrollreveal@4.0.0/dist/scrollreveal.min.js"></script>
<link href="${path}/resources/css/ksg/period.css" rel="stylesheet"/>
	
	<div id="createParty_wrap">
		<div id="periodBox">
			<h1>어떤 만남을 추구하시나요?</h1>
			<ul class="widget-list">
				<li class="widget"><p><br/><br/><br/>짜릿한 일회성 만남</p></li>
				<li class="widget"><p><br/><br/><br/>오래 보고싶은 인연을 <br/>만나고 싶으세요?</p></li>
			</ul>
		</div>
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
    	<input type="text" id="period" name="period" class="reqInput" autocomplete="off" required/>
    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
<script>
	ScrollReveal().reveal('.widget', { interval: 200 });
	const divs = document.querySelectorAll(".widget");
	divs.forEach((target) => target.addEventListener("click", handleConcept));
	function handleConcept(e){
		for(let i=0; i<divs.length; i++){
			divs[i].style.backgroundColor = "white";			
			const p = divs[i].children;
			$(p).css("background-color", "white");
		}
		let value = e.target.innerText;
		$("#period").val(value.trim());
		e.target.style.backgroundColor = "#FF385C";
	}
	
</script>
<%@ include file="partyCreateFooter.jsp" %>
