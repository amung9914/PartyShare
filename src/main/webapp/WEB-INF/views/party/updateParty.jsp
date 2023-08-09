<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>파티 수정하기</h2>
<!-- 수정되는 객체 -->
 <form method="POST">
		<input type="hidden" name="pnum" value="${party.pnum}"/> 
		파티이름 : <input type="text" name="pname" value="${party.pname}"/><br/>
		
		주소수정하기 : <br/>
		<input type="button" onclick="execDaumPostcode()" value="주소찾기"><br>
		<input type="text" name="address" id="address" value="${party.address}"/><br>
		<input type="text" name="detailAddress" id="detailAddress" value="${party.detailAddress}"/>
		<input type="text" id="extraAddress" placeholder="참고항목"><br/>
		<input type="hidden" id="sido" name="sido" value="${party.address}"/>
		<input type="hidden" id="sigungu" name="sigungu" value="${party.sigungu}"/>
		<input type="hidden" id="lat" name="lat" value="${map.lat}"/>
    	<input type="hidden" id="lng" name="lng" value="${map.lng}">
		
		시작일 : <input type="date" name="startDate" value="${party.startDate}" id="startDateInput"/><br/>
		종료일 : <input type="date" name="endDate" value="${party.endDate}"/><br/>
		카테고리1 :    
		<select name="mainCategory" >
		    <option value="${party.mainCategory}">${party.mainCategory}</option>
		    <option value="기상천외한 파티">기상천외한 파티</option>
		    <option value="초소형 주택">초소형 주택</option>
		    <option value="캠핑장">캠핑장</option>
		    <option value="해변바로앞">해변바로앞</option>
		    <option value="농촌">농촌</option>
		    <option value="속세를 벗어남">속세를 벗어남</option>
		    <option value="럭셔리">럭셔리</option>
		    <option value="대저택">대저택</option>
		    <option value="그외">그외</option>
	  	</select>
		<br/>
		카테고리2 : 
		<select name="subCategory" >
			<option value="${party.subCategory}">${party.subCategory}</option>
			<option value="농구">농구</option>
			<option value="축구">축구</option>
			<option value="등산">등산</option>
			<option value="서핑">서핑</option>
			<option value="게임">게임</option>
			<option value="수영">수영</option>
			<option value="음주가무">음주가무</option>
			<option value="광란의 파티">광란의 파티</option>
			<option value="그외">그외</option>
		</select>
		<br/>
		
		파티소개 : <textarea name="pcontext" rows="10" >${party.pcontext}</textarea><br/>
		<button>수정</button>
	</form>
	<button onclick="goBack()">취소</button>
<script>
	function goBack(){
		history.go(-1);
	}
</script>
<!-- 주소정보 script -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey}&libraries=services"></script>
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

                

                //주소-좌표 변환 객체를 생성합니다
                var geocoder = new kakao.maps.services.Geocoder();

                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
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
                    }
                });
            }
        }).open();
    }
</script>
</body>
</html>