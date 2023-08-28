<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<style>
  table {
    width: 70%;
    border-collapse: collapse;
    margin: 10px auto;
  }
  th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
  }
  th {
    background-color: #f2f2f2;
  }
</style>
</head>
<body>
  <h1>블랙리스트 목록</h1>
  <table>
    <tr>
      <th>정지먹은 계정</th>
      <th>정지여부</th>
    </tr>
    <c:forEach var="member" items="${blackMembers}">
      <tr>
        <td>${member.username}</td>
        <td>Y</td>
      </tr>
    </c:forEach>
	    
  </table>
</body>
</html>
