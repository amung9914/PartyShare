<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="lat" value="${location[0]}" />
<c:set var="lng" value="${location[1]}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detailOfParty.jsp</title>
<script>
	const message = '${message}';
	if(message != ''){
		alert(message);
	}
</script>
<style>

	nav{
		width : 100%;
		border: 1px solid black; 
	}

	ul{
		display: flex;
		justify-content: space-evenly;
		list-style : none;
	}
	
	body{
	 	position : relative;
	}
	
	#banner{
		position: fixed;
		height: 300px;
		right: 21px;
		bottom: 200px;
		width: 200px;
	    border: 1px solid rgb(221, 221, 221);
    	border-radius: 12px;
    	padding: 24px;
    	background-color: white;
    	box-shadow: rgba(0, 0, 0, 0.12) 0px 6px 16px;
		transition: top 0.5s; 
		z-index: 1;
	}
	
	#banner.top{
		position: fixed;
		right: 21.5px;
  		top: 350px;
	}
	
	#banner.on {
		position: fixed;
		right: 21.5px;
  		bottom: 350px;
	}
	
	#bannerBtn {
		width : 150px;
		height: 50px;
		border: 1px solid black;
		border-radius: 5px;
		text-align: center;
		line-height: 50px;
	}
	
	#top{
		background-color : beige;
		height : 300px;
	}
	
	#middle{
		height : 1000px;
	}
	
	#footer{
		background-color : beige;
		height : 300px;
	}
	
</style>
</head>
<body>
	<div id=top>
		<h1>detailOfParty.jsp</h1>
		<nav>
			<ul>
				<li><a href="<c:url value='/'/>">홈</a></li>
				<li><a href="<c:url value='/partyBoard/listPage?pnum=${vo.pnum}'/>">게시판</a></li>
				<li><a href="<c:url value='/chat?pnum=${vo.pnum}'/>">채팅창</a></li>
			</ul>	
		</nav>
	</div>
	
	<img src="${contextPath}/upload/party${f:replace(vo.partyImage1, 's_', '')}" width="50%"/>
	<img src="${contextPath}/upload/party${f:replace(vo.partyImage2, 's_', '')}" width="25%"/>
	<img src="${contextPath}/upload/party${f:replace(vo.partyImage3, 's_', '')}" width="25%"/>
	
	<h1>파티 소개</h1>
	
	${vo.pcontext}
	
	<h1>파티원 통계</h1>
	<c:choose>
		<c:when test="${isEmpty eq true}">
			해당 파티에 참여중인 파티원이 없습니다.
		</c:when>
		<c:otherwise>
			<button onclick="showGraph('joinCntGraph')">참여횟수</button>
			<button onclick="showGraph('genderGraph')">성별</button>
			<button onclick="showGraph('ageGraph')">연령</button>
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
		</c:otherwise>
	</c:choose>
	
	<h1>파티 장소</h1>
	${vo.sido} ${vo.sigungu} ${vo.address} ${vo.detailAddress} <br/><br/><br/>
	<div id="map" style="width:100%;height:350px;z-index:0;"></div>
	
	<div id="middle"></div>
	<div id="footer"></div>
	
	<div id="banner">
		<h1>함께 하시겠습니까?</h1>
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
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(${lat}, ${lng}); 
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
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
		    var val = $(document).height() - $w.height() - footerHei;
		
		    if (sT >= val) {
		        $banner.addClass('on');
		    } else {
		        $banner.removeClass('on');
		    }
	
		  	if (sT <= bannerTopLimit) {
		        $banner.addClass('top');
		    } else {
		        $banner.removeClass('top');
		    }  
	    	
  		}); 
	
	});
	
		var joinCntChart = null;
	    var genderChart = null;
	    var ageChart = null;
	
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
			          hoverBackgroundColor: ["#FF8200", "#FF8200", "#FF8200", "#FF8200"],
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
			          hoverBackgroundColor: ["#FF8200", "#FF8200"],
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
			          hoverBackgroundColor: ["#FF8200", "#FF8200", "#FF8200", "#FF8200", "#FF8200"],
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
	
</body>
</html>