<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
 <c:set var="path" value="${pageContext.request.contextPath}"/>
 <script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%@ include file="../common/header.jsp" %>
<link href="${path}/resources/css/in/notice.css" rel="stylesheet"/>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

  <div id="wrap">
  <h1>확인한 알림</h1>
	<div id="post">
	</div>
  </div>	
	<script type="text/javascript">
	
	$(document).ajaxSend(function(e,xhr,options){
	    xhr.setRequestHeader(
	          '${_csrf.headerName}',
	          '${_csrf.token}');
	 });
		 
	
	
	
		bonPostList();	
		//확인 누르면 제거까지 됨
		function bonPostList(){
			
			str = "";
			$("#post").html(str);
			$.ajax({
				url : '${path}/notice/bonPostList', 
				method : 'post',
				data:{
					'${_csrf.headerName}':'${_csrf.token}',
					mid : '${loginMember.mid}'
				}, 
				dataType: 'json',
				success: function (list) {
					
					str += '<table class="table" id="postTable">';
					str += "<tr class='tableTr'>";
					str += '<th class="first">일자</th>';
					str += '<th>보낸이</th>';
					str += '<th>내용</th>';
					str += '</tr>';
				
					
					// readed속성이 y인 것만 가져온 리스트	// 일자 보낸이 내용
					$(list).each(function () {
						let dateFormat = new Intl.DateTimeFormat("ko" , {dateStyle:"full"});
	    			    let date = dateFormat.format(this.date);
						str += '<tr class="tableTr">';
						str += `<td>\${date}</td>`; 
						str += `<td>관리자</td>`; 
						str += `<td>\${this.context}</td>`; 
						str += '</tr>';
						str += '<tr>';
						str += '<td colspan="3"><button id="deleteBtn" class="btn btn-outline-dark" onclick="deletePost('+this.noticeNum+')" ';
						str += '>확인</button> 버튼을 누르면 삭제됩니다.</td>';
						str += '</tr>';
			//			console.log(this.noticeNum);
					}) // foreach
					str += '</table>'; // 끝
					$("#post").html(str);
				},
				error: function (error) {
					console.log(error)	
				}
				
			})	//ajax	
		} //end 
		
		function deletePost(no) {
			/* let stringNo = $("#deleteBtn").data("num");
			console.log(stringNo);
			no = stringNo/1;  */
			console.log(no);
			$.ajax({
				url : '${path}/notice/deletePost/'+no, 
				method : 'post',
				data:{
					'${_csrf.headerName}':'${_csrf.token}',
					mid : '${loginMember.mid}'
				}, 
				dataType: 'text',
				success: function (message) {
					alert(message);
					bonPostList();
					
				},
				error: function (error) {
					alert(error);	
				}
			})// ajax
		}
	</script>
<%@ include file="../common/footer.jsp" %>