<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" 
  rel="stylesheet" 
  integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" 
  crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <meta charset="UTF-8">
<title>Insert title here</title>
	<style>
	#bottle{
	display:none;
	position: fixed; 
	left : 200px; 
	top : 200px;
  	width: 20px;
	height: 20px;
	border-radius:50%;
	font-style: bold;
  	background-color: lightblue;
	}
	#bottle:hover {
    cursor: pointer;
	}
	#bottle:hover #tooltip {
    display: block;
	}
	#tooltip {
   	display: none;
    position: fixed;
    top: 200px;
    left: 110px;
    transform: translateX(-50%);
    background-color: rgba(0, 0, 0, 0.7);
    color: white;
    padding: 5px;
    border-radius: 3px;
    pointer-events: none; 
	}
	#post{
	display:none;
	position: fixed; 
	left : 230px; 
	top : 100px;
	}
	#postTable{
	border : 1px solid black;
	}
	
	
	#bottle2 {
	 position: fixed;
    top: 55px;
    left: 110px;		/*  */
  width: 30px;
  height: 20px;
  display: none;
}

/* 편지통 CSS  */

	#postTable {
  width: 100%;
  border-collapse: collapse;
  border: 1px solid #ccc;
}

#postTable th, #postTable td {
  padding: 8px;
  border: 1px solid #ccc;
}

#postTable th {
  background-color: #f2f2f2;
  text-align: left;
}

#checkBtn {
  width: 100%;
  padding: 5px 10px;
  background-color: #007bff;
  color: #fff;
  border: none;
  cursor: pointer;
}

#checkBtn:hover {
  background-color: #0056b3;
}
</style>
</head>
<body>
	</style>
	
	
</head>
<body>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<c:set var="fd" value="${formattedDate}" />
<c:set var="pd" value="${formattedDate}" />
	<!-- 메시지함 만들기 -->
	<div id="bottle">

	</div>
	<div id="bottle2"></div>
<div id="post" ><%-- 
												<div id ="postDate">
												도착시간이 표시됩니다! ${post.date} }
												</div>
												<div id="postContent">
												내용이 표시됨니다! ${post.context} 
												</div>
												<div id="okAndClose">확인버튼입니다.</div> --%>
 </div>
 
 <button type="button" id="show">show</button>

<script type="text/javascript">
/*				getjson하기로 함
	function receivePost() {
		console.log('rcving');
		$.ajax({
			url:'receivePost',
			type:'post',
			data: {}
			
			dataType:"json",
			success
		})
	}
	*/
//	setInterval(receivePost, 1000);
	
	function checkAndClose(num){
//		alert(num);
		$.ajax({
			url : '${path}/notice/readPost',
			type : 'post',
			data : {noticeNum : num},
			dataType : 'text',
			success : function (message) {
				console.log(message);
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
				console.log(url);
		 $.getJSON(url,{mId : 'reporter2'}, function(post) {
				let str = "";
	       	// data == 읽지 않은 메일 , 내가 읽지 않은 메일! 
			   if (post.length > 0) {
				   $("#bottle").css("display","block");
				   let tooltipMsg = post.length+"개의 알림 읽지 않음";
				   let bottleStr = `<span id="tooltip"></span>`;
//				   console.log(post);
//			    	console.log('확인하지 않은 내용이 있습니다' + post.length);
			    	$("#bottle").html(post.length);
			    	$("#bottle2").append(bottleStr);			//
			    	
			    	$("#tooltip").html(tooltipMsg);
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
			    	str += '<tr>';
			    	str += 	`<td>보낸 이:</td>`;
			    	str +=	`<td>관리자</td>`;
			    	str += '</tr>';
			    	// 첫째줄
			    	str += '<tr>';
			    	str += 	`<td>발송 시간:</td>`;	
			    	str +=	`<td>\${date}</td>`;
			    	str += '</tr>';
			    	// 둘째줄
			    	str += '<tr>';
			    	str += `<td>내용</td>`;
			    	str += `<td>\${post.context}</td>`;
			    	str += '</tr>';
			    	// 셋째줄
			    	str += '<tr>';
			    	str += `<td colspan="2"><button width="100%" id="checkBtn" data-num="\${post.noticeNum}">확인</button></td>`;
			    	str += '</tr>';
			    	
			    	
			    });
			    	str += `</table>`;
//				    console.log('str:' + str); 
			       $("#post").html(str);
				
			//    	$("#bottle").html(str);
			    // 여기서 필요한 추가 동작을 수행하세요.
			} else {
				
			    console.log('post : 없음');
			    
			  //  $("#post").css("display","block");
			    $("#post").css("display","block");
			    $("#post").toggle("fast");
			    $("#post").html("");
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
//			console.log('3초');
	        receivePost();
	    }, 3000);
		
		
		
		 	/* 아래 내용이 되도록 작성 */
		 	/*
		 <div id="post" value="">
			<div id ="postDate">
			도착시간이 표시됩니다! ${post.date} }
			</div>
			<div id="postContent">
			내용이 표시됨니다! ${post.context} 
			</div>
			<div id="okAndClose">확인버튼입니다.</div>
		 </div>
		 */
		 	
		 	
		 	
		$("#show").click(function () {
			$("#bottle").toggle("fast");
			
			
		});
		$("#bottle").click(function(){
			$("#post").toggle("fast");
		});
		
		
		$("#okAndClose").click(function(){
			$("#post").toggle("fast");
			$("#bottle").toggle("fast");
		});
		
		/*
		$("#checkBtn").click(function () {
			alert('되나');
		})
		*/
		  $("#post").on("click" , "#checkBtn" , function () {
			  //alert('이건 되나');  // 됨
			  checkAndClose($(this).data("num"));
			  receivePost();
		});
		
		
		
		/*   
		$(".close").click(function () {
		        $("#searchModal").toggle("fast");
		        $("#responsed").html("");
		      });
		 */
		
	});
</script>

<!-- 메시지함 만들기 -->
</body>
</html>