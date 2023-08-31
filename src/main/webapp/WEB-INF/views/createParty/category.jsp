<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://unpkg.com/scrollreveal@4.0.0/dist/scrollreveal.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="${path}/resources/css/ksg/createParty.css" rel="stylesheet"/>
<div id="createParty_wrap">
	<h1>다음 중 당신의 파티를 가장 잘 설명하는 것은 무엇인가요?</h1>
	<c:if test="${!empty category}">
		<div id="categoryBox">
			<ul class="widget-list">
				<c:forEach var="list" items="${category}">
					<li class="widget">
						${list}
					</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>
	
	<form action="createCategory" method="post"> 
		<input type="hidden" name="host" value="${loginMember.mnum}"/>
		<input type="hidden" name="description" value="${vo.description}" />
		<input type="text" class="reqInput" id="category" name="category" autocomplete="off" required/><br/>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
	</div>
<script>
	const divs = document.querySelectorAll(".widget");
	divs.forEach((target) => target.addEventListener("click", handleConcept));
	function handleConcept(e){	
		for(let i=0; i<divs.length; i++){
			divs[i].style.backgroundColor = "white";
		}
		let value = e.target.innerText;
		document.querySelector("#category").value = value;
		e.target.style.backgroundColor = "#FF385C";
	}
	
	ScrollReveal().reveal('.widget', { interval: 200 });
</script>
<%@ include file="partyCreateFooter.jsp" %>
