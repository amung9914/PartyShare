<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<h3> 친구 수락 여부를 확인해보세요 </h3>
	
	<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#responserequestList" aria-controls="offcanvasExample">
  친구신청목록
</button>

<div class="offcanvas offcanvas-start" tabindex="-1" id="responserequestList" aria-labelledby="offcanvasExampleLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" >친구신청 목록</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
    <div>
      내가 친구신청을 보낸 목록입니다.<br/>원치 않을 경우 친구신청을 취소할 수 있습니다. 
    </div>
    <c:choose>
			<c:when test="${!empty requestList}">
				<c:forEach var="requestList" items="${requestList}">
				    <div class="card ${requestList.fto}">
					  <div class="card-body">
					  	<div class="cardBox">
					  		<img class="profileImg" src="${path}/user/friend/printImg?fileName=${requestList.profileImageName}" />
						    <div class="info">
						    <h5 class="card-title">${requestList.mnick}</h5>
						    <p class="card-text">${requestList.mid}</p>
						    <p class="card-text">
							    <f:formatDate var="now" pattern="yyyy년MM월dd일" value="<%= new java.util.Date() %>"/>
								<f:formatDate var="req" pattern="yyyy년MM월dd일" value="${requestList.requestTime}"/>
								<c:choose>
									<c:when test="${now == req}">
										<f:formatDate pattern="HH:mm:ss" value="${requestList.requestTime}"/>
									</c:when>
									<c:otherwise>
										${req}
									</c:otherwise>
								</c:choose>
							</p>
							</div>
						</div>
					  	<button class="cancelBtn btn btn-light" id="${requestList.fto}">요청취소</button>
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
  </div> <!-- end offcanvas-body -->
</div>
	
	<script>
	
	$(".cancelBtn").on("click",function(){
		const fto = this.id;
		let area = document.getElementsByClassName(fto);
		$.ajax({
			type : "DELETE",
			url : "${path}/user/friend/deleteRequest/"+fto,
			dataType: "text",
			success : function(result){
				alert(result);
				area[0].remove();
			}
		});
	
	});
	
	</script>		
