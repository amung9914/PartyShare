<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="common/header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>
	html, body {
	    height: 100%
	    
	}
	body{
		text-align: -webkit-center;
	}
	#wrap {
	    min-height: 100%;
	    position: relative;
	    padding-bottom: 120px;
	}
	
	#modifyBox{
		width: 30%;
	}
	
	.profile_img_wrap{
		position: relative;
		right: 90px;
		margin: 20px auto;
		width: 250px;
	}
	
	.profile_img_wrap .profile_img{
		width:250px;
		height:250px;
		border-radius: 125px;
	}
	
	.profile_img_wrap .trash_cover{
		width: 40px;
		height: 40px;
		position:absolute;
		bottom: 5px;
		border:1px solid white;
		background-color: #aaaaaa99;
		border-radius:20px;
		padding: 4px;
		box-sizing:border-box;
	}
	
	.profile_img_wrap .trash_cover > label{
		display:block;
		background-image:url('${path}/resources/img/trash.png');
		background-size:30px;
		background-repeat:no-repeat;
		width: 30px;
		height: 30px;
		margin:0;
	}
	
	.profile_img_wrap .img_cover{
		width: 40px;
		height: 40px;
		position:absolute;
		bottom: 5px;
		right:5px;
		border:1px solid white;
		background-color: #aaaaaa99;
		border-radius:20px;
		padding: 4px;
		box-sizing:border-box;
	}
	
	.profile_img_wrap .img_cover > label{
		display:inline-block;
		background-image:url('${path}/resources/img/camera.png');
		background-size:30px;
		background-repeat:no-repeat;
		width: 30px;
		height: 30px;
		margin:0;	
	}
	
	.profile_img_wrap .img_cover .img_file, #delete_img{
		display: none;
	}
	
	#partyListContanier{
		margin-top: 3%;
		width: 50%;
	}
	#title2{
		margin-top:3%;
	}
	
	#modifyBox table tr th{
		font-size: 30px;
		text-align: center;
	}
	#partyImg{
		width: 200px;
		height: 200px;
	}
	#pmBox{
		text-align: center;
		font-size: 20px;
	}
	#pmBox a{
		text-decoration: none;
		color:black;
	}
	#modifyBox table input{
		border:none;
		outline: none;
		text-align: center;
	}
	#modifyBox table tr td {
		text-align: center;
	}
	
	.card-body{
		text-align: left;
	}
	
	.card-title{
		font-weight: bold;
	}
	
</style>
<div id="wrap">
	<h1 id="title">계정 정보</h1>
	<div class="profile_img_wrap">
		<img id="profile_img" class="profile_img" src="<c:url value='/image/printProfileImage?fileName=${loginMember.profileImageName}'/>"/>
		<div class="trash_cover" id="delete_img">
			<label></label>
		</div>
		<div class="img_cover">
			<label for="img_file"></label>
			<input type="file" class="img_file" id="img_file" accept=".gif, .jpg, .jpeg, .png" />
			<input type="hidden" id="uImage" />
		</div>
	</div>
	
	<form action="${path}/user/modify" method="post" enctype="multipart/form-data">
		<input type="hidden" name="mnum" value="${loginMember.mnum}"/>
		<input type="hidden" name="mbanCnt" value="${loginMember.mbanCnt}"/>
		<input type="hidden" name="mjoinCnt" value="${loginMember.mjoinCnt}"/>
		<input type="hidden" name="mblackYN" value="${loginMember.mblackYN}"/>
		<input type="hidden" name="withdraw" value="${loginMember.withdraw}"/>
		<input type="hidden" name="profileImageName" id="profileImageName" value="${loginMember.profileImageName}"/>
	
		<div id="modifyContainer">
			<div id="modifyBox">
				<table class="table">
					<colgroup>
						<col width="20%">
						<col width="80%">
					</colgroup>
					<tr>
						<th colspan="2">계정 수정</th>
					</tr>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="mid" value="${loginMember.mid}" readonly/></td>
					
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="mpw" value="${loginMember.mpw}" required/></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td><input type="password" name="passwordChk" value="${loginMember.mpw}" required/></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="mname" value="${loginMember.mname}" required/></td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td><input type="text" name="mnick" value="${loginMember.mnick}" readonly/></td>
					</tr>
					<tr>
						<td>나이</td>
						<td><input type="number" name="mage" value="${loginMember.mage}" required/></td>
					</tr>
					<tr>
						<td>email</td>
						<td><input type="email" name="memail" value="${loginMember.memail}" readonly/></td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input type="text" name="maddr" value="${loginMember.maddr}" required/></td>
					</tr>
					<tr>
						<td>성별</td>
						<td>
							<input type="radio" name="mgender" value="M" required 
								<c:if test="${loginMember.mgender eq 'M'}">checked</c:if>
							 />남자
							<input type="radio" name="mgender" value="F" required 
								<c:if test="${loginMember.mgender eq 'F'}">checked</c:if>
							/>여자
						</td>
					</tr>
					
					<tr>
						<td colspan="2" style="text-align: center">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<button class="btn btn-dark">수정완료</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</form>
	<div id="partyListContanier">
		<h2 id="title2">내가 참여했던 파티 목록</h2>
		<c:choose>
			<c:when test="${!empty joinPartyList}">
				<c:forEach var="list" items="${joinPartyList}">
					<div class="card mb-3" style="max-width: 540px; cursor: pointer;" onclick="partyDetail(${list.pnum});">
					  <div class="row g-0">
					    <div class="col-md-4">
					      <img src="${path}/image/printPartyImage?fileName=${list.partyImage1}" class="img-fluid rounded-start" >
					    </div>
					    <div class="col-md-8">
					      <div class="card-body">
					        <h5 class="card-title">${list.pname}</h5>
					        <p class="card-text">${list.formatStartDate} ~ ${list.formatEndDate}</p>
					        <p class="card-text">${list.address} ${list.detailAddress}</p>
					      </div>
					    </div>
					  </div>
					</div>
				</c:forEach>
				<div id="pmBox">
					<c:if test="${pm.prev}">
						<a href="<c:url value='/user/profileModify${pm.mkQueryStr(pm.startPage-1)}'/>">&laquo;</a>
					</c:if>
					
					<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
						<c:choose>
							<c:when test="${i eq pm.cri.page}">
								<a style="color:red;" href="<c:url value='/user/profileModify${pm.mkQueryStr(i)}'/>">[${i}]</a>
							</c:when>
							<c:otherwise>
								<a href="<c:url value='/user/profileModify${pm.mkQueryStr(i)}'/>">[${i}]</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<c:if test="${pm.next}">
						<a href="<c:url value='/user/profileModify${pm.mkQueryStr(pm.endPage+1)}'/>">&raquo;</a>
					</c:if>
				</div>
			</c:when>
			<c:otherwise>
				<h1>참여한 파티가 없습니다.</h1>
			</c:otherwise>
		</c:choose>	
	</div>
</div>	

<script>
	var contextPath = '${pageContext.request.contextPath}';
	// 프사 이미지 경로를 저장할 변수
	var profile = "";
	var oldProfileImageName = "";
	$("#img_file").on("change", function(){
		let files = this.files;
		let isImages = false;
		let formData = new FormData();
		formData.append("file", files[0]);
		
		let imgs = ['jpg','jpeg','png','gif'];
		for(let i = 0; i < imgs.length; i++){
			if(files[0].name.toLowerCase().endsWith(imgs[i])){
				isImages = true;		
			}
		}
		
		if(isImages){
			$.ajax({
				type:"POST",
				url: contextPath+"user/image/uploadAjax",
				data:formData,
				processData:false,
				contentType:false,
				dataType:"text",
				success:function(result){
					alert('프로필 이미지 변경 완료');
					// result : /2023/10/10/kdlsafghdlkzfgkl_sdlkfj.jpg
					$("#profileImageName").val(result);
					oldProfileImageName = '${loginMember.profileImageName}';
					profile = $("#profile_img").attr("src");
					$("#profile_img").attr("src", "<c:url value='/image/printProfileImage?fileName="+result+"'/>");
					// 업로드된 이미지를 삭제할 때 이미지 이름을 읽어올 입력태그
					$("#uImage").val(result);
					$("#delete_img").fadeIn("fast");
				}
			});
		}
	});
	
	$("#delete_img").click(function(){
		let fileName = $("#uImage").val();
		$.ajax({
			type:"DELETE",
			url: contextPath+"user/image/deleteFile",
			data : fileName,
			dataType:"text",
			success:function(result){
				alert('프로필 이미지 변경 취소');
				// 기본 프로필 이미지로 다시 변경
				$("#profile_img").attr("src", profile);
				$("#profileImageName").val(oldProfileImageName);
				// 쓰레기통 아이콘 삭제
				$("#delete_img").fadeOut("fast");
			}
		});
	});
	
	function partyDetail(pnum){
		location.href='${path}/partyDetail/detailOfParty?pNum='+pnum;
	}
</script>
<%@ include file="common/footer.jsp" %>