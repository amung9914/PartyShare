<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!-- 부트스트랩 CSS 포함 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<style>
    /* 아이디 입력칸 스타일 */
    .custom-input {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        margin-bottom: -5px; /* 아래쪽 간격 추가 */
    }

    .custom-button {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        margin-bottom:-4px;
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
<!-- 부트스트랩 모달 -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered"> <!-- 가운데 정렬 -->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">로그인</h5>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/member/loginCheck" method="post">
                    <div class="form-group mb-3">
                        <input type="text" id="mid" name="mid" class="form-control custom-input" placeholder="아이디를 입력해주세요" required>
                    </div>
                    <div class="form-group mb-3">
                        <input type="password" id="mpw" name="mpw" class="form-control custom-input" placeholder="비밀번호를 입력해주세요" required>
                    </div>
                    <div class="form-group form-check mb-3">
                        <input type="checkbox" class="form-check-input" id="cookie" name="cookie">
                        <label class="form-check-label" for="cookie">로그인 상태 유지</label>
                    </div>
                    <div class="form-group text-center mb-3">
                        <button type="submit" class="btn btn-primary custom-button" style="background-color: #FF385C; border-color: #FF385C;">로그인</button>
                    </div>
                    <div class="form-group text-center">
                        <button type="button" onclick="location.href='${pageContext.request.contextPath}/member/goJoin';" class="btn btn-dark custom-button">회원가입</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>