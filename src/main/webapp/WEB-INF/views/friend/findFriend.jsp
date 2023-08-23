<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style type="text/css">
	.findResult{
		display: none;
	}
</style>
</head>
<body>
<a class="btn btn-primary" data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample">
  친구찾기
</a>

<!-- offcanvas 출력 -->
<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="offcanvasExampleLabel">친구찾기</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
    <div>
      추가하고 싶은 상대방의 아이디 혹은 닉네임을 입력해주세요.
    </div>
    <br/>
    
	    <div class="input-group mb-3">
	    <select class="form-select" id="select">
		    <option value="mid">아이디</option>
		    <option value="mnick">닉네임</option>
	  	</select>
	 	 <input type="text" class="form-control" id="target" placeholder="입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2" required>
	 	 <button class="btn btn-outline-secondary" id="selectButton">찾기</button>
		</div>
	
    <!-- selectButton 제이쿼리로 클릭이벤트 -> find-result 보이게 출력 (완료)-->
    <!-- form태그로 submit 하면 ajax로 결과 받아와서 결과출력란에 보일 수 있도록! 구현하기 -->
    <div class="findResult" >
	    <!-- 검색 결과 출력 -->
	    
    </div> <!-- findResult end-->
    
  </div>
</div> <!-- end off-canvas -->

<script>

const loginMnum = ${loginMember.mnum};

// 엔터키 EventListener
document.getElementById("target")
	.addEventListener("keyup",function(e){
		if(e.code === 'Enter'){
			document.getElementById("selectButton").click();
		}
	});

$("#selectButton").on("click",function(event){
	$(".findResult").toggle();
	// 변수에 담는다.
	const select = $("#select").val();
	const target = $("#target").val();
	
	// 입력값이 없는 경우
	if(target == ""){
		let str = "추가하고 싶은 상대방의 아이디 혹은 닉네임을 입력해주세요.";
			$(".findResult").html(str);
	}else{
		findId();	
	}
	
	
	// DB에서 사용자를 찾는 함수
	function findId(){
		let url="friend/searchId/"+select+"/"+target;
		$.getJSON(url,function(data){
			let str = "";
			
			if(data.length === 0){
				$(".findResult").empty(); //기존내용삭제
				str += "일치하는 사용자가 없습니다.";
				$(".findResult").append(str);
			}else{
				// 반복문으로 검색결과를 페이지에 표시
				// 버튼에 data-mnum속성으로 mnum을 넣어줍니다. 
				$(data).each(function(){
					$(".findResult").empty();
					str +="<div data-mnum='"+this.mnum+"' class='username'>";
					str +="<img class='profileImg' src='${path}/friend/printImg?fileName="+this.profileImageName+"'/>";
					str += "id : "+this.mid+" | 닉네임 : "+this.mnick;
					str +="</div>"
					str += "<button data-mnum='"+this.mnum+"' class='btn btn-outline-secondary' type='button'>친구 요청</button><br/>";
					$(".findResult").append(str);
				});	
			}
				

			
			
		});
		
		
		
	} // end findId()
	
	
})// end selectButton

//친구 추가 버튼 클릭했을 때 
$(".findResult").on("click",".btn.btn-outline-secondary",function(){
	const target = $(this);
	let ffrom = loginMnum;
	let fto = target.attr("data-mnum");
	$.ajax({
		type : "POST",
		url : "friend/create",
		data: {
			ffrom,
			fto
		},
		dataType: "text",
		success : function(result){
			alert(result);
		},
		error : function(res){
			alert(res.responseText);
			
		}
		
	});
});

	
	
	

</script>

</body>
</html>