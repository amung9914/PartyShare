<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
 <c:set var="path" value="${pageContext.request.contextPath}"/>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonPost</title>
</head>
<body>

  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <h1>확인한 알림</h1>
	<div id="post">
	
		
			
			
			
		
	
	</div>
	
	<script type="text/javascript">
	var loginMemberId = ""+'${loginMember.mid}'+"";
	
		bonPostList();	
		//확인 누르면 제거까지 됨
		function bonPostList(){
			
			str = "";
			$.ajax({
				url : '${path}/notice/bonpostList', 
				method : 'post',
				data:{
					mid : loginMemberId
				}, 
				dataType: 'text',
				success: function (list) {	
					str += '<table id="postTable">';
					str += "<tr class='tableTr'>";
					str += '<th>일자</th>';
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
						str += '<td colspan="3"><button id="deleteBtn" onclick="deletePost()" ';
						str += ' data-num="\${this.no}">확인</button></td>';
						str += '</tr>';
					}) // foreach
					str += '</table>'; // 끝
					$("#post").html(str);
				},
				error: function (error) {
					console.log(error)	
				}
				
			})	//ajax	
		} //end 
		
		function deletePost() {
			let no = $("#deleteBtn").data("num");
			$ajax({
				url : '${path}/notice/deletePost', 
				method : 'post',
				data:{
					no : no , 
					mid : loginMemberId
				}, 
				dataType: 'text',
				success: function (list) {	
					bonPostList();	
				},
				error: function (error) {
					alert(error);	
				}
			})// ajax
		}
	</script>
</body>
</html>