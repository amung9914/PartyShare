<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<c:if test="${!empty loginMember}"> <!-- 로그인한 사용자만 댓글작성가능 -->
	<!-- 댓글 등록 폼 -->
	<div class="mb-3">
	  <textarea class="form-control" id="cText" rows="3" placeholder="여러분의 소중한 댓글을 입력해주세요."></textarea>
	  <div class="col-auto">
	    <button type="button" id="addBtn" class="btn btn-dark" >댓글달기</button>
	  </div>
	</div>
</c:if>
<!-- 댓글 수정영역 -->
<div id="modDiv">
	<!-- 수정할 댓글 번호 저장 -->
	<div id="modCno"></div>
	<div>
		<input type="hidden" id="modMid" readonly/>
		<input type="hidden" id="modMnick" readonly/>
		<!-- 댓글 내용 수정 -->
		<textarea class="form-control" id="modText" rows="3" ></textarea>
	</div>
	<div class="control">
		<button id="modBtn">저장</button>
		<button id="delBtn">삭제</button>
		<button id="closeBtn">닫기</button>
	</div>
</div>
<!-- 댓글 리스트 -->
<div>
	<ul id="comments"></ul>
</div>

<script>
	const bno = ${board.bno}; 
	const pnum = ${board.pnum}; 
	const mnick = "${loginMember.mnick}";
	const mid = "${loginMember.mid}";
	
	var page = 1;

	listPage(page);
	
	//리스트 불러오는 함수
	function listPage(page){
		$("#modDiv").css("display","none"); // 수정칸 안보이게함 
		$("body").prepend($("#modDiv"));
		let url = "comments/"+pnum+"/"+bno+"/"+page;
		$.getJSON(url,function(data){
			// data == Map
			// {'list':{}, 'pm' : {}}
			printList(data.list);
		});
	}
	
	// 검색된 댓글 목록을 출력할 함수
	function printList(list){
		// #comments
		let str = "";
		// each함수 : list 순회하면서 반복한다
		$(list).each(function(){
			// commentVO == this
			let cno = this.cno; // this : list에서 꺼내온 commmentVO 로 접근
			let cText = this.commentText;
			let cMnick = this.mnick;
			let cMid = this.mid;
			const updateStr = new Date(this.updatedate);
			const koDF = new Intl.DateTimeFormat("ko", {dateStyle: "long", timeStyle: 'medium'});
			const updateDate = koDF.format(updateStr);
			
			str += "<li class='commentLi'>";
			str += "<div class='commentInfo'>";
			str += cMnick+"&nbsp";
			str += updateDate;
			// 수정할 댓글 번호, text, auth
			str +="<div class='control'>";
			// 글쓴이만 수정버튼 볼 수 있음
			if(mnick==cMnick){
				str += ` &nbsp <button class='cmodify' data-cno='\${cno}' data-text='\${cText}' data-mnick='\${cMnick}' data-mid='\${cMid}'>수정</button>`;	
			}
			// 본인은 자기 댓글 신고 못하게 막음
			if(mnick!=cMnick){
			str += "<button data-cno='"+cno+"' class='reportBtn' >신고</button>";
			}
			str += "</div>";
			str +="</div>";// end commentInfo
			str += "<pre>"+cText+"</pre>";
			str += "</li>";
		});
		$("#comments").append(str); 
	}
	
	// 댓글 삽입 요청 처리
	$("#addBtn").click(function(){
		let text = $("#cText").val();
		
		$.ajax({
			type : "POST",
			url : "comments",
			data : {
				bno : bno,
				commentText : text,
				mnick : mnick,
				mid : mid,
				pnum : pnum
			},
			dataType : "text", // 성공유무에 대한 정보를 text로 전달받겠다.
			success : function(result){
				page = 1;
				//초기화 후 다시 목록 받기 
				$(".commentLi").remove(); 
				listPage(page);
			},
			error : function(res,status){
				console.log(res);
				console.log(status);
			}
		});
	});
	
	// 수정 창 열기
	$("#comments").on("click",".cmodify",function(){
		let cno = $(this).attr('data-cno');
		let text = $(this).attr('data-text');
		let cMnick = $(this).attr('data-mnick');
		let cMid = $(this).attr('data-mid');
		$("#modCno").text(cno);
		$("#modText").val(text);
		$("#modMnick").val(cMnick);
		$("#modMid").val(cMid);
		
		$(this).parent().parent().parent().after($("#modDiv"));
		$("#modDiv").toggle();
		
	});
	
	// 수정창 닫기
	$("#closeBtn").click(function(){
		$("#modDiv").toggle();
	});
	
	// 수정 요청 처리
	$("#modBtn").click(function(){
		const cno = $("#modCno").text();
		const text = $("#modText").val();
		
		const cMnick = $("#modMnick").val();
		const cMid = $("#modMid").val();
		
		$.ajax({
			type : "PATCH",
			url : "comments/"+cno,
			headers : {
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				commentText : text,
				pnum : pnum,
				bno : bno,
				cno : cno
			}),
			dataType : "text",
			success : function(data){
				alert(data);
				$("#modDiv").toggle(); // 수정창 닫기
				location.href="${path}/partyBoard/read?bno="+bno+"&pnum="+pnum;
			}
			
		}); 
	})
	
	// 삭제 요청 처리
	$("#delBtn").click(function(){
		const cno = $("#modCno").text();
		$.ajax({
			type : "DELETE",
			url : "comments/"+cno,
			headers : {
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				pnum : pnum,
				bno : bno,
				cno : cno
			}),
			dataType : "text",
			success : function(data){
				alert(data);
				$("#modDiv").toggle();
				location.href="${path}/partyBoard/read?bno="+bno+"&pnum="+pnum;
			}
		});
	});
	
	// 무한 페이지
	$(window).scroll(function(){
		let dh = $(document).height();
		let wh = $(window).height();
		let wt = $(window).scrollTop();
		
		if((wt+wh) >= (dh -10)){
			 if($("#comments li").size() <= 1){
				 return false;
			} 
			//수정창을 열지 않은 경우() 무한페이지 실행
			
			const status = $("#modDiv").css("display");
			
			if(status == 'none'){
				page++;
				listPage(page);	
			
			}
		}
	});
	
	// 신고창 오픈
	$("#comments").on("click",".reportBtn",function(){
		const cno = $(this).attr("data-cno");
		report();
		function report (){
			window.open("/partyshare/partyBoard/comments/report?pnum="
					+pnum+"&bno="+bno+"&cno="+cno,"Pop","width=500,height=600")
		}
	})
</script>
