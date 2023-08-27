<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/header.jsp" %>
<style>
    .container {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
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
</style>
<title>회원가입</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<div class="container">
    <div class="form-container">
        <h2>회원가입</h2>
        <form action="<c:url value='/member/join' />" method="POST" id="passwordForm" enctype="multipart/form-data">
            <table class="table table-hover">
                <tr>
                    <td>아이디:</td>
                    <td><input type="text" name="mid" id="mId" placeholder="아이디를 입력하세요" required></td>
                </tr>
                <tr>
                    <td>비밀번호:</td>
                    <td><input type="password" name="mpw" id="password" placeholder="비밀번호를 8자리 이상 입력해주세요" required></td>
                </tr>
                <!-- 비밀번호 확인: <input type="password" name="repw" placeholder="비밀번호를 다시확인해주세요"> -->
                <tr>
                    <td>이름:</td>
                    <td><input type="text" name="mname" placeholder="이름" required></td>
                </tr>
                <tr>
                    <td>닉네임:</td>
                    <td><input type="text" name="mnick" placeholder="닉네임" required></td>
                </tr>
                <tr>
                    <td>나이:</td>
                    <td><input type="number" name="mage" placeholder="나이를 입력하세요" required></td>
                </tr>
                <tr>
                    <td>성별:</td>
                    <td>
                        <input type="radio" name="mgender" value="m" checked>남자
                        <input type="radio" name="mgender" value="f">여자
                    </td>
                </tr>
                <tr>
                    <td>이메일:</td>
                    <td><input type="email" name="memail" placeholder="이메일을 입력하세요" required></td>
                </tr>
                <tr>
                    <td>주소:</td>
                    <td><input type="text" name="maddr" placeholder="주소를 입력하세요" required></td>
                </tr>
                <tr>
                    <td>프로필 사진:</td>
                    <td><input type="file" name="file" accept=".jpg, .jpeg, .png"/></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button type="submit" class="btn btn-primary" style="background-color: #FF385C; border-color: #FF385C; margin-right: 20px;">가입</button>
                        <a href="<c:url value='/member/login' />">goLogin</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
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
<%@ include file="../common/footer.jsp" %>
