<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join</title>
<style>
    /* 모달 스타일링 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0,0,0,0.4);
    }

    .modal-content {
        background-color: #fefefe;
        margin: 10% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 20%;
        height : 50%;
        position: relative; /* 모달 내부 요소의 위치를 상대적으로 설정 */
    }

    .close {
        position: absolute;
        top: -11px;
        right: 4px;
        padding: 5px;
        cursor: pointer;
        font-size : 33px;
    }

    /* 아이디 입력칸 스타일 */
    input[type="text"] {
        width: 50%; /* 100% 폭으로 설정하여 모달 창의 너비에 맞게 크기 조정 */
        padding: 10px; /* 내부 여백 설정 */
        font-size: 16px; /* 폰트 크기 설정 */
    }
    input[type="password"] {
        width: 50%; /* 100% 폭으로 설정하여 모달 창의 너비에 맞게 크기 조정 */
        margin-top: 10px;
        padding: 10px; /* 내부 여백 설정 */
        font-size: 16px; /* 폰트 크기 설정 */
    }
    input[type="submit"] {
        width: 80%; /* 100% 폭으로 설정하여 모달 창의 너비에 맞게 크기 조정 */
        padding: 10px; /* 내부 여백 설정 */
        font-size: 16px; /* 폰트 크기 설정 */
    }
</style>
</head>
<body>

<button id="loginButton">로그인</button>
<form action="${pageContext.request.contextPath}/member/goJoin">
	<button>회원가입</button>
</form>

<!-- 모달 창 -->
<div id="loginModal" class="modal">
    <div class="modal-content">
        <span class="close" id="closeModal">&times;</span> <!-- &times;는 X 문자 -->
        <h2>로그인</h2>
        <hr/>
        <form action="${pageContext.request.contextPath}/member/loginCheck" method="post">
            <input type="text" name="mid" placeholder="아이디를 입력해주세요" required><br/>
            <input type="password" name="mpw" placeholder="비밀번호를 입력해주세요" required><br/>
            로그인 상태 유지 : <input type="checkbox" name="cookie"><br/>
            <input type="submit" value="로그인">
        </form>
    </div>
</div>

<script>
    const loginButton = document.getElementById("loginButton");
    const loginModal = document.getElementById("loginModal");
    const closeModal = document.getElementById("closeModal");

    loginButton.addEventListener("click", () => {
        loginModal.style.display = "block";
    });

    closeModal.addEventListener("click", () => {
        loginModal.style.display = "none";
    });
</script>

</body>
</html>