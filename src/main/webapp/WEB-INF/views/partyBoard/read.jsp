<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>read.jsp</title>
<style>
	#comments li{
		list-style:none;
		padding:10px;
		border:1px solid #ccc;
		height:150px;
		margin: 5px 0;}
	#modDiv{
		border:1px solid black;
		padding:10px;
		display:none;/* 처음에는 안보이게 */
	}
</style>
</head>
<body>
		<table border="1">
		<tr>
			<td>제목</td>
			<td>${board.title}</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${board.writer}</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${board.content}</td>
		</tr>
		<tr>
			<td>작성시간</td>
			<td>
				<f:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
		</tr>
		</table>
		<div>
			<c:if test="${!empty loginMember}">
				
				<br/>
				<input type="button" id="replyBtn" value="답글작성"/>
				<c:if test="${loginMember.mnum eq board.mnum}">
					<input type="button" id="modify" value="수정"/>
					<input type="button" id="remove" value="삭제"/>
				</c:if>
			</c:if>
			<input type="button" id="list" value="목록"/>
		</div>
		<br/>
		<div>
			  <%@ include file="comment.jsp" %>  
		</div>
		<form id="submitForm" method="POST">
			<input type="hidden" name="bno"  value="${board.bno}"/>
		</form>
	<script>
		var result = '${result}';
		if(result != null && result != ''){
			alert(result);
		}
	</script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		// 문서가 모두 로드 되었을 때...
		$(function(){
			
			var formObj = $("#submitForm");
			
			$("#list").click(function(e){
				e.preventDefault();
				location.href="listPage?pnum=${board.pnum}";
			});
			
			//답글 작성
			$("#replyBtn").click(function(e){
				location.href="reply?pnum=${board.pnum}&bno=${board.bno}";
			})
			
			// 수정 페이지 요청 
			$("#modify").click(function(e){
				location.href="modify?pnum=${board.pnum}&bno=${board.bno}";
			});
			
			// 게시글 삭제요청
			$("#remove").click(function(e){
				e.preventDefault();
				let conf = confirm("복구 할 수 없습니다. 삭제하시겠습니까?");
				if(conf){
					formObj.attr("action","remove?pnum=${board.pnum}");
					formObj.submit();
				}
			});
			
			
		});
	</script>
</body>
</html>













