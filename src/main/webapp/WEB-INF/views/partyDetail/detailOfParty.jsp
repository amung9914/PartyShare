<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../common/header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="lat" value="${location[0]}" />
<c:set var="lng" value="${location[1]}" />
<script>
	const message = '${message}';
	if(message != ''){
		alert(message);
	}
</script>
<link href="${contextPath}/resources/css/jinlee/detailOfParty.css" rel="stylesheet">
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
			  <li><a href="<c:url value='/user/chat?pnum=${vo.pnum}'/>">채팅창</a></li>
			</ul>	
		</nav>
	</div>
		
	<div class="grid-container">
	  <div class="first-image">
	    <img src="${contextPath}/image/printPartyImage?fileName=${fn:replace(vo.partyImage1, 's_', '')}"/>
	  </div>
	    <div class="second-image">
	      <img src="${contextPath}/image/printPartyImage?fileName=${fn:replace(vo.partyImage2, 's_', '')}"/>
	    </div>
	    <div class="third-image">
	      <img src="${contextPath}/image/printPartyImage?fileName=${fn:replace(vo.partyImage3, 's_', '')}"/>
	    </div>
	</div>

	
	<div class="introduce-party">
		<div class="introduce-party-text">
			<h2>파티 소개</h2> <br/><hr/><br/>
			<div class="introduce-party-content">
				${vo.pcontext}
			</div>
		</div>
	</div>
	
	<div class="stats-party">
		<div class="stats-party-text">
		<h2>파티원 통계</h2> <br/><hr/><br/>
			<c:choose>
				<c:when test="${isEmpty eq true}">
					해당 파티에 참여중인 파티원이 없습니다.
				</c:when>
				<c:otherwise>
					<div class="statsArea">
						<div class="statsAreaBtn">
							<button class="statsBtn" style="margin: 0;" onclick="showGraph('joinCntGraph')">참여횟수</button>
							<button class="statsBtn" style="margin-left: 10px; margin-right: 0;" onclick="showGraph('genderGraph')">성별</button>
							<button class="statsBtn" style="margin-left: 10px; margin-right: 0;" onclick="showGraph('ageGraph')">연령</button>
						</div>
						<div id="joinCntGraph">
							<h3>참여횟수</h3>
							<canvas id="joinCnt-chart" style="margin: 0 auto;" height="300"></canvas>
						</div>
						<div id="genderGraph">
							<h3>성별</h3>
							<canvas id="gender-chart" style="margin: 0 auto;" height="300"></canvas>
						</div>
						<div id="ageGraph">
							<h3>연령</h3>
							<canvas id="age-chart" style="margin: 0 auto;" height="300"></canvas>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<div class="location-party">
		<div class="location-party-text">
			<h2>파티 장소</h2> <br/><hr/><br/>
			${vo.sido} ${vo.sigungu} ${vo.address} ${vo.detailAddress} <br/><br/><br/>
			<div id="map" style="width:100%;height:350px;z-index:0;"></div>
		</div>
	</div>
	
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey}&libraries=services"></script>
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
<%@ include file="../common/fixFooter.jsp" %>