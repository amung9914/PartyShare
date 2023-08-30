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
<style>
	@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100&family=Noto+Sans+KR:wght@300&display=swap');
    * {margin: 0; padding: 0; font-family: 'Hahmlet', serif; font-family: 'Noto Sans KR', sans-serif;}
    
    #report {
    	margin: 0 auto;
    	text-align: center;
    }
    
    #report-title {
    	margin-top : 10px;
    	margin-bottom : 15px;
    }
    
    #report-toMid {
    	margin-left: 30px;
    	text-align: left;
    }
    
    #report-select-title {
	    margin-left: 30px;
	    margin-top: 10px;
	    text-align: left;
    }
    
    #report-select {
    	margin-left: 30px;
    	text-align: left;
    }
    
    #report-reason-title {
    	margin-left: 30px;
	    margin-top: 10px;
	    text-align: left;
    }
    
    .context {
    	width: 84%;
    	height: 55px;
    }
    
    .submit {
    	margin-top: 15px;
    	padding: 5px;
		width: 70px;
		background-color: #DADADA;
		color: black;
		font-weight: bold;
		border: none;
		border-radius: 30px;
		cursor: pointer;
		outline: none;
    }
    
    .submit:hover {
    	background-color: #E9E9E9;
    }
    
    .close {
    	margin-top: 15px;
    	margin-left: 20px;
    	padding: 5px;
		width: 70px;
		background-color: #DADADA;
		color: black;
		font-weight: bold;
		border: none;
		border-radius: 30px;
		cursor: pointer;
		outline: none;
    }
    
    .close:hover {
    	background-color: #E9E9E9;
    }
</style>
</head>
<body>
	<div id="report">
		<div id="report-title">
			<h2>신고하기</h2>
		</div>
		
		<div id="report-toMid">
			작성자 | ${mnick} 
		</div>
		
		<div id="report-select-title">
			<h3>사유선택</h3> 
		</div>
		
		<form name="${contextPath}/user/freeBoard/reportPopup" method="POST">
		<div id="report-select">
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
			</select>
		</div>
		<div id="report-reason-title">
			<h3>상세 신고 사유</h3>
		</div>
			<textarea class="context" name="context" cols="30" rows="2"></textarea> <br/> 
			<input class="submit" type="submit" value="신고하기" />
			<input class="close" type="button" value="닫기" onclick="window.close();" />
		</form>
	</div>
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