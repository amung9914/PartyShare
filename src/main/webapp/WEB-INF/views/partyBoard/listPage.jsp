<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listPage.jsp</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style>
	a{
	text-decoration:none;
	color:black;
	}
	a:hover{
	text-decoration:underline;
	}
	.control{
		display:flex;
		margin:10px;
	}
	.searchForm{
		width : 50%;
		margin : 20px;
	}
	.title{
		width: 50%;
	}
	table{
		text-align: left;
	}
	.tableBox{
		text-align: -webkit-center;
	}
	
</style>
</head>
<body>
	<div class="tableBox">
	<div class="control">
	<form name="changeCri" action="listPage" method="GET">
		<input type="hidden" name="pnum" value="${pnum}"/>
		<select name="perPageNum" class="form-select" onchange="changeCri.submit();">
			<c:forEach var="i" begin="5" end="20" step="5">
				<option value="${i}"${pm.cri.perPageNum eq i?'selected':''}>${i}개씩 보기</option> 
			</c:forEach>
		</select>
	</form>
	<button class="btn btn-outline-secondary" onclick="location.href='register?pnum=${pnum}';">
	<img src="${path}/resources/img/write.png"/>
	글쓰기
	</button>	
	</div>
	
	<table class="table" id="boardList" border=1>
		<thead>
			<tr>
				<th>글번호</th>
				<th class="title">제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		 <tbody class="table-group-divider">
		<!-- 공지글 출력 -->
		<c:if test="${!empty notice}">
			<c:forEach var="board" items="${notice}">
				<c:choose>
						<c:when test="${board.showboard == 'y'}">
							<tr>
								<td>${board.bno}</td>
								<td>
									[공지]<a href="<c:url value='/partyBoard/readPage${pm.mkQueryStr(pm.cri.page)}&bno=${board.bno}&pnum=${pnum}'/>">${board.title}</a>
								</td>
								<td>${board.writer}</td>
								<td> <!-- 당일이면 시간표시 / 아니면 날짜표시 -->
									<f:formatDate var="now" pattern="yyyy년MM월dd일" value="<%= new java.util.Date() %>"/>
									<f:formatDate var="reg" pattern="yyyy년MM월dd일" value="${board.regdate}"/>
									<c:choose>
										<c:when test="${now == req}">
											<f:formatDate pattern="HH:mm:ss" value="${board.regdate}"/>
										</c:when>
										<c:otherwise>
											${reg}
										</c:otherwise>
									</c:choose>
								</td>
								<td>${board.viewCnt}</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td></td>
								<td>삭제된 게시물 입니다.</td>
								<td></td>
								<td> <!-- 삭제 요청 시간 출력 / 당일이면 시간표시 / 아니면 날짜표시 -->
									<f:formatDate var="now" pattern="yyyy년MM월dd일" value="<%= new java.util.Date() %>"/>
									<f:formatDate var="updateTime" pattern="yyyy년MM월dd일" value="${board.updatedate}"/>
									<c:choose>
										<c:when test="${now == updateTime}">
											<f:formatDate pattern="HH:mm:ss" value="${board.updatedate}"/>
										</c:when>
										<c:otherwise>
											${updateTime}
										</c:otherwise>
									</c:choose>
								</td>
								<td></td>
							</tr>
						</c:otherwise>
					</c:choose>
			</c:forEach>
		</c:if>
		<!-- 일반 게시물 -->
		<c:choose>
			<c:when test="${!empty list}">
				<c:forEach var="board" items="${list}">
					<c:choose>
						<c:when test="${board.showboard == 'y'}">
							<tr>
								<td>${board.bno}</td>
								<td>
									<c:if test="${board.depth != 0}">
										<c:forEach begin="1" end="${board.depth}">
										&nbsp;&nbsp;&nbsp;
										</c:forEach>
									</c:if>
									<c:if test="${board.category eq 'reply'}">
									ㄴ
									</c:if>
									<a href="<c:url value='/partyBoard/readPage${pm.mkQueryStr(pm.cri.page)}&bno=${board.bno}&pnum=${pnum}'/>">${board.title}</a>
								</td>
								<td>${board.writer}</td>
								
								<td> <!-- 당일이면 시간표시 / 아니면 날짜표시 -->
									<f:formatDate var="now" pattern="yyyy년MM월dd일" value="<%= new java.util.Date() %>"/>
									<f:formatDate var="reg" pattern="yyyy년MM월dd일" value="${board.regdate}"/>
									<c:choose>
										<c:when test="${now == reg}">
											<f:formatDate pattern="HH:mm:ss" value="${board.regdate}"/>
										</c:when>
										<c:otherwise>
											${reg}
										</c:otherwise>
									</c:choose>
								</td>
								<td>${board.viewCnt}</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td></td>
								<td>삭제된 게시물 입니다.</td>
								<td></td>
								<td> <!-- 삭제 요청 시간 출력 / 당일이면 시간표시 / 아니면 날짜표시 -->
									<f:formatDate var="now" pattern="yyyy년MM월dd일" value="<%= new java.util.Date() %>"/>
									<f:formatDate var="updateTime" pattern="yyyy년MM월dd일" value="${board.updatedate}"/>
									<c:choose>
										<c:when test="${now == updateTime}">
											<f:formatDate pattern="HH:mm:ss" value="${board.updatedate}"/>
										</c:when>
										<c:otherwise>
											${updateTime}
										</c:otherwise>
									</c:choose>
								</td>
								<td></td>
							</tr>
						</c:otherwise>
					</c:choose>
			</c:forEach>
			<tr>
				<th colspan="5">
					<c:if test="${pm.first}">
						<a class="btn btn-outline-secondary" href="<c:url value='/partyBoard/listPage?pnum=${pnum}&page=1'/>">&laquo;</a>
					</c:if>
					<c:if test="${pm.prev}">
						<a class="btn btn-outline-secondary" href="<c:url value='/partyBoard/listPage?pnum=${pnum}&page=${pm.startPage-1}'/>">&lt;</a>
					</c:if>
					<c:forEach var="i" 
							   begin="${pm.startPage}" 
							   end ="${pm.endPage}">
						<a class="btn btn-outline-secondary" href="<c:url value='/partyBoard/listPage?pnum=${pnum}&page=${i}'/>">${i}</a>
					</c:forEach>
					<c:if test="${pm.next}">
						<a class="btn btn-outline-secondary" href="<c:url value='/partyBoard/listPage?pnum=${pnum}&page=${pm.endPage+1}'/>">&gt;</a>
					</c:if>
					<c:if test="${pm.last}">
						<a class="btn btn-outline-secondary" href="<c:url value='/partyBoard/listPage?pnum=${pnum}&page=${pm.maxPage}'/>">&raquo;</a>
					</c:if>
				</th>
			</tr>
			
			
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5">등록된 게시물이 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	
	<form action="listPage" method="GET" class="searchForm">
			<input type="hidden" name="pnum" value="${pnum}"/>
			<div class="input-group">
				<select class="form-select" name="searchType">
					<option value="n">--------------------------</option>
					<option value="t">제목</option>
					<option value="c">내용</option>
					<option value="w">작성자</option>
					<option value="tc">제목 &amp; 내용</option>
					<option value="cw">내용 &amp; 작성자</option>
					<option value="tcw">제목 &amp; 내용 &amp; 작성자</option>
				</select>
				<input type="text" class="form-control" name="keyword" placeholder="검색어를 입력하세요" />
				<input type="submit" class="btn btn-dark" value="검색" />
			</div>
			
	</form>
	
	
	</div>
</body>
</html>







