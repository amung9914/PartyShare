<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<c:choose>
			<c:when test="${!empty responseList}">
				<c:forEach var="list" items="${responseList}">
				    <div class="card friendView ${list.ffrom}">
					  <div class="card-body">
					  	<div class="cardBox">
					  		<img class="profileImg" src="${path}/user/friend/printImg?fileName=${list.profileImageName}" />
						    <div class="info">
						    <h5 class="card-title">${list.mnick}님에게 친구 요청을 받았습니다</h5>
						    <p class="card-text">${list.mid}</p>
						    <p class="card-text">
							    <f:formatDate var="now" pattern="yyyy년MM월dd일" value="<%= new java.util.Date() %>"/>
								<f:formatDate var="req" pattern="yyyy년MM월dd일" value="${list.requestTime}"/>
								<c:choose>
									<c:when test="${now == req}">
										<f:formatDate pattern="HH:mm:ss" value="${list.requestTime}"/>
									</c:when>
									<c:otherwise>
										${req}
									</c:otherwise>
								</c:choose>
							</p>
							</div>
						</div>
					  	<button class="acceptBtn btn btn-dark" id="${list.ffrom}">수락
						</button>
						<button class="rejectBtn btn btn-light" id="${list.ffrom}">거절
						</button>
					  </div>
					</div>
   				 </c:forEach>
    		</c:when>
    		<c:otherwise>
    			<br/>
    			<div class="card  mb-3">
				  <div class="card-body">
				     <p class="card-text">친구신청 내역이 존재하지 않습니다</p>
				  </div>
				</div>
    		</c:otherwise>
    </c:choose>
    
    
	
	<script>
	
	// 수락하기
	$(".acceptBtn").on("click",function(){
		const ffrom = this.id;
		let area = document.getElementsByClassName(ffrom);
		
		$.ajax({
			type : "PUT",
			url : "${path}/user/friend/accept/"+ffrom,
			dataType: "text",
			success : function(result){
				alert(result);
				area[0].remove();
				location.href="${path}/user/friend";
			},
			error : function(result){
				alert(result);
			}
		});
	
	});
	
	
	// 거절하기
	$(".rejectBtn").on("click",function(){
		const ffrom = this.id;
		let area = document.getElementsByClassName(ffrom);
		
		$.ajax({
			type : "DELETE",
			url : "${path}/user/friend/reject/"+ffrom,
			dataType: "text",
			success : function(result){
				alert(result);
				area[0].remove();
			},
			error : function(result){
				alert(result);
			}
		});
	
	});
	
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(
				'${_csrf.headerName}',
				'${_csrf.token}');
	});
	
	</script>		
