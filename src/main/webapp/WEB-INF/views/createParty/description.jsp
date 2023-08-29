<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://unpkg.com/scrollreveal@4.0.0/dist/scrollreveal.min.js"></script>
<style>
	
	#box{
		width: 50%;
		margin-top: 5%;
	}
	
	#description{
		visibility: hidden;
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
	  width: 25%;
	  height: 150px;
	  flex: auto;
	  margin: 0.5rem;
	  background: white;
	  border: 1px solid rgb(221,221,221);
	  box-shadow:1px 1px 1px;
	  line-height: 150px;
	  text-align: center;
	  border-radius: 4px;
	  box-shadow: rgba(0, 0, 0, 0.08) 0px 6px 16px;
	}
	
	/* extension */
	html.sr .widget {
	  visibility: hidden;
	}
	
</style>
<div id="createParty_wrap">
	<h1>다음 중 당신의 파티를 가장 잘 설명하는 것은 무엇인가요?</h1>
	<c:if test="${!empty description}">
		<div id="box">
			<ul class="widget-list">
				<c:forEach var="list" items="${description}">
					<li class="widget">
						${list}
					</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>
	
	<form action="${path}/user/party/createDescription" method="post">
		<input type="hidden" name="host" value="${loginMember.mnum}"/>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="text" id="description" class="reqInput" name="description" required/> <br/>
	</form>
</div>	
<script>
	ScrollReveal().reveal('.widget', { interval: 200 });
	const divs = document.querySelectorAll(".widget");
	divs.forEach((target) => target.addEventListener("click", handleConcept));
	function handleConcept(e){
		for(let i=0; i<divs.length; i++){
			divs[i].style.backgroundColor = "white";
		}
		let value = e.target.innerText;
		document.querySelector("#description").value = value;
		e.target.style.backgroundColor = "#FF385C";
	}
	
	
</script>
<%@ include file="partyCreateFooter.jsp" %>
