<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/search.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="https://unpkg.com/scrollreveal@4.0.0/dist/scrollreveal.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="${path}/resources/css/ksg/partyList.css" rel="stylesheet"/>

<div class="modal fade" id="listModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Wish List</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <button type="button" id="newWishList" class="btn btn-outline-dark" onclick="newAlias();">새 위시리스트 만들기</button>
        <ul id="wishListUl">
        
        </ul>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="createAliasModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Wish List</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" align="center">
		<input type="text" id="newAlias" autocomplete="off"/> <br/>최대 50자<br/><br/>
		<button id="newAliasBtn" class="btn btn-outline-dark" onclick="newAliasBtnClick();">새로 만들기</button>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
<c:if test="${!empty message}">
	<script>
		alert('${message}');
	</script>
</c:if>
<!-- partyList 필요 -->
<hr/>
<div id="mapBtn">
	<button onclick="location.href='${contextPath}/location/map';" class="btn btn-dark">지도보기</button>
</div>
<div id="wrap">
	<div id="partyListContainer">
		<ul id="partys">
		
		</ul>
	</div>
</div>
	<script>
	
	var page = 1;
	
	// 파티 상세 페이지로 이동
	function partyDetail(pnum){
		location.href="<c:url value='/partyDetail/detailOfParty?pNum="+pnum+"'/>";
	}
	// wishList
	
	function toggleHeart(heartElement) {
		if('${loginMember}' == ''){
			location.href="${path}/member/login";
		}else{
			if (heartElement.src.includes("${path}/resources/img/redHeart.png")) {
	            heartElement.src = "${path}/resources/img/emptyHeart.png"; // 빈 하트 이미지 경로로 변경
	            var pNum = $(heartElement).attr("id");
	            // dao.deleteWishList() 호출
	            $.ajax({
	                type: "POST",
	                url: "${path}/user/wishlist/deleteWishlist", // deleteWishlist에 해당하는 컨트롤러 URL
	                data: {pNum : pNum},
	                success: function(data) {
	                    console.log("Wish List deleted");
	                }
	            });
	        } else {
	        	heartElement.src = "${path}/resources/img/redHeart.png";
	            var pNum = $(heartElement).attr("id");
	        	$.ajax({
	        		type:"GET",
	        		url:"${path}/user/wishlist/getWishList",
	        		data:{
	        			mnum : "${loginMember.mnum}"
	        		},
	        		success:function(list){
	        			let str = "";
	        			$(list).each(function(){
	        				let alias = this.alias;
	            			let partyImage1 = this.partyImage1;	            			
	        				str += "<li id='"+alias+"' class='"+pNum+"' data-he='"+heartElement+"' onclick='addWishlist(this);'>";
	            			str += "<div>";
	            			str += "<div>";
	            			str += "<img src='${path}/image/printPartyImage?fileName="+partyImage1+"'/>";
	            			str += "</div>";
	            			str += "<div>";
	            			str += "<strong>"+alias+"</strong>";
	            			str += "</div>";
	            			str += "</div>";
	            			str += "</li>";
	        			});
	        			$("#wishListUl").html(str);
	        		}
	        	});
	        	$("#newWishList").attr("data-pnum", pNum);
	        	$("#listModal").modal("show");
	        }
		}
			
	  }
	
	function addWishlist(li){
        // dao.addWishList() 호출
        let alias = $(li).attr("id");
        let pNum = $(li).attr("class");
        $.ajax({
            type: "POST",
            url: "${path}/user/wishlist/addWishlist", // addWishlist에 해당하는 컨트롤러 URL
            data: {
            	pNum : pNum,
            	alias : alias
            },
            success: function(data) {
                $("#listModal").modal("hide");
            }
        });
    }
	function newAlias(){
		$("#listModal").modal("hide");
		let datapnum = $("#newWishList").attr("data-pnum");
		$("#newAlias").attr("data-pnum", datapnum);
		$("#createAliasModal").modal("show");
	}
	
	function newAliasBtnClick(){
		let inputAlias = $("#newAlias").val();
		console.log(inputAlias);
		let pnum = $("#newAlias").attr("data-pnum");
		$.ajax({
			type:"POST",
			url: "${path}/user/wishlist/addWishlist", // addWishlist에 해당하는 컨트롤러 URL
            data: {
            	pNum : pnum,
            	alias : inputAlias
            },
            success: function(data) {
                $("#createAliasModal").modal("hide");
            }
        });
	}
	
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(
				'${_csrf.headerName}',
				'${_csrf.token}');
	});
    </script>
