<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-latest.min.js"></script>
  <link href="${path}/resources/css/in/member/post.css" rel="stylesheet">


<!-- 부트 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 부트 -->

	


<c:set var="path" value="${pageContext.request.contextPath}"/>

<c:set var="fd" value="${formattedDate}" />
<c:set var="pd" value="${formattedDate}" />
	<!-- 메시지함 만들기 -->
	<button type="button" id="bottle" class="btn btn-success"></button>
	<div id="bottle2"></div>
<div id="postBox" >
<!-- 내용 -->
 </div>
 

<script type="text/javascript">
	
$(document).ajaxSend(function(e,xhr,options){
    xhr.setRequestHeader(
          '${_csrf.headerName}',
          '${_csrf.token}');
 });
	 
	var loginMemberId = '${loginMember.mid}';
	
	function checkAndClose(num){
		$.ajax({
			url : '${path}/notice/readPost',
			type : 'post',
			data : {
					noticeNum : num ,
					mid : loginMemberId
					},
			dataType : 'text',
			success : function (message) {
				receivePost();
			},
			error : function (error) {
				alert(error);
			} 
		});
	}
	
	function dateFormat(date) {
        let month = date.getMonth() + 1;
        let day = date.getDate();
        let hour = date.getHours();
        let minute = date.getMinutes();
 //       let second = date.getSeconds();

        month = month >= 10 ? month : '0' + month;
        day = day >= 10 ? day : '0' + day;
        hour = hour >= 10 ? hour : '0' + hour;
        minute = minute >= 10 ? minute : '0' + minute;

        return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + '시' + minute+'분';// + ':' + second;
		}
	
	function receivePost(){
		
				let url = "${path}/notice/receivePost";
			 $.getJSON(url,{mid : loginMemberId}, function(post) {
				let str = "";
	       	// data == 내가 읽지 않은 메일
			   if (post.length > 0) {
				   $("#bottle").css("display","block");
				   let tooltipMsg = post.length+"개의 알림 읽지 않음";
				   let bottleStr = `<span id="tooltip"></span>`;

				   $("#bottle").html(post.length);
			    	$("#bottle").hover(
					        function() {
					        	$("#bottle2").css("display","block");	
					            $("#tooltip").css("display","block");
					        },
					        function() {
					        	$("#bottle2").css("display","block");	
					        	$("#tooltip").css("display","none");
					        }
					    );
					
			    	str += `<table id="postTable">`;
			    	
			    post.forEach(function(post, index) { 
			    	
			    	var postDate = new Date(post.date);
			    	let date = dateFormat(postDate);
			    	// 1
			    	str += '<tr class="postTr">';
			    	str += 	`<td class="postTd"><b>보낸 이:</b></td>`;
			    	str +=	`<td class="postTd"><b>관리자</b></td>`;
			    	str += '</tr>';
			    	// 2
			    	str += '<tr class="postTr">';
			    	str += 	`<td class="postTd"><b>발송 시간:</b></td>`;	
			    	str +=	`<td class="postTd"><b>\${date}</b></td>`;
			    	str += '</tr>';
			    	// 3
			    	str += '<tr class="postTr">';
			    	str += `<td class="postTd"><b>내용</b></td>`;
			    	str += `<td class="postTd"><b>\${post.context}</b></td>`;
			    	str += '</tr>';
			    	// 4
			    	str += '<tr class="postTr">';
			    	str += `<td class="postTd" colspan="2"><button class="postBtn" width="100%" id="checkBtn" data-num="\${post.noticeNum}">확인</button></td>`;
			    	str += '</tr>';
			    	
			    	
			    });
			    	str += `</table>`;
			       $("#postBox").html(str);
				
			} else {
				
			    $("#postBox").css("display","block");
			    $("#postBox").toggle("fast");
			    $("#postBox").html("");
			    $("#bottle").css("display","none");
			    $("#bottle").html("");
			    
			}
	  		  });
		
	}


	$(document).ready(function (){

	
		receivePost();
		
		setInterval(function() {
	        receivePost();
	    }, 3000);
		
		
		$("#show").click(function () {
			$("#bottle").toggle("fast");
			
			
		});
		$("#bottle").click(function(){
			$("#postBox").toggle("fast");
		});
		
		
		$("#okAndClose").click(function(){
			$("#post").toggle("fast");
			$("#bottle").toggle("fast");
		});
		
		  $("#postBox").on("click" , "#checkBtn" , function () {
			  checkAndClose($(this).data("num"));
			  receivePost();
		});
		
		
	});
</script>
