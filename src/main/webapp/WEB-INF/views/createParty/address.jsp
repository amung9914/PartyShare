<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	h1{
		margin-left:40%;
	}
	#addressBox{
		border:1px black solid;
		width: 700px;
		height: 130px;
		margin-left: 30%;
		line-height: 30px;
		margin-top: 3%;
	}
	#addressBox form{
		margin-top:1%;
		margin-left:5%;
	}
	#address{
		width: 500px;
	}
	#detailAddress{
		width: 310px;
	}
	#mapBox{
		width: 550px;
		height: 550px;
		border: 1px lightgrey solid;
		box-shadow: 1px 1px 1px;
		margin-left: 35%;
		margin-top: 3%;
		text-align: center;
	}
</style>
</head>
<body>
	<h1>주소를 입력해주세요</h1>
	<div id="addressBox">
		<form action="createAddress" method="post">
			<input type="hidden" name="host" value="${loginMember.mnum}"/>
			<input type="hidden" name="description" value="${vo.description}" />
			<input type="hidden" name="category" value="${vo.category}"/>
			
			<input type="text" id="postcode" placeholder="우편번호">
			<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="address" id="address" placeholder="주소"><br>
			<input type="text" name="detailAddress" id="detailAddress" class="reqInput" placeholder="상세주소">
			<input type="text" id="extraAddress" placeholder="참고항목">
			<input type="hidden" id="sido" name="sido"/>
			<input type="hidden" id="sigungu" name="sigungu"/>
			<input type="hidden" id="lat" name="lat">
	    	<input type="hidden" id="lng" name="lng">
		</form>
	</div>
	
<div id="mapBox">파티 위치
	<div id="map" style="width:500px;height:500px;margin:3% auto;"></div>
</div>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0534688966ae7b4ea20ffd95099348e8&libraries=services"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
        	oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };  

                //지도를 생성합니다    
                var map = new kakao.maps.Map(mapContainer, mapOption); 

                //주소-좌표 변환 객체를 생성합니다
                var geocoder = new kakao.maps.services.Geocoder();

                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                document.getElementById("sido").value = data.sido;
                document.getElementById("sigungu").value = data.sigungu;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
                
             // 주소로 좌표를 검색합니다
                
                geocoder.addressSearch(addr, function(result, status) {
                	

                    // 정상적으로 검색이 완료됐으면 
                     if (status === kakao.maps.services.Status.OK) {

                        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                       
                        
                        document.getElementById('lat').value = result[0].y;
                        document.getElementById('lng').value = result[0].x;
                        console.log(result[0].y,result[0].x);

                        // 결과값으로 받은 위치를 마커로 표시합니다
                        var marker = new kakao.maps.Marker({
                            map: map,
                            position: coords
                        });

                        // 인포윈도우로 장소에 대한 설명을 표시합니다
                        var infowindow = new kakao.maps.InfoWindow({
                            content: '<div style="width:150px;text-align:center;padding:6px 0;">파티장소</div>'
                        });
                        infowindow.open(map, marker);

                        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                        map.setCenter(coords);
                    }
                });
            }
        }).open();
    }
</script>
<%@ include file="partyCreateFooter.jsp" %>
</body>
</html>