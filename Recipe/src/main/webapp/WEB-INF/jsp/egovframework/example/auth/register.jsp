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
    <link rel="stylesheet" href="/css/register.css">
</head>
<body>
<!-- 로그인화면 -->
<div class="registerpage">
  <div class="registerbox">
    <div class="brandtext">
       <a class="register_home" href="<c:url value='home.do'/>">RecipeCode</a>
    </div>
    <div class="tcenter">
	   <h4 class="pro_text">회원 가입</h4>
	</div>
    <div class="error_box">
    <c:if test="${not empty errors}">
    <p class="regi_error">${errors}</p>
    </c:if>
    </div>
    <div class= "inputbox">
    <div class= "input_center">
      <form id="addForm" name="addForm"action="/registeraddition.do" method="post">
		<div class="form-group">
		    <input type="text" class="form-control"
            		           id="userId"
            		           name="userId"							
						       placeholder="아이디"  />
		</div>
		<div class="form-group">
			<input type="password" class="form-control"
            		               id="password"
            		               name="password"										
								   placeholder="비밀번호"  />
		</div>
		<div class="form-group">
			<input type="password" class="form-control"
            		               id="repassword"
            		               name="repassword"										
								   placeholder="비밀번호 확인"  />
		</div>
		<div class="form-group">
			<input type="text" class="form-control"
            		            id="userName"
            		            name="userName"											
							    placeholder="사용자명"   />
		</div>
		<div class="form-group">
			<input type="text" class="form-control"
            		            id="nickname"
            		            name="nickname"											
							    placeholder="사용자 별명"   />
		</div>
		<div class="form-group">
			<input type="text" class="form-control"
            		            id="phoneNum"
            		            name="phoneNum"											
							    placeholder="휴대폰 번호('-'빼고입력하시오)"   />
		</div>
		<div class="form-group">
			<input type="e-mail" class="form-control"
            		            id="email"
            		            name="email"											
							    placeholder="E-mail"   />
								</div>
				<button class ="btn">Register</button>
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
<!-- 유효성체크 플러그인 -->
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.21.0/dist/jquery.validate.min.js"></script>
<script src="/js/auth/register-validation-config.js"></script>


<!-- 꼬리말 -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>