<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 파비콘 추가 -->
    <link rel="icon" href="/images/01.png" type="image/png">
    <!--     부트스트랩 css  -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!--     개발자 css -->
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/exstyle.css">
    <link rel="stylesheet" href="/css/login.css">
</head>
<body>
<!-- 로그인화면 -->
<div class="loginpage">
  <div class="loginbox">
      <div class="brandtext">
       <a class="login_home" href="<c:url value='home.do'/>">RecipeCode</a>
    </div>
      <div class="error_box">
      <c:if test="${not empty msg}">
		<br><p class="regi">${msg}</p>
      </c:if>
      <c:if test="${not empty errors}">
       <p class="login_error">${errors}</p>
      </c:if>
    </div>
  
    <div class= "inputbox">
    <div class= "input_center">
      <form id="addForm" name="addForm"action="/loginProcess.do" method="post">
		<div class="form-group">
		    <p class="input_name">아이디</p>
		    <input type="text" class="form-control"
            		           id="userid"
            		           name="userid"							
						       placeholder="사용자 아이디"  />

		</div>
		<div class="form-group">
		    <p class="input_name">비밀번호</p>
			<input type="password" class="form-control"
            		               id="password"
            		               name="password"										
								   placeholder="비밀번호"  />

		</div>
		<div>
				<button class ="btn">LOGIN</button>
		</div>
		<div>
         <ul class="login_menu">
            <li><a class="find_id logmn" href="<c:url value='findid.do'/>">아이디찾기</a></li>
            <li>|</li>
            <li><a class="find_password logmn" href="<c:url value='findpassword.do'/>">비밀번호찾기</a></li>
            <li>|</li>
            <li><a class="register logmn" href="<c:url value='register.do'/>">회원가입</a></li>
          </ul>
         </div>
      </form>
       </div>
     </div>
   </div>
</div>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<!-- 토글 애니메이션 js -->
<script src="/js/nav.js"></script>
<!-- 유효성체크 플러그인 -->
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.21.0/dist/jquery.validate.min.js"></script>
<script src="/js/auth/login-validation-config.js"></script>


<!-- 꼬리말 -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>