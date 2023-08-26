<!-- header.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<style>
/* 헤더정보 시작 */
*{margin:0 auto;
	padding:0}
header{
    width: 100%;
    height:100px;
    background: #FF385C;
	}
#headerDiv{
	width : 100%;
	height : 70px;
	margin :1px 0 0 0 ;
/* 	background: #FF385C; */
}
  div{	
  	display: flex; 
	/* background: gray; */
	width : 610px;
	height : 35px;
	display: inline-block;
	margin : 5px 0 0 0; 
	  }
#userMenu{
 /* 우측 : 선택바 위치 */
 	background: white;
 	display: block;
 	height:auto;
 	width :100%;
 	
}
#leftHd{
	margin : 0 0 0 20px;
}
#centerHd{
/*	display: flex;*/
}
.divC{
	display: inline-block;
	width: 150px !important;
	height:30px !important;
}
#rightHd{
	width:610px; 
	/*margin:100px;*/
}
#rightBox{
	width:270px;	
}

#menuBox{
	width:50px;
	height:30px;
	background-color: white;
	border-radius: 25%;
	
}

/* 헤더정보 끝 */
</style>
<meta charset="UTF-8">
<title>헤더</title>
</head>
<body>
<c:set var="path" value="${pageContext.request.contextPath}" />
<header>
<hr/>

	<div id="userMenu">
	<div id="menuBox"><a href="<c:url value='/'/>"> 홈ㅋ</a></div> 
	</div>
	<hr/>
	<div id="headerDiv">
<!-- 좌 -->	<div id="leftHd">
			<div><a href="<c:url value='/freeBoard/freeBoard'/>">자유게시판</a>&nbsp;&nbsp;&nbsp; <a href="${path}/admin/admin">관리자페이지 </a>
  								<a href="${path}/member/report"> 신고페이지</a>
  								<a href="${path}/member/post">post</a></div>
			</div>
	
<!-- 중  -->	<div id="centerHd">
				<div id="centerDivBox">
			 	
			<div class="divC"><a href="<c:url value='/party/partyHost?pnum=496'/>">partyMemberList</a></div>
			<div class="divC"><a href="<c:url value='/party/partyList'/>">partyList</a></div>
			<div class="divC"><a href="<c:url value='/friend'/>">친구리스트</a>&nbsp;<a href="<c:url value='/account'/>">계정관리</a></div>
			
		</div>
	</div>					<!-- -->
	
<!-- 우 -->		<div id="rightHd">
					<div id="rightBox">
					<%@ include file="../member/login.jsp" %></div>
					<div id="rightBox">
					
					<div id="menuBox">
					<a href="<c:url value='/member/profileModify?page=1'/>">프로필modify</a>
					</div> 
					</div>
				</div>
	</div>



<hr/>
</header>

<!-- 부트스트랩CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script>
	/* 로그인 해제 */
	const invalidate = '${invalidate}';
	if(invalidate != ''){
		alert(invalidate);
		location.href='<c:url value="/user/signOut"/>';
	}
</script>

</body>
</html>