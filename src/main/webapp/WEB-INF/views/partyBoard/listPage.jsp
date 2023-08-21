<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listPage.jsp</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<button onclick="location.href='register?pnum=${pnum}';">글쓰기</button>
	<h3> LIST </h3>
	<form name="changeCri" action="listPage" method="GET">
		<input type="hidden" name="pnum" value="${pnum}"/>
		<select name="perPageNum" onchange="changeCri.submit();">
			<c:forEach var="i" begin="5" end="20" step="5">
				<option value="${i}"${pm.cri.perPageNum eq i?'selected':''}>${i}개씩 보기</option> 
			</c:forEach>
		</select>
	</form>
	<br/>
	<form action="listPage" method="GET">
			<input type="hidden" name="pnum" value="${pnum}"/>
			<select name="searchType">
				<option value="n">--------------------------</option>
				<option value="t">제목</option>
				<option value="c">내용</option>
				<option value="w">작성자</option>
				<option value="tc">제목 &amp; 내용</option>
				<option value="cw">내용 &amp; 작성자</option>
				<option value="tcw">제목 &amp; 내용 &amp; 작성자</option>
			</select>
			<input type="text" name="keyword" />
			<input type="submit" value="검색" />
		</form>
	<br/>
	
	<table id="boardList" border=1>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
			<th>조회수</th>
			<th>신고</th>
		</tr>
		<!-- 공지글 출력 -->
		<c:if test="${!empty notice}">
			<c:forEach var="board" items="${notice}">
				<c:choose>
						<c:when test="${board.showboard == 'y'}">
							<tr>
								<td>${board.bno}</td>
								<td>
									[공지]<a href="readPage${pm.mkQueryStr(pm.cri.page)}&bno=${board.bno}&pnum=${pnum}">${board.title}</a>
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
								<td><button class="reportBtn" data-bno="${board.bno}">신고하기</button></td>
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
									<a href="readPage${pm.mkQueryStr(pm.cri.page)}&bno=${board.bno}&pnum=${pnum}">${board.title}</a>
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
								<td><button class="reportBtn" data-bno="${board.bno}">신고하기</button></td>
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
						<a href="listPage?pnum=${pnum}&page=1">[&laquo;]</a>
					</c:if>
					<c:if test="${pm.prev}">
						<a href="listPage?pnum=${pnum}&page=${pm.startPage-1}">[&lt;]</a>
					</c:if>
					<c:forEach var="i" 
							   begin="${pm.startPage}" 
							   end ="${pm.endPage}">
						<a href="listPage?pnum=${pnum}&page=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${pm.next}">
						<a href="listPage?pnum=${pnum}&page=${pm.endPage+1}">[&gt;]</a>
					</c:if>
					<c:if test="${pm.last}">
						<a href="listPage?pnum=${pnum}&page=${pm.maxPage}">[&raquo;]</a>
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
	<script>
	
	
	$("#boardList").on("click",".reportBtn",function(){
		const bno = $(this).attr("data-bno");
		report();
		function report(){
			window.open("report?pnum="+${pnum}+"&bno="+bno,"Pop","width=500,height=600");
		}
	})
	
	
	</script>
</body>
</html>







