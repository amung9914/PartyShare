<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register.jsp</title>
</head>
<body>
	<h1>REGISTER BOARD</h1>
	<form method="POST"> <!-- action 지정이 안되어 있으면 동일한 url요청 경로에 전송방식만 POST로 요청감 -->
		
		<input type="hidden" name="pnum" value="${pnum}"/>
		<select name="category" >
		    <option value="공지사항">공지사항</option>
		    <option value="normal">일반</option>
	  	</select>
		<div>
			<label>TITLE</label>
			<input type="text" name="title"/>
		</div>
		<div>
			<label>CONTENT</label>
			<textarea name="context" rows=3></textarea>
		</div>
		<div>
			<label>WRITER</label>
			<input type="text" name="mnick" value="${loginMember.mnick}" />
		</div>
		<div>
			<input type="submit" value="글작성 완료"/>
		</div>
	</form>
</body>
</html>












