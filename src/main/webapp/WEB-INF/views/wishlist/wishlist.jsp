<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../common/header.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="${contextPath}/resources/css/jinlee/wishlist.css" rel="stylesheet">
<body>
	<div id="wishlist-title">
		<h1>위시리스트</h1>
	</div>
	<ul>
		<c:set var="seen" value="" />
		<c:forEach var="wishlist" items="${wishlist}">
   			 <c:if test="${fn:indexOf(seen, wishlist.alias) eq -1}">
			      <li>
			      	<a href="${contextPath}/user/wishlist/perWishlist?alias=${wishlist.alias}">
			      		<div class="wishlistBox">
			      		<c:choose>
                            <c:when test="${not empty wishlist.parties}">
                            <div class="partyImages">
                                <img class="partyImg" src="${contextPath}/image/printPartyImage?fileName=${wishlist.parties[0].partyImage1}"/>
                          	</div>
                            </c:when>
                            <c:otherwise>
                                <!-- 파티 이미지가 없을 경우 대체 이미지 등을 표시 -->
                                <%-- <img class="partyImg" src="${contextPath}/resources/img/noPartyImage.jpg"/> --%>
                            </c:otherwise>
                        </c:choose>
			      		</div>
			      		<h2>${wishlist.alias}</h2>
			      	</a>
			      </li>
			      <c:set var="seen" value="${seen}${wishlist.alias}," />
		    </c:if>
    	</c:forEach>
	</ul>
<%@ include file="../common/fixFooter.jsp" %>