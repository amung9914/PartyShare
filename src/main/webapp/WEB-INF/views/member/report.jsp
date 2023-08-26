<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
	<style>
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
	#hideList{
	display: none; 
	}
	
	</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<c:set var="path" value="${pageContext.request.contextPath}" />
</head>
<body>

	<form>						
		신고자<input type="text" id="fromMid" value="reporter" disabled="disabled" class="reportInput"/>	<br/>
		검색 <input type="text" id="searchId"  oninput="searchNick()">
		
			<div id="result"></div>
			<!-- 검색된 유저가 나타날 창  -->
			<!--  mid로 검색하기 만들어야 함 DAO  -->
			<div id ="resultProfile"><img src="#"> </div>
			<!-- 검색 완료된 유저 프로필 이미지  -->
			
			
			<input type="hidden" id="toMid" class="reportInput"/><br/>
		<input type="hidden" id="date"/><br/>
		<!-- 사유<input type="text" id="category" class="reportInput"/><br/> -->
		사유<select id="category" class="reportInput" >
			  <option value="none" >"선택"</option>
			  <option value="언행이 불량함" >"언행이 불량함"</option>
			  <option value="참가 약속을 지키지 않음" >참가 약속을 지키지 않음</option>
			  <option value="고의적인 방해" >고의적인 방해</option>
			  <option value="거친 언행" >거친 언행</option>
		</select>
			
		내용<textarea id="context" ></textarea>	<br/> 
			<button id="report">신고하기</button>	<!-- data  -->
			<button id="cancel">뒤로 가기</button>	<!-- data  --> <hr/>
		<br/><br/><br/><br/><br/>
		 <button type="button" id="reportReview">나의 신고 내역 확인하기</button>	<!-- data  -->
		 <button type="button" id="hideList">숨기기</button>	<!-- data  -->
		 
			<ul id="printTarget">
			
			</ul>
			<p>신고 되면 뒤로 가기 활성화 : 주석 임시제거 테스트</p>
	</form>
	
		<script type="text/javascript">
		var searchIdValue = "";
		
		function hideList(){
			$("#printTarget").toggle("fast");
		}
		
		
		function searchNick() {
		     searchIdValue = $("#searchId").val(); // 전역변수 저장
		    
		    $.ajax({
		        url: "${path}/report/searchId", 
		        method: "post",
		        data: {
		            mnick: searchIdValue
		        },
		        dataType: "json",
		        success: function(result) {
		        	let str ="";
		            	str += "<ul>";
		            $(result).each(function() {
		                console.log(this);
		                str += `<li> onclick="pick('\${this}')">\${this.mnick}</li>`;
		            }); // 반복문
		            str += "</ul>";
		            
		            $("#result").html(str);
		        },
		        error: function(error) {
		            // 에러 처리
		        }
		    }); // ajax
		}
		
		
		
		function pick(profile){
			$("#resultProfile").attr("src" , profile);	//프로필 이미지 변경
			//$("#toMid").val
			
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
		    		console.log(response);
		    			$(response).each(function(){
		    				let dateFormat = new Intl.DateTimeFormat("ko" , {dateStyle:"full"});
		    			    let date = dateFormat.format(this.date);
		    			console.log(str);
		    			str += `<div class='reportDiv'>`;
		    			str += `<li class='reportLi'>상대방 id:\${this.toMid} | \${date} | \${this.category}</li><hr/>`;
		    			str += `<li class='reportLi'>신고 내용:\${this.context}</li>`;
		    			str += `</div>`;
		    			//str += "</li>";
						});
		    			$("#printTarget").append(str);
		    			$("#reportReview").toggle("fast");
		    			$("#hideList").toggle("fast");
		    			},
		    			
		    		
		    		error: function(res){
		    			alert('이거 오나? error');
		    			console.log(res)
		    		}
		    	})
		    
			}
		
			$(document).ready(function(){
		    var category = ""; // 변수 초기화
		    console.log(category);
		   
			// 신고하기 버튼: submit??    submit이면 -> 전달되어서 in Controller VO 생성 -> 리스트에 추가.//  이 리스트는? 딱히 어디서 받을 필요가 없다 . 
					// 근데 본인의 신고 내역은 확인이 가능해야 함     
			// 신고자 SELECT = "SELECT * FROM report WHERE fromMid = loginUser.mId"
			// 관리자 SELECT = "SELECT * FROM report "
			
		  // 사유 선택이 변경될 때마다 값을 category 변수에 저장
			    $("#category").change(function() {
			        category = $(this).val();
			        console.log("사유 value: " + category);
			    });
			
			    
			    $("#reportReview").click(function() {
			        reportReview() 
			    });
			    
			    $("#hideList").click(function(){
			    	hideList()
			    });
			    
			 
				
			
			






							

    //---------------------
    			// 나의 신고 내역 확인하기 버튼 누르면 실행되는 코드
				
			
			
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
			                fromMid:$("#fromMid").val(),   // 로그인 된 유저 아이디 -> MemberVO매개
			                toMid: $("#toMid").val(), 
			                category: category,
			                context: $("#context").val(),
			                mId : $("#fromMid").val(), // 현재 페이지에서 MemberVO 생성용 data
			                
			            }, 
			            dataType : "text",		// entity<String> entity
			            success: function(response) {   // == HttpStatus.OK    
			                console.log('요청 성공:'+ response);
			                alert(response);
			                toMid: $("#toMid").val("");
			                context: $("#context").val("")
	// 임시제거 테스트		    window.history.back(); 
			            },
			            error: function(response) {
			                //console.error('요청 에러:', status, error);
			                alert(response);  
			            }
			        });
			    }); // report 신고하기
			 
			});// ready
			</script>
			
			
		
	
		
	
	
	<!-- private int no;
	private String fromMid;		//신고자
	private String  toMid; 		//대상	
	private Date date;		 	//날짜
	private String category;  	//  -- 신고 카테고리 
	private String context;   	//  -- 신고 내용  -->
</body>
</html>