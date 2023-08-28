<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/search.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="https://unpkg.com/scrollreveal@4.0.0/dist/scrollreveal.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<style>
	html, body {
	    height: 100%
	}
	
	#wrap {
		width: 100%;
	    min-height: 100%;
	    position: relative;
	    padding-bottom: 93px;
	    text-align: center;
	}
	
	#partyListContainer{
		width: 100%;
	}

	#partys{
		display: flex;
   		flex-wrap: wrap;
	}
	
	#partys li{
		list-style:none;
		width: 300px;
		height:400px;
		margin:1%;
	}
	
	#partys li .partyImg{
		width: 300px;
		height: 300px;
		cursor: pointer;
		border-radius: 10px;
	}
	
	#partys li .likeBtn{
		width: 25px;
		height:25px;
		cursor: pointer;
		position: relative;
		top: 40px;
		left: 120px;
	}
	
	#mapBtn{
		position: absolute;
		bottom: 120px;
		position: fixed;
		left:48%;
		z-index: 1;
	}
	#createPartyBtn{
		position: relative;
		left:87%;
	}
	#wishListUl{
		width: 400px;
	}
	#newWishList{
		width: 100%;
		
	}
	#wishListUl li{
		padding: 5px;
		width: 100%;
		list-style: none;
		height: 100px;
		display: inline-block;
		cursor: pointer;
	}
	#wishListUl li img{
		width: 100px;
		height : 100px;
		float: left;
	}
	#wishListUl li strong{
		float: left;
		line-height: 100px;
		margin-left:10%;
		font-size:20px;
	}
	#newAlias{
		width: 400px;
		height:50px;
		border-radius: 10px;
		border:1px solid black;
		text-align: center;
	}
	#newAliasBtn{
		width: 400px;
		height: 50px;
		
	}
	
</style>
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
      <div class="modal-body">
		<input type="text" id="newAlias" /> <br/>최대 50자<br/>
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
	
	var contextPath = '${pageContext.request.contextPath}';
	var page = 1;
	
	//listPage(page);
	
	// 파티 리스트를 가져와 출력 
	function listPage(page){
		const value= $("#searchKeyword").val();
		$.ajax({
			type:"GET",
			url:"${path}/party/searchPartyList/"+page,
			data:{
				keyword:value
			},
			success: function(data){
				printList(data);
			}
		});
	}
	
	// 가져온 파티 리스트 출력
	function printList(data){
		let str = "";
		let wishlistPnum = [];
		if(data.wishlist != null){
			$(data.wishlist).each(function(){
				let wishPnum = this.pnum;
				wishlistPnum.push(wishPnum);
			});	
		}
		
		$(data.list).each(function(){
			let pname = this.pname;
			let address = this.address;
			let date = this.formatStartDate +"~"+ this.formatEndDate;		
			let pnum = this.pnum;
			let path = this.partyImage1;
			let detailAddress = this.detailAddress;
			
			str += '<li>';
			// wishList 받아서 fullHeart.png로 출력
			if(data.wishlist != null){
				if(wishlistPnum.indexOf(pnum) < 0){
					str += "<img src='${contextPath}/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
				}else{
					str += "<img src='${contextPath}/resources/img/redHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
				}
			}else{
				str += "<img src='${contextPath}/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
			}
			str += '<img src="'+contextPath+'/image/printPartyImage?fileName='+path+'" class="partyImg" onclick="partyDetail('+pnum+');">';
			str += "<hr/>";
			str += "<strong onclick='partyDetail("+pnum+");' style='cursor: pointer;'>"+pname+"</strong><br/>";
			str += address+" "+detailAddress+"<br/>";
			str += date;
			str += "</li>";
		});
		$("#partys").append(str);
	} 
	
	// 파티 상세 페이지로 이동
	function partyDetail(pnum){
		location.href="<c:url value='/partyDetail/detailOfParty?pNum="+pnum+"'/>";
	}
	
	// 무한 페이징
	$(window).scroll(function(){
		let dh = $(document).height();
		let wh = $(window).height();
		let wt = $(window).scrollTop();
			
		if((wt+wh) >= (dh - 10)){
			if($("#partys li").size() <= 1){
				return false;
			}
			page++;
			listPage(page);
		}	
	});
	
	// wishList
	
	function toggleHeart(heartElement) {
		if('${loginMember}' == ''){
			$("#loginModal").modal("show");
		}else{
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
	        	heartElement.src = "${contextPath}/resources/img/redHeart.png";
	            var pNum = $(heartElement).attr("id");
	        	$.ajax({
	        		type:"GET",
	        		url:"${contextPath}/wishlist/getWishList",
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
	            			str += "<img src='${contextPath}/image/printPartyImage?fileName="+partyImage1+"'/>";
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
            url: "${contextPath}/wishlist/addWishlist", // addWishlist에 해당하는 컨트롤러 URL
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
			url: "${contextPath}/wishlist/addWishlist", // addWishlist에 해당하는 컨트롤러 URL
            data: {
            	pNum : pnum,
            	alias : inputAlias
            },
            success: function(data) {
                $("#createAliasModal").modal("hide");
            }
        });
	}
    </script>
