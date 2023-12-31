<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link href="${path}/resources/css/sy/friend.css" rel="stylesheet"/>

<a class="btn btn-primary" data-bs-toggle="offcanvas" href="#offcanvasfind" role="button" aria-controls="offcanvasExample">
  친구찾기
</a>

<!-- offcanvas 출력 -->
<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasfind" aria-labelledby="offcanvasExampleLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" >친구찾기</h5>
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
		let url="${path}/user/friend/searchId/"+select+"/"+target;
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
					str +="<img class='profileImg' src='${path}/user/friend/printImg?fileName="+this.profileImageName+"'/>";
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
	
	if(ffrom==fto){
		alert("본인은 추가할 수 없습니다.");
	}else{
	$.ajax({
		type : "POST",
		url : "${path}/user/friend/create",
		data: {
			ffrom,
			fto
		},
		dataType: "text",
		success : function(result){
			alert(result);
			location.href="${path}/user/friend";
		},
		error : function(res){
			alert(res.responseText);
			
		}
		
	});
	}
});

$(document).ajaxSend(function(e,xhr,options){
	xhr.setRequestHeader(
			'${_csrf.headerName}',
			'${_csrf.token}');
});
	
	

</script>
