<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>perWishlist.jsp</title>
<style>
	ul {
	    display: flex;
	    flex-wrap: wrap;
    	justify-content : space-around;
		list-style-type : none;
	}
		
	li {
        margin : 20px;
	}
		
	.wishlistBox {
		display: block;
		width: 40vw;
		height: 300px;
		padding : 10px;
		border-radius : 8px;
		background-color : white;
		box-shadow : 0px 2px 4px rgba(0, 0, 0, 0.2);
	}
	
	.heart {
    	width: 30px; /* 원하는 너비로 설정 */
    	height: auto; /* 너비에 따라 자동으로 높이를 조절 */
	}
</style>
</head>
<body>
	 <h1>${alias}</h1>
	 <ul>
		<c:forEach var="party" items="${parties}">
		      	<div class="wishlistBox">
		      	<img id="${party.pnum}" class="heart" src="${contextPath}/resources/img/redHeart.png" alt="하트" onclick="toggleHeart(this)"> <br/><br/><br/>
		    	<li>
			      	<a href="${contextPath}/partyDetail/detailOfParty?pNum=${party.pnum}">
					<img src="${contextPath}/upload/party${party.partyImage1}"/> 
					<img src="${contextPath}/upload/party${party.partyImage2}"/> 
					<img src="${contextPath}/upload/party${party.partyImage3}"/> <br/> 
			      	파티 이름 : ${party.pname} <br/>
			      	주소 : ${party.sido} ${party.sigungu} ${party.address} ${party.detailAddress} <br/>
			      	시작 날짜 : ${party.formatStartDate} <br/>
			      	종료 날짜 : ${party.formatEndDate} <br/>
			      	</a>
		   		</li>
		      	</div>
    	</c:forEach>
	</ul>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

    function toggleHeart(heartElement) {
        if (heartElement.src.includes("${contextPath}/resources/img/redHeart.png")) {
            heartElement.src = "${contextPath}/resources/img/emptyHeart.png"; // 빈 하트 이미지 경로로 변경
            var pNum = $(heartElement).attr("id");
            // dao.deleteWishList() 호출
            $.ajax({
                type: "POST",
                url: "${contextPath}/wishlist/deleteWishlist", // deleteWishlist에 해당하는 컨트롤러 URL
                data: {pNum : pNum},
                success: function(data) {
                    console.log("Wish List deleted");
                }
            });
        } else {
            heartElement.src = "${contextPath}/resources/img/redHeart.png"; // 빨간 하트 이미지 경로로 변경
            var pNum = $(heartElement).attr("id");
            // dao.addWishList() 호출
            $.ajax({
                type: "POST",
                url: "${contextPath}/wishlist/addWishlist", // addWishlist에 해당하는 컨트롤러 URL
                data: {
                	pNum : pNum,
                	alias : "${alias}"
                },
                success: function(data) {
                    console.log("Wish List added");
                }
            });
        }
    }
    
</script>
</body>
</html>