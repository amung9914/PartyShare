<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>여러개 마커에 이벤트 등록하기1</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>   
</head>
<body>
<div id="map" style="width:100%;height:350px;"></div>
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
	        position: pos.latlng // 마커의 위치
	    });
 
	    var pnum = pos.content; 
	    let pname = null;
	    let host = null;
	
		// 마커 클릭 이벤트
	    kakao.maps.event.addListener(marker, 'click', function() {
	    		
				let url = "location/"+pnum;
				$.getJSON(url,function(data){
					// data == Map
					// {'list':{}, 'pm' : {}}
					pname = data.pname;
					host = data.host;
					
					// content HTMLElement 생성
				    var content = document.createElement('div');
					
				    var infoDiv = document.createElement('div');
				    infoDiv.style.backgroundColor  = "Yellow"; // 원하는 스타일 속성을 설정하세요
				    infoDiv.style.textDecoration = "underline"; // 다른 스타일 속성도 필요한 경우 설정하세요
				    
				    
				 	// 마커 클릭시 표시할 내용입니다.
				    var info = document.createElement('a');
				    info.appendChild(document.createTextNode("파티이름:"+pname)); 
				    info.appendChild(document.createElement('br'));
				    info.appendChild(document.createTextNode("host:"+host));
				    info.href = "partyDetail?pnum="+pnum; // 파티 상세페이지 연결
				    
				    content.appendChild(infoDiv);
				    infoDiv.appendChild(info);
				    

				    var closeBtn = document.createElement('button');
				    closeBtn.appendChild(document.createTextNode('닫기'));
				    // 닫기 이벤트 추가
				    closeBtn.onclick = function() {
				        overlay.setMap(null);
				    };

				    content.appendChild(closeBtn);

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