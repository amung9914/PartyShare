<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.mnum{
		display:none;
	}
</style>
</head>
<body>
	<h3> 요청받은목록 </h3>
	<table id="table" class="table table-striped table-hover">
		<tr>
			<th>사진</th>
			<th>아이디</th>
			<th>닉네임</th>
			<th>친구요청일</th>
			<th>수락</th>
			<th>거절</th>
		</tr>
		<c:choose>
			<c:when test="${!empty responseList}">
				<c:forEach var="list" items="${responseList}">
					<tr class="${list.ffrom}">
						<td><img class="profileImg" src="${path}/friend/printImg?fileName=${list.profileImageName}" /></td>
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
						<td ><button class="acceptBtn" id="${list.ffrom}">수락
						</button></td>
						<td ><button class="rejectBtn" id="${list.ffrom}">거절
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
	
	// 수락하기
	$(".acceptBtn").on("click",function(){
		const ffrom = this.id;
		let area = document.getElementsByClassName(ffrom);
		
		$.ajax({
			type : "PUT",
			url : "accept/"+ffrom,
			dataType: "text",
			success : function(result){
				alert(result);
				area[0].remove();
			},
			error : function(result){
				alert(result);
			}
		});
	
	});
	
	
	// 거절하기
	$(".rejectBtn").on("click",function(){
		const ffrom = this.id;
		let area = document.getElementsByClassName(ffrom);
		
		$.ajax({
			type : "DELETE",
			url : "reject/"+ffrom,
			dataType: "text",
			success : function(result){
				alert(result);
				area[0].remove();
			},
			error : function(result){
				alert(result);
			}
		});
	
	});
	
	</script>		
