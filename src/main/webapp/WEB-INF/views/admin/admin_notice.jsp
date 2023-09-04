<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="../common/header.jsp" %>
<link href="${path}/resources/css/in/notice.css" rel="stylesheet"/>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<div id="wrap">
	<div id="textBox">
	<div id="memberModal">
	<ul id="memberUl">
	
	</ul>
	</div>
	<br/>
	
	<!-- 유저목록 테이블 생성  -->
	<h4><b>알림 보내기</b></h4> <br/>
	<form>
		<textarea id="context" rows="10" cols="80"></textarea><br/>
		<button class="btn btn-dark" type="button" id="registPost">알림 보내기</button>
		<a href="${path}/admin/admin" class="btn btn-outline-dark" >관리자 홈</a>
	</form>
	
	<script>
	/* READY OPTION */
		   $(document).ajaxSend(function(e,xhr,options){
	      xhr.setRequestHeader(
	            '${_csrf.headerName}',
	            '${_csrf.token}');
	   });
	
	$(document).ready(function () {
		$("#registPost").click(function () {
			let context = $("#context").val();
			$.ajax({
				url:'${path}/admin/sendPost',
				
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
	})//ready
		</script>
		</div>
</div>
<%@ include file="../common/footer.jsp" %>