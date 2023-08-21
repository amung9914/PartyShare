<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
	let message = "${message}";
	alert(message);
	setTimeout(function(){
			window.close();
		},100);
	</script>
</body>
</html>