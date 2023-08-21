<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<h2>신고하기</h2>
	<hr/>
	작성자 : ${comment.mnick}
	<br/>
	내용 : ${comment.commentText}
	<hr/>
	<h3>사유선택</h3>
	<form method="POST">
	  <input type="hidden" name="pnum" value="${comment.pnum}"/>
	  <input type="hidden" name="bno" value="${comment.bno}"/>
      <input type="hidden" name="fromMid" value="${loginMember.mid}"/>
      <input type="hidden" name="toMid" value="${comment.mid}"/>
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
      <input type="submit" id="reportBtn" value="신고하기" />
      <input type="button" value="닫기" onclick="window.close();" />
   </form>
   
</body>
</html>
