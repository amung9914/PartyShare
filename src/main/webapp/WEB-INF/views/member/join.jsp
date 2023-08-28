<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/header.jsp"%>
<style>
html, body {
	height: 100%
}

#wrap {
	min-height: 100%;
	position: relative;
	padding-bottom: 93px;
}

.container {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	margin-top: -5%;
}

.form-container {
	background-color: white;
	border: 1px solid #ccc;
	padding: 20px;
	width: 800px; /* 조정 가능한 너비 */
}

#mId {
	width: 300px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

/* 예시: 비밀번호 입력 필드의 너비 조정 */
#password {
	width: 300px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

input[name="repw"] {
	width: 300px;
	padding: 10px;
}

/* 예시: 이름 입력 필드의 너비 조정 */
input[name="mname"] {
	width: 200px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

/* 예시: 이메일 입력 필드의 너비 조정 */
input[name="memail"] {
	width: 300px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

/* 예시: 주소 입력 필드의 너비 조정 */
input[name="maddr"] {
	width: 400px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

input[name="mnick"] {
	width: 200px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

/* 예시: 나이 입력 필드의 너비 조정 */
input[name="mage"] {
	width: 200px; /* 원하는 너비로 조정 */
	padding: 10px; /* 내용과 테두리 사이의 여백 설정 */
}

.uploadImage {
	width: 100px;
	height: 100px;
	border-radius: 50px;
	border: 1px solid #ccc;
}
</style>
<title>회원가입</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div id="wrap">
		<div class="container">
			<div class="form-container">
				<h2>회원가입</h2>
				<form action="<c:url value='/member/join' />" method="POST"
					id="passwordForm" enctype="multipart/form-data">
					<table class="table table-hover">
						<tr>
							<td>아이디:</td>
							<td><input type="text" name="mid" id="mId"
								placeholder="아이디를 입력하세요" required></td>
						</tr>
						<tr>
							<td>비밀번호:</td>
							<td><input type="password" name="mpw" id="password"
								placeholder="비밀번호를 8자리 이상 입력해주세요" required></td>
							<td><button type="button"
									onclick="togglePasswordVisibility()">보이기</button></td>
						</tr>
						<!-- <tr>
							<td>비밀번호 확인 :</td>
							<td><input type="password" name="repw" id="repw"
								placeholder="비밀번호를 다시확인해주세요"></td>
						</tr> -->
						<tr>
							<td>이름:</td>
							<td><input type="text" name="mname" placeholder="이름"
								required></td>
						</tr>
						<tr>
							<td>닉네임:</td>
							<td><input type="text" name="mnick" placeholder="닉네임"
								required></td>
						</tr>
						<tr>
							<td>나이:</td>
							<td><input type="number" name="mage" placeholder="나이를 입력하세요"
								required></td>
						</tr>
						<tr>
							<td>성별:</td>
							<td><input type="radio" name="mgender" value="m" checked>남자
								<input type="radio" name="mgender" value="f">여자</td>
						</tr>
						<tr>
							<td>이메일:</td>
							<td><input type="email" name="memail"
								placeholder="이메일을 입력하세요" required></td>
						</tr>
						<tr>
							<td>주소:</td>
							<td><input type="text" name="maddr" placeholder="주소를 입력하세요"
								required></td>
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
								<button type="submit" class="btn btn-primary"
									style="background-color: #FF385C; border-color: #FF385C; margin-right: 20px;">가입</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<script>
		const passwordInput = document.getElementById('password');
		const mIdInput = document.getElementById('mId');

		document.getElementById('passwordForm').addEventListener('submit',
				function(event) {
					if (passwordInput.value.length <= 8) {
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
	</script>
	<%@ include file="../common/footer.jsp"%>