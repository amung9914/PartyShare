<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>wishlist.jsp</title>
<style>
	ul {
	    display: flex;
	    flex-wrap: wrap;
    	justify-content: flex-start;
		list-style-type : none;
	}
	
	li {
        margin : 20px;
	}
	
	.wishlistBox {
		display: block;
		width: 40vw;
		height: 200px;
		padding : 10px;
		border-radius : 8px;
		background-color : white;
		box-shadow : 0px 2px 4px rgba(0, 0, 0, 0.2);
	}
</style>
</head>
<body>
	<h1>위시리스트</h1>
	<ul>
		<c:set var="seen" value="" />
		<c:forEach var="wishlist" items="${wishlist}">
   			 <c:if test="${fn:indexOf(seen, wishlist.alias) eq -1}">
			      <li>
			      	<a href="${contextPath}/wishlist/perWishlist?alias=${wishlist.alias}"><div class="wishlistBox">${wishlist.alias}</div></a>
			      </li>
			      <c:set var="seen" value="${seen}${wishlist.alias}," />
		    </c:if>
    	</c:forEach>
	</ul>
</body>
</html>