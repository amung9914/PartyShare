<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../common/header.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="${path}/resources/css/ksg/chat.css" rel="stylesheet" />

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<div id="wrap">
<div id=top>
		<nav>
			<ul id="navUl">
				<li><a href="<c:url value='/'/>">홈</a></li>
				<li><a href="<c:url value='/user/partyBoard/listPage?pnum=${party.pnum}'/>">게시판</a></li>
				<li><a href="<c:url value='/partyDetail/detailOfParty?pNum=${party.pnum}'/>">파티창</a></li>
			</ul>	
		</nav>
	</div>

<main id="chatMain">
	<section id="chatSection">
		<div id="chat_container">
			<div class="chatWrap">
				<div class="content chatcontent">
					<div id="chatList">
						<c:forEach var="chat" items="${firstList}" >
							<!-- 내 채팅일 경우 -->
							<c:if test="${loginMember.mnum eq chat.mnum}">
								<li class="me" data-no="${chat.cnum}">
									<img src="<c:url value='/image/printProfileImage?fileName=${loginMember.profileImageName}'/>"/>
									<div class="me">
										<p class="myChat">${chat.content}</p> 
									</div>
								</li>
							</c:if>
							
							<!-- 다른사람의 채팅일 경우 -->
							<c:if test="${loginMember.mnum ne chat.mnum}">
								<li id="otherChat" data-no="${chat.cnum}">
									<c:forEach var="joinMember" items="${joinMemberList}">
										<c:if test="${chat.mnum eq joinMember.mnum}">
											<img src="<c:url value='/image/printProfileImage?fileName=${joinMember.profileImageName}'/>" />
											<div id="otherChatBox">
												<div id="otherChatDiv">
													<span>${joinMember.mnick}</span>
													<p class="otherChat">${chat.content}</p>
												</div>
											</div>
										</c:if>
									</c:forEach>
								</li>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="chat-fixK">
					<div class="fix_btn">
						<textarea name="msg" id="msgi" rows="3"></textarea>
						<button type="button" id="sendBtn" class="send btn btn-outline-dark">보내기</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	
	
	<section id="infoSection">
		<div id="partyInfoContainer">
			<div class="card" style="width: 100%;">
			  <img src='${path}/image/printPartyImage?fileName=${fn:replace(party.partyImage1, "s_", "")}' class="card-img-top" >
			  <div class="card-body">
			    <h5 class="card-title">${party.pname}</h5>
		        <p class="card-text">${party.formatStartDate} ~ ${party.formatEndDate}</p>
		        <p class="card-text">${party.address}</p>
			  </div>
			</div>
		</div>
	</section>
</main>
</div>
</body>
<script type="text/javascript">
	var contextPath = '${pageContext.request.contextPath}';
	function moveDown(){
		$(".chatcontent").scrollTop($(".chatcontent")[0].scrollHeight);
	}
	
	$(document).ready(function() {
		//시작할때 스크롤 내리기
		$(".chatcontent").scrollTop($(".chatcontent")[0].scrollHeight);
		
		// 더이상 가져올 채팅내용이 없으면 true
		var isEnd = false;
		
		var isScrolled = false;
		
		var fetchList = function() {
			if (isEnd == true) {
				return;
			}

			var endNo = $("#chatList li").first().data("no");
			$.ajax({
				url : contextPath+"/user/chatList?endNo="+endNo+"&pnum=${party.pnum}",
				type : "GET",
				dataType : "json",
				success : function(result) {
					// 컨트롤러에서 가져온 방명록 리스트는 result.data에 담김
					var length = result.length;
					if (length < 10) {
						isEnd = true;
					}
					$.each(result, function(index, vo) {
						var html = renderList(vo);
						$("#chatList").prepend(html);

					})
					var position = $('[data-no='+endNo+']').prev().offset();//위치값
					document.querySelector('.chatcontent').scrollTo({top : position.top, behavior : 'auto'});
					isScrolled = false;
				}
			});
		}
		
		var renderList = function(vo) {
			var html = "";
			endNo = vo.cnum;
			//내가 보낸 채팅일 경우
			if(vo.mnum =="${loginMember.mnum}"){
			html = 	"<li class='me' data-no="+endNo+">"
					+'<img src="<c:url value='/image/printProfileImage?fileName=${loginMember.profileImageName}'/>"/>'
					+"<div class='me'>"
					+ "<p class='myChat'>"+vo.content+"</p>"
					+"</div>"
					+ "</li>";
			}
			//남이 보낸 채팅일 경우
			else{
				const mnum = vo.mnum;
				html = "<li id='otherChat' data-no="+endNo+">"
					+ "<img src='<c:url value='/image/printProfileImageNum?mnum="+mnum+"'/>'/>"
					+"<div id='otherChatDiv'>"
					+"<span>"+vo.nick+"</span>"
					+ "<p class='otherChat'>"+vo.content+"</p>"
					+"</div>"
					+ "</li>";
			}
			return html;
		}
		
		$(".chatcontent").scroll(function() {
			var $window = $(this);
			var scrollTop = $window.scrollTop();
			var windowHeight = $window.height();
			var documentHeight = $(document).height();

			// scrollbar의 thumb가 위의1px까지 도달 하면 리스트를 가져옴
			if (scrollTop < 1 && isScrolled == false) {
				isScrolled = true;
				fetchList();
			}
		});
		
		$(function() {
			var messageInput = $('textarea[name="msg"]');
			var sock = new SockJS("https://partyshare.store/user/echo");
			
			sock.onopen = function(){
				sock.send(JSON.stringify({
					puum : "${party.pnum}",
					muum : "${loginMember.mnum}",
					content : "E!n@t#e$t$",
					path : "${loginMember.profileImageName}",
					nick : "${loginMember.mnick}"
				})); 
			};
			sock.onmessage = onMessage;
			sock.onclose = onClose;
			
			function sendmsg() {
				var message = messageInput.val();
				if (message == "") {
					return false;
				}
			
				sock.send(JSON.stringify({
					puum : "${party.pnum}",
					muum : "${loginMember.mnum}",
					content : message,
					path : "${loginMember.profileImageName}",
					nick : "${loginMember.mnick}"
				})); 
						
				messageInput.val('');
			}
			
			function onMessage(msg){
				var chat = JSON.parse(msg.data);
				var html = renderList(chat);
				$("#chatList").append(html);
				moveDown();
			}
				
			$('.send').click(function() {
					sendmsg();
			}); 
			
			function onClose(e) {
				$("#messageArea").append("연결 끊김");
			}
		});
	});
	
	$("#msgi").keydown(function(event) {
	    if (event.which === 13) {
	        event.preventDefault();
	        $("#sendBtn").click();
	    }
	});
	
</script>
<%@ include file="../common/footer.jsp" %>















