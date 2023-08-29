<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<jsp:include page="../common/header.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="lat" value="${location[0]}" />
<c:set var="lng" value="${location[1]}" />
<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detailOfParty.jsp</title> -->
<script>
	const message = '${message}';
	if(message != ''){
		alert(message);
	}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
 	/* @import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100&family=Noto+Sans+KR:wght@300&display=swap');
    * {margin: 0; padding: 0; font-family: 'Hahmlet', serif; font-family: 'Noto Sans KR', sans-serif;} */
	
	body{
	 	position : relative;
	}
	
	#banner{
		display: none;
		position: fixed;
		text-align: center;
		height: auto;
		right: 21px;
		bottom: 200px;
		width: 360px;
	    border: 1px solid rgb(221, 221, 221);
    	border-radius: 12px;
    	padding: 24px;
    	background-color: white;
    	box-shadow: rgba(0, 0, 0, 0.12) 0px 6px 16px;
		transition: top 0.5s; 
		z-index: 0;
	}
	
	.banner-text-1, .banner-text-2, .banner-text-3 {
		text-align : left;
		padding: 2px;
		margin-bottom: 7px; 
	}
	
	.banner-text-1 {
		margin-top: 15px;
	}
	
	.banner-text-3 {
		margin-bottom: 20px;
	}
	
	#banner.top{
		position: fixed;
		right: 21.5px;
  		top: 700px;
  		height: fit-content
	}
	
	#banner.on {
		position: fixed;
		right: 21.5px;
  		/* bottom: 300px; */
  		bottom: 180px;
	}
	
	#bannerBtn {
		width : 80%;
		margin: 0 auto;
		height: 50px;
		color: white;
		background-color: #FF385C;
		font-weight: bold;
		text-decoration: none;
		border-radius: 5px;
		text-align: center;
		line-height: 50px;
	}
	
	#bannerBtn:hover{
		background-color: #FF6666;
	}
	
	#banner a {
		text-decoration: none;
	}
	
	/* #middle{
		height : 1000px;
	}
	
	#footer{
		background-color : beige;
		height : 300px;
	} */
	
	/* 상단 파티 이름 */
	.grid-container-text{
	 	margin: 20px 0px 20px 20px;
	}
	
	/* 대문사진 */
	.grid-container {
	  display: grid;
	  width: 95%;
	  margin: 0 auto;
	  height: 350px;
	  grid-template-columns: 1fr 1fr 1fr; 
	  gap: 5px;
	}
	
	.grid-container img {
	  width: 100%;
	  height: 100%;
	  object-fit: contain;
	}
	
	.first-image, .second-image, .third-image {
	  width: 100%;
	  max-height: 350px;
	}
	
	/* 네비게이션 바 */
	#top {
		/* background-color : #FF385C;  */
		width: 95%;
		height: 50px;
		display: flex;
		justify-content: center; /* 수평 가운데 정렬 */
		align-items: center; /* 수직 가운데 정렬 */
		height: 50px; /* 컨테이너의 전체 높이만큼 설정하여 수직 중앙 정렬을 적용 */
		margin: 20px auto;
		color: white;
		border-top: 2px solid black; /* 위쪽 테두리 */
   		border-bottom: 2px solid black; /* 아래쪽 테두리 */
		/* border-radius: 10px; */
	}
	
	nav{
		width : 100%;
		font-weight: bold;
	}

	ul{
		display: flex;
		justify-content: space-evenly;
		list-style : none;
		margin-bottom: 0;
	}
	
	ul li a {
		color: black;
		text-decoration: none;
	}
	
	ul li a:hover {
		color: #FF385C;
	}
	
	/* 파티 소개 */
	.introduce-party {
		/* border: 1px solid black; */
		width: 65%;
	}
	
	.introduce-party-text {
		margin: 20px 0px 20px 30px;
		padding-bottom: 35px;
		border-bottom: 1px solid #CACACA;
	}
	
	/* 파티 통계 */
	.stats-party {
		/* border: 1px solid black; */
		width: 65%;
	}
	
	.stats-party-text {
		margin: 20px 0px 20px 30px;
		padding-bottom: 35px;
		border-bottom: 1px solid #CACACA;
	}
	
	.stats-party-text h1 {
		padding-bottom: 20px;
	}
	
	.statsBtn {
	  display: inline-block;
	  padding: 10px 20px;
	  margin-right: 15px;
	  margin-bottom: 20px;
	  font-size: 15px;
	  border-radius: 30px; /* 테두리 둥글게 설정 */
	  border: 1px solid #FF385C; /* 테두리 색 설정 */
	  background-color: white; /* 배경 색 설정 */
	  color: black;
	  text-align: center;
	  cursor: pointer;
	  transition: background-color 0.3s, border-color 0.3s;
	}
	
	.statsBtn.active {
   		background-color: #F3F3F3;
	}

	.statsBtn:hover:not(.active) {
    	background-color: #F3F3F3;
	}
	
	.statsArea {
		width: 501px;
		text-align: center;
	    border: 1px solid rgb(221, 221, 221);
    	border-radius: 12px;
    	padding: 24px;
    	background-color: white;
    	box-shadow: rgba(0, 0, 0, 0.12) 0px 6px 16px;
	}
	
	.statsArea h3 {
		margin-bottom : 20px;
	}
	
	/* 파티 지도 */
	.location-party {
		/* border-bottom: 1px solid #CACACA; */
		width: 65%;
	}
	
	.location-party-text {
		margin: 20px 0px 187px 30px;
		padding-bottom: 35px;
		border-bottom: 1px solid #CACACA;
	}

</style>
</head>
<body>
	
	<div class="grid-container-text">
		<h1>${vo.pname}</h1>
		<b>시작일</b> ${vo.formatStartDate} &nbsp; | &nbsp; <b>장소</b> 
		${vo.sido} ${vo.sigungu} ${vo.address} ${vo.detailAddress} <br/>
	</div>
	
	<div id=top>
		<nav>
			<ul>
				<li><a href="<c:url value='/'/>">홈</a></li>
				<li><a href="<c:url value='/user/partyBoard/listPage?pnum=${vo.pnum}'/>">게시판</a></li>
				<li><a href="<c:url value='/chat?pnum=${vo.pnum}'/>">채팅창</a></li>
			</ul>	
		</nav>
	</div>
		
	<div class="grid-container">
	  <div class="first-image">
	    <!-- 왼쪽 사진 -->
	    <img src="${contextPath}/upload/party${f:replace(vo.partyImage1, 's_', '')}"/>
	  </div>
	    <div class="second-image">
	      <!-- 상단 오른쪽 사진 -->
	      <img src="${contextPath}/upload/party${f:replace(vo.partyImage2, 's_', '')}"/>
	    </div>
	    <div class="third-image">
	      <!-- 하단 오른쪽 사진 -->
	      <img src="${contextPath}/upload/party${f:replace(vo.partyImage3, 's_', '')}"/>
	    </div>
	</div>

	
	<div class="introduce-party">
		<div class="introduce-party-text">
			<h1>파티 소개</h1>
			${vo.pcontext}
		</div>
	</div>
	
	<div class="stats-party">
		<div class="stats-party-text">
		<h1>파티원 통계</h1>
			<c:choose>
				<c:when test="${isEmpty eq true}">
					해당 파티에 참여중인 파티원이 없습니다.
				</c:when>
				<c:otherwise>
					<button class="statsBtn" onclick="showGraph('joinCntGraph')">참여횟수</button>
					<button class="statsBtn" onclick="showGraph('genderGraph')">성별</button>
					<button class="statsBtn" onclick="showGraph('ageGraph')">연령</button>
					<div class="statsArea">
						<div id="joinCntGraph">
							<h3>참여횟수</h3>
							<canvas id="joinCnt-chart" width="500" height="300"></canvas>
						</div>
						<div id="genderGraph">
							<h3>성별</h3>
							<canvas id="gender-chart" width="500" height="300"></canvas>
						</div>
						<div id="ageGraph">
							<h3>연령</h3>
							<canvas id="age-chart" width="500" height="300"></canvas>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<div class="location-party">
		<div class="location-party-text">
			<h1>파티 장소</h1>
			${vo.sido} ${vo.sigungu} ${vo.address} ${vo.detailAddress} <br/><br/><br/>
			<div id="map" style="width:100%;height:350px;z-index:0;"></div>
		</div>
	</div>
	
	<div id="middle"></div>
	<div id="footer"></div>
	
	<div id="banner">
		<h3><b>함께 하시겠습니까?</b></h3>
			<div class="banner-text-1">
				<b>시작일</b> <br/>
				${vo.formatStartDate} <br/>
			</div>
			<div class="banner-text-2">
				<b>종료일</b> <br/>
				${vo.formatEndDate} <br/>
			</div>
			<div class="banner-text-3">
				<b>장소</b> <br/>
				${vo.sido} ${vo.sigungu} ${vo.address} ${vo.detailAddress}
			</div>
		<a href="${contextPath}/partyDetail/bookingParty?pNum=${vo.pnum}"><div id="bannerBtn">파티 참여하기</div></a>
	</div>
	
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0534688966ae7b4ea20ffd95099348e8"></script>
<script>

	var result = '${result}';
	if(result != null && result != ''){
		alert(result);
	}

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(${lat}, ${lng}), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	var imageSrc = '${contextPath}/resources/img/marker.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(64, 64), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(20, 64)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(${lat}, ${lng}); 
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition,
	    image: markerImage
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
	// marker.setMap(null);    

	// 스크롤 이벤트 리스너 추가
	$(function() {
	    var $w = $(window);
	    footerHei = $('#footer').outerHeight();
	    $banner = $('#banner');
	    bannerTopLimit = $('#top').outerHeight(); // 원하는 배너가 유지되는 최소 스크롤 위치
	
	    $w.on('scroll', function() {
	
		    var sT = $w.scrollTop();
		    // var val = $(document).height() - $w.height() - footerHei;
		    var val = $(document).height() - $w.height() - 100;
		
		    if (sT >= val) {
		        $banner.addClass('on');
		    } else {
		        $banner.removeClass('on');
		    }
	
		  	if (sT <= bannerTopLimit) {
		        $banner.addClass('top');
		    } else {
		        $banner.removeClass('top');
		        $banner.show();
		    }  
	    	
  		}); 
	
	});
	
		var joinCntChart = null;
	    var genderChart = null;
	    var ageChart = null;
	    var activeButton = null; // 현재 활성화된 버튼

	    var buttons = document.getElementsByClassName("statsBtn");
	    for (var i = 0; i < buttons.length; i++) {
	        buttons[i].addEventListener("click", function() {
	            toggleActive(this);
	        });
	    }

	    function toggleActive(button) {
	        if (button.classList.contains("active")) {
	            button.classList.remove("active");
	        } else {
	            if (activeButton !== null) {
	                activeButton.classList.remove("active");
	            }
	            button.classList.add("active");
	            activeButton = button;
	        }
	    }

	    
		// 초기에 참여횟수 그래프만 보이도록 설정
		createJoinCntChart();
	    /* document.getElementById("joinCntGraph").style.display = "block"; */
	    document.getElementById("genderGraph").style.display = "none";
	    document.getElementById("ageGraph").style.display = "none";
	    
	    function showGraph(graphId) {
	        var graphs = ["joinCntGraph", "genderGraph", "ageGraph"];
	        for (var i = 0; i < graphs.length; i++) {
	            var graph = document.getElementById(graphs[i]);
	            if (graphs[i] === graphId) {
	                graph.style.display = "block";
	                if (graphId === "joinCntGraph") {
	                	if (joinCntChart) {
	                        joinCntChart.destroy(); // 기존 차트 제거
	                    }
	                    createJoinCntChart(); // 새로운 차트 생성
	                } else if (graphId === "genderGraph") {
	                	if (genderChart) {
	                        genderChart.destroy();
	                    }
	                    createGenderChart();
	                } else if (graphId === "ageGraph") {
	                	if (ageChart) {
	                        ageChart.destroy();
	                    }
	                    createAgeChart();
	                }
	            } else {
	                graph.style.display = "none";
	            }
	        }
	        
	    }
	    
	    function createJoinCntChart() {
			var canvas = document.getElementById("joinCnt-chart");
			  joinCntChart = new Chart(canvas, {
			    type: 'doughnut',
			    data: {
			      labels: ["처음이에요", "두 번째", "세 번째", "네 번 이상"],
			      datasets: [
			        {
			          backgroundColor: ["#dcdcdc", "#dcdcdc", "#dcdcdc", "#dcdcdc"],
			          borderColor: ["#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF"],
			          borderWidth: [2, 2, 2, 2, 2],
			          hoverBackgroundColor: ["#FF385C", "#FF385C", "#FF385C", "#FF385C"],
			          data: [${joinCntPercent[0]}, ${joinCntPercent[1]}, ${joinCntPercent[2]}, ${joinCntPercent[3]}]
			        }
			      ]
			    },
			    options: {
			    	responsive: false,
			        animation: {
			            duration: 1500, // 애니메이션 지속 시간 (밀리초)
			            easing: 'easeInOutQuart' // 애니메이션 이징 함수 (선택 사항)
			        },
				    tooltips: {
				    	enabled: true, // 툴팁 사용
		                mode: 'single', // 하나의 툴팁만 표시
		                displayColors: false, // 툴팁 내 색상 표시 제거
		                backgroundColor: 'rgba(0, 0, 0, 0.7)', // 툴팁 배경색 지정
		                bodyFontSize: 14, // 툴팁 내 텍스트 글자 크기 설정
		                callbacks: {
		                    label: function(tooltipItem, data) {
		                        var label = data.labels[tooltipItem.index] || '';
		                        var value = data.datasets[0].data[tooltipItem.index];
		                        return label + ': ' + value + '%';
		                    }
		                }
		            },
		            legend: {
		                display: false // 데이터 레이블 숨기기
		            }
			    }
			});
	    }
	
	    function createGenderChart() {
	    	var canvas = document.getElementById("gender-chart");
	    	genderChart = new Chart(canvas, {
			    type: 'doughnut',
			    data: {
			      labels: ["남성", "여성"],
			      datasets: [
			        {
			          backgroundColor: ["#dcdcdc", "#dcdcdc"],
			          borderColor: ["#FFFFFF", "#FFFFFF"],
			          borderWidth: [2, 2, 2, 2, 2],
			          hoverBackgroundColor: ["#FF385C", "#FF385C"],
			          data: [${genderPercent[0]},${genderPercent[1]}]
			        }
			      ]
			    },
			    options: {
			    	responsive: false,
			        animation: {
			            duration: 1500, // 애니메이션 지속 시간 (밀리초)
			            easing: 'easeInOutQuart' // 애니메이션 이징 함수 (선택 사항)
			        },
				    tooltips: {
				    	enabled: true, // 툴팁 사용
		                mode: 'single', // 하나의 툴팁만 표시
		                displayColors: false, // 툴팁 내 색상 표시 제거
		                backgroundColor: 'rgba(0, 0, 0, 0.7)', // 툴팁 배경색 지정
		                bodyFontSize: 14, // 툴팁 내 텍스트 글자 크기 설정
		                callbacks: {
		                    label: function(tooltipItem, data) {
		                        var label = data.labels[tooltipItem.index] || '';
		                        var value = data.datasets[0].data[tooltipItem.index];
		                        return label + ': ' + value + '%';
		                    }
		                }
		            },
		            legend: {
		                display: false // 데이터 레이블 숨기기
		            }
			    }
			});
	    }
		
	    function createAgeChart() {
	    	var canvas = document.getElementById("age-chart");
	    	ageChart = new Chart(canvas, {
			    type: 'doughnut',
			    data: {
			      labels: ["10대", "20대", "30대", "40대", "50대 이상"],
			      datasets: [
			        {
			          backgroundColor: ["#dcdcdc", "#dcdcdc", "#dcdcdc", "#dcdcdc", "#dcdcdc"],
			          borderColor: ["#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF"],
			          borderWidth: [2, 2, 2, 2, 2],
			          hoverBackgroundColor: ["#FF385C", "#FF385C", "#FF385C", "#FF385C", "#FF385C"],
			          data: [${agePercent[0]}, ${agePercent[1]}, ${agePercent[2]}, ${agePercent[3]}, ${agePercent[4]}]
			        }
			      ]
			    },
			    options: {
			    	responsive: false,
			        animation: {
			            duration: 1500, // 애니메이션 지속 시간 (밀리초)
			            easing: 'easeInOutQuart' // 애니메이션 이징 함수 (선택 사항)
			        },
				    tooltips: {
				    	enabled: true, // 툴팁 사용
		                mode: 'single', // 하나의 툴팁만 표시
		                displayColors: false, // 툴팁 내 색상 표시 제거
		                backgroundColor: 'rgba(0, 0, 0, 0.7)', // 툴팁 배경색 지정
		                bodyFontSize: 14, // 툴팁 내 텍스트 글자 크기 설정
		                callbacks: {
		                    label: function(tooltipItem, data) {
		                        var label = data.labels[tooltipItem.index] || '';
		                        var value = data.datasets[0].data[tooltipItem.index];
		                        return label + ': ' + value + '%';
		                    }
		                }
		            },
		            legend: {
		                display: false // 데이터 레이블 숨기기
		            }
			    }
			});
	    }
	</script>
	
<!-- </body>
</html> -->
<%@ include file="../common/fixFooter.jsp" %>