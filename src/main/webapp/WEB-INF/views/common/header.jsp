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
    position:fixed;
    width: 100%;
    height:100px;
    background: #FF385C;
    z-index:999;
    top:0;left:0;
	}
#headerDiv{
	width : 100%;
	height : 70px;
	margin :1px 0 0 0 ;
	background: #FF385C;
}
  div{	
  	display: flex; 
	background: gray;
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
<header>
<hr/>

	<div id="userMenu">
	<div id="menuBox">ㅇ</div> 
	</div>
	<hr/>
	<div id="headerDiv">
<!-- 좌 -->	<div id="leftHd">
			<div>여기도 하나</div>
			</div>
	
<!-- 중  -->	<div id="centerHd">
				<div id="centerDivBox">
			 	
			<div class="divC">아니</div><div class="divC">이렇게</div><div class="divC">하면</div>
			
		</div>
	</div>					<!-- -->
	
<!-- 우 -->		<div id="rightHd">
					<div id="rightBox">글자를 넣으면?</div>
					<div id="rightBox"><div id="menuBox">ㅇ</div> 
					<!-- 
					<select class="form-select" size="3" aria-label="size 3 select example">
					  <option selected>Open this select menu</option>
					  <option value="1">One</option>
					  <option value="2">Two</option>
					  <option value="3">Three</option>
					</select>
					-->
					</div>
				</div>
	</div>



<hr/>
</header>
<a href="<c:url value='home'/>"> 홈ㅋ</a>
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