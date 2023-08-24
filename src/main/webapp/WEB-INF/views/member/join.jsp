<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<h2>회원가입</h2>
<form action="<c:url value='/member/join' />" method="POST" id="passwordForm" enctype="multipart/form-data">
    아이디:<input type="text" name="mId" id="mId" placeholder="아이디를 입력하세요" required ><br/>
    비밀번호:<input type="password" name="mPw" id="password" placeholder="비밀번호를 8자리 이상 입력해주세요" required><br/>
    <!-- 비밀번호 확인: <input type="password" name="repw" placeholder="비밀번호를 다시확인해주세요"> -->
    이름:<input type="text" name="mName"placeholder="이름"  required><br/>
    닉네임:<input type="text" name="mNick" placeholder="닉네임"  required> <br/>
    나이:<input type="number" name="mAge" placeholder="나이를 입력하세요"  required><br/>
    <br/>
    <input type="radio" name="mGender" value="m" checked>남자
    <input type="radio" name="mGender" value="f">여자<br/>
    이메일 :<input type="email" name="mEmail" placeholder="이메일을 입력하세요"  required><br/>
    주소 : <input type="text" name="mAddr" placeholder="주소를 입력하세요"  required> <br/>
    프로필 사진 :<input type="file" name="file" accept=".jpg, .jpeg, .png"/> <br/>
    <input type="submit" value="가입">
</form>

<a href="<c:url value='/member/login' />">goLogin</a>
<script>
    const passwordInput = document.getElementById('password');
    const mIdInput = document.getElementById('mId');
    
    document.getElementById('passwordForm').addEventListener('submit', function(event) {
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
</script>
</body>
</html>
