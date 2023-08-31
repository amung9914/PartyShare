<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../common/header.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>wishlist.jsp</title> -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100&family=Noto+Sans+KR:wght@300&display=swap');
    * {margin: 0; padding: 0; font-family: 'Hahmlet', serif; font-family: 'Noto Sans KR', sans-serif;}

	ul {
	    display: flex;
	    flex-wrap: wrap;
		list-style-type : none;
		justify-content: center;
		margin-bottom: 250px;
	}
	
	li {
        margin : 20px;
	}
	
	li a {
		text-decoration: none;
		color: black;
	}
	
	#wishlist-title {
		margin-left: 40px;
    	margin-top: 20px;
    	margin-bottom: 40px;
	}
	
	.wishlistBox {
		display: inline-block;
		width: 350px;
		height: 200px;
		border-radius : 8px;
		background-color : white;
		box-shadow : 0px 2px 4px rgba(0, 0, 0, 0.2);
	}

    /* 이미지 스타일 */
    .partyImg {
        width: 100%;
        max-width: 100%;
        min-height: 200px;
        max-height: 200px; 
        border-radius: 5px;
        cursor: pointer;   
        object-fit: cover;
    }
</style>
</head>
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
<!-- </body>
</html> -->
<%@ include file="../common/fixFooter.jsp" %>