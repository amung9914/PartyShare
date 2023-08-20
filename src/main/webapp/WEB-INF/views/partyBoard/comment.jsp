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
  <textarea class="form-control" id="cText" rows="3"></textarea>
  <div class="col-auto">
    <button type="button" id="addBtn" class="btn btn-primary mb-3">등록</button>
  </div>
</div>
<!-- 댓글 수정영역 -->
<div id="modDiv">
	<!-- 수정할 댓글 번호 저장 -->
	<div id="mdCno"></div>
	<div>
		<input type="text" id="cAuth" readonly/>
		<!-- 댓글 내용 수정 -->
		<textarea class="form-control" id="modText" rows="3"></textarea>
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
	const perPageNum = 10;
	
	var page = 1;
	

	//getCommentList();
	listPage(page);
	
	//리스트 불러오는 함수
	function listPage(page){
		$("#modDiv").css("display","none"); // 수정칸 안보이게함 
		$("body").prepend($("#modDiv"));
		let url = "comments/"+pnum+"/"+bno+"/"+page+"/"+perPageNum;
		$.getJSON(url,function(data){
			printList(data);
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
			str += "<li>";
			str += cno+"-"+cAuth;
			// 수정할 댓글 번호, text, auth
			//data- : 사용자정의형 속성
			str += ` - <button data-cno='\${cno}' data-text='\${cText}' data-auth='\${cAuth}'>수정</button>`;
			str += "<br/><hr/>"+cText;
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
				//getCommentList(); // 성공시 새로 목록 추가 
				let str ="";
				str += "<li>";
				str += cno+"-"+mnick;
				str += ` - <button data-cno='\${cno}' data-text='\${cText}' data-auth='\${cAuth}'>수정</button>`;
				str += "<br/><hr/>"+cText;
				str += "</li>";
				$("#comments").prepend(str); 
			},
			error : function(res,status){
				console.log(res);
				console.log(status);
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
			page++;
			listPage(page);
		}
	});
	
</script>
