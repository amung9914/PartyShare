<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://unpkg.com/scrollreveal@4.0.0/dist/scrollreveal.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<style>
	#partyListContainer{
		width: 90%;
		margin-left: 10%;
	}

	#partys{
		display: flex;
   		flex-wrap: wrap;
	}
	
	#partys li{
		list-style:none;
		padding:10px;
		width: 300px;
		height:400px;
		margin: 20px;
	}
	
	#partys li .partyImg{
		width: 300px;
		height: 300px;
		cursor: pointer;
		border-radius: 10px;
	}
	
	#partys li .likeBtn{
		width: 40px;
		height: 40px;
		cursor: pointer;
		position: relative;
		left: 260px;	
		top:40px;	
	}
	
	#mapBtn{
		position: absolute;
		bottom: 50px;
		position: fixed;
		left:48%;
	}
	
</style>

<c:if test="${!empty message}">
	<script>
		alert('${message}');
	</script>
</c:if>
<!-- partyList 필요 -->
<a href="<c:url value='/party/createParty'/>">파티등록</a><br/>
<div id="mapBtn">
	<button onclick="location.href='${contextPath}/location/map';" class="btn btn-dark">지도보기</button>
</div>
<hr/>
	<div id="partyListContainer" >
		
		<ul id="partys">
		
		</ul>
	</div>

	<script>
	
	var contextPath = '${pageContext.request.contextPath}';
	var page = 1;
	
	listPage(page);
	
	function listPage(page){
		let url = contextPath+"/party/partyList/"+page;
		$.getJSON(url,function(data){
			console.log(data.list);
			printList(data.list);
		});
	}
	
	function printList(list){
		let str = "";
		$(list).each(function(){
			let pname = this.pname;
			let address = this.address;
			let date = this.formatStartDate +"~"+ this.formatEndDate;		
			let pnum = this.pnum;
			let path = this.partyImage1;
			let detailAddress = this.detailAddress;
			
			str += '<li>';
			// wishList 받아서 fullHeart.png로 출력
			str += "<img src='"+contextPath+"/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>"
			str += '<img src="'+contextPath+'/image/printPartyImage?fileName='+path+'" class="partyImg" onclick="partyDetail('+pnum+');">';
			str += "<hr/>";
			str += "<strong onclick='partyDetail("+pnum+");' style='cursor: pointer;'>"+pname+"</strong><br/>";
			str += address+" "+detailAddress+"<br/>";
			str += date;
			str += "</li>";
		});
		$("#partys").append(str);
	}
	
	function partyDetail(pnum){
		location.href="<c:url value='/partyDetail/detailOfParty?pNum="+pnum+"'/>";
	}
	
	// wishList
	$("#partys").on("click", "li .likeBtn", function(){
		let likeImg = $(this).attr("src");
		if(likeImg == contextPath+'/resources/img/emptyHeart.png'){
			$(this).attr("src", contextPath+"/resources/img/redHeart.png");
		}else{
			$(this).attr("src", contextPath+"/resources/img/emptyHeart.png");
		}
	});
	
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
                	alias : "party"
                },
                success: function(data) {
                    console.log("Wish List added");
                }
            });
        }
    }
    </script>
