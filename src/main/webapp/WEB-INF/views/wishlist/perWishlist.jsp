<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../common/header.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="${contextPath}/resources/css/jinlee/perWishlist.css" rel="stylesheet">
<body>
	 <div id="perWishlist-title">
	 	<h1>${alias}</h1>
	 </div>
	 <div id="perWishlist-content">
	 <ul>
		<c:forEach var="party" items="${parties}">
	    	<li class="perWishlist-li">
	      		<img id="${party.pnum}" class="heart" src="${contextPath}/resources/img/redHeart.png" alt="하트" onclick="toggleHeart(this)"> <br/><br/><br/>
				<img class="partyImg" src="${contextPath}/image/printPartyImage?fileName=${fn:replace(party.partyImage1, 's_', '')}"/>
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
                url: "${contextPath}/user/wishlist/deleteWishlist", // deleteWishlist에 해당하는 컨트롤러 URL
                data: {pNum : pNum},
                success: function(data) {
                }
            });
        } else {
            heartElement.src = "${contextPath}/resources/img/redHeart.png"; // 빨간 하트 이미지 경로로 변경
            var pNum = $(heartElement).attr("id");
            // dao.addWishList() 호출
            $.ajax({
                type: "POST",
                url: "${contextPath}/user/wishlist/addWishlist", // addWishlist에 해당하는 컨트롤러 URL
                data: {
                	pNum : pNum,
                	alias : "${alias}"
                },
                success: function(data) {
                }
            });
        }
    }
    
    $(document).ajaxSend(function(e,xhr,options){
        xhr.setRequestHeader(
              '${_csrf.headerName}',
              '${_csrf.token}');
    });
</script>
<%@ include file="../common/fixFooter.jsp" %>