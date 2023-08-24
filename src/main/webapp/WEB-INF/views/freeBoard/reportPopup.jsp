<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:if test="${mnick eq '관리자'}">
	<script>
		alert('공지글은 신고할 수 없습니다.');
		window.close();
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reportPopup.jsp</title>
</head>
<body>
	<h2>신고하기</h2>
	
	작성자 | ${mnick} <br/>
	
	<h3>사유선택</h3> 
	<form name="${contextPath}/freeBoard/reportPopup" method="POST">
		<input type="hidden" name="fromMid" value="${fromMid}"/>
		<input type="hidden" name="toMid" value="${toMid}"/>
		<input type="hidden" name="bno" value="${bno}"/>
		<input type="hidden" name="cno" value="${cno}"/>
		<select name="category">
			<option value="nothing" selected>분류</option>
			<option value="spam">스팸홍보/도배</option>
			<option value="obscene">음란물</option>
			<option value="illegal">불법정보</option>
			<option value="insult">욕설/혐오/차별적 표현</option>
			<option value="privacy">개인정보 노출</option>
			<option value="etc">기타</option>
		</select><br/><hr/>
		상세 신고 사유<br/>
		<textarea name="context" cols="30" rows="2"></textarea> <br/> 
		<input type="submit" value="신고하기" />
		<input type="button" value="닫기" onclick="window.close();" />
	</form>
<script>
	var message = '${message}';
	if(message === '신고 완료'){
		alert(message);
		window.close();
	}else if(message === '신고 실패'){
		alert(message);
	}else if(message === '분류를 선택해주세요.'){
		alert(message);
	}
</script>
</body>
</html>