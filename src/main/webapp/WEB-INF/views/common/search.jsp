<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="imgPath" value="${path}/image/printProfileImage?fileName=" />
<c:set var="descImgPath" value="${path}/resources/img/descImg/" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>검색 구현</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
/*모달 제어*/
/* 모달 스타일 */
.itemsNO {
	
}

#searchModal {
	display: none;
	position: relative;
	z-index: 1;
/* 	left: -100px; */
	top: 50px;
	/* width: 400px;
	height: 600px; */
	overflow: auto;
/* 	background-color: aqua; */
}
/* 헤더부분 시작 */
#searchHeader {
	width: 100%;
	height: 180px;
	background: transparent;
}

#userMenu {
	
}
/* 헤더부분 끝 */
.modalContent {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 95%;
}

#responded {
	width: 400px;
	height: 600px;
	display: flex;
	overflow: auto;
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

#flexContainer {
	display: flex;
}

.items {
	width: 70px;
	height: 70px;
	font-size: samll;
	display: inline-block;
	padding: 3px;
	margin: 10px;
	border: solid 1px black;
	flex-direction: row;
}

#selectedCategory {
	font: bold;
}

.template {
	display: fixed;
	background-color: gray;
}

#barContatiner {
	display: none;
	display: block;
	display: flex;
}

.barItem {
	font-size: smaller;
	display: inline-block;
	width: 95px;
	height: 100px;
	border: 1px solid gray;
}
..barItem:hover{

}

.card_Ptag{
	font-size: 2px;
	font-style: bold;
}

#keywordBtn {
	position: block;
	top: 100px;
	left: 300px;
}

.template {
	display: none;
}

#previousBtn {
	float: left;
	top: 50px;
}

#nextBtn {
	float: right;
	top: 50px;
	left: 1800px;
}
.clicked {
/*   background-color: #e74c3c; */
  border-color : #e74c3c;
}

</style>

<c:set var="path" value="${pageContext.request.contextPath}" />
<header id="searchHeader" >
	<div id="barContatiner"></div>
	
	<div class="searchBtnContainer">
		<div class="searchContainer">
			<!-- oninput="keywordSearch()"> -->
		      <input type="hidden" id="searchKeywordt" />  
		    </div>
		<!-- 버튼창 -->
		<div class="buttonsContainer">
		<button type="button" id="categoryBtn" data-targetContents="category" class="btn btn-outline-danger searchBtn">카테고리 선택</button>
		<button type="button" id="dateBtn" data-targetContents="date" class="btn btn-outline-danger searchBtn">날짜 선택</button>
		<button type="button" id="locationBtn" data-targetContents="location" class="btn btn-outline-danger searchBtn">위치 선택</button>
		</div>
		
		<!-- 
		<div class="buttonsContainer">
			<button data-targetContents="category" id="categoryBtn"
				class="searchBtn">카테고리 선택</button>
			<button data-targetContents="date" id="dateBtn"
			 class="searchBtn">날짜 선택</button>
			<button data-targetContents="location" id="locationBtn"
				class="searchBtn">위치 선택</button>
		</div>
		 -->
		 
	</div>
	<div id="categoryTemplate" class='template'></div>
	<div id="dateTemplate" class='template'></div>
	<div id="descriptionTemplate" class='template'></div>
	<div id="sidoTemplate" class='template'></div>
	<div id="sigunguTemplate" class='template'></div>
	<div id="keywordTemplate" class='template'></div>
	<input type="hidden"  id="keywordTemplate" />


</header>
<script>
		
</script>
<!-- 모달창이 위치합니다 여기가 파란색 박스입니다!   -->
<div id="searchModal">
	<div class="modalContent">
	 <span class="close">&times;</span>
		<div id="responsed">
			<!-- responsed의 html을 정의함 -->
			responded
		</div>
		
	</div>
</div>
<!-- 모달창이 위치합니다 끝 searchModal -->
<script>
/*
function listPage(page){
	const value= $("#searchKeyword").val();
	$.ajax({
		type:"GET",
		url:"${path}/party/searchPartyList/"+page,
		data:{
			keyword:value
		},
		success: function(data){
			printList(data);
		}
	});
}
*/

var contextPath = '${pageContext.request.contextPath}';
// var page = 1;

if(typeof keyword === 'undefined'){keyword = "noValue"}
var resultQuery ="noValue|noValue|noValue|noValue|noValue|" +keyword;

 // listAjax(page,resultQuery);


//	listAjax(page,resultQuery);      //초기실행 주석
//listPage(page);


// 가져온 파티 리스트 출력

	
	

							/*  페이징처리   */



  	var contextPath="${pageContext.request.contextPath}";
  //	<div><a href=''><img src='샘플이미지' /></a></div class="categoryImgDiv">
  		var countDescription = 1;
  		var lastPageDs = 10;
  		var descriptionPage = 1;
  		var keyword = "${searchValue}";

  		if(typeof keyword === 'undefined' || keyword ==''){keyword = "noValue"}
  		var resultQuery ="noValue|noValue|noValue|noValue|noValue|" +keyword;
  		console.log(resultQuery);

  		//select("");
  	console.log("keyword : " + keyword);
  	$("#keywordTemplate").val(keyword);
  	let k = $("#keywordTemplate").val();
  	console.log("k : " + k);
  	
  	function keywordSearch(){
  		
  		keyword = '${searchValue}';
  		$("#keywordTemplate").val(keyword);
  		console.log(keyword);
  		console.log($("#keywordTemplate").val());
  		
  		if(keyword.includes("㉾")){
  			alert('해당 문자는 사용할 수 없습니다.');
  			$("#searchKeyword").val('');	// factor구분자 제거
  		}
  	
  		
  		select("㉾"+keyword);
  	}
  		
 	
 	 disableP();
  	 disableN();
  	countDesc();
 	printDescription(); 		//버튼이벤트 없이 호출이니까 ready에서 ㄴㄴㄴrmsid aㅓㅁㅌㄹ
 	console.log(lastPageDs);
  	function printDescription(){
  		$.ajax({
  			url:"${path}/search/printDescription",
  			method : "post",
  			data:{descPage : descriptionPage },
  			dataType :"json",		// List<descpriptionVO>
  			success: function (list){
  				let str = "";
  					console.log('버튼출력할때' +descriptionPage );
 
  					str += `<div id="previousBtn" onclick="previous(descriptionPage)">previous</div>`;			
  					
  	//				str += `<div class='barItem' onclick='select("description"+"\${this.description}")'>`;
  				$(list).each(function(){
  					let descriptionSrc = "";
  					descriptionSrc = "description";
  					descriptionSrc += ""+this.no;
  	//				console.log(descriptionSrc);
  			str+=	  `<div class="card barItem" onclick='select("description"+"\${this.description}")'>`;
  			str+=	  `<img src="${descImgPath}description2.jpg" height="55px" class="card-img-top" alt="...">`;
  			str+=	  `<div class="card-body">`;
  			str+=	  `<p class="card_Ptag card-text" >\${this.description}</p>`;			//내용
  			str+=	  `</div>`;
  			str+=	  `</div>`;
  					
  					
//  					str += `<div class='barItem' class="card" onclick='select("description"+"\${this.description}")'>`;    /*  */
//  					str += `\${this.description}`;																			/*  */
//  					str += '</div>';																					/*  */
  				})
  					str += `<div id="nextBtn" onclick="next(descriptionPage)">next</div><br>`;
  					str += `<div id="cancelDescription" onclick="cancel()">선택해제</div>`;                
  				$("#barContatiner").html(str);
  			},
  			error : function(error){
  	//			alert(error);
  			}
  		});	
  	}
  	
  	function cancel() {
  		$("#descriptionTemplate").html("");
  		select("");
		
	}
 	// 45개가 있다고 치자 -> 마지막 페이지는 5 lastPageDs
 	function next(descriptionPage){
 		if(descriptionPage != lastPageDs){
 		descriptionPage += 1;
 		console.log("if절" + descriptionPage);
 		printDescription();
 		}
 	//	console.log(descriptionPage);
 		disableN();
 	}
 	function previous(descriptionPage){
 		if(descriptionPage != 1){
 		descriptionPage += -1;
 		console.log(descriptionPage);
 		printDescription();
 		}
 		disableP();
 	}
 	function disableN(){
 		console.log("lastP" + lastPageDs)
 		if(descriptionPage == lastPageDs){
 //			alert('조건 충족');
 			$("#nextBtn").prop("disabled", true);
 			$("#nextBtn").css("opacity","0.5"); 			
 		}else{
 			$("#nextBtn").prop("disabled", false);
 			$("#nextBtn").css("opacity","0"); 
 		}
 	}
 	function disableP(){
 	if(descriptionPage != 1){
			$("#previousBtn").prop("disabled", false);
			$("#previousBtn").css("opacity","0"); 
		}else{
			$("#previousBtn").css("opacity","0.5"); 
			$("#previousBtn").prop("disabled", true);
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
 	            console.log('description :' + countDescription + '개');
 	           lastPageDs = Math.ceil(countDescription/10);
 	            
 	        },
			error: function(count){

			}
 			
 		});
 		console.log('이거까지 되나');
 	}
  
  
  	function printCategory(list){ 
//  		console.log('작동');
  				let str="";
  				str += '<div id="selectedCategory"></div>';
  		$("#responsed").html(str);
  				str += `<div class="container">`;   
  	 			str += `<button type="button" onclick='select("category")' class='itemsNO btn btn-outline-dark'>선택하지 않음</button> <br/> `;
		  		 
  	  	$(list).each(function(){	
  	  			// categoryVO
		//	   	str += `<div onclick='select("category"+"\${this.category}")' 
		//	   	class='items' class='close'>\${this.category}</div> `;
			   	str += `<button type="button" class="btn btn-outline-danger items" style="font-size: 13px;" `; 
			   	str += ` onclick='select("category"+"\${this.category}")'>\${this.category}</button>`;
//			   	console.log('ㅇ');
  	  	})
  			str +=	`</div>`;
  					    //	console.log(str); 주르륵 나오는거
  		$("#responsed").append(str);
  	};
  	
  	
  	
  	//////////////////////////////////////////////////////////////////////////////
  	// List<Integer>
  	function printDate(list){ 
  		let str="";
  //		str += '<div id="selectedDate"></div><hr/>';
  			str += `<div class="container">`;     
  			str += `<button type="button" onclick='select("date")' class='itemsNO btn btn-outline-dark'>선택하지 않음</button> <br/> `;
  		//	str +=	`<div class='itemsNO' class='close' onclick='select("date")'>선택하지 않음</div> <br/>`;
  		$(list).each(function(){
  			//str += `<div class='items' class='close' onclick='select("date\${this}")'>\${this}일 이내</div>`;
  			str += `<button type="button" class="btn btn-outline-danger items" onclick='select("date\${this}")'>\${this}일 이내</button>`;
  		})
  			 str +=	`</div>`;
  	//	console.log(str);
  		$("#responsed").html(str);//
  		
  	//	$("#responsed").append(str); 
  		//alert('오류?');
  	};
  	
 	 //List<String>
  	function printLocation(list){	
  		let str="";
  		$("#responsed").html(str);
  		
  		
  	  <!-- Content here -->
 
  		str += `<div class="container">`;    
  		str += `<button type="button" onclick='select("sido")' class='itemsNO btn btn-outline-dark'>선택하지 않음</button> <br/> `;
  //		str += `<div class='itemsNO close' onclick='select("sido")'>선택하지 않음</div> <br/>`;
  		$(list).each(function(){	// locationVO
  		//	str += `<div class='items close' onclick='select("sido\${this.sido}")'>\${this.sido}</div>`;
  	  	//	str += `<span class="badge bg-light items" onclick='select("sido\${this.sido}")'>\${this.sido}</span>`;
  		  	str += `<button type="button" class="btn btn-outline-danger items" onclick='select("sido\${this.sido}")'>\${this.sido}</button>`;
  		})
  		str +=	`</div>`;
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
  		        	str += `<div class="container">`;    
  		        	str += `<button type="button" onclick='select("sigungu")' class='itemsNO btn btn-outline-dark'>선택하지 않음</button> <br/> `;
  				//	str += `<div class='itemsNO' class='close' onclick='select("sigungu")'>선택하지 않음</div>`;
  					$(sigungu).each(function(){
				//	str += `<div class='items' class='close' onclick='select("sigungu\${this.sigungu}")'>\${this.sigungu}</div>`;
					str += `<button type="button" class="btn btn-outline-danger items" onclick='select("sigungu\${this.sigungu}")'>\${this.sigungu}</button>`;
					$("#responsed").html(str);  //셀렉트 기능 구현 아직 안함
				})	
					str += `</div>`;
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
  		page = 1;
  		$("#partys").html("");
  	  		console.log(factor + "< factor");
  	 // 	$("#sigunguTemplate").html("");
  		// 키워드 검색 추가하기 
  		// select factor로 변경되는 문자열이 들어온다 빈 문자열부터 찬 문자열까지 undefined는 안나오고
  		if(factor.includes('description')){
  	  		$("#descriptionTemplate").html(factor);
  	  		}
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
  	
//  		let selectedKeyword = $("#kewordTemplate").html();		
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
  		
  		if(factor.includes("㉾")){ // 해결
  			$("#keywordTemplate").html(factor);
  			
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
 
  					//description
  		let selectedKeyword = $("#keywordTemplate").val();
  					console.log(selectedKeyword);

  		  			if(selectedKeyword ==""){
  		  				selectedKeyword = "noValue";
  		  			}
  		if(selectedSido == "noValue"){selectedSigungu = "noValue"}
  			console.log(selectedSido);
  			
  		resultQuery = selectedDescription+"|"+selectedCategory+"|"
  		+selectedDate+"|"+selectedSido+"|"+selectedSigungu+"|"+selectedKeyword;
  		console.log("resultQ: " + resultQuery);					

  		console.log('listAjax호출 당시 page' + page);
  		console.log('listAjax호출 당시 resultQuery' + resultQuery);
  		
  		listAjax(page,resultQuery);
  		
  
  	} // select(factor)
  	
  	
  	
  	
  	//////함수화 시킬 ajax 
  	function listAjax(page,resultQuery ){
  		console.log('listAjax호출됨');
  		console.log(page);
  	// 선택값이 없을 시  noValue
  		// 이제 ajax로 보낸다
  		
  		console.log('listAjax호출 당시 page' + page);
  		console.log('listAjax호출 당시 resultQuery' + resultQuery);
  		 $.ajax({
			
   			url : "${path}/search/querySearch/"+page ,
   			method : "GET",
   			data : {
   				resultQuery : resultQuery
   			},
   			dataType : "JSON",  //partyVO 리스트로 받아옴 finish N 조건 추가

   			success :  function(partyList){
   				  	console.log("ListAjax에서 출력")
   			  		console.log(partyList);
   				let str = "";
   				let wishlistPnum = [];
//   				console.log("printListAjax 들어옴");

   				if(partyList.wishlist != null){
   					$(partyList.wishlist).each(function(){
   						let wishPnum = this.pnum;
   						wishlistPnum.push(wishPnum);
   					});	
   				}
   				
   				$(partyList).each(function(){
   					let pname = this.pname;
   					let address = this.address;
   					let date = this.formatStartDate +"~"+ this.formatEndDate;		
   					let pnum = this.pnum;
   					let path = this.partyImage1;
   					let detailAddress = this.detailAddress;
   					
   					str += '<li>';
   					// wishList 받아서 fullHeart.png로 출력
   					if(partyList.wishlist != null){
   						if(wishlistPnum.indexOf(pnum) < 0){
   							str += "<img src='${contextPath}/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
   						}else{
   							str += "<img src='${contextPath}/resources/img/redHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
   						}
   					}else{
   						str += "<img src='${contextPath}/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
   					}
   					str += '<img src="'+contextPath+'/image/printPartyImage?fileName='+path+'" class="partyImg" onclick="partyDetail('+pnum+');">';
   					str += "<hr/>";
   					str += "<strong onclick='partyDetail("+pnum+");' style='cursor: pointer;'>"+pname+"</strong><br/>";
   					str += address+" "+detailAddress+"<br/>";
   					str += date;
   					str += "</li>";
   				});

   				console.log("출력, 현재 페이지:" + page);
   				
   				if(page == 1){
   					$("#partys").html(str);
   					console.log('html');
   				}else{
   					console.log('appned');
   					$("#partys").append(str);
   				}
			
  			},
   			error : function(error){
   		//		alert(error);
   			}
   			
   		}); 
  	}// listAjax(page,resultQuery)
  		
  		
  		/*
  		
  		*/
  //	} // select(factor)

  /*
  이사 시작
  	function printListAjax(data){
	  	console.log("printListAjax에서 출력")
  		console.log(data);
	let str = "";

	
	let wishlistPnum = [];
//	console.log("printListAjax 들어옴");

	if(data.wishlist != null){
		$(data.wishlist).each(function(){
			let wishPnum = this.pnum;
			wishlistPnum.push(wishPnum);
		});	
	}
	
	$(data).each(function(){
		let pname = this.pname;
		let address = this.address;
		let date = this.formatStartDate +"~"+ this.formatEndDate;		
		let pnum = this.pnum;
		let path = this.partyImage1;
		let detailAddress = this.detailAddress;
		
		str += '<li>';
		// wishList 받아서 fullHeart.png로 출력
		if(data.wishlist != null){
			if(wishlistPnum.indexOf(pnum) < 0){
				str += "<img src='${contextPath}/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
			}else{
				str += "<img src='${contextPath}/resources/img/redHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
			}
		}else{
			str += "<img src='${contextPath}/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
		}
		str += '<img src="'+contextPath+'/image/printPartyImage?fileName='+path+'" class="partyImg" onclick="partyDetail('+pnum+');">';
		str += "<hr/>";
		str += "<strong onclick='partyDetail("+pnum+");' style='cursor: pointer;'>"+pname+"</strong><br/>";
		str += address+" "+detailAddress+"<br/>";
		str += date;
		str += "</li>";
	});

	console.log("출력, 현재 페이지:" + page);
	
	if(page == 1){
		$("#partys").html(str);
		console.log('html');
	}else{
		console.log('appned');
		$("#partys").append(str);
	}

//	$("#partys").html(str);
} 
  */ 
  //이사 끝

// 파티 상세 페이지로 이동
function partyDetail(pnum){
	location.href="<c:url value='/partyDetail/detailOfParty?pNum="+pnum+"'/>";
}

// 무한 페이징


$(window).scroll(function(){
	
	let dh = $(document).height();		
	let wh = $(window).height();
	let wt = $(window).scrollTop();
	
	if((wt+wh) >= (dh  )){
		if($("#partys li").size() <= 1){
			console.log('return false');
			return false;
		}
		console.log(dh);
		console.log(wh);
		console.log(wt);
		console.log(wt+wh);
		console.log("wt+wh-dh : ");
		console.log(wt+wh-dh);
		page++;
		listAjax(page,resultQuery);
		console.log('listAjax실행' + page + resultQuery);
	}//
});	//
  	
  	
  	
  	//////함수화 시킬 ajax 
  	
  	
  	
    // MODAL OPEN + 문서 업로드 후 실행 함수 표기
    $(document).ready(function() {
    	
    	/*
    	$(window).on("change", function(){
    		console.log('무한반복')
    	});
    	*/
    	$(".barItem").click(function() {
    	//	 $(this).css("border-color", "#e74c3c"); // 테두리색 변경 // 배경색 변경
    		 $(".barItem.clicked").removeClass("clicked");

    		  // 클릭된 요소의 테두리색 변경
    		  $(this).addClass("clicked");
    		});
    	
    	
    	
    	// 이 자체가 실행이 안 된다.
    	$("#keywordBtn").click(function(){
    //		keywordSearch();
    	console.log(page);
    	console.log("이 사이에");
    	console.log(resultQuery);
    		 listAjax(page,resultQuery);
    	});
    		
    	
      // 문서가 로드된 후 실행되는 코드
      $(".searchBtn").click(function () {
    //    console.log('searchBtnClick');
        // 타겟 정의
        console.log('searchBtn확인');
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
        $("#searchModal").hide();
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
      
    
	
    }); // ready
    
  </script>
