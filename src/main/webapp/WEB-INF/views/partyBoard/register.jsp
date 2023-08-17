<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register.jsp</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <!-- Editor's Style -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<style>
#title{
    border: 1px solid white;
    border-bottom: 1px solid black;
}
</style>
</head>
<body>
	<form method="POST" id="post"> <!-- action 지정이 안되어 있으면 동일한 url요청 경로에 전송방식만 POST로 요청감 -->
		
		<input type="hidden" name="pnum" value="${pnum}"/>
		<select name="category" >
		    <option value="공지사항">공지사항</option>
		    <option value="normal">일반</option>
	  	</select>
		<div>
			<label>제목 : </label>
			<input type="text" name="title" id="title"/>
		</div>
		<br/>
		<div>
		<!-- 	<label>CONTENT</label>
			<textarea name="context" rows=3></textarea> -->
		</div>
		<div>
			
			<input type="hidden" name="mnick" value="${loginMember.mnick}" />
		</div>
		<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
		 <div id="editor"></div>
		<div>
			 <button>완료</button>
			<button type="button" onclick="goBack();">뒤로가기</button>	
		</div>
		</form>
<script>
const editor = new toastui.Editor({  
    el: document.querySelector('#editor'),  
    previewStyle: 'vertical',  
    height: '500px',  
    initialEditType : 'wysiwyg',  
    initialValue: '내용을 입력해주세요.',  
    hideModeSwitch: 'true'  
  });  
  
 function goBack(){
	 history.go(-1);
 }
 
 $("#post").addEventListenet("submit",function(){
	 
 });
 
</script>
</body>
</html>

  








