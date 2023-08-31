<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="${path}/resources/css/ksg/createParty.css" rel="stylesheet"/>
<div id="createParty_wrap">
	<div id="formBox">
		<form action="createName" method="post">
			<input type="hidden" name="host" value="${loginMember.mnum}"/>
			<input type="hidden" name="description" value="${vo.description}" />
			<input type="hidden" name="category" value="${vo.category}" />
			<input type="hidden" name="address" value="${vo.address}">
			<input type="hidden" name="sido" value="${vo.sido}">
			<input type="hidden" name="sigungu" value="${vo.sigungu}">
			<input type="hidden" name="detailAddress" value="${vo.detailAddress}">
			<input type="hidden" id="lat" name="lat" value="${mapVO.lat}">
	    	<input type="hidden" id="lng" name="lng" value="${mapVO.lng}">
	    	<input type="hidden" name="startDate" value="${vo.startDate}" />
			<input type="hidden" name="endDate" value="${vo.endDate}" />
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			
			<input type="text" name="pname" id="pname" class="reqInput" autocomplete="off" placeholder="파티 이름은 무엇인가요?"/><br/>
		</form>
	</div>
</div>	
	<%@ include file="partyCreateFooter.jsp" %>
