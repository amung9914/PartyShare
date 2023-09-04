<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../common/header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="${path}/resources/css/in/admin/searchOpt.css" rel="stylesheet"/>
<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<div id="wrap">
	<div id="searchOptBox">	
		<h1>관리자 검색 기준 관리</h1>
		<br/>
		<!-- 카테고리 수정 버튼 -->
		<button class="modal-button btn btn-dark" id="categoryBtn" data-target="modalCategory">카테고리 수정</button>
		<!-- <button class="modal-button" data-target="modalDate">날짜 수정</button>
		<button class="modal-button" data-target="modalLocation">위치 수정</button> -->
		
		<!-- 모달 -->
		<div id="modalCategory" class="modal">
		  <!-- 모달 내용 -->
		  <div class="modal-content">
		    <div>
		    <h1>카테고리 추가</h1>
		    <br/>
		     <input id="description" type="text" autocomplete="off" placeholder="description"/><button id="addDescription" class="btn btn-dark">설명 추가</button>
		     <br/><br/>
		     <input id="category" type="text" autocomplete="off" placeholder="category"/><button id="addCategory" class="btn btn-dark">카테고리 추가</button> <br/>
		     </div>
		    
		    <span class="close" onclick="closeModal('modalCategory')">&times;</span>
		  </div>
		</div>
		<div id="modalDate" class="modal">
		  <!-- 모달 내용 -->
		  <div class="modal-content">
		    <div>
		    <h1>날짜 수정</h1><br/>
		     <input type="text" placeholder="추가,삭제할 날짜" autocomplete="off"/>
		  		<button id="dateAdd" class="btn btn-dark">날짜 추가</button>	
		     	<button id="dateDelete" class="btn btn-dark">날짜 삭제</button>
		     	<br/>
		     </div>
		    <span class="close" onclick="closeModal('modalDate')">&times;</span>
		  </div>
		</div>
		<div id="modalLocation" class="modal">
		  <!-- 모달 내용 -->
		  <div class="modal-content">
		    
		    <span class="close" onclick="closeModal('modalLocation')">&times;</span>
		  </div>
		</div>
	</div>
</div>	
	
 
	<script>
		// 모달 열기 함수				
		function openModal(id) {
		  $("#"+id).css("display", "block");
		  if(id == "modalCategory" ){ 
			  let str = "";
			  let url = ""; 	
			  let data = ""; 
			  $.getJSON(url,function(data){ 
				 
					console.log(data);
					printList(data.list);
				});
			  
			  $("#description").append(str);
		  }else if(id == "modalDate"){
			  let str = "";
			  let url = ""; 	 
			  $.getJSON(url,function(data){ 
				  
					
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
				url : "${path}/admin/search/addCategory",
				data : {
					category : $("#category").val()
				},
				dataType : "text",
				success : function(result){
					alert(result);
					$("#category").val("");
				
				
				},
				error : function(res,status,error){
					alert(res.responseText);
				}
			});
		}); addDescription
		
		$("#addDescription").click(function(){
			console.log('add디스크립션');
			$.ajax({
				type : "post",
				url : "${path}/admin/search/addDescription",
				data : {
					description : $("#description").val()
				},
				dataType : "text",
				success : function(result){
					$("#description").val("");
				
				
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
<%@ include file="../common/fixFooter.jsp" %>