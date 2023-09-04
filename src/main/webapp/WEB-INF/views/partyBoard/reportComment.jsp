<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests"> 
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link href="${path}/resources/css/sy/report.css" rel="stylesheet"/>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>

</head>
<body>
	<div id="wrap">
		<h2 class="titleH2"><b>신고하기</b></h2>
		<hr/>
		<table class="reportWindow">
			<tr>
				<td>작성자 : ${comment.mnick}
					<br/>
					내용 : ${comment.commentText}</td>
			</tr>
		</table>
		<hr/>
		<div class="title"><b>사유선택</b></div>
		<form method="POST" action="${path}/user/partyBoard/comments/report">
		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		  <input type="hidden" name="pnum" value="${comment.pnum}"/>
		  <input type="hidden" name="bno" value="${comment.bno}"/>
		  <input type="hidden" name="cno" value="${comment.cno}"/>
	      <input type="hidden" name="fromMid" value="${loginMember.mid}"/>
	      <input type="hidden" name="toMid" value="${comment.mid}"/>
	      <select name="category" class="form-select reportWindow">
	         <option value="nothing" selected>분류</option>
	         <option value="spam">스팸홍보/도배</option>
	         <option value="obscene">음란물</option>
	         <option value="illegal">불법정보</option>
	         <option value="insult">욕설/혐오/차별적 표현</option>
	         <option value="privacy">개인정보 노출</option>
	         <option value="etc">기타</option>
	      </select><br/><hr/>
	      <div class="title"><b>상세 신고 사유</b></div>
	      <textarea class="form-control reportWindow" name="context" cols="30" rows="2" placeholder="신고 사유를 작성해주세요"></textarea> <br/> 
	      <input type="submit" class="btn btn-dark" id="reportBtn" value="신고하기" />
	      <input type="button" class="btn btn-light" value="취소" onclick="window.close();" />
	   </form>
   </div>
</body>
</html>
