<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style>
	.mnum{
		display:none;
	}
</style>
</head>
<body>
	<h3> 요청보낸목록 </h3>
	<table id="table" class="table table-striped table-hover">
		<tr>
			<th>사진</th>
			<th>아이디</th>
			<th>닉네임</th>
			<th>친구요청일</th>
			<th>취소</th>
		</tr>
		<c:choose>
			<c:when test="${!empty list}">
				<c:forEach var="list" items="${list}">
					<tr class="${list.fto}">
						<td> <img class="profileImg" src="${path}/friend/printImg?fileName=${list.profileImageName}" /></td>
						<td>${list.mid}</td>
						<td>${list.mnick}</td>
						<!-- 당일이면 시간표시 / 아니면 날짜표시 -->
						<td>
						<f:formatDate var="now" pattern="yyyy년MM월dd일" value="<%= new java.util.Date() %>"/>
						<f:formatDate var="req" pattern="yyyy년MM월dd일" value="${list.requestTime}"/>
						<c:choose>
							<c:when test="${now == req}">
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
			</c:when>
			<c:otherwise>
				<tr>
				<td></td>
				<td></td>
				<td>친구신청 내역이 없습니다.</td>
				<td></td>
				<td></td>
				</tr>
			</c:otherwise>
		</c:choose>
		
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