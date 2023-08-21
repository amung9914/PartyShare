<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>


<!-- 댓글 등록 폼 -->
<div class="mb-3">
  <label for="exampleFormControlTextarea1" class="form-label">의견쓰기</label>
  <textarea class="form-control" id="cText" rows="3" placeholder="여러분의 소중한 댓글을 입력해주세요."></textarea>
  <div class="col-auto">
    <button type="button" id="addBtn" class="btn btn-primary mb-3">댓글달기</button>
  </div>
</div>
<!-- 댓글 수정영역 -->
<div id="modDiv">
	<!-- 수정할 댓글 번호 저장 -->
	<div id="mdCno"></div>
	<div>
		<input type="text" id="cAuth" readonly/>
		<!-- 댓글 내용 수정 -->
		<textarea class="form-control" id="modText" rows="3" ></textarea>
	</div>
	<div>
		<button id="modBtn">MODIFY</button>
		<button id="delBtn">DELETE</button>
		<button id="closeBtn">CLOSE</button>
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
			let cAuth = this.mnick;
			const updateStr = new Date(this.updatedate);
			
			const koDF = new Intl.DateTimeFormat("ko", {dateStyle: "long", timeStyle: 'medium'});
			const updateDate = koDF.format(updateStr);
			
			str += "<li class='commentLi'>";
			str += cno+"-"+cAuth;
			str += updateDate;
			// 수정할 댓글 번호, text, auth
			
			// 글쓴이만 수정버튼 볼 수 있음
			if(mnick==cAuth){
				str += ` - <button data-cno='\${cno}' data-text='\${cText}' data-auth='\${cAuth}'>수정</button>`;	
			}
			str += "<br/><hr/>"+"<pre>"+cText+"</pre>";
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
				alert(result);
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
	$("#comments").on("click","li button",function(){
		let cno = $(this).attr('data-cno');
		let text = $(this).attr('data-text'); 
		$("#mdCno").text(cno);
		$("#modText").val(text);
		$("#cAuth").val(mnick);
		
		$(this).parent().after($("#modDiv"));
		$("#modDiv").toggle();
	});
	
	// 수정창 닫기
	$("#closeBtn").click(function(){
		$("#modDiv").toggle();
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
			page++;
			listPage(page);
		}
	});
	
</script>
