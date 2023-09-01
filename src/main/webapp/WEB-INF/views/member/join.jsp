<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/header.jsp"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
html, body {
	height: 100%
}

#wrap {
	min-height: 100%;
	position: relative;
	padding-bottom: 93px;
}

/* .container {
   display: flex;
   justify-content: center;
   align-items: center;
   min-height: 100vh;
   margin-top: -5%;
} */
.btn-primary-custom {
	background-color: #FF385C;
	border-color: #FF385C;
	margin-right: 20px;
}

.form-container {
	background-color: white;
	border: 1px solid #ccc;
	padding: 20px;
	width: 800px; /* 조정 가능한 너비 */
}

#mid {
	width: 400px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

/* 예시: 비밀번호 입력 필드의 너비 조정 */
#mpw {
	width: 400px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

input[name="repw"] {
	width: 400px;
	padding: 10px;
}

/* 예시: 이름 입력 필드의 너비 조정 */
input[name="mname"] {
	width: 400px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

/* 예시: 이메일 입력 필드의 너비 조정 */
input[name="memail"] {
	width: 400px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

/* 예시: 주소 입력 필드의 너비 조정 */
input[name="maddr"] {
	width: 400px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

input[name="mnick"] {
	width: 400px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

/* 예시: 나이 입력 필드의 너비 조정 */
input[name="mage"] {
	width: 400px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

.uploadImage {
	width: 100px;
	height: 100px;
	border-radius: 50px;
	border: 1px solid #ccc;
}
</style>
<div id="wrap">
	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<div class="card" style="width: 800px;">
					<div class="card-body">
						<h2 class="card-title text-center">회원가입</h2><br/>
						<form action="<c:url value='/member/join' />" method="POST"
							id="joinForm" class="ms-4" enctype="multipart/form-data">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<table class="table table-hover">
								<tr>
									<td>아이디:</td>
									<td><input type="text" name="mid" id="mid"
										style="display: grid;" placeholder="아이디를 입력하세요"></td>
								</tr>
								<tr>
									<td>비밀번호:</td>
									<td><input type="password" name="mpw" id="mpw"
										style="display: grid;" placeholder="비밀번호를 8자리 이상 입력해주세요"></td>
								</tr>
								<!-- <tr>
                     <td>비밀번호 확인 :</td>
                     <td><input type="password" name="repw" id="repw"
                        placeholder="비밀번호를 다시확인해주세요"></td>
                  </tr> -->
								<tr>
									<td>이름:</td>
									<td><input type="text" name="mname" id="mname"
										style="display: grid;" placeholder="이름"></td>
								</tr>
								<tr>
									<td>닉네임:</td>
									<td><input type="text" name="mnick" id="mnick"
										style="display: grid;" placeholder="닉네임"></td>
								</tr>
								<tr>
									<td>나이:</td>
									<td><input type="number" name="mage" id="mage"
										style="display: grid;" placeholder="나이를 입력하세요"></td>
								</tr>
								<tr>
									<td>성별:</td>
									<td><input type="radio" name="mgender" value="m" checked>남자
										<input type="radio" name="mgender" value="f">여자</td>
								</tr>
								<tr>
									<td>이메일:</td>
									<td><input type="email" name="memail"
										style="display: grid;" id="memail" placeholder="이메일을 입력하세요"></td>
								</tr>
								<tr>
									<td>주소:</td>
									<td><input type="text" name="maddr" id="maddr"
										style="display: grid;" placeholder="주소를 입력하세요"></td>
								</tr>
								<tr>
									<td>프로필 이미지</td>
									<td class="text-center"><img
										src="${path}/resources/img/profile.jpg" id="viewImage"
										class="uploadImage" />
										<div class="row">
											<div class="col-md-6">
												<input type="file" id="profileImage" name="file"
													accept="image/*" class="full-left" />
											</div>
											<div class="col-md-6">
												<input type="button" id="removeProfile" value="삭제" />
											</div>
										</div></td>
								</tr>

								<tr>
									<td colspan="2" align="center">
										<div class="text-center">


											<div class="row">
												<div class="col-sm-6 text-end">
													<button type="submit" class="btn btn-primary"
														style="background-color: #FF385C; border-color: #FF385C;">가입</button>
												</div>
												
												</div>
											</div>





									</td>
								</tr>
							</table>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
<script>
/* 
      const passwordInput = document.getElementById('password');
      const mIdInput = document.getElementById('mId');

      document.getElementById('passwordForm').addEventListener('submit',
            function(event) {
               if (passwordInput.value.length <= 7) {
                  alert("비밀번호는 8자 이상이어야 합니다.");
                  event.preventDefault(); // 제출 막기
               }

               if (hasSpecialCharacters(mIdInput.value)) {
                  alert("아이디에 특수 문자를 사용할 수 없습니다.");
                  event.preventDefault(); // 제출 막기
               }
            });

      function hasSpecialCharacters(input) {
         const specialCharacters = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/;
         return specialCharacters.test(input);
      }
      function togglePasswordVisibility() {
         var passwordField = document.getElementById("password");
         if (passwordField.type === "password") {
            passwordField.type = "text";
         } else {
            passwordField.type = "password";
         }
      }
       */
   </script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
<script>
   
   var imgTemp = $("#viewImage").attr("src");
	
	$("#profileImage").on("change", function(){
		var files = $(this)[0].files[0];
		if (!files.type.startsWith('image/')) {
			alert('이미지를 선택해주세요.');
			removeImage();
		}else{
			var path = window.URL.createObjectURL(files);
			$("#viewImage").attr("src",path);	
		}
	});
	
	$("#removeProfile").click(function(){
		removeImage();
	});
	
	function removeImage(){
		$("#profileImage").val("");
		$("#viewImage").attr("src",imgTemp);
	}
	
	// 정규표현식을 통한 검증 추가
	$.validator.addMethod("regex",function(value,element,regexpr){
		return regexpr.test(value);
	});
	
	var regexPass = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;	
	var regexMobile = /^[0-9]{2,3}?[0-9]{3,4}?[0-9]{4}$/;
	
	// 8월 31일
	$("#joinForm").validate({
		// 포커스 out시 유효성 검사
		onfocusout: function(element) {
            this.element(element);
        },
		rules : {
			mid : {
				required : true		
				
			},
			mpw : {
				required : true, 
				minlength : 8,
				maxlength : 16,
				regex : regexPass
			},
			mname : {
				required : true,
				rangelength : [2,6]
			},
			mage : {
				required : true
			},
			memail : {
				required : true
			},
			maddr : {
				required : true
			},
			mnick :{
				required : true
			},
			
		},
		messages : {
			mid : {
				required : "이메일(아이디)를 작성해주세요."
			},
			mpw : {
				required : "비밀번호를 작성해주세요.",
				minlength : "비밀번호는 최소 8글자 이상입니다.",
				maxlength : "비밀번호는 최대 16글자만 가능합니다.",
				regex : "비밀번호는 특수문자와 숫자를 포함해야합니다."
			},
			repw : {
				required : "비밀번호를 작성해주세요.",
				minlength : "비밀번호는 최소 8글자 이상입니다.",
				maxlength : "비밀번호는 최대 16글자만 가능합니다.",
				equalTo : "비밀번호가 일치하지 않습니다."
			},
			mnick : {
				required : "닉네임을 입력해주세요."
			},
			mage : {
				required : "나이를 숫자로 입력해주세요."
			},
			mname : {
				required : "이름을 작성해 주세요.",
				rangelength : $.validator.format(
					"문자 길이가 {0}에서 {1}사이의 값을 입력하세요."
				)
			},
			memail : {
				required : "이메일을 작성해주세요"
			},
			
			maddr : {
				required : "주소를 확인해 주세요."
			},
		},
		errorElement : "span",
		errorClass : "text-danger"
	});
	
	$.validator.setDefaults({
		submitHandler : function(){
			$("#joinForm").submit();
		}
	});
	
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(
				'${_csrf.headerName}',
				'${_csrf.token}');
	});
   
   </script>

<%@ include file="../common/footer.jsp"%>
