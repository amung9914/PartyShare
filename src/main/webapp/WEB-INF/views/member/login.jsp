<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join</title>
<!-- 부트스트랩 CSS 포함 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
    /* 아이디 입력칸 스타일 */
    .custom-input {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        margin-bottom: 10px; /* 아래쪽 간격 추가 */
    }

    .custom-button {
        width: 100%;
        padding: 10px;
        font-size: 16px;
    }

    /* 모달 내부 "X" 버튼 스타일 */
    .closeModal {
        background-color: transparent;
        border: none; /* 태두리 없애기 */
        font-size: 30px;
        position: absolute;
        right: 15px;
        top: 15px;
    }

    .modal-title {
        margin-bottom: 10px;
    }

    .modal-title + hr {
        margin-top: 0;
        margin-bottom: 15px;
    }
</style>

</head>
<body>

<button id="loginButton" class="btn btn-primary">로그인</button>

<form action="${pageContext.request.contextPath}/member/goJoin">
   <button class="btn btn-secondary">회원가입</button>
</form>

<!-- 부트스트랩 모달 -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered"> <!-- 가운데 정렬 -->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">로그인</h5>
                <button type="button" class="closeModal close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>a
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/member/loginCheck" method="post">
                    <div class="form-group">
                        <input type="text" id="mid" name="mid" class="form-control" placeholder="아이디를 입력해주세요" required>
                    </div>
                    <div class="form-group">
                        <input type="password" id="mpw" name="mpw" class="form-control" placeholder="비밀번호를 입력해주세요" required>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="cookie" name="cookie">
                        <label class="form-check-label" for="cookie">로그인 상태 유지</label>
                    </div>
                    <div class="form-group text-center">
                        <button type="submit" class="btn btn-primary">로그인</button>
                        <button type="button" onclick="location.href='${pageContext.request.contextPath}/member/goJoin';" class="btn btn-primary">회원가입</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 부트스트랩 JS와 jQuery 포함 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    const loginButton = document.getElementById("loginButton");
    const closeModal = document.getElementsByClassName("closeModal")[0];

    loginButton.addEventListener("click", () => {
        $('#loginModal').modal('show');
    });

    closeModal.addEventListener("click", () => {
        $('#loginModal').modal('hide');
    });
</script>

</body>
</html>
