<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		#memberModal{
	display: none;
	position: fixed;
	overflow: auto;
	}
	</style>
</head>
<body>
	<a href="{path}/admin/admin" >관리자 홈</a>
	
	</div> <br/>
	<div id="memberModal">
	<ul id="memberUl">
	
	</ul>
	</div>
	<br/>
	
	<!-- 유저목록 테이블 생성  -->
	<h5>알림 보내기  </h5> <br/>
	<form>
		<textarea id="context" row=""></textarea> <br/>
		<button type="button" id="registPost">알림 보내기</button>
	</form>
	
	
	<script>
	/* READY OPTION */
	$(document).ready(function () {
		$("#registPost").click(function () {
			let context = $("#context").val();
			$.ajax({
				url:'${path}/notice/sendPost',
				type: 'post',
				data:{context : context},
				dataType: 'text',
				success: function (response) {
					alert(response);
					 $("#context").val("");
				},
				error: function (err) {
					alert(err);
				}
				
			});
		});
		</script>
</body>
</html>