<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="imgPath" value="${path}/image/printProfileImage?fileName=" />
<c:set var="descImgPath" value="${path}/resources/img/descImg" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<!-- 부트스트랩 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="${path}/resources/css/in/searchheader.css" rel="stylesheet"/>

<header id="searchHeader" >
	<div id="barContatiner" class="flex-container" ></div>
	
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
		<!-- 선택버튼 출력 -->
		</div>
		
	</div>
</div>
<script>
	   $(document).ajaxSend(function(e,xhr,options){
	      xhr.setRequestHeader(
	            '${_csrf.headerName}',
	            '${_csrf.token}');
	   });
	
var contextPath = '${pageContext.request.contextPath}';
// var page = 1;

if(typeof keyword === 'undefined'){keyword = "noValue"}
var resultQuery ="noValue|noValue|noValue|noValue|noValue|" +keyword;





  	var contextPath="${pageContext.request.contextPath}";
	var isToggle = true;
	var countDescription = 1;
	var lastPageDs = 10;
	var descriptionPage = 1;
	var keyword = "${searchValue}";

	if(typeof keyword === 'undefined' || keyword ==''){keyword = "noValue"}
	var resultQuery ="noValue|noValue|noValue|noValue|noValue|" +keyword;

  	$("#keywordTemplate").val(keyword);
  	let k = $("#keywordTemplate").val();
  	
  	function keywordSearch(){
  		keyword = '${searchValue}';
  		$("#keywordTemplate").val(keyword);
  		
  		if(keyword.includes("㉾")){
  			alert('해당 문자는 사용할 수 없습니다.');
  			$("#searchKeyword").val('');	//구분자 제거
  		}
  	
  		
  		select("㉾"+keyword);
  	}
  		
 	
 	 disableP();
  	 disableN();
  	countDesc();
 	printDescription(descriptionPage); 		
 	// page를 같이 넘겨준다.
  	function printDescription(descriptionPage){
  		$.ajax({
			type : "POST",
  			url : "${path}/search/printDescription",
  			headers: { "${_csrf.parameterName}": "${_csrf.token}" },
  			data:{
  				descPage : descriptionPage ,
  				},
  			dataType :"json",		// List<descpriptionVO>
  			success: function (list){
  				let str = "";
  					str += '<button type="button" id="previousBtn" class="btn btn-dangerno" onclick="previous('+descriptionPage+')"><b>&lt;</b></button>';	
  					
  				$(list).each(function(){
  					let descriptionSrc = "";
  					descriptionSrc += "${descImgPath}/description"+this.no+".jpg";
  			str+=	  `<div class="card barItem"  onclick='select("description"+"\${this.description}")'>`;	
  			str+=	  '<img src="'+descriptionSrc+'" class="icon"/>';
  			str+=	  `<div class="ctext">`;
  			str+=	  `<p class="card_Ptag card-text" >\${this.description}</p>`;			//내용
  			str+=	  `</div>`;
  			str+=	  `</div>`;
  					
  					
  				})	
  				str += '<button type="button" id="nextBtn" class="btn btn-dangerno" onclick="next('+descriptionPage+')"><b>&gt;<b/></button><br/>';	
  					str += `<div id="cancelDescription" onclick="cancel()">선택해제</div>`;                
  				$("#barContatiner").html(str);
  			},
  			error : function(error){
		
  			}
  		});	
  	}
  	
  	function cancel() {
  		$("#descriptionTemplate").html("");
  		select("");
		
	}

  	function next(descriptionPage){
 		if(descriptionPage != lastPageDs){
 		descriptionPage++;
 		printDescription(descriptionPage);
 		}

 		disableN();
 	}
 	function previous(descriptionPage){
 		if(descriptionPage != 1){
 		descriptionPage--;
 		printDescription(descriptionPage);
 		}
 		disableP();
 	}
 	function disableN(descriptionPage){
 		if(descriptionPage == lastPageDs){
 //			alert('조건 충족');
 			$("#nextBtn").prop("disabled", true);
 			$("#nextBtn").css("opacity","0.5"); 			
 		}else{
 			$("#nextBtn").prop("disabled", false);
 			$("#nextBtn").css("opacity","1"); 
 		}
 	}
 	function disableP(descriptionPage){
 	if(descriptionPage == 1){
			$("#previousBtn").prop("disabled", true);
			$("#previousBtn").css("opacity","1"); 
		}else{
			$("#previousBtn").css("opacity","0.5"); 
			$("#previousBtn").prop("disabled", false);
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
 	           lastPageDs = Math.ceil(countDescription/10);
 	            
 	        },
			error: function(count){

			}
 			
 		});
 	}
  
  
  	function printCategory(list){ 
  				let str="";
  				str += '<div id="selectedCategory"></div>';
  		$("#responsed").html(str);
  				str += `<div class="containerNO">`;   
  	 			str += `<button type="button" onclick='select("category")' class='itemsNO btn btn-outline-dark'>선택하지 않음</button> <br/> `;
		  		 
  	  	$(list).each(function(){	
			   	str += `<button type="button" class="btn btn-outline-danger items" style="font-size: 13px;" `; 
			   	str += ` onclick='select("category"+"\${this.category}")'>\${this.category}</button>`;
  	  	})
  			str +=	`</div>`;
  		$("#responsed").append(str);
  	};
  	
  	
  	
  	// List<Integer>
  	function printDate(list){ 
  		let str="";
  			str += `<div class="containerNO">`;     
  			str += `<button type="button" onclick='select("date")' class='itemsNO btn btn-outline-dark'>선택하지 않음</button> <br/> `;
  		$(list).each(function(){
  			str += `<button type="button" class="btn btn-outline-danger items" onclick='select("date\${this}")'>\${this}일 이내</button>`;
  		})
  			 str +=	`</div>`;
  		$("#responsed").html(str);//

  	};
  	
 	 //List<String>
  	function printLocation(list){	
  		let str="";
  		$("#responsed").html(str);
  		
  		
  	  <!-- Content here -->
 
  		str += `<div class="containerNO">`;    
  		str += `<button type="button" onclick='select("sido")' class='itemsNO btn btn-outline-dark'>선택하지 않음</button> <br/> `;
  		$(list).each(function(){	// locationVO
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
  			method : "get",
  			data : { targetContents : sido },
  			dataType : "json",
  			success : function(sigungu){	// List<LocationVO>
  				
  		        	str += `<div class="containerNO">`;    
  		        	str += `<button type="button" onclick='select("sigungu")' class='itemsNO btn btn-outline-dark'>선택하지 않음</button> <br/> `;
  					$(sigungu).each(function(){
					str += `<button type="button" class="btn btn-outline-danger items" onclick='select("sigungu\${this.sigungu}")'>\${this.sigungu}</button>`;
					$("#responsed").html(str); 
					
					
				})	
					str += `</div>`;
  					isToggle = true;
  			},	
  			error : function(error){

  			}
  			
  		})
  	}
  	
  	function select(factor){	// 아무 요소나 선택되었을 때
  		page = 1;
  		$("#partys").html("");
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
  		$("#dateTemplate").html(factor); 	
  		}
  		
  		if(factor.includes('sido')){
  		
  		$("#sidoTemplate").html(factor);
  			factor = factor.substring("sido".length);
 
 				$("#searchModal").css("display","block");
  			printLocation2(factor);	
  		}
  		if(factor.includes('sigungu')){
  	  		$("#sigunguTemplate").html(factor);
  	  		}		
  		
  		if(!factor.includes('description') ){
  			if(!(factor.includes('㉾')||factor ==""))
  			$("#searchModal").toggle("fast");
  			
  		}
  		
  		
  	
  		let selectedDescription = $("#descriptionTemplate").html();
  		let selectedCategory = $("#categoryTemplate").html();
  		let selectedDate = $("#dateTemplate").html();
  		let selectedSido= $("#sidoTemplate").html();
  		let selectedSigungu= $("#sigunguTemplate").html();
  		
  		if (typeof selectedDescription === 'undefined'
  				|| selectedDescription == "" ) { 
  			selectedDescription = "noValue";
  		} else {
  			let length = "description".length;
  			selectedDescription = selectedDescription.substring(length);
  		}
  		
  		if (typeof selectedCategory === 'undefined'
  				|| selectedCategory == "" || selectedCategory=="category") { 
  			selectedCategory = "noValue";
  		} else {
  			let length = "category".length;
  			selectedCategory = selectedCategory.substring(length);
  			
  		}
  	
  		if (typeof selectedDate === 'undefined' 
  			|| selectedDate == "" || selectedDate == "date" ) {
  			selectedDate = "noValue";
  		} else {
  			let length = "date".length;
  			selectedDate = selectedDate.substring(length);
  		}
  		if (typeof selectedSido === 'undefined'
  			|| selectedSido == ""	|| selectedSido =="sido") {
  			
  			selectedSido = "noValue";
  			
  		} else {
  			let length = "sido".length;
  			selectedSido = selectedSido.substring(length);
  			$("#locationBtn").html(selectedSido);
  		}
  		if (typeof selectedSigungu === 'undefined'
  			|| selectedSigungu == ""	|| selectedSigungu =="sigungu") {
  			selectedSigungu = "noValue";
  		} else {
  			let length = "sigungu".length;
  			selectedSigungu = selectedSigungu.substring(length);
  		}
  		
  		if(factor.includes("㉾")){ 
  			$("#keywordTemplate").html(factor);
  			
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

  		  			if(selectedKeyword ==""){
  		  				selectedKeyword = "noValue";
  		  			}
  		if(selectedSido == "noValue"){selectedSigungu = "noValue"}
  			
  		resultQuery = selectedDescription+"|"+selectedCategory+"|"
  		+selectedDate+"|"+selectedSido+"|"+selectedSigungu+"|"+selectedKeyword;
  		
  		listAjax(page,resultQuery);
  		
  
  	} 
  	
  	
  	
  	
  	function listAjax(page,resultQuery ){
  	// 선택값이 없을 시  noValue
  		
  		 $.ajax({
			
   			url : "${path}/search/querySearch/"+page ,
   			method : "GET",
   			data : {
   				resultQuery : resultQuery
   			},
   			dataType : "JSON",  

   			success :  function(data){
   				let str = "";
   				let wishlistPnum = [];

   				if(data.wishlist != null){
   					$(data.wishlist).each(function(){
   						let wishPnum = this.pnum;
   						wishlistPnum.push(wishPnum);
   					});	
   				}
   				
   				$(data.partyList).each(function(){
   					let pname = this.pname;
   					let address = this.address;
   					let date = this.formatStartDate +"~"+ this.formatEndDate;		
   					let pnum = this.pnum;
   					let path = this.partyImage1;
   					let detailAddress = this.detailAddress;
   					
   					str += '<li>';
   					if(data.wishlist != null){
   						if(wishlistPnum.indexOf(pnum) < 0){
   							str += "<img src='${path}/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
   						}else{
   							str += "<img src='${path}/resources/img/redHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
   						}
   					}else{
   						str += "<img src='${path}/resources/img/emptyHeart.png' id='"+pnum+"' class='likeBtn' onclick='toggleHeart(this);'/>";
   					}
   					str += '<img src="'+contextPath+'/image/printPartyImage?fileName='+path+'" class="partyImg" onclick="partyDetail('+pnum+');">';
   					str += "<hr/>";
   					str += "<strong onclick='partyDetail("+pnum+");' style='cursor: pointer;'>"+pname+"</strong><br/>";
   					str += address+" "+detailAddress+"<br/>";
   					str += date;
   					str += "</li>";
   				});

   				
   				if(page == 1){
   					$("#partys").html(str);
   				}else{
   					$("#partys").append(str);
   				}
			
  			},
   			error : function(error){
   		//		alert(error);
   			}
   			
   		}); 
  	}// listAjax(page,resultQuery)
  		
  		
  
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
			return false;
		}
		page++;
		listAjax(page,resultQuery);
	}//
});	//
  	
  	
  	
 
  	
  	
  	
    $(document).ready(function() {
    	
    	$(".barItem").click(function() {
    	    if (!$(this).hasClass("clicked")) {
    	      $(".barItem").removeClass("clicked");
    	      $(this).addClass("clicked");
    	      $(this).css("border","2px");
    	    }
    	  });
    	
    	
    	
    	$("#keywordBtn").click(function(){
    		 listAjax(page,resultQuery);
    	});
    		
    	
      $(".searchBtn").click(function () {
        // 타겟 정의
        var targetContents = $(this).attr("data-targetContents");
        if(isToggle){
        $("#searchModal").toggle("fast");
        }
  
        $.ajax({
        	  url: '${path}/search/getSearchContents', // target컨텐츠가 전달
        	  method: 'get',
        	  headers: { "${_csrf.parameterName}": "${_csrf.token}" },
        	  data: {targetContents : targetContents},
        	  dataType: 'JSON',  // return : entity
        	  success: function(response) {
        	    
        	    if(targetContents == "category" ){
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
        	  }
        	});
      });

      // MODAL CLOSE
      
      $(".close").click(function () {
        $("#searchModal").toggle("fast");
        $("#searchModal").hide();
        $("#responsed").html("");
      });
	
    }); // ready
    
  </script>

