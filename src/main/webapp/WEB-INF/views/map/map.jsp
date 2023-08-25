<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>여러개 마커에 이벤트 등록하기1</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>   
<style>
 .infoBox{
 	background-color:white;
 	width: 400px;
    border-radius: 20px;
    display: inline-flex;
}
.infoDiv{
    display: inline-flex;
    width: 370px;
}
.infoDiv img{
	width: 200px;
}
.infoText{
	padding: 10px;
}
.pname{
	font-size: 20px;
	height: 75%;
	}
.hostName{
	color:grey;
} 
.closeBtn{
    border-radius: 10px;
    background-color: #b3b3b3;
    border: none;
    color: white;
    width: 20px;
    margin: 10px;
    }
</style>
</head>
<body>
<div id="map" style="width:100%;height:97.5vh;"></div>
<div id="detailView"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey}&libraries=services"></script>
<script>

//위치 좌표 얻어옴(성공했을 때 실행할 함수, 실패했을 때 실행할 함수)
navigator.geolocation.getCurrentPosition(onGeoOk,onGeoError);
function onGeoOk(position){
	
    const lat = position.coords.latitude; //위도
    const lng = position.coords.longitude; //경도
    console.log("You live in",lat,lng);
    mapOption.center = new kakao.maps.LatLng(lat,lng); //지도의 중심좌표를 현재좌표로 변경 
    open(); //지도 생성
}
function onGeoError(){
    alert("위치정보를 불러올 수 없습니다.");
    history.back();
}

var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 6 // 지도의 확대 레벨
    };

let map = null;

//지도를 생성합니다
function open(){
	map = new kakao.maps.Map(mapContainer, mapOption); 

	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();

	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
	var imageSrc = '${path}/resources/img/marker.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(64, 64), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(20, 64)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	
	// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
	var positions = [
		<c:forEach items="${list}" var="list">
	    {
	        content: '${list.pnum}',
	        latlng: new kakao.maps.LatLng(${list.lat}, ${list.lng})
	    },
	    </c:forEach>
	];

		positions.forEach(function (pos)  {
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: pos.latlng, // 마커의 위치
	        image: markerImage
	    });
 
	    var pnum = pos.content; 
	    let pname = null;
	    let host = null;
	
		// 마커 클릭 이벤트
	    kakao.maps.event.addListener(marker, 'click', function() {
	    		
				let url = "${path}/location/"+pnum;
				$.getJSON(url,function(data){
					pname = data.pname;
					host = data.host;
					pImg = data.partyImage1;
					
					// content HTMLElement 생성
				    var content = document.createElement('div');
					
					let str = "";
					str += "<div class='infoBox'>";
					str += "<div class='infoDiv' data-pnum='"+pnum+"'>";
					str += "<img src='${path}/location/printImg?fileName="+pImg+"'/>";
					str += "<div class='infoText'>";
					str += "<div class='pname'>"+pname+"</div>";
					str += "<div class='hostName'>"+host+"</div>";
					str += "</div>";
					str += "</div>";//end infoDiv
					str += "<div class='btnBox'>";
					str += "<button class='closeBtn'>x</button>";
					str += "</div>";
					str += "</div>";
					
				    content.innerHTML = str;
					
				    //팝업 클릭 이벤트
				    $("#map").on("click",".infoDiv",function(){
				    	let pnum = $(this).attr("data-pnum");
				    	location.href="<c:url value='/partyDetail/detailOfParty?pNum="+pnum+"'/>";
				    })
				    
				    //팝업 닫기 이벤트 
				    $("#map").on("click",".closeBtn",function(){
				    	 overlay.setMap(null);
				    })
				    
				    // customoverlay 생성, 이때 map을 선언하지 않으면 지도위에 올라가지 않습니다.
			    	var overlay = new daum.maps.CustomOverlay({
				        position: pos.latlng,
				        content: content
				    });
			        overlay.setMap(map);
				});
			
	        
	    });
	  
	})
	
	
}// end open()

</script>
</body>
</html>