<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page isErrorPage = "true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러페이지</title>
</head>
<body>
	<script>
		alert("아이디 이미 있습니다. 다른 아이디로 회원가입 해주십시오.");
		history.go(-1);
	</script>
</body>
</html>