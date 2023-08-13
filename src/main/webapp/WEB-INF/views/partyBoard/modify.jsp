<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modify.jsp</title>
</head>
<body>
	<h3>MODIFY BAORD- ${criteria}</h3>
	<!-- model boardVO -->
	<!-- board/modify POST -->
	<form method="POST">
		<input type="hidden" name="pnum" value="${partyBoardVO.pnum}"/>
		<input type="hidden" name="bno" value="${partyBoardVO.bno}"/>
		<input type="hidden" name="page" value="${criteria.page}"/>
		<input type="hidden" name="perPageNum" value="${criteria.perPageNum}"/>
		<div>
			<label>제목</label>
			<input type="text" name="title" value="${partyBoardVO.title}" />
		</div>
		<div>
			<label>내용</label>
			<textarea name="context" rows=3>${partyBoardVO.context}</textarea>
		</div>
		<div>
			<label>작성자</label>
			<input type="text" name="mnick" value="${partyBoardVO.mnick}" />
		</div>
		<div>	
			<input type="submit" value="수정 완료"/>
			<a href="listPage?pnum=${partyBoardVO.pnum}&page=${criteria.page}&perPageNum=${criteria.perPageNum}">LIST</a>
		</div>
	</form>
</body>
</html>













