<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
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

	.tableBox{
		text-align: -webkit-center;
		    margin: 0px 50px;
	}
	.input-group{
		margin:100px 0px;
	}
	.pm{
		text-align:center;
	}
	
	/* footer */
	html, body {
    height: 90%
}

	
</style>
	
	<div class="tableBox">
	<div class="control">
	<form name="changeCri" action="${path}/user/partyBoard/listPage" method="GET">
	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" name="pnum" value="${pnum}"/>
		<select name="perPageNum" class="form-select" onchange="changeCri.submit();">
			<c:forEach var="i" begin="5" end="20" step="5">
				<option value="${i}"${pm.cri.perPageNum eq i?'selected':''}>${i}개씩 보기</option> 
			</c:forEach>
		</select>
	</form>
	<button class="btn btn-outline-secondary" onclick="location.href='${path}/user/partyBoard/register?pnum=${pnum}';">
	<img src="${path}/resources/img/write.png"/>
	<b>글쓰기</b>
	</button>	
	</div>
	
	<table class="table" id="boardList">
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
								<td style="color: #FF385C;"><b>공지</b></td>
								<td>
									<a href="<c:url value='/user/partyBoard/readPage${pm.mkQueryStr(pm.cri.page)}&bno=${board.bno}&pnum=${pnum}'/>"><b>${board.title}</b></a>
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
								<td>규제된 게시물 입니다.</td>
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
									<a href="<c:url value='/user/partyBoard/readPage${pm.mkQueryStr(pm.cri.page)}&bno=${board.bno}&pnum=${pnum}'/>"><b>${board.title}</b></a>
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
								<td><b>삭제된 게시물 입니다.</b></td>
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
				<th class="pm" colspan="5">
					<c:if test="${pm.first}">
						<a class="btn btn-outline-secondary" href="<c:url value='/user/partyBoard/listPage?pnum=${pnum}&page=1&perPageNum=${pm.cri.perPageNum}'/>">&laquo;</a>
					</c:if>
					<c:if test="${pm.prev}">
						<a class="btn btn-outline-secondary" href="<c:url value='/user/partyBoard/listPage?pnum=${pnum}&page=${pm.startPage-1}&perPageNum=${pm.cri.perPageNum}'/>">&lt;</a>
					</c:if>
					<c:forEach var="i" 
							   begin="${pm.startPage}" 
							   end ="${pm.endPage}">
						<a class="btn btn-outline-secondary" href="<c:url value='/user/partyBoard/listPage?pnum=${pnum}&page=${i}&perPageNum=${pm.cri.perPageNum}'/>">${i}</a>
					</c:forEach>
					<c:if test="${pm.next}">
						<a class="btn btn-outline-secondary" href="<c:url value='/user/partyBoard/listPage?pnum=${pnum}&page=${pm.endPage+1}&perPageNum=${pm.cri.perPageNum}'/>">&gt;</a>
					</c:if>
					<c:if test="${pm.last}">
						<a class="btn btn-outline-secondary" href="<c:url value='/user/partyBoard/listPage?pnum=${pnum}&page=${pm.maxPage}&perPageNum=${pm.cri.perPageNum}'/>">&raquo;</a>
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
	
	<form action="${path}/user/partyBoard/listPage" method="GET" class="searchForm">
	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<input type="hidden" name="pnum" value="${pnum}"/>
			<div class="input-group">
				<select class="form-select" name="searchType">
					<option value="n">검색 내용 선택</option>
					<option value="t">제목</option>
					<option value="c">내용</option>
					<option value="w">작성자</option>
					<option value="tc">제목 &amp; 내용</option>
					<option value="cw">내용 &amp; 작성자</option>
					<option value="tcw">제목 &amp; 내용 &amp; 작성자</option>
				</select>
				<input type="text" class="form-control" name="keyword" placeholder="검색어를 입력하세요" />
				<input type="submit" style="z-index: 0;" class="btn btn-dark" value="검색" />
			</div>
			
	</form>
	<br/>
	
	</div>
	
<%@ include file="../common/fixFooter.jsp" %>






