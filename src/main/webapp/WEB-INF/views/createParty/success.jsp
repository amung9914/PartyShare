<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="${path}/resources/css/ksg/createParty.css" rel="stylesheet"/>
<div id="successWrap">
	<div id="successBox">
		<h1>축하합니다.</h1>
		<h1>새로운 파티가 생성되었습니다.</h1>
		<a href="<c:url value='/party/partyList'/>">목록으로</a>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>