<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!--context 이미지 절대경로 -->
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="imgPath" value="${path}/image/printProfileImage?fileName=" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests"> 
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 부트스트랩 -->
	<style>
 	#cancelHr {
 	 border: none; /* 기본 hr 테두리 제거 */
 	 border-top: 10px solid red; /* 원하는 색으로 상단 테두리 설정 */
  	 margin: 10px 0; /* hr 위아래 여백 조절 */
	}
	.reportInput{
	width : 300px; 
	height: 50px;
	border-top: none;
	border-bottom: 2px solid black; 
	border-left: none;
	border-right: none;
	margin: 6px 0 6px 0;
	padding: 2px;
	}
	
	#wrap {
	 display: flex;
	 justify-content: center;
	 align-items: center;
	 min-height: 100vh;
	 margin: 0;
	 background-color: white;
	 padding: 20px 0; 
	 }
	 #reportForm{
	 padding: 10px;
	 border : solid 1px black;
	 }
	.reportDiv{
	margin: 10px 0 0 0;
	padding: 2px;
	border: solid black 1px;
	}
	
	.reportLi{
	list-style: none;
	}
	
	#reportReview{
	display:block; 
	
	}
	.reportDiv table {
	  width: 100%;
	  border-collapse: collapse;
	}
	
	.reportDiv th, .reportDiv td {
	  border: 1px solid #ccc;
	  padding: 8px;
	  text-align: left;
	}
	.riviewTable {
	
	border-collapse: collapse; 
	width: 100%;
  	border: 1px solid #ccc;
	}

	.reviewTR, .reviewTd {
    border: 1px solid #ccc; /* 테두리 스타일과 색상 */
    padding: 8px; /* 셀 안 여백 */
    text-align: left; /* 텍스트 정렬 */
	}
	
	.listUl{
	
	}
	#hideList{
	display: none; 
	}
	
	#targetInfo{
	list-style: none;
	}
	#result{
	padding: 5px;
	border: 1px solid gray;
	display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
	}
	
	.listLi{
	list-style: none;
	}
	#resultProfileContainer {
    max-height: 300px; /* 최대 높이 설정 */
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤 생성 */
    }
    #result{
    display:block;
    height:350px;
    max-height: 350px; /* 최대 높이 설정 */
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤 생성 */
    }
    b{
    font-size: larger;
    }
    .selectImg{
    border-color: blue;
    }
	
	</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<script>
	   $(document).ajaxSend(function(e,xhr,options){
	      xhr.setRequestHeader(
	            '${_csrf.headerName}',
	            '${_csrf.token}');
	   });
	   </script>	   

</head>
<body>
<hr/>
<button type="button" id="cancel" class="btn btn-secondary">계정 관리 페이지로</button><hr id="cancelHr"/>

<!-- 
<button id="cancel">뒤로 가기</button>	data 
  -->
	<div id="wrap">
	<form id="reportForm">						
	<!-- 	<div class="form-text" id="basic-addon4">신고자</div> -->
	
		<b>신고자 ID</b> <br/>
		<input type="text" id="fromMid" value="${loginMember.mid}" disabled="disabled" class="reportInput"/>	<br/>
		<b>신고할 상대방의 닉네임을 입력하세요</b> <br/>
		<input type="text" id="searchId" class="reportInput" oninput="searchNick()">

			
			<div id="result">
			<b>입력하신 정보와 일치하는 유저</b>
			 	<div id="resultNick"></div>
	
				<div id="resultProfileContainer">
					
				</div>
			</div>
			
			<input type="hidden" id="toMid" class="reportInput" readonly="readonly"/><br/><b>선택한 유저입니다</b><br/>
		<input type="hidden" id="date"/><br/>
		<input type="text" readonly="readonly" id="toNick" class="reportInput"/><br/>
		 <b>사유를 선택해 주세요</b>
		 
		<select id="category" class="form-select form-select-sm reportInput" aria-label="Small select example">
		  <option selected>선택하세요</option>
		  <option value="언행이 불량함"><b>언행이 불량함</b></option>
		  <option value="참가 약속을 지키지 않음">참가 약속을 지키지 않음</option>
		  <option value="고의적인 방해">고의적인 방해</option>
		  <option value="거친 언행">거친 언행</option>
		</select>
		
		<b>자세한 내용을 입력해 주세요</b><br/>	
		<textarea id="context" rows="5" cols="60"></textarea>	<br/> 
		<span id="report" class="badge text-bg-danger">신고하기</span>
			
		<br/><br/><br/><br/><br/>
		<button type="button" id="reportReview" class="btn btn-secondary">나의 신고 내역 확인하기</button>
	<!-- 	 <button type="button" id="reportReview">나의 신고 내역 확인하기</button>	data  -->
		 <button type="button" id="hideList" class="btn btn-secondary">숨기기</button>	<!-- data  -->
		 
			<div id="printTarget">
				
			</div>
	</form>
	</div>
	
		<script type="text/javascript">
		var searchIdValue = "";
		var profileNick = "";
		var imgsrc = "";
		var mid="";
		var obj = {};
		function hideList(){
			$("#hideList").html("나의 신고 내역 확인하기");
			$("#printTarget").toggle("fast");
		}
		
		
		function searchNick() {
		     searchIdValue = $("#searchId").val(); // 전역변수 저장
		    if(searchIdValue == "" || searchIdValue === 'undefinded'){
		    	return;
		    }
		     let html = `<img id="resultProfile" src="#"/>`;
		     $("#resultProfileContainer").html(html);
		    $.ajax({
		        url: "${path}/report/searchId", 
		        method: "post",
		        data: {
		            mnick: searchIdValue
		        },
		        dataType: "json",
		        success: function(result) {
		        	let str ="";
		            	str += "<ul id='listUl'>";
		            $(result).each(function() {
		            	obj = this;
		            	profileNick = this.mnick;
		            					// ~= 까지
		            	profileName	= this.profileImageName;
		            	mnum = this.mnum;
		                mid = this.mid;
						
		                str += '<li id="targetInfo' + mnum + '" onclick="pick(' + mnum + ')" class="listLi" data-profile="' + imgsrc + '" data-mnick="' + profileNick + '" data-mid="' + mid + '">';
		                str += `\${profileNick}</li>`;
 
		              
		                // 닉네임선택
		                str += `<li class="listLi">`;
						str += `<img id="targetImg"`;
						str += ' width="80px" ';
						str += ' height="80px" ';
						str += 'onclick="pick(' + mnum + ')"  ';
						str +=  `data-profile="\${imgsrc}"`; 
						str += `data-mnick="\${profileNick}"`;
						str += `data-mid="\${mid}"`;
						str += "src='${imgPath}"+profileName+"'>";
		                str += `</li>`;
		                // 이미지선택
		            }); // 반복문
		            str += "</ul>";
		            
		            $("#result").html(str);
		        },
		        error: function(error) {
		        }
		    }); // ajax
		}
			
		function pick(mnum) {
		    let pickSrc = $("#targetInfo" + mnum).data("profile");
		    let pickNick = $("#targetInfo" + mnum).data("mnick");
		    let pickMid = $("#targetInfo" + mnum).data("mid");
		    
		    $("#toNick").val(pickNick);
		    $("#toMid").val(pickMid);
		    

		    let str = `<div>${pickNick}</div>`;
		    $("#resultProfile").attr("src", pickSrc);

		    let image = $("#resultProfile").attr("src");

		    $("#resultNick").html(str);
		}
		
		
		
		function reportReview() {
			   
		    let str = "";
		    	$.ajax({
		    		url:"${path}/report/reportReview",
		    		method: "POST",
		    		data:{
		    			mid:$("#fromMid").val() //로그인한 유저
		    		},   
		    		dataType: "json" ,
		    		success: function(response){
						
		    			$(response).each(function(){
		    				let dateFormat = new Intl.DateTimeFormat("ko" , {dateStyle:"full"});
		    			    let date = dateFormat.format(this.date);
		    			str += `<div class='reportDiv'>`;
		    			str += '<table class ="reviewTable">'; 
		    			str += 	'<tr class="reviewTr">';
		    			str += 		`<th class='reviewTd'>상대방</th>`;
		    			str += 		`<th class='reviewTd'>신고 날짜</th>`;
		    			str += 		`<th class='reviewTd'>사유 </th>`;
		    			str += 	'</tr>';
		    			str += 	'<tr class="reviewTr">';
		    			str += 		`<td class='reviewTd'>\${this.toMid} </td>`;
		    			str += 		`<td class='reviewTd'>\${date} </td>`;
		    			str += 		`<td class='reviewTd'>\${this.category}</td>`;
		    			str += 	'</tr>';
		    			str += 	'<tr class="reviewTr">';
		    			str += 		`<td class='reviewTd' colspan="3">신고 내용</td>`;
		    			str += 	'</tr>';
		    			str += 	'<tr class="reviewTr">';
		    			str += 		`<td class='reviewTd' colspan="3">\${this.context}</td>`;
		    			str += 	'</tr>';
		    			str += '</table>';
		    			str += `</div>`;
						});
		    		
		    			$("#printTarget").append(str);
		    			$("#reportReview").toggle("fast");
		    			$("#hideList").toggle("fast");
		    			},
		    			
		    		
		    		error: function(res){
		    			alert('이거 오나? error');
		    		}
		    	})
		    
			}
			
	
			 
		
			$(document).ready(function(){
		    var category = ""; // 변수 초기화
		  
		  
			    $("#category").change(function() {
			        category = $(this).val();
			    });
			
			    
			    $("#reportReview").click(function() {
			        reportReview() 
			    });
			    
			    $("#hideList").click(function(){
			    	hideList()
			    });
			    

			    $(document).on("click", "#targetInfo", function() {
			        pick();
			    });
			
			
			 // 취소 버튼: 이동 -> 이전 페이지 
			    $("#cancel").click(function(e){ 
			        e.preventDefault();    
			        window.history.back();            
			    })

			    // 신고하기 버튼 클릭 시 category 값을 사용
			    $("#report").click(function(e){
			        e.preventDefault();    // 확인함
			        if (!category || category =="") {
			            alert('사유를 선택하세요.');
			            return;
			        }
			        
			        // Ajax 요청
			        $.ajax({
			            url: '${path}/report/report',
			            method: 'post',
			            data: { 
			                fromMid:$("#fromMid").val(),   
			                toMid: $("#toMid").val(), 
			                category: category,
			                context: $("#context").val(),
			                mId : $("#fromMid").val(), 
			                
			            }, 
			            dataType : "text",		// entity<String> entity
			            success: function(response) {   
			                alert(response);
			                toMid: $("#toMid").val("");
			                context: $("#context").val("")
			            },
			            error: function(response) {
			                alert(response);  
			            }
			        });
			    }); // report 신고하기
			 
			});// ready
			</script>
			
			<script>
			$(document).ready(function () {
			    $("#targetImg").click(function () {
			        $(this).addClass("selectImg");
			    });
			});
			
			</script>
</body>
</html>