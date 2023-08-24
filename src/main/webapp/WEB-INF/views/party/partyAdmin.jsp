<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
	#title{
		margin-left: 10%;
	}
	table img{
		width: 50px;
		height: 50px;
	}
	#partyMemberListBox{
		width:20%;
		margin-left: 10%;
		
	}
	#partyFinishBox{
		margin-left: 10%;
		width: 20%;
	}
</style>
</head>
<body>
<a href="<c:url value='/home'/>">home으로</a>
<c:if test="${!empty message}">
	<script>
		alert('${message}');
	</script>
</c:if>
	<h1 id="title">파티원 관리</h1>
	<div id="partyMemberListBox">
		<table class="table">
			<tr>
				<th colspan="3">파티원 목록</th>
			</tr>
			<c:if test="${!empty partyJoinMember}">
				<c:forEach var="list" items="${partyJoinMember}">
					<tr>
						<td><img src="<c:url value='/image/printProfileImage?fileName=${list.profileImageName}'/>"/></td>
						<td style="width: 200px;">${list.mname}</td>
						<td>
							<button type="button" class="btn btn-outline-danger" id="banBtn" onclick="banMember(${list.mnum}, '${list.mname}');">강퇴</button>
						</td>
					</tr>
					
				</c:forEach>
			</c:if>
		</table>
	</div>
	<div id="partyFinishBox">
		<button type="button" class="btn btn-primary btn-lg btn-dark" onclick="partyFinish(${pnum});">파티종료</button>
	</div>
	<script>
		function partyFinish(pnum){
			if(confirm('파티를 종료하시겠습니까?')){
				location.href="<c:url value='/party/partyFinish?pnum="+pnum+"'/>";	
			}
		}

		function banMember(mnum, mname){
			if(confirm(mname+'님을 강퇴 하시겠습니까?')){
				location.href="<c:url value='/party/partyMemberBan?mnum="+mnum+"&pnum=${pnum}'/>";	
			}
		}
		
	</script>
</body>
</html>