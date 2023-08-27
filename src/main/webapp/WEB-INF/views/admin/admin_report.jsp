<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8">
<c:set var="path" value="${pageContext.request.contextPath}"/>
<title>admin_report.jsp</title>
<style type="text/css">
	#reportTable{
	border: 1px solid black; 
	}
	 .reportTd {
    width: auto;
    height: 25px;
    border: 1px solid black;
    border-collapse: collapse;
 	}
 	#reportTr:hover{
 	cursor: pointer;
  	}
   
  .detailDiv{
  	display: none;
  	overflow: auto;
  	width : 60%;
  	margin: 0 20% 0 20%;
  	height: auto;
 	background-color: rgb(128, 128, 128);
 	color: white;
 	border: 1px solid black;
  }
  #black_or_ok{
  border: 1px solid black;
  }
  	
</style>
</head>
<body>
	<h1>신고 내역 확인</h1>
	<button id="changeBtn" onclick="reportedBoard()">게시판 신고 내역 보기</button>
	<button id="partyBoardBtn" onclick="reportedPartyBoard()">party게시판 신고 내역 보기</button>
	<table id="reportTable">
		
	</table>
	<div id="detailDiv"></div>
	<script>
	/*
	function printList() {
		for (let i = 0; i < reportList.length; i++) {
	        
	    }
	   
	    
	}
	*/
	var mode = 'member';
	function reportedBoard(){
		$.ajax({
			url:'${path}/report/reportedBoard' ,
			method:'post',
			data :{},
			dataType :'json',
			success:function(list){ //성공절
				str ="";
				pageStr = "";
				str += "<tr>";
				str += "<th>순번</th>";
				str += "<th>신고자</th>";
				str += "<th>대상</th>";
				str += "<th>날짜</th>";
				str += "<th>분류</th>";
				str += "<th>게시글 번호</th>";
				str += "<th>댓글 번호</th>";
				str += "</tr>";
		//		pageStr += `<div>&lt;</div>`;
					$(list).each(function(){
				
						
						   	str += `<tr id="reportTr" >`;
							
						   	str += `<td class='reportTd' onclick='reportDetail(\${this.no})'>\${this.no}</td>`;
						   	str += `<td class='reportTd'>\${this.fromMid}</td>`;
						   	str += `<td class='reportTd'>\${this.toMid}</td>`;
						   	str += `<td class='reportTd'>\${this.date}</td>`;
						   	str += `<td class='reportTd'>\${this.category}</td>`;
						   	str += `<td class='reportTd' id="B" onclick='boardReportDetail("b"+\${this.bno})'>\${this.bno}</td>`;
						   	str += `<td class='reportTd'class="B" id="C" onclick='boardReportDetail("c"+\${this.cno})'>\${this.cno}</td>`;
						   	str +=	`</tr>`;
						
						   	
						  }) //each
						  $("#detailDiv").css("display","none");
						  $("#reportTable").html(str);
						  $("#changeBtn").attr("onclick","reportList()");
						  $("#changeBtn").html("유저 신고 내역 보기");
						  $("#reportTable").after(pageStr);
						
						},
			error:function(){
									
			}
			
		})
	}

	function reportedPartyBoard(){
		 $.post("${path}/report/reportedPartyBoard",function(list){ //List<PbReportVO>
			    console.log(list);
			    console.log(typeof list);
			   // console.log('위가 제이슨');
			    
			    let str = "";
				str += "<tr>";
				str += "<th>순번</th>"; //1
				str += "<th>신고자</th>"; //2
				str += "<th>대상</th>";	//3
				str += "<th>날짜</th>";	//4
				str += "<th>분류</th>";	//5
				str += "<th>읽음</th>";//6 처리
				str += "<th>파티번호</th>";//7
				str += "<th>게시글 번호</th>";//8
				str += "<th>댓글 번호</th>";//9
				str += "</tr>";
			    	$(list).each(function(){	// pbReportVO
	    		let dateFormat = new Intl.DateTimeFormat("ko" , {dateStyle:"full"});
			    let date = dateFormat.format(this.date);
			   	str += `<tr id="reportTr">`;
				
			   	str += `<td class='reportTd'>\${this.no}</td>`;
			   	str += `<td class='reportTd'>\${this.fromMid}</td>`;
			   	str += `<td class='reportTd'>\${this.toMid}</td>`;
			   	str += `<td class='reportTd'>\${date}</td>`;
			   	str += `<td class='reportTd'>\${this.category}</td>`; //5
			   	str += `<td class='reportTd'>\${this.readed}</td>`; //6
			   	str += `<td class='reportTd'>\${this.pnum}</td>`; //7
			   	str += `<td class='reportTd' onclick='PbReportDetail("b"+\${this.bno})'>\${this.bno}</td>`; //8
			   	str += `<td class='reportTd' id="comment" onclick='PbReportDetail("c"+\${this.cno})'>\${this.cno}</td>`; //9	/
			   		/*		cno를 매개로 전달 -> 원본VO와 댓글VO 모두 로드 		*/
//내용 안 보이게	   	str += `<td class='reportTd'>\${this.context}</td>`;
				if(this.cno == 0){
					$("#comment").attr("disabled","disabled");
					}
			   	str +=	`</tr>`;
	//		    	console.log(str);
			    	})
			    	  $("#detailDiv").css("display","none");
			    	 $("#reportTable").html(str);
		//	    	 $("#changeBtn").attr("onclick","reportedBoard()");
		//	    	 $("#changeBtn").html("게시판 신고 내역 보기");
			    });
	}
	/* /* /* /* /* /* /* 그냥 freeboard 원본을 수정 */ 
	// onclick='boardReportDetail("b"+\${this.bno})'
	function boardReportDetail(no){
		if(no.startsWith("c")){			//댓글
			no = no.substring(1);
			 	alert(no);
			 	let originalBoardNum = 0;
			 	let originalText = "없음";
			 	let originalWriter = "없음";
			 	
			 	let str = ""; // 이전으로 뺐음 (1ajax와 2ajax를 사용)
			 	$("#detailDiv").html(str);	//가장 먼저 없애고
			 	//원본추출 시작
			 $.ajax({
				url : '${path}/report/boardReportOriginal/'+no,
				method : 'post',
				data:{},
				dataType:'json',
				async : false ,
				success : function (original) {
					console.log(original);
					console.log('원본 추출이 먼저');
					str += `원본 글 번호: \${original.bno}<br/>`;
					str += `원본 글 작성자: \${original.mnick}<br/>`;
					str += `원본 글 내용: \${original.context}<br/>`;
					$("#detailDiv").html(str);
				},
				error : function(error){
					alert('아나');
				}
			}) 
			console.log(str + "원본 이후");
			 	//원본추출 끝
			
	    	$.ajax({
	    		url:'${path}/report/boardReportComment/'+no,	// cno 
	    		method : 'post',
	    		data : {},
	    		dataType:'json',
	    		async : false ,
	    		success : function (comment){
	    			let str = "";
	    			console.log('댓글 추출이 먼저');
	//    	
	    			str += `댓글 번호: \${comment.cno}<br/>`;
	    			str += `댓글 내용:\${comment.commentText}<br/>`;
	//    			console.log(originalWriter + "작성자 2");
	    			str += `<div id='black_or_ok'>`;
	    			str += `<button id='blindBoardComment' class='confirm' data-target='\${no}'>댓글 가리기</button>`;
	    			str += `<button id='ok' class='confirm'>확인</button>`;
	    			str += `</div>`;
	    			str += `<div>`;
	    			
	    			$("#detailDiv").append(str);
	    		
	    				$("#detailDiv").css("display","block");
	    		},
	    		error : function (error) {
					alert(error);
				}
	    	}); // ajax 코멘트절
	    			
	    
					
		}else if(no.startsWith("b")){						//원본글						
			no = no.substring(1);
//			 	alert(no);
	    	$.ajax({
	    		url:'${path}/report/boardReportBoard/'+no,	//bno
	    		method : 'post',
	    		data : {},
	    		dataType:'json',
	    		success : function (board){ 
	    			console.log(board);
	    			let str = "";
	    			$("#detailDiv").html(str);	//비워주고
	    			str += `<div>`;
	    			str += '신고 분류 : 원본 글<br/>';
	    			str += `게시글 번호: \${no}<br/>`;
	    			str += `게시글 분류:\${board.category}<br/>`;
	    			str += `작성자:\${board.mnick}<br/>`;
	    			str += `게시글 내용:\${board.context}<br/>`;
	    			str += `<div id='black_or_ok'>`;
	    			str += `<button id='blindFreeBoard' class='confirm' data-target='\${no}'>원본 글 가리기</button>`;
	    			str += `<button id='ok' class='confirm'>확인</button>`;
	    			str += `</div>`;
	    			str += `<div>`;
	    			
	    			$("#detailDiv").append(str);
	    		
	    				$("#detailDiv").css("display","block");
	    		},
	    		error : function (error) {
					//alert('에러');
				}
	    	}); // ajax
		}else{
			alert('확인할 수 없습니다.');
		}
		//alert('PbReportDetail 작동 중' + no);
	}
	/* /* /* /* /* /* /* 그냥 freeboard 원본을 수정 */ 
	
	
	function PbReportDetail(no){
		if(no.startsWith("c")){			//댓글
			no = no.substring(1);
			 	alert(no);
			 	let originalBoardNum = 0;
			 	let originalText = "없음";
			 	let originalWriter = "없음";
			 	
			 	let str = ""; // 이전으로 뺐음 (1ajax와 2ajax를 사용)
			 	$("#detailDiv").html(str);	//가장 먼저 없애고
			 	//원본추출
			 		$.ajax({
				url : '${path}/report/PbReportOriginal/'+no,
				method : 'post',
				data:{},
				dataType:'json',
				async : false ,
				success : function (original) {
					console.log(original);
					console.log('원본 추출이 먼저');
					str += `원본 글 번호: \${original.bno}<br/>`;
					str += `원본 글 작성자: \${original.writer}<br/>`;
					str += `원본 글 내용: \${original.content}<br/>`;
					$("#detailDiv").html(str);
				},
				error : function(error){
					alert('아나');
				}
			}) 
			console.log(str + "원본 이후");
			 	//원본추출 끝
			
	    	$.ajax({
	    		url:'${path}/report/PbReportComment/'+no,	// cno 
	    		method : 'post',
	    		data : {},
	    		dataType:'json',
	    		async : false ,
	    		success : function (comment){
	    			let str = "";
	    			console.log('댓글 추출이 먼저');
	 
	    			str += `댓글 번호: \${comment.cno}<br/>`;
	    			str += `댓글 내용:\${comment.commentText}<br/>`;
	//    			console.log(originalWriter + "작성자 2");
	    			str += `<div id='black_or_ok'>`;
	    			str += `<button id='blindPartyComment' class='confirm' data-target='\${no}'>댓글 가리기</button>`;
	    			str += `<button id='ok' class='confirm'>확인</button>`;
	    			str += `</div>`;
	    			str += `<div>`;
	    			
	    			$("#detailDiv").append(str);
	    		
	    				$("#detailDiv").css("display","block");
	    		},
	    		error : function (error) {
					alert(error);
				}
	    	}); // ajax 코멘트절
	    			
	    
					
		}else if(no.startsWith("b")){						//원본글						
			no = no.substring(1);
			 	alert(no);
	    	$.ajax({
	    		url:'${path}/report/PbReportBoard/'+no,	//bno
	    		method : 'post',
	    		data : {},
	    		dataType:'json',
	    		success : function (board){ 
	    			console.log(board);
	    			let str = "";
	    			$("#detailDiv").html(str);	//비워주고
	    			str += `<div>`;
	    			str += '신고 분류 : 원본 글<br/>';
	    			str += `게시글 번호: \${no}<br/>`;
	    			str += `게시글 분류:\${board.category}<br/>`;
	    			str += `작성자:\${board.writer}<br/>`;
	    			str += `게시글 내용:\${board.content}<br/>`;
	    			str += `<div id='black_or_ok'>`;
	    			str += `<button id='blindPartyBoard' class='confirm' data-target='\${no}'>원본 글 가리기</button>`;
	    			str += `<button id='ok' class='confirm'>확인</button>`;
	    			str += `</div>`;
	    			str += `<div>`;
	    			
	    			$("#detailDiv").append(str);
	    		
	    				$("#detailDiv").css("display","block");
	    		},
	    		error : function (error) {
					//alert('에러');
				}
	    	}); // ajax
		}else{
			alert('확인할 수 없습니다.');
		}
		//alert('PbReportDetail 작동 중' + no);
	}
	
	    reportList();
	    
	$(document).ready(function(){
		$("#detailDiv").css("display", "none");
		
		$("#detailDiv").on("click", "#black", function(){ //버튼
			let target = $(this).data('target');
						
			$.ajax({
				method : 'post' ,
				url : '${path}/admin/blackMember' , 
				data :{target : target} ,
				dataType : 'text' , 
				success : function( result){
					alert(result);
				} ,
				error : function(error){
				//	alert("어");
				}
			}); //ajax
			
		});//on click
		//blindFreeBoard
		$("#detailDiv").on("click", "#blindFreeBoard", function(){ //버튼
			let target = $(this).data('target');
			console.log(target);
			
			$.ajax({
				method : 'post' ,
				url : '${path}/board/blindFreeBoard' , 
				data :{bno : target} ,
				dataType : 'text' , 
				success : function( result){
				alert(result);
				} ,
				error : function(error){
				//	alert("어");
				}
			}); //ajax
		})
			
			//blindBoardComment
		$("#detailDiv").on("click", "#blindBoardComment", function(){ //버튼
			let target = $(this).data('target');
			console.log(target);
			
			$.ajax({
				method : 'post' ,
				url : '${path}/board/blindBoardComment' , 
				data :{cno : target} ,
				dataType : 'text' , 
				success : function( result){
				alert(result);
				} ,
				error : function(error){
				//	alert("어");
				}
			}); //ajax	
		})
		//ㄱㅊ
		$("#detailDiv").on("click", "#blindPartyBoard", function(){ //버튼
			let target = $(this).data('target');
			console.log(target);
			$.ajax({
				method : 'post' ,
				url : '${path}/board/blindPartyBoard' , 
				data :{bno : target} ,
				dataType : 'text' , 
				success : function( result){
					alert(result);
				} ,
				error : function(error){
				//	alert("어");
				}
			}); //ajax
			
		});//on click
		//ㄱㅊ
		$("#detailDiv").on("click", "#blindPartyComment", function(){ //버튼
			let target = $(this).data('target');
			console.log(target);
			$.ajax({
				method : 'post' ,
				url : '${path}/board/blindPartyComment' , 
				data :{cno : target} ,
				dataType : 'text' , 
				success : function( result){
					alert(result);
				} ,
				error : function(error){
				//	alert("어");
				}
			}); //ajax
		});
		
		$("#detailDiv").on("click", "#ok", function(){
			alert("확인했습니다.");
		});
		
	 }); // ready
		
	
//	$(document).ready(function() {
	    function reportDetail(no){
	    	//alert(no);
	    	$.ajax({
	    		url:'${path}/report/reportDetail/'+no,
	    		method : 'post',
	    		data : {no : no},
	    		dataType:'json',
	    		success : function (reportVO){ // 컨트롤러 가서 
	    			console.log(reportVO)
	    			let str = "";
	    			//if()
	    			$("#detailDiv").html(str);
	    			str += `<div>`;
	    			str += `번호: \${reportVO.no}<br/>`;
	    			str += `신고 내용:\${reportVO.context}<br/>`;
	    			str += `게시글 번호:\${reportVO.bno}<br/>`;
	    			str += `댓글 번호:\${reportVO.cno}<br/>`;
	    			str += `<div id='black_or_ok'>`;
	    			str += `<button id='black' class='confirm' data-target='\${reportVO.toMid}'>유저 블랙리스트</button>`;
	    			str += `<button id='ok' class='confirm'>확인</button>`;
	    			str += `</div>`;
	    			str += `<div>`;
	    			
	    			$("#detailDiv").append(str);
	    		
	    				$("#detailDiv").css("display","block");
	    			
	    			
	    			
	    		//	str ="";
	    		},
	    		error : function (error) {
					//alert('에러');
				}
	    	}); // ajax
	    } // function
	  //  function reportList(){
	//	 $(document).ready(function() {
		 function reportList() {
			 $.getJSON("${path}/report/reportList",function(list){ //List<ReportVO>
				    console.log(list);
				    console.log(typeof list);
				  
				    let str = "";
					str += "<tr>";
					str += "<th>순번</th>";
					str += "<th>신고자</th>";
					str += "<th>대상</th>";
					str += "<th>날짜</th>";
					str += "<th>분류</th>";
					str += "</tr>";
				    	$(list).each(function(){	// ReportVO
				   	str += `<tr id="reportTr" onclick='reportDetail(\${this.no})'>`;
				   	str += `<td class='reportTd'>\${this.no}</td>`;
				   	str += `<td class='reportTd'>\${this.fromMid}</td>`;
				   	str += `<td class='reportTd'>\${this.toMid}</td>`;
				   	str += `<td class='reportTd'>\${this.date}</td>`;
				   	str += `<td class='reportTd'>\${this.category}</td>`;
				   	str +=	`</tr>`;
				    	console.log(str);
				    	})
				    	  $("#detailDiv").css("display","none");
				    	 $("#reportTable").html(str);
				    	 $("#changeBtn").attr("onclick","reportedBoard()");
				    	 $("#changeBtn").html("게시판 신고 내역 보기");
				    });
			}
			
	</script>
</body>
</html>