<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://unpkg.com/scrollreveal@4.0.0/dist/scrollreveal.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
	#category{
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
	  width: 15%;
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
	
</style>
</head>

<body>
	
	<h1>다음 중 당신의 파티를 가장 잘 설명하는 것은 무엇인가요?</h1>
	<c:if test="${!empty category}">
		<div id="box">
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
		<input type="text" class="reqInput" id="category" name="category" required/><br/>
	</form>
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
</body>
</html>