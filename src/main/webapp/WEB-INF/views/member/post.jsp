<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <link href="${path}/resources/css/in/member/post.css" rel="stylesheet">


<!-- 부트 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 부트 -->

	


<c:set var="path" value="${pageContext.request.contextPath}"/>

<c:set var="fd" value="${formattedDate}" />
<c:set var="pd" value="${formattedDate}" />
	<!-- 메시지함 만들기 -->
	<%-- <a href="${path}/user/bonpost">이미 본 알림</a> --%>
	<button type="button" id="bottle" class="btn btn-success"></button>
<!--
 	<div id="bottle">

	</div> 
	-->
	<div id="bottle2"></div>
<div id="postBox" >
<!-- 내용 -->
 </div>
 
 <!-- <button type="button" id="show">show</button> -->

<script type="text/javascript">
	
$(document).ajaxSend(function(e,xhr,options){
    xhr.setRequestHeader(
          '${_csrf.headerName}',
          '${_csrf.token}');
 });
	 
	var loginMemberId = '${loginMember.mid}';
	
	function checkAndClose(num){
//		alert(num);
		$.ajax({
			url : '${path}/notice/readPost',
			type : 'post',
			data : {
					noticeNum : num ,
					mid : loginMemberId
					},
			dataType : 'text',
			success : function (message) {
	//			console.log(message);
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
//        second = second >= 10 ? second : '0' + second;

        return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + '시' + minute+'분';// + ':' + second;
		}
	
	function receivePost(){
		
				let url = "${path}/notice/receivePost";
	//			console.log(loginMemberId+"ㅁ메버");
		 $.getJSON(url,{mid : loginMemberId}, function(post) {
				let str = "";
	       	// data == 읽지 않은 메일 , 내가 읽지 않은 메일! 
			   if (post.length > 0) {
				   $("#bottle").css("display","block");
				   let tooltipMsg = post.length+"개의 알림 읽지 않음";
				   let bottleStr = `<span id="tooltip"></span>`;
			//	   console.log(post);
				   //console.log('확인하지 않은 내용이 있습니다' + post.length);
			    	$("#bottle").html(post.length);
	//		    	$("#bottle2").append(bottleStr);			//
			    	
	//		    	$("#tooltip").html(tooltipMsg);
			    	$("#bottle").hover(
					        function() {
					        	$("#bottle2").css("display","block");	//
					            $("#tooltip").css("display","block");
					        },
					        function() {
					        	$("#bottle2").css("display","block");	//
					        	$("#tooltip").css("display","none");
					        }
					    );
					
			    	str += `<table id="postTable">`;
			    	// item == NoticeVO
			    post.forEach(function(post, index) { 
			    	
			    	var postDate = new Date(post.date);
			    //	var currentFormatDate = dateFormat(currentDate);
//			    	console.log(currentDate);
			    	let date = dateFormat(postDate);
			    //	console.log(currentFormatDate);
			    	//0째줄 
			    	str += '<tr class="postTr">';
			    	str += 	`<td class="postTd"><b>보낸 이:</b></td>`;
			    	str +=	`<td class="postTd"><b>관리자</b></td>`;
			    	str += '</tr>';
			    	// 첫째줄
			    	str += '<tr class="postTr">';
			    	str += 	`<td class="postTd"><b>발송 시간:</b></td>`;	
			    	str +=	`<td class="postTd"><b>\${date}</b></td>`;
			    	str += '</tr>';
			    	// 둘째줄
			    	str += '<tr class="postTr">';
			    	str += `<td class="postTd"><b>내용</b></td>`;
			    	str += `<td class="postTd"><b>\${post.context}</b></td>`;
			    	str += '</tr>';
			    	// 셋째줄
			    	str += '<tr class="postTr">';
			    	str += `<td class="postTd" colspan="2"><button class="postBtn" width="100%" id="checkBtn" data-num="\${post.noticeNum}">확인</button></td>`;
			    	str += '</tr>';
			    	
			    	
			    });
			    	str += `</table>`;
//				    console.log('str:' + str); 
			       $("#postBox").html(str);
				
			//    	$("#bottle").html(str);
			    // 여기서 필요한 추가 동작을 수행하세요.
			} else {
				
	//		    console.log('post : 없음');
			    
			  //  $("#post").css("display","block");
			    $("#postBox").css("display","block");
			    $("#postBox").toggle("fast");
			    $("#postBox").html("");
			    $("#bottle").css("display","none");
			 //   $("#bottle").css("display","block");
			 //   $("#bottle").toggle("fast");
			    $("#bottle").html("");
			    
			}
	  		  });
		
	}


	$(document).ready(function (){
	//	$("#post").style("display","none");
	
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
	//		  alert($(this).data("num"));  // 됨
			  checkAndClose($(this).data("num"));
			  receivePost();
		});
		
		
	});
</script>
