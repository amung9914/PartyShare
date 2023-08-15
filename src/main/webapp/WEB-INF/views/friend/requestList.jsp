<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
	.mnum{
		display:none;
	}
</style>
</head>
<body>
	<h3> 요청보낸목록 </h3>
	<table id="table" border=1>
		<tr>
			<th>아이디</th>
			<th>닉네임</th>
			<th>친구요청일</th>
			<th>취소</th>
		</tr>
		<c:forEach var="list" items="${list}">
			<tr class="${list.fto}">
				<td>${list.mid}</td>
				<td>${list.mnick}</td>
				<!-- 당일이면 시간표시 / 아니면 날짜표시 -->
				<td>
				<f:formatDate var="now" pattern="yyyy년MM월dd일" value="<%= new java.util.Date() %>"/>
				<f:formatDate var="req" pattern="yyyy년MM월dd일" value="${list.requestTime}"/>
				<c:choose>
					<c:when test="${now eq req}">
						<f:formatDate pattern="HH:mm:ss" value="${list.requestTime}"/>
					</c:when>
					<c:otherwise>
						${req}
					</c:otherwise>
				</c:choose>
				</td>
				<td ><button class="cancelBtn" id="${list.fto}">요청취소
				
				</button></td>
				
			</tr>
		</c:forEach> <!-- 반복문 끝 -->
		</table>
	<script>
	
	$(".cancelBtn").on("click",function(){
		const fto = this.id;
		let area = document.getElementsByClassName(fto);
		console.log(area);
		$.ajax({
			type : "DELETE",
			url : "deleteRequest/"+fto,
			dataType: "text",
			success : function(result){
				alert(result);
				area[0].remove();
			}
		});
	
	});
	
	</script>		
		
</body>
</html>