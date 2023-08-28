<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/header.jsp" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>perWishlist.jsp</title> -->
<style>
	@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100&family=Noto+Sans+KR:wght@300&display=swap');
    * {margin: 0; padding: 0; font-family: 'Hahmlet', serif; font-family: 'Noto Sans KR', sans-serif;}
    
    #perWishlist-title{
    	margin-left: 40px;
    	margin-top: 20px;
    }
    
    #perWishlist-content{
    	width: 90%;
    	margin: 0 auto;
    }
    
	ul {
	    display: flex;
	    flex-wrap: wrap;
		list-style-type : none;
		justify-content: space-between;
		margin-bottom: 250px;
	}
		
	li {
		padding: 10px;
		width: 300px;
		height: 400px;
        margin : 20px;
        text-decoration: none;
	}
	
	li a {
		 text-decoration: none;
		 color: black;
	}
	
	.partyImg {
		width: 300px;
	    height: 300px;
	    cursor: pointer;
	    border-radius: 15px;
	}
	
	.heart {
    	width: 30px; /* 원하는 너비로 설정 */
    	height: auto; /* 너비에 따라 자동으로 높이를 조절 */
    	cursor: pointer;
    	position: relative;
    	top: 95px;
   		left: 255px;
	}
	
</style>
</head>
<body>
	 <div id="perWishlist-title">
	 	<h1>${alias}</h1>
	 </div>
	 <div id="perWishlist-content">
	 <ul>
		<c:forEach var="party" items="${parties}">
	    	<li>
	      		<img id="${party.pnum}" class="heart" src="${contextPath}/resources/img/redHeart.png" alt="하트" onclick="toggleHeart(this)"> <br/><br/><br/>
				<img class="partyImg" src="${contextPath}/upload/party${party.partyImage1}"/> 
		      	<a href="${contextPath}/partyDetail/detailOfParty?pNum=${party.pnum}">
		      	<b>${party.pname}</b> <br/>
		      	${party.sido} ${party.sigungu}<br/>
		      	${party.address} ${party.detailAddress} <br/>
		      	${party.formatStartDate} <br/>
		      	- ${party.formatEndDate} <br/>
		      	</a>
	   		</li>
    	</c:forEach>
    </div>
	</ul>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

    $(".partyImg").click(function(event) {
        var pNum = $(this).closest("li").find(".heart").attr("id");
        var url = "${contextPath}/partyDetail/detailOfParty?pNum=" + pNum;
        window.location.href = url;
    });


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
<!-- </body>
</html> -->
<%@ include file="../common/fixFooter.jsp" %>