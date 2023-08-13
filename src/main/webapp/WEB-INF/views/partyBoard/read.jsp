<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>read.jsp</title>
</head>
<body>
	
		<div>
			<label>제목</label>
			<input type="text" name="title" value="${PartyBoardVO.title}" readonly/>
		</div>
		<div>
			<label>내용</label>
			<textarea name="content" readonly rows=3>${PartyBoardVO.context}</textarea>
		</div>
		<div>
			<label>작성자</label>
			<input type="text" name="writer" value="${PartyBoardVO.mnick}" readonly/>
		</div>
		<div>
			<a href="" id="modify">수정</a> |
			<a href="" id="remove">삭제</a> |
			<a href="" id="list">목록</a>
		</div>
		<form id="submitForm" method="POST">
			<input type="hidden" name="bno"  value="${PartyBoardVO.bno}"/>
			<input type="hidden" name="page"  value="${cri.page}"/>
			<input type="hidden" name="perPageNum"  value="${cri.perPageNum}"/>
		</form>
	<script>
		var result = '${result}';
		if(result != null && result != ''){
			alert(result);
		}
	</script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		// 문서가 모두 로드 되었을 때...
		$(function(){
			
			var formObj = $("#submitForm");
			
			$("#list").click(function(e){
				e.preventDefault();
				location.href="listPage?pnum=${PartyBoardVO.pnum}&page=${cri.page}";
			});
			
			// 수정 페이지 요청 
			$("#modify").click(function(e){
				e.preventDefault();
				formObj.attr("action","modify?pnum=${PartyBoardVO.pnum}");
				formObj.attr("method","get");
				formObj.submit();
			});
			
			// 게시글 삭제요청
			$("#remove").click(function(e){
				e.preventDefault();
				let conf = confirm("복구 할 수 없습니다. 삭제하시겠습니까?");
				if(conf){
					formObj.attr("action","remove?pnum=${PartyBoardVO.pnum}");
					formObj.submit();
				}
			});
		});
	</script>
</body>
</html>













