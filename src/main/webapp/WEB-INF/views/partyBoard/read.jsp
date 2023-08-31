<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="../common/header.jsp" %>
<link href="${path}/resources/css/sy/partyBoardRead.css" rel="stylesheet"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>

<div id="wrap" class="wrapper">
	<div class="tableBox">
		<table class="table">
		<tr>
			<td>
				<h2>${board.title}</h2>
				
				<div class="info">
					${board.writer}
					<f:formatDate value="${board.regdate}" pattern="yyyy.MM.dd. HH:mm"/>
					<c:if test="${loginMember.mnick ne board.writer}">
					&nbsp;<div class="boardReport">신고</div>
					</c:if>
				</div>
			</td>
		</tr>
		<tr>
			<td>${board.content}</td>
		</tr>
		</table>
		
		<!-- 로그인시 보이는 메뉴 -->
		<div class="btnBox">
			<c:if test="${!empty loginMember}">
				
				<br/>
				<c:if test="${board.category ne 'notice'}">
				<input type="button" class="btn btn-outline-dark" id="replyBtn" value="답글작성"/>
				</c:if>
				<c:if test="${loginMember.mnum eq board.mnum}">
					<input type="button" class="btn btn-outline-dark" id="modify" value="수정"/>
					<input type="button" class="btn btn-outline-dark" id="remove" value="삭제"/>
				</c:if>
			</c:if>
			<input type="button" class="btn btn-outline-dark" id="list" value="목록"/>
		</div>
			<br/>
			<div>
				  <%@ include file="comment.jsp" %>  
			</div>
		</div>
		
		<form id="submitForm" method="POST">
		 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
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
				location.href="<c:url value='/user/partyBoard/listPage?pnum=${board.pnum}'/>";
			});
			
			//답글 작성
			$("#replyBtn").click(function(e){
				location.href="<c:url value='/user/partyBoard/reply?pnum=${board.pnum}&bno=${board.bno}'/>";
			})
			
			// 수정 페이지 요청 
			$("#modify").click(function(e){
				location.href="<c:url value='/user/partyBoard/modify?pnum=${board.pnum}&bno=${board.bno}'/>";
			});
			
			// 게시글 삭제요청
			$("#remove").click(function(e){
				e.preventDefault();
				let conf = confirm("복구 할 수 없습니다. 삭제하시겠습니까?");
				if(conf){
					formObj.attr("action","${path}/user/partyBoard/remove?pnum=${board.pnum}");
					formObj.submit();
				}
			});
			
			
		});
	</script>
	<script>
	$(".boardReport").on("click",function(){
			window.open("${path}/user/partyBoard/report?pnum="+${board.pnum}+"&bno="+${board.bno},"Pop","width=500,height=600");
	})
	
	</script>

</div>
<%@ include file="../common/fixFooter.jsp" %>












