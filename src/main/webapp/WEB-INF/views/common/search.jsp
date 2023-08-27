<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <title>검색 구현</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" 
  rel="stylesheet" 
  integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" 
  crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <style>
    /*모달 제어*/
    /* 모달 스타일 */
    .itemsNO{
    
    }
    #searchModal {
      display: none;
      position: fixed;
      z-index: 1;
      left: 10px;
      top: 200px;
      width: 400px;
      height: 600px;
      overflow: auto;
      background-color: aqua;
    }
  /* 헤더부분 시작 */  
    #searchHeader{
    width: 100%;
    height:180px;
    background: transparent;
    margin-top: 3%;
  	}
  	
  	#userMenu{
  	
  	}
  /* 헤더부분 끝 */  
    .modalContent {
      background-color: #fefefe;
      margin: auto;
      padding: 20px;
      border: 1px solid #888;
      width: 95%;
    }
    #responded{
    width: 400px;
    height : 600px;
    display: flex;
    overflow : auto;
    }

    /* 닫기 버튼 스타일 */
    .close {
      color: #aaaaaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
    }

    .close:hover {
      color: #000;
      text-decoration: none;
    }
    /*모달 제어 끝*/

    /* 버튼 스타일 */
    .searchBtn {
      display: inline-block;
      width: auto;
      height: 50px;
      background-color: #3498db;
      color: white;
      border: none;
      border-radius: 25%;
      text-align: center;
      font-size: 16px;
      line-height: 50px;
      margin-right: 10px;
      cursor: pointer;
      
      /* position: absolute; 
      top: 300px; */
      /* left:100px; */
      
    }

    /* 검색창 스타일 */
    #searchKeyword {
      height: 30px;
      width: 150px;
      padding: 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
      /* position: absolute;
      top:100px;
      left:300px; */
    }

    /* 버튼과 검색창을 감싸는 부모 컨테이너 스타일 */

    /* 검색창을 감싸는 div 스타일 */
    .searchContainer {
      display: inline-block;
    }

    /* 버튼 컨테이너 스타일 */
    .buttonsContainer {
      display: inline-block;
    }
    
    #flexContainer{
    display: flex;
    }
    .items{
    width: 70px;
    height: 70px;
    font-size:samll;
    display : inline-block;
    padding : 3px; 
    margin : 10px;
    border : solid 1px black;
    flex-direction: row;
    
    }
    #selectedCategory{
    font:bold; 
    }
    .template{
    display: fixed;
    background-color: gray;
    
    }
    #barContatiner{
    display:block;
    display:flex;
    }
    .barItem{
    font-size: smaller;
    display:inline-block;
    width: 100px;
    height: 100px;
    border: 1px solid gray;
    }
    #keywordBtn {
    position: block;
    top:100px;
    left:300px;
     }
     .template{
     display: none;
     }
     #previous{
     float:left;
  	 top:50px;
     }
     #next{
     float:right;
  	 top:50px;
   	 left:1800px;
     }
  
  </style>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<header id="searchHeader">	
  

  <div id="barContatiner"></div>
  <div class="searchBtnContainer">
    <div class="searchContainer">
   		<!--검색창  -->
      <input type="text" id="searchKeyword"  oninput="keywordSearch()">
     <!--  <button id="keywordBtn">검색</button> -->
    </div>
    <!-- 버튼창 -->
    <div class="buttonsContainer">
      <button data-targetContents="category" id="categoryBtn" class="searchBtn">카테고리 선택</button>
      <button data-targetContents="date" id="dateBtn" class="searchBtn">날짜 선택</button>
      <button data-targetContents="location" id="locationBtn" class="searchBtn">위치 선택</button>
    </div>
  </div>
  	<div id="categoryTemplate" class='template'></div>
	 <div id="dateTemplate" class='template'></div>
	 <div id="descriptionTemplate" class='template'></div>
	 <div id="sidoTemplate" class='template'></div>
	 <div id="sigunguTemplate" class='template'></div>
	
	 <a href="<c:url value='/go'/>">간다</a>
</header>
<!-- 모달창이 위치합니다 여기가 파란색 박스입니다!   -->
  <div id="searchModal">
    <div class="modalContent">
    
      <div id="responsed">
      <!-- responsed의 html을 정의함 -->
      responded
      </div>
      <span class="close">&times;</span>
    </div>
  </div>
  <!-- 모달창이 위치합니다 끝 searchModal -->
  <script>
  	var contextPath="${pageContext.request.contextPath}";
  //	<div><a href=''><img src='샘플이미지' /></a></div class="categoryImgDiv">
  		var countDescription = 1;
  		var lastPage = 10;
  		var descriptionPage = 1;
  		var keyword = "";
  		//select("");
  	function keywordSearch(){
  		keyword = $("#searchKeyword").val();
  		
  		if(keyword.includes("㉾")){
  			alert('해당 문자는 사용할 수 없습니다.');
  			$("#searchKeyword").val('');	// factor구분자 제거
  		}
  	//	alert("다 지우면??" +keyword);
  		// 지웠을 때 빈 문자열인지 확인  --> 된다 -> 빈 문자열 처리할 필요 없음
  		// keyword가 검색 조건에 추가되도록 함 6번째 배열 매개변수로 들어감 기본 noValue
  		// 없을 수도 있으니까
  		
  		select("㉾"+keyword);
  	}
  	
  	
  	
  		
  //	alert(searchFor);
  //		alert(keyword);
  		// 키워드가 실시간으로 반영됨 // 문제점 
  		/*
  		ajax({
  			url: "keywordSearch",
  			method: "post",
  			data: {keyword : keyword,
  				  searchFor : searchFor},
  			dataType:"json",	// partyVO
  			success: function(data){
  				
  			},
  			error: function (error) {
				
			}
  			
  		})// ajax
  		*/
  	 //keywordSearch
  	 disableP();
  	 disableN();
  	countDesc();
 	printDescription(); 		//버튼이벤트 없이 호출이니까 ready에서 ㄴㄴㄴrmsid aㅓㅁㅌㄹ
 	console.log(lastPage);
  	function printDescription(){
  		$.ajax({
  			url:"${path}/search/printDescription",
  			method : "post",
  			data:{page : descriptionPage },
  			dataType :"json",		// List<descpriptionVO>
  			success: function (list){
  				let str = "";
  					str += `<div id="previous" onclick="previous(descriptionPage)">previous</div>`;
  	//				str += `<div class='barItem' onclick='select("description"+"\${this.description}")'>`;
  				$(list).each(function(){	
  					str += `<div class='barItem' onclick='select("description"+"\${this.description}")'>`;
  					str += `\${this.description}`;
  					str += '</div>';
  				})
  					str += `<div id="next" onclick="next(descriptionPage)">next</div>`;
  				$("#barContatiner").html(str);
  			},
  			error : function(error){
  	//			alert(error);
  			}
  		})	
  	}
 	// 45개가 있다고 치자 -> 마지막 페이지는 5 lastPage
 	function next(page){
 		if(descriptionPage != lastPage){
 		descriptionPage += 1;
 		console.log(descriptionPage);
 		printDescription();
 		}
 		console.log(descriptionPage);
 		disableN();
 	}
 	function previous(page){
 		if(descriptionPage != 1){
 		descriptionPage += -1;
 		console.log(descriptionPage);
 		printDescription();
 		}
 		disableP();
 	}
 	function disableN(){
 		console.log("lastP" + lastPage)
 		if(descriptionPage == lastPage){
 //			alert('조건 충족');
 			$("#next").prop("disabled", true);
 			$("#next").css("opacity","0.5"); 			
 		}else{
 			$("#next").prop("disabled", false);
 			$("#next").css("opacity","0"); 
 		}
 	}
 	function disableP(){
 	if(descriptionPage != 1){
			$("#previous").prop("disabled", false);
			$("#previous").css("opacity","0"); 
		}else{
			$("#previous").css("opacity","0.5"); 
			$("#previous").prop("disabled", true);
		}
 	}
 	function countDesc(){
 		$.ajax({
 			url:'${path}/search/count',
 			method: 'get',
 			data:{},
 			dataType: 'text', 
 	        success: function(count) {
 	        	countDescription = parseInt(count); 
 	            console.log(countDescription + '개');
 	           	lastPage = Math.ceil(countDescription/10);
 	            
 	        },
			error: function(count){

			}
 			
 		});
 		console.log('이거까지 되나');
 	}
  
  
  	function printCategory(list){ 
//  		console.log('작동');
  				let str="";
  				str += '<div id="selectedCategory"></div><hr/>';
  		$("#responsed").html(str);
  	 			str += `<div onclick='select("category")' 
		  		class='itemsNO' class='close'>선택하지 않음</div> <br/> `;
  	  	$(list).each(function(){	
  	  			// categoryVO
			   	str += `<div onclick='select("category"+"\${this.category}")' 
			   	class='items' class='close'>\${this.category}</div> `;
			   	console.log('ㅇ');
  	  	})
  		
  					    //	console.log(str); 주르륵 나오는거
  		$("#responsed").append(str);
  	};
  	
  	
  	
  	//////////////////////////////////////////////////////////////////////////////
  	// List<Integer>
  	function printDate(list){ 
  		let str="";
  //		str += '<div id="selectedDate"></div><hr/>';
  			str +=	`<div class='itemsNO' class='close' onclick='select("date")'>선택하지 않음</div>`;
  		$(list).each(function(){
  			str += `<div class='items' class='close' onclick='select("date\${this}")'>\${this}일 이내</div>`;
  		})
  	//	console.log(str);
  		$("#responsed").html(str);//
  		
  	//	$("#responsed").append(str); 
  		//alert('오류?');
  	};
  	
 	 //List<String>
  	function printLocation(list){	
  		let str="";
  		$("#responsed").html(str);
  		str += `<div class='itemsNO' class='close' onclick='select("sido")'>선택하지 않음</div>`;
  		$(list).each(function(){	// locationVO
  			str += `<div class='items' class='close' onclick='select("sido\${this.sido}")'>\${this.sido}</div>`;
  		})
  		$("#responsed").html(str);
  		
  	};
  	
  	function printLocation2(sido){
  		$("#searchModal").toggle("fast");
  		let str = "";
  		$("#responsed").html(str);
  		$.ajax({
  			url : "${path}/search/getSearchContents",
  			method : "POST",
  			data : { targetContents : sido },
  			dataType : "json",
  			success : function(sigungu){	// List<LocationVO>
  					str += `<div class='itemsNO' class='close' onclick='select("sigungu")'>선택하지 않음</div>`;
  					$(sigungu).each(function(){
					str += `<div class='items' class='close' onclick='select("sigungu\${this.sigungu}")'>\${this.sigungu}</div>`;
					$("#responsed").html(str);  //셀렉트 기능 구현 아직 안함
				})				
  			},
  			error : function(error){

  			}
  			
  		})
  		// 출력 target = responded
  		//울산광역시를 매개변수로 그에 해당하는 sigungu 목록을 검색하는 쿼리를 작동시킨다. -> targetContents
  		//final modal에 출력되는 sigungu를 출력한다.
  	}
  	/////////////////////////////셀렉트 된 후 = 모달 속 factor클릭!//////////////////////////
  	function select(factor){		// 아무 요소나 선택되었을 때
  	  		console.log(factor + "< factor");
  	 // 	$("#sigunguTemplate").html("");
  		// 키워드 검색 추가하기 
  		// select factor로 변경되는 문자열이 들어온다 빈 문자열부터 찬 문자열까지 undefined는 안나오고
  		if(factor.includes('description')){
  	  		$("#descriptionTemplate").html(factor);
  	  		}
  	
  		if(factor.includes('category')){
  		$("#categoryTemplate").html(factor);
  		}
  		
  		if(factor.includes('date')){
  		$("#dateTemplate").html(factor); //console.log(factor +"factor");	
  		}
  		
  		if(factor.includes('sido')){
  		$("#sidoTemplate").html(factor);// 시도를 선택했을 때 시군구 선택 창이 open되도록 메소드 추가
  			factor = factor.substring("sido".length);
 // 			alert(factor+"시도");
  			printLocation2(factor);	//factor=울산광역시
  		}
  		if(factor.includes('sigungu')){
  	  		$("#sigunguTemplate").html(factor);
  	  		}		
  		/* description은 토글이 작동하지 않게 */ 
  		// select호출이라서 토글이 작동하는중 호출이 되었는데 그것이 키워드 검색이 아닐 때
  		if(!factor.includes('description') ){
  			if(!(factor.includes('㉾')||factor ==""))
  			$("#searchModal").toggle("fast");
  		}
  		
  		
  	//	selectedCategory = $("#selectedCategory").html();
  	
  		let selectedKeyword = "noValue";		
  		let selectedDescription = $("#descriptionTemplate").html();
  		let selectedCategory = $("#categoryTemplate").html();
//	  	console.log(selectedDescription);
  		let selectedDate = $("#dateTemplate").html();
  		let selectedSido= $("#sidoTemplate").html();
  		let selectedSigungu= $("#sigunguTemplate").html();
  		
  		if (typeof selectedDescription === 'undefined'
  				|| selectedDescription == "" ) { // category절 추가
  			selectedDescription = "noValue";
  		} else {
  			let length = "description".length;
  			selectedDescription = selectedDescription.substring(length);
  		}
  		//cate절
  		if (typeof selectedCategory === 'undefined'
  				|| selectedCategory == "" || selectedCategory=="category") { // category절 추가
//  			$("#categoryBtn").html("카테고리 선택");
  			selectedCategory = "noValue";
  		} else {
  			let length = "category".length;
  			selectedCategory = selectedCategory.substring(length);
  			// 선택버튼의 출력값을 변화 
  			//categoryBtn dateBtn locationBtn 
  			
  		}
  		//cate절
  		if (typeof selectedDate === 'undefined' // ||추가
  			|| selectedDate == "" || selectedDate == "date" ) {
  			selectedDate = "noValue";
//  			$("#dateBtn").html("날짜 선택");
  		} else {
  			let length = "date".length;
  			selectedDate = selectedDate.substring(length);
  			// 출력값
 // 			$("#dateBtn").html(selectedDate +"일 이내");
  		}
  		if (typeof selectedSido === 'undefined'//||추가
  			|| selectedSido == ""	|| selectedSido =="sido") {
  			
  			selectedSido = "noValue";
  			console.log(selectedSido);
//  			selectedSigungu = "noValue";
 // 			$("#locationBtn").html("지역 선택");
  		} else {
  			let length = "sido".length;
  			selectedSido = selectedSido.substring(length);
  			$("#locationBtn").html(selectedSido);
  		}
  		if (typeof selectedSigungu === 'undefined'//||추가
  			|| selectedSigungu == ""	|| selectedSigungu =="sigungu") {
  			selectedSigungu = "noValue";
  		} else {
  			let length = "sigungu".length;
  			selectedSigungu = selectedSigungu.substring(length);
  		}
  		
  		if(factor.includes("㉾")){
  			selectedKeyword = keyword;
  			if(selectedKeyword ==""){
  				selectedKeyword = "noValue";
  			}
  			//alert("selectedKeyword: " +selectedKeyword);
  		}
  		// 버튼 값을 정리
  		$("#locationBtn").html(selectedSido +" : "+ selectedSigungu);
  		if(selectedSido == "noValue"){
  			$("#locationBtn").html("지역 선택");
  		}
		if( selectedSido != "noValue" && selectedSigungu == "noValue"){ 
  			$("#locationBtn").html(selectedSido +" : 전체" );	
  			}
		
  		if(selectedDate == "noValue" || selectedDate == 3650){
  			$("#dateBtn").html("날짜 선택")
  		}else{$("#dateBtn").html(selectedDate + "일 이내");}
  		
  		if(selectedCategory == "noValue"){
  			$("#categoryBtn").html("카테고리 선택");
  		}else{
  			$("#categoryBtn").html(selectedCategory);
  			}
  	//	console.log(selectedDescription);
  	//	console.log(selectedCategory);
  	//	console.log(selectedDate);
  	//	console.log(selectedSido);
  	//	console.log(selectedSigungu);
  					//description
  		if(selectedSido == "noValue"){selectedSigungu = "noValue"}
  			console.log(selectedSido);		
  		let resultQuery = selectedDescription+"|"+selectedCategory+"|"
  		+selectedDate+"|"+selectedSido+"|"+selectedSigungu+"|"+selectedKeyword;
  		console.log("resultQ: " + resultQuery);					
  		// 선택값이 없을 시  noValue
  		// 이제 ajax로 보낸다
  		 $.ajax({
  			url : "${path}/search/querySearch" ,
  			method : "GET",
  			data : {
  				resultQuery : resultQuery
  			},
  			dataType : "JSON",  //partyVO 리스트로 받아옴 finish N 조건 추가

  			success :  function(partyList){
  				let str = "";
  				$(partyList).each(function(){
  					let pname = this.pname;
  					let address = this.address;
  					let date = this.formatStartDate +"~"+ this.formatEndDate;		
  					let pnum = this.pnum;
  					let path = this.partyImage1;
  					let detailAddress = this.detailAddress;
  					
  					str += '<li>';
  					// wishList 받아서 fullHeart.png로 출력
  					str += "<img src='"+contextPath+"/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>"
  					str += '<img src="'+contextPath+'/image/printPartyImage?fileName='+path+'" class="partyImg" onclick="partyDetail('+pnum+');">';
  					str += "<hr/>";
  					str += "<strong onclick='partyDetail("+pnum+");' style='cursor: pointer;'>"+pname+"</strong><br/>";
  					str += address+" "+detailAddress+"<br/>";
  					str += date;
  					str += "</li>";
  				});
  				$("#partys").html(str);

  			},
  			error : function(error){
  		//		alert(error);
  			}
  			
  		}); 
  	} // select(factor)
  	
  	
  	
    // MODAL OPEN + 문서 업로드 후 실행 함수 표기
    $(document).ready(function() {
    	
    	/*
    	$(window).on("change", function(){
    		console.log('무한반복')
    	});
    	*/
    	
    	
    	$("#keywordBtn").click(function(){
    		keywordSearch()
    	});
    		
    	
      // 문서가 로드된 후 실행되는 코드
      $(".searchBtn").click(function () {
    //    console.log('searchBtnClick');
        // 타겟 정의
        var targetContents = $(this).attr("data-targetContents");
        $("#searchModal").toggle("slow");
        console.log("targetContents console = " +targetContents);
        // 각 타겟을 이용해 요청명을 Controller에 전달
        
    //    $("#selectedCategory").html('카테고리 선택');
     //   $("#selectedDate").html('일정 범위 선택');
      //  $("#selectedLocation").html('장소 선택');
        $.ajax({
        	  url: '${path}/search/getSearchContents', // target컨텐츠가 전달
        	  method: 'POST',
        	  data: {targetContents : targetContents},
        	  dataType: 'JSON',  // return : entity
        	  success: function(response) {
        	    // entity<Object>
        	    console.log('Object성공! : ', response);
        	    // 이게 어느 타입이냐에 따라 메서드가 나뉘어야 함
        	    
        	    if(targetContents == "category" ){
        	    //	console.log(response);
        	     printCategory(response); 
        	    }
        	    // 날짜 선택 버튼 클릭
        	    if(targetContents == "date" ){
        	     printDate(response);
        	    }
        	    // 위치 선택 버튼 클릭
        	    if(targetContents == "location" ){
        	     printLocation(response);
        	    }
        	    
        	  },
        	  error: function(res, status, error) {
        		  console.log('json이 왜 안 오지', res);
        	  }
        	});
      });

      // MODAL CLOSE
      $(".close").click(function () {
        $("#searchModal").toggle("fast");
        $("#responsed").html("");
      });
      // 스크롤
    /*  
    $(window).scroll(function(){
			let dh = $(document).height();
			let wh = $(window).height();
			let wt = $(window).scrollTop();
				
			if((wt+wh) >= (dh - 10)){
				if($("#comments li").size() <= 1){
					return false;
				}
				page++;
				listPage(page);
			}	
		}); 
      */
      
      /*
      $("#selectBox").on('change', function() {
		    // 선택된 option 요소의 value 값을 변수에 저장
		    searchFor = $(this).val();
		    
		   
		    
		//	alert(searchFor)
		//alert(keyword+'로 검색');
	})
	*/  //검색 기준에서 없앨 예정 -> 키워드 실시간으로 통일
	  
	 /*
	 $("#searchKeyword").on('change',function(){
	   	  
	     })
	     */
	
    }); // ready
    
  </script>
