<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<style>
	#chat_container{
		width : 45%;
		font-size: 20px;
		border-radius: 20px;
		border:1px solid lightgrey;
		box-shadow: 1px 1px 1px;
		float:left;
		margin-top: 5%;
		margin-left: 5%;
	}
	
	.chatcontent {
		height: 600px;
		width : 95%;
		overflow-y: scroll;
	}
	
	.chat-fix {
		position: fixed;
		bottom: 0;
		width: 100%;
		text-align: center;
	}
		
	#msgi{	
		width:75%;
		resize: none;
		margin-left:5%;
		border-radius: 10px;
			
	}
	.send{
		height:100px;
		width:100px;
		position: relative;
		bottom: 41px;
		
	}
	
	li{
		list-style-type:none;
	}
	.me{
		text-align : right;
		margin-right : 10px;
		border-radius: 10px;
	}
	.me img{
		width:60px;
		height:60px;
		border-radius: 30px;
	}
	
	.myChat{
		text-align:left;
		background-color : yellow;
		display:inline-block;
		max-width : 250px;  
		border-radius: 10px;
		padding:5px;
		word-wrap:break-word; 
		word-break:break-all;
	}
	
	.otherChat{
		display:inline-block;
		max-width : 250px;
		margin-left: 10px;
		background-color: white;
		color:black;
		border-radius: 10px;
		padding:5px;
		word-wrap:break-word; 
		word-break:break-all;
		
	}
	#otherChat img{
		width:60px;
		height:60px;
		border-radius: 30px;
		
	}
	#otherChat span{
		margin-left: 5px;
		font-size: 25px;
		displsy:flex;
		flex-wrap: wrap;
		height: 30px;
	}
	
	#partyInfoContainer{
		width : 500px;
		height: 700px;
		background-color:white;
		float:left;
		margin-left: 5%;
		margin-top: 5%;
	}
	#partyInfoContainer img{
		text-align:center;
		width : 350px;
		height : 450px;
	}
	#partyInfoContainer table{
		font-size: 21px;
	}
	#partyInfoContainer table tr td:last-child{
		padding-left: 10px;
	}
	
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
<a href="<c:url value='/home'/>">home으로</a>
<a href="<c:url value='/party/partyList'/>">List화면으로 이동</a><br/>
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
									<img src="<c:url value='/image/printProfileImage?fileName=${joinMember.profileImageName}'/>" /><span>${joinMember.mnick}</span>
								</c:if>
							</c:forEach>
							<div>
								<p class="otherChat">${chat.content}</p>
							</div> 
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
<div id="partyInfoContainer">
	<table class="table table-bordered border-black">
		<tr>
			<th colspan="2" style="text-align: center;">
				<img src="<c:url value='/image/printPartyImage?fileName=${fn:replace(party.partyImage1, "s_", "")}'/>"/>
			</th>
		</tr>
		<tr>
			<td>파티이름</td>
			<td>${party.pname}</td>
		</tr>
		<tr>
			<td>파티날짜</td>
			<td>${party.formatStartDate} ~ ${party.formatEndDate}</td>
		</tr>
		<tr>
			<td>파티장소</td>
			<td>${party.address}</td>
		</tr>
		<tr>
			<td>파티소개</td>
			<td>${party.pcontext}</td>
		</tr>
	</table>
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
				url : contextPath+"/chatList?endNo="+endNo+"&pnum=${party.pnum}",
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
					+ "<img src='<c:url value='/image/printProfileImageNum?mnum="+mnum+"'/>'/><span>"+vo.nick+"</span>"
					+"<div>"
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
			let sockAddr = 'echo/${pnum}';
			var sock = new SockJS(sockAddr);
			
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
				console.log(chat);
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
</html>















