<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- footer.jsp -->
<style>
	footer{
		width: 100%;
		background-color : #f7f7f7;
		position : relative;
  		transform : translateY(-100%);
  		padding: 20px 0px 0px 0px;
	}
	#footerAtag, #footerPtag{
		width: 90%;
		margin-left:5%;
	}
	#footerAtag{
		height: 15px;
		line-height: 15px;
	}
	#footerAtag a{
		text-decoration: none;
		color:black;
	}
	#footerAtag a:hover{
		text-decoration: underline;
	}
	#footerPtag{
		font-size: 10px;
	}
</style>
<footer>
	<div id="footerAtag">
		&copy;2023 PartyShare, Inc. 
		<a href="<c:url value='/policy'/>">개인정보 처리방침</a> |
		<a href="<c:url value='/policy2'/>">이용약관</a> |
		<a href="">사이트맵</a> |
		<a href="<c:url value='/infomation'/>">세부정보</a>
	</div>
	<div id="footerPtag">
		<hr/>
		<p>웹사이트 제공자: PartyShare | 이사: 김서영, 이진형, 김선국, 이인, 김진우 | 연락처: partyShare@partyShare.com, 웹사이트, 080-000-0000 | 호스팅 서비스 제공업체: 아마존 웹서비스 | 파티쉐어는 파티매칭 중개자로 파티쉐어 플랫폼을 통하여 게스트와 호스트 사이에 이루어지는 파티매칭의 당사자가 아닙니다. <br/>파티쉐어 플랫폼을 통하여 예약된 숙소, 체험, 호스트 서비스에 관한 의무와 책임은 해당 서비스를 제공하는 호스트에게 있습니다.</p>
	</div>
</footer>

</body>
</html>