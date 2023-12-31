<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ include file="../common/header.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="${contextPath}/resources/css/jinlee/freeBoard.css" rel="stylesheet">
	<div class="header-container">
		<div id="searchFreeBoard">
			<form name="${contextPath}/freeBoard/freeBoard" method="GET">
				<select class="searchFreeBoard-select" name="type">
					<option value="" ${param.type == '' ? 'selected' : ''}>검색 내용 선택</option>
					<option value="title" ${param.type == 'title' ? 'selected' : ''}>제목</option>
					<option value="context" ${param.type == 'context' ? 'selected' : ''}>내용</option>
					<option value="mnick" ${param.type == 'mnick' ? 'selected' : ''}>작성자</option>
				</select>
				<input class="searchFreeBoard-keyword" type="text" name="keyword" value="${param.keyword}" />
				<input class="searchFreeBoard-submit" type="submit" value="검색" />
			</form>
		</div>
		
		<button id="writeFreeBoard" onclick="freeBoardWrite()">글 작성</button>
	</div>
	
	<table id="boardtable">
		<thead>
			<tr class="boardtable-thead">
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일시</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="notice" items="${FreeBoardNotice}">
			<tr style="background-color: #FFFAFA;">
	            <td style="color:#FF385C; font-weight:bold;">공지</td>
	            <td><a href="${contextPath}/freeBoard/freeBoardRead${pm.mkQueryStr(pm.cri.page)}&bno=${notice.bno}">${notice.title} <span style="color: #FF385C; margin-left: 10px; font-weight: normal;">[${notice.commentCount}]</span></a></td>
	            <td>${notice.mnick}</td>
	            <td>${notice.formatDate}</td>
	            <td>${notice.viewCnt}</td>
	        </tr>
        </c:forEach>
	    <c:choose>
	        <c:when test="${empty FreeBoard}">
	            <tr>
	                <td colspan="5">조건에 해당하는 게시물이 없습니다.</td>
	            </tr>
	        </c:when>
	        <c:otherwise>
	        	<c:set var="num" value="${pm.totalCount - ((pm.cri.page - 1) * pm.cri.perPageNum)}" />
	            <c:forEach var="board" items="${FreeBoard}">
	            	<c:choose>
	            		<c:when test="${board.showBoard eq 'N'}">
	            			<tr>
	            				<td>${num}</td>
	            				<td>신고 접수로 인해 블라인드 처리된 게시물입니다.</td>
	            				<td></td>
	            				<td></td>
	            				<td></td>
	            			<tr>
	            		</c:when>
	            		<c:otherwise>
			                <tr>
			                    <td>${num}</td>
			                    <td>
			                    	<a href="${contextPath}/freeBoard/freeBoardRead${pm.mkQueryStr(pm.cri.page)}&bno=${board.bno}">
			                    		<!-- 답변글일 경우 -->
			                    		<c:if test="${board.depth != 0}">
			                    			<c:forEach var="i" begin="1" end="${board.depth}">
			                    				&nbsp;&nbsp;&nbsp;
			                    			</c:forEach>
			                    			└ <!-- ㅂ + 한자 + 6 -->
			                    		</c:if>
			                    		<c:out value="${board.title}"/><span style="color: #FF385C; margin-left: 10px; font-weight: normal;">[${board.commentCount}]</span>
			                    	</a>
			                    </td>
			                    <td>${board.mnick}</td>
			                    <td>${board.formatDate}</td>
			                    <td>${board.viewCnt}</td>
			                </tr>
	            		</c:otherwise>
	            	</c:choose>
	            <c:set var="num" value="${num - 1}"/>
	            </c:forEach>
	        </c:otherwise>
	    </c:choose>
		</tbody>
		<c:if test="${!empty pm and pm.maxPage > 1}">
				<tr style="text-align:center;">
					<th colspan="5">
						<c:if test="${pm.first}">
							<a class="paging-link" href="${contextPath}/freeBoard/freeBoard?page=1<c:if test="${not empty param.type}">&type=${param.type}</c:if><c:if test="${not empty param.keyword}">&keyword=${param.keyword}</c:if>" >&laquo;</a>
						</c:if>
						<c:if test="${pm.prev}">
							<a class="paging-link" href="${contextPath}/freeBoard/freeBoard?page=${pm.startPage-1}<c:if test="${not empty param.type}">&type=${param.type}</c:if><c:if test="${not empty param.keyword}">&keyword=${param.keyword}</c:if>" >&lt;</a>
						</c:if>
						<c:forEach var="i" 
								   begin="${pm.startPage}" 
								   end ="${pm.endPage}">
							<a class="paging-link" href="${contextPath}/freeBoard/freeBoard?page=${i}<c:if test="${not empty param.type}">&type=${param.type}</c:if><c:if test="${not empty param.keyword}">&keyword=${param.keyword}</c:if>">${i}</a>
						</c:forEach>
						<c:if test="${pm.next}">
							<a class="paging-link" href="${contextPath}/freeBoard/freeBoard?page=${pm.endPage+1}<c:if test="${not empty param.type}">&type=${param.type}</c:if><c:if test="${not empty param.keyword}">&keyword=${param.keyword}</c:if>">&gt;</a>
						</c:if>
						<c:if test="${pm.last}">
							<a class="paging-link" href="${contextPath}/freeBoard/freeBoard?page=${pm.maxPage}<c:if test="${not empty param.type}">&type=${param.type}</c:if><c:if test="${not empty param.keyword}">&keyword=${param.keyword}</c:if>">&raquo;</a>
						</c:if>
					</th>
				</tr>
		</c:if>
	</table>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var result = '${result}';
	if(result != null && result != ''){
		alert(result);
	}

	const freeBoardWrite = () => {
		location.href = '${contextPath}/user/freeBoard/freeBoardWrite';
	}
</script>
<%@ include file="../common/fixFooter.jsp" %>