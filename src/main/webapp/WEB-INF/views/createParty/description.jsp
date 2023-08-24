<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		margin-left: 23%;
	}
	#categoryContainer div{
		border:1px black solid;
		width: 100px;
		height: 50px;
		padding :20px;
	}
	
	#categoryContainer{
		display:flex;
		flex-wrap: wrap;
		width: 1000px;
		hight:50px;
		padding:20px;
		text-align: center;
	}
	
	form button{
		width: 100px;
		height: 50px;
	}
	
	#box{
		width: 50%;
		margin-left: 25%;
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
	  border:1px black solid;
	  box-shadow:1px 1px 1px;
	  line-height: 150px;
	  text-align: center;
	  border-radius: 4px;
	}
	
	/* extension */
	html.sr .widget {
	  visibility: hidden;
	}
	
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
</head>
<body>
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
	
	
	<form action="createDescription" method="post">
		<input type="hidden" name="host" value="${loginMember.mnum}"/>
		<input type="text" id="description" class="reqInput" name="description" required/> <br/>
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
		document.querySelector("#description").value = value;
		e.target.style.backgroundColor = "#FF385C";
	}
	
	
</script>
<%@ include file="partyCreateFooter.jsp" %>
</body>
</html>