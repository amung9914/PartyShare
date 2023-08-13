<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listPage.jsp</title>
<script>
	var result = '${result}';
	if(result != ''){
		alert(result);
	}
</script>
</head>
<body>
	<!-- model : list, pm -->
	<h3>BOARD LIST PAGE</h3>
	<button onclick="location.href='register?pnum=${pnum}';">NEW BOARD</button>
	<h3> LIST </h3>
	<table border=1>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="board" items="${list}">
			<tr>
				<td>${board.bno}</td>
				<td>
				<c:if test="${board.category eq '공지사항'}">
					[공지]
				</c:if>
				<a href="readPage${pm.mkQueryStr(pm.cri.page)}&bno=${board.bno}">${board.title}</a></td>
				<td>${board.mnick}</td>
				<td><f:formatDate pattern="yyyy년MM월dd일" 
					              value="${board.date}"/></td>
				<td>${board.viewCnt}</td>
			</tr>
		</c:forEach>
		<c:if test="${!empty pm and pm.maxPage > 1}">
			<tr>
				<th colspan="5">
					<c:if test="${pm.first}">
						<a href="listPage?pnum=${pnum}&page=1">[&laquo;]</a>
					</c:if>
					<c:if test="${pm.prev}">
						<a href="listPage?pnum=${pnum}&page=${pm.startPage-1}">[&lt;]</a>
					</c:if>
					<c:forEach var="i" 
							   begin="${pm.startPage}" 
							   end ="${pm.endPage}">
						<a href="listPage?pnum=${pnum}&page=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${pm.next}">
						<a href="listPage?pnum=${pnum}&page=${pm.endPage+1}">[&gt;]</a>
					</c:if>
					<c:if test="${pm.last}">
						<a href="listPage?pnum=${pnum}&page=${pm.maxPage}">[&raquo;]</a>
					</c:if>
				</th>
			</tr>
		</c:if>
	</table>
</body>
</html>







