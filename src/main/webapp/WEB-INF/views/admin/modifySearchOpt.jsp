<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 옵션 관리</title>
<style>
/* 모달 스타일 */
.modal {
  display: none; /* 모달을 기본적으로 숨김 */
  position: fixed;
  z-index: 1; /* 다른 요소들보다 위에 위치 */
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto; /* 스크롤 가능하도록 설정 */
  background-color: rgba(0,0,0,0.4); /* 배경을 어둡게 */
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto; /* 모달 창을 중앙에 위치 */
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

/* 닫기 버튼 스타일 */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
</style>
<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<body>
	<h1>관리자 검색 기준 관리</h1>
	
	<!-- 카테고리 수정 버튼 -->
	<button class="modal-button" data-target="modalCategory">카테고리 수정</button>
	<button class="modal-button" data-target="modalDate">날짜 수정</button>
	<button class="modal-button" data-target="modalLocation">위치 수정</button>
	
	<!-- 모달 -->
	<div id="modalCategory" class="modal">
	  <!-- 모달 내용 -->
	  <div class="modal-content">
	    <div>
	     카테고리 수정 누르면 나오는 모달<br/>
	     <input id="description" type="text" placeholder="description"/>
	     <input id="category" type="text" placeholder="category"/><br/>
	  		<button id="addDescription">설명 추가</button> 
	  		<button id="addCategory">카테고리 추가</button> <br/>
	  		
	  		<div>
		        <ul id="categoryList"> <!-- li태그로 출력하기 : category TABLE -->
		         	<!-- 리스트 요소 개수만큼 반복문이 돌 예정 / 고로 나왔냐 이후 반환받는 타입은list == dataType from Ajax  -->
		         	
		        </ul>
   			 </div>
   			 <div>
		        <ul id="descriptionList"> <!-- $("#descriptionList").append(str); -->
		        	<!-- 리스트 요소 개수만큼 반복문이 돌 예정 / 고로 나왔냐 이후 반환받는 타입은list == dataType from Ajax  -->
		          <!-- 설명 출력하는 function-->
		        </ul>
   			 </div>
	  		
	     
	     </div>
	    
	    <span class="close" onclick="closeModal('modalCategory')">&times;</span>
	  </div>
	</div>
	<div id="modalDate" class="modal">
	  <!-- 모달 내용 -->
	  <div class="modal-content">
	    <div>
	     날짜 수정 누르면 나오는 모달<br/>
	     <input type="text" placeholder="추가,삭제할 날짜"/>
	  		<button id="dateAdd">날짜 추가</button>	
	     	<button id="dateDelete">날짜 삭제</button>
	     </div>
	    <span class="close" onclick="closeModal('modalDate')">&times;</span>
	  </div>
	</div>
	<div id="modalLocation" class="modal">
	  <!-- 모달 내용 -->
	  <div class="modal-content">
	    <div> 위치 수정 누르면 나오는 모달</div>
	    
	    <span class="close" onclick="closeModal('modalLocation')">&times;</span>
	  </div>
	</div>
	
	
	
 
	<script>
		// 모달 열기 함수				
		function openModal(id) {
		  $("#"+id).css("display", "block");
		  if(id == "modalCategory" ){ //'카테고리 수정'버튼을 눌렀을 때
			  let str = "";
			  let url = ""; 	// 카테고리와 리스트 모두를 불러올 수 있는것 
			  let data = ""; 
			  $.getJSON(url,function(data){ // 안쪽은 data 활용구문 // 출력값은 list 인데  // categoryList와 descriptionList를 모두....
				  	// list<list<>>
					// data == Map
					// {'list':{}, 'pm' : {}}
					console.log(data);
					printList(data.list);
					// printPage(data.pm);
				});
			  
			  $("#description").append(str);
		  }else if(id == "modalDate"){
			  let str = "";
			  let url = ""; 	 
			  $.getJSON(url,function(data){ // 안쪽은 data 활용구문 // 출력값은 list 인데  // categoryList와 descriptionList를 모두....
				  
					
				});
			  
		  }else if(id == "modalLocation"){
			  console.log("modalLocation나왔냐")
		  }
		}
		
		// 모달 닫기 함수
		function closeModal(id) {
		  $("#"+id).css("display", "none");
		}
		
		// target으로 열기 버튼 구현
		$(".modal-button").click(function () {
			var target = $(this).data("target");
			openModal(target);
		});
	</script>
	
				
	<script> /* 카테고리 리스트를 출력하는 스크립트 */
        function addListItem(text) {
            var ul = document.getElementById("categoryList");
            var li = document.createElement("li");
            li.appendChild(document.createTextNode(text));
            ul.appendChild(li);
        }

        // 리스트 아이템 생성을 위한 데이터 배열
     //   var categoryList = ["항목 1", "항목 2", "항목 3"]; // 카테고리 리스트로 교체됨

        // 반복문을 사용하여 리스트 아이템 생성
        for (var i = 0; i < categoryList.length; i++) {
            addListItem(categoryList[i]);
        }
        /* 카테고리 리스트를 출력하는 스크립트 끝 */
    </script>	
	
	<script>		/* 날짜 수정을 위한 스크립트 */
	
	</script>
	
	
	<script type="text/javascript">   /* AJAX는 여기 */
		
		$("#addCategory").click(function(){
			console.log('add카테고리');
			$.ajax({
				type : "POST",
				url : "${path}/search/addCategory",
				data : {
					category : $("#category").val()
				},
				dataType : "text",
				success : function(result){
					alert(result);
					$("#category").val("");
				//	$("#targetid").val("");
				//	$("#sender").val("");  	val의 매개변수가 없다면 값을 흡수한다.
				//	$("#message").val("");	val의 매개변수가 존재하면 그 매개변수로 값을 변경한다.
				//	$("#targetid").focus(); 포커스가 들어간다.
				//	getMessageList();
				
				},
				error : function(res,status,error){
					alert(res.responseText);
				}
			});
		}); addDescription
		
		$("#addDescription").click(function(){
			console.log('add디스크립션');
			$.ajax({
				type : "get",
				url : "${path}/search/addDescription",
				data : {
					description : $("#description").val()
				},
				dataType : "text",
				success : function(result){
					alert("여기야? desc");
					$("#description").val("");
				//	$("#targetid").val("");
				//	$("#sender").val("");  	val의 매개변수가 없다면 값을 흡수한다.
				//	$("#message").val("");	val의 매개변수가 존재하면 그 매개변수로 값을 변경한다.
				//	$("#targetid").focus(); 포커스가 들어간다.
				//	getMessageList();
				
				},
				error : function(res,status,error){
					alert(res.responseText);
				}
			});
		});
	</script>
	<script>
   $(document).ajaxSend(function(e,xhr,options){
      xhr.setRequestHeader(
            '${_csrf.headerName}',
            '${_csrf.token}');
   });
</script>
</body>
</html>
