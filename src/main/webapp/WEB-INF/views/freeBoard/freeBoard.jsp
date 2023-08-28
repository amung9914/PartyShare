<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeBoard.jsp</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100&family=Noto+Sans+KR:wght@300&display=swap');
    * {margin: 0; padding: 0; font-family: 'Hahmlet', serif; font-family: 'Noto Sans KR', sans-serif;}
    
    /* 검색창 및 글 작성 버튼 */
    .header-container {
	    display: flex; 
	    justify-content: space-between; 
	    align-items: center; 
	}
    
    #writeFreeBoard {
    	width: 100px;
	    height: 35px;
	    border-radius: 10px;
	    font-weight: bold;
	    border: none;
	    background-color: #FF385C;
	    color: white;
	    cursor: pointer;
	    margin-right: 20px;
    }
    
    #writeFreeBoard:hover {
    	background-color: #FF6666;
    }
    
    /* 검색창 */
    #searchFreeBoard {
    	margin : 20px;
    }
    
    .searchFreeBoard-select {
    	border: 1px solid lightgray;
    	text-align: center;
	   	width: 118px;
	    height: 35px;
	    border-radius: 10px;
	    font-weight: bold;
	    margin-right: 10px;
    }
    
    .searchFreeBoard-keyword {
   		border: 1px solid lightgray;
    	padding: 0 8px;
    	width: 200px;
	    height: 34px;
	    border-radius: 10px;
	    margin-right: 10px;
    }
    
    .searchFreeBoard-submit {
	   	width: 70px;
	    height: 35px;
	    border-radius: 10px;
	    font-weight: bold;
	    border: none;
	    background-color: #FF385C;
	    color: white;
	    cursor: pointer;
    }
    
    .searchFreeBoard-submit:hover {
    	background-color: #FF6666;
    }
    
    /* 게시물 목록 */
   	#boardtable {
   		border-top: 2px solid black;
	   	width: 100%;
	    border-collapse: collapse;
	    margin-bottom: 20px;
   	}
   	
   	.boardtable-thead th {
	    background-color: #FFE6E6;
	    font-weight: bold;
	    text-align: center;
	    padding: 8px;
	}
	
	/* 번호 */
	#boardtable th:first-child,
	#boardtable td:first-child {
	    width: 10%; 
	}
	
	#boardtable td:first-child {
		text-align: center;
	}
	
	/* 제목 */
	#boardtable th:nth-child(2),
	#boardtable td:nth-child(2) {
	    width: 40%; 
	}
	
	/* 작성자 */
	#boardtable th:nth-child(3),
	#boardtable td:nth-child(3) {
	    width: 10%; 
	}
	
	#boardtable td:nth-child(3){
		text-align: center;
	}
	
	/* 작성일시 */
	#boardtable th:nth-child(4),
	#boardtable td:nth-child(4) {
	    width: 30%; 
	}
	
	#boardtable td:nth-child(4){
		text-align: center;
	}
	
	/* 조회수 */
	#boardtable th:nth-child(5),
	#boardtable td:nth-child(5) {
	    width: 10%; 
	}
	
	#boardtable td:nth-child(5){
		text-align: center;
	}
	
	#boardtable td {
	    padding: 8px;
	    border-bottom: 1px solid #ddd;
	}

	#boardtable a {
	    color: black;
	    font-weight: bold;
	    text-decoration: none;
	}

	/* 페이징 */

	/* 페이지 버튼 스타일 */
	.paging-link {
		width: 18px;
	    display: inline-block;
	    margin: 20px 3px;
	    padding: 5px 10px;
	    border: 1px solid #D6D6D6;
	    background-color: white;
	    text-decoration: none;
	    border-radius: 3px;
	}
	
	/* 현재 페이지의 페이지 버튼 스타일 */
	.paging-link:hover {
	    background-color: #FFE6E6;
	    color: #fff;
	    border: 1px solid #D6D6D6;
	}
	
</style>
</head>
<body>

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
	            <td><a href="${contextPath}/freeBoard/freeBoardRead${pm.mkQueryStr(pm.cri.page)}&bno=${notice.bno}">${notice.title}</a></td>
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
			                    		<c:out value="${board.title}"/>
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
				<tr>
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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var result = '${result}';
	if(result != null && result != ''){
		alert(result);
	}

	const freeBoardWrite = () => {
		location.href = '${contextPath}/freeBoard/freeBoardWrite';
	}
</script>
</body>
</html>