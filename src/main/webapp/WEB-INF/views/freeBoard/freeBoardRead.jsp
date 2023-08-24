<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:if test="${freeBoardVO.showBoard eq 'N'}">
	<script>
		alert('신고 접수로 인해 블라인드 처리된 게시물입니다.');
		history.back();
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeBoardRead.jsp</title>
<style>
	#content {
		border : 1px solid gray;
		padding : 10px;
		margin : 10px; 
	}
	
	#writeComment {
		border : 1px solid gray;
		padding : 10px;
		margin : 10px; 
	}

	#modDiv {
		border : 1px solid black;
		padding : 10px;
		display : none;
	}

	#comments li {
		list-style : none;
		padding : 10px;
		border : 1px solid #ccc;
		height : 150px;
		margin : 5px 0;
	}
	
	#pagination li{
		list-style : none;
		float : left;
		padding : 3px;
		border : 1px solid skyblue;
		margin : 3px;
	}
	
	#pagination li a{
		text-decoration : none;
		color : black;
	}
	
	#pagination li a.active{
		color : red;
	}
</style>
</head>
<body>
	<h1>게시물 상세보기</h1>
	
	<!-- 댓글 수정창 -->
	<div id="modDiv">
		<!--댓글 작성자 닉네임 저장 -->
		<div id="modMnick"></div>
		<!-- 댓글 내용 수정 -->
		<div>
			<!-- 댓글 번호, 댓글 작성자 아이디 저장 -->
			<input type="hidden" id="modCno" name="modCno"/>
			<input type="hidden" id="modMid" name="modMid"/>
			<textarea id="modText">안농</textarea>
		</div>
		<div>
			<button id="modBtn">수정</button>
			<button id="closeBtn">닫기</button>
		</div>
	</div>
	
	<div>
		<label>제목</label>
		<input type="text" name="title" value="${freeBoardVO.title}" readonly/>
	</div>
	<div>
		<label>작성자</label>
		<input type="text" name="writer" value="${freeBoardVO.mnick}" readonly/>
	</div>
	<div>
		조회수 : ${freeBoardVO.viewCnt}
	</div>
	<div>
		작성일 : ${freeBoardVO.formatDate}
	</div>
	<div id="content">
		<label>내용</label> <hr/>
		${freeBoardVO.context}
	</div>
	<div>
		<c:if test="${freeBoardVO.category eq '일반'}">
			<a href="" id="reply">답변글 작성</a> |
		</c:if>
			<a href="" id="modify">수정</a> |
			<a href="" id="remove">삭제</a> |
			<a href="" id="report">신고</a> |
		<a href="" id="list">목록</a>
	</div>
	
	<!-- 댓글 작성 -->
	<div id="writeComment">
		댓글 작성 <hr/> 
		<textarea name="commentText" id="cText" cols="30" rows="2"></textarea> <br/>
		<button id="addBtn">댓글 작성</button>
	</div>
	
	<!-- 댓글 목록 -->
	<ul id="comments"></ul>
	
	<!-- 댓글 페이징 블럭 정보 -->
	<ul id="pagination"></ul>
	
	<form id="submitForm" method="POST">
		<input type="hidden" name="mid" value="${freeBoardVO.mid}"/>
		<input type="hidden" name="bno" value="${freeBoardVO.bno}"/>
		<input type="hidden" name="page" value="${cri.page}"/>
		<input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
	</form>
	<script>
		var result = '${result}';
		if(result != null && result != ''){
			alert(result);
		}
	</script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		// 댓글 관련 JS
		
		var bno = "${freeBoardVO.bno}";
		var page = 1;
		var mnick = "${loginMember.mnick}"; 
		var mid = "${loginMember.mid}";
		var maxPage;
		
		function updateMaxPage(page){
			let url = "${contextPath}/comment/comments/" + bno + "/" + page;
			$.getJSON(url, function(data){
				// maxPage를 계산하여 저장
				maxPage = data.cpm.maxPage; 
				// 댓글을 작성한 후 제일 마지막 댓글 페이지로 이동
	            listPage(maxPage);
			});
		}
		
		updateMaxPage(page);
		
		function listPage(page){
			$("#modDiv").css("display", "none");
			$("body").prepend($("#modDiv"));
			let url = "${contextPath}/comment/comments/" + bno + "/" + page;
			$.getJSON(url, function(data){
				// 댓글 페이지를 누를 때 기존의 댓글 목록을 비우고 새로운 댓글 목록을 출력
	            $("#comments").empty();
				printList(data.list);
				printPage(data.cpm);
			});
		}
		
		// 검색된 댓글 목록을 출력할 함수
		function printList(list){
			// #comments	
			let str = "";
			$(list).each(function(){
				// commentVO == this
				
				let cno = this.cno;
				let cText = this.commentText;
				let preText = '<pre>' + cText + '</pre>'
				let mnick = this.mnick;
				let mid = this.mid;
				let regdate = this.regdateStr;
				
				if(this.showBoard === 'N'){
					str += "<li>";
					str += "작성자 : " + mnick + "<br/>작성일시 : " + regdate;
					str += "<br/><hr/>" + "신고 접수로 인해 블라인드 처리된 댓글입니다.";
					str += "</li>";
				} else {
					str += "<li>";
					str += "작성자 : " + mnick + "<br/>작성일시 : " + regdate;
					// 수정할 댓글 번호, text, auth
					// data가 붙으면 사용자 정의형 속성
					str += ` - <button id="modifyBtn_\${cno}" data-cno=\${cno} data-mid=\${mid} data-mnick=\${mnick} data-text="\${cText}">수정</button>`
						 + ` <button id="deleteBtn_\${cno}" data-cno=\${cno} data-mid=\${mid}>삭제</button> `
						 + ` <button id="reportBtn_\${cno}" data-cno=\${cno} data-mid=\${mid} data-mnick=\${mnick} data-cno=\${cno}>신고</button> `
					str += "<br/><hr/>" + preText;
					str += "</li>";
				}
			});
			// $("#comments").html(str);
			$("#comments").append(str);
		}
		
		
		// 댓글 페이징 처리
		function printPage(cpm) {
			if (cpm !== null && typeof cpm !== 'undefined') {
				let str = "";
				if(cpm.first){
					str += "<li><a href='1'> << </a></li>" 
				}
				if(cpm.prev){
					str += "<li><a href='" + (cpm.startPage - 1) + "'> < </a></li>";
				}
				
				for(let i = cpm.startPage ; i <= cpm.endPage ; i++){
					if(cpm.cri.page == i){
						str += "<li><a href='" + i + "' class='active'>" + i + "</a></li>";
					} else {
						str += "<li><a href='" + i + "'>" + i + "</a></li>"; 
					}
				}
				
				if(cpm.next){
					str += "<li><a href='" + (cpm.endPage + 1) + "'> > </a></li>";
				}
				if(cpm.last){
					str += "<li><a href='" + (cpm.maxPage) + "'> >> </a></li>";
				}
				
				$("#pagination").html(str);
			}
		}
		
		
		$("#pagination").on("click", "li a", function(e){
			e.preventDefault();
			let commentPage = $(this).attr("href");
			page = commentPage;
			listPage(page);
		});
		
		
		// 댓글 삽입 요청 처리
		$("#addBtn").click(function(){
			// 로그인 여부 확인
		    if (mid === "") {
		        alert("댓글을 작성하려면 로그인이 필요합니다.");
		        $("#cText").val("");
		        return;
		    }
			
			let text = $("#cText").val();
			
			$.ajax({
				type : "POST",
				url : "${contextPath}/comment/comments",
				data : JSON.stringify({
					bno : bno,
					commentText : text,
					mnick : mnick,
					mid : mid
				}),
				contentType: "application/json",
				dataType : "text",
				success : function(result){
					 $("#cText").val("");
					// 댓글을 작성한 후 제일 마지막 댓글 페이지로 이동
		           	updateMaxPage(1);
				},
				error : function(res, status){
					console.log(res);
					console.log(status);
				}
			});
		});
		
		// 수정창 열기
		$("#comments").on("click", "button[id^='modifyBtn_']", function(){
			var cno = $(this).data("cno");
		    var mid = $(this).data("mid");
		    var mnick = $(this).data("mnick");
		    var text = $(this).data("text");
		    
		 	// 로그인한 사용자의 mid와 댓글 작성자의 mid 비교
		    if (mid !== "${loginMember.mid}") {
		        alert("본인이 작성한 댓글만 수정할 수 있습니다.");
		        return;
		    }
		    
		    $("#modMnick").text("작성자 : " + mnick);
		    $("#modText").val(text);
		    $("#modCno").val(cno);
		    $("#modMid").val(mid);
		    
		    $(this).parent().after($("#modDiv"));
		   
		    $("#modDiv").slideDown("slow");
		});
		
		// 수정창 닫기
		$("#closeBtn").click(function(){
			$("#modDiv").slideUp("slow");
		});
		
		// 댓글 수정 요청
		$("#comments").on("click", "button[id='modBtn']", function() {
		    var cno = $("#modCno").val();
		    var mid = $("#modMid").val();
		    var text = $("#modText").val();
		    
		    $.ajax({
				type : "PATCH",
				url : "${contextPath}/comment/comments/"+cno,
				headers : {
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					commentText : text
				}),
				dataType : "text",
				success : function(data){
					alert(data);
					updateMaxPage(page);
				}
			});
		});

		// 댓글 삭제 요청
		$("#comments").on("click", "button[id^='deleteBtn_${cno}']", function() {
		    let cno = $(this).data("cno");
		    let mid = $(this).data("mid");
		    
		    // 로그인한 사용자의 mid와 댓글 작성자의 mid 비교
		    if (mid !== "${loginMember.mid}") {
		        alert("본인이 작성한 댓글만 삭제할 수 있습니다.");
		        return;
		    }
		    
		    $.ajax({
				type : "DELETE",
				url : "${contextPath}/comment/comments/"+cno,
				data : {
					cno : cno
				},
				dataType : "text",
				success : function(result){
					alert(result);
					updateMaxPage(page);
				}
			});
		});
		
		// 댓글 신고 요청
		$("#comments").on("click", "button[id^='reportBtn_${cno}']", function() {
			let fromMid = mid;
		    let toMid = $(this).data("mid");
		    let mnick = $(this).data("mnick");
		    let cno = $(this).data("cno");
		    
		    if (mid === "") {
		        alert("신고요청을 위해선 로그인이 필요합니다.");
		        return;
		    }
			
			// 팝업창 오픈
			let url = "${contextPath}/freeBoard/reportPopup?fromMid=" + fromMid + "&toMid=" + toMid + "&mnick=" + mnick + "&cno=" + cno;
		    window.open(url, "댓글 신고", "width=400, height=300, left=100, top=50");
		});
		
	</script>
	<script>
		// 게시물 관련 JS
	
		// 문서가 모두 로드 되었을 때...
		$(function(){
			
			var formObj = $("#submitForm");
			
			$("#list").click(function(e){
				e.preventDefault();
				$("input[name='bno']").remove();
				formObj.attr("action", "${contextPath}/freeBoard/freeBoard");
				formObj.attr("method", "GET");
				formObj.submit();
			});
			
			$("#reply").click(function(e){
				e.preventDefault();
				formObj.attr("action","${contextPath}/freeBoard/freeBoardReply");
				formObj.attr("method","get");
				formObj.submit();
			});
			
			// 수정 페이지 요청
			$("#modify").click(function(e){
				e.preventDefault();
				formObj.attr("action", "${contextPath}/freeBoard/freeBoardModify");
				formObj.attr("method", "get");
				formObj.submit();
			});
			
			// 게시글 삭제 요청
			$("#remove").click(function(e){
				e.preventDefault();
				let conf = confirm("복구할 수 없습니다. 삭제하시겠습니까?");
				if(conf){
					formObj.attr("action", "${contextPath}/freeBoard/freeBoardRemove");
					formObj.attr("method", "get");
					formObj.submit();
				}
			});
			
			// 게시글 신고 요청
			$("#report").click(function(e){
				
			    if (mid === "") {
			        alert("신고요청을 위해선 로그인이 필요합니다.");
			        return;
			    }
				
				// 팝업창 오픈
				let url = "${contextPath}/freeBoard/reportPopup?fromMid=${loginMember.mid}&toMid=${freeBoardVO.mid}&mnick=${freeBoardVO.mnick}&bno=${freeBoardVO.bno}";
			    window.open(url, "댓글 신고", "width=400, height=300, left=100, top=50");
			});
			
		});
	</script>
</body>
</html>