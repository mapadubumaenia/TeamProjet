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
    <link rel="stylesheet" href="/css/findid.css">
</head>
<body>
<!-- 로그인화면 -->
<div class="findidpage">
  <div class="findidbox">
    <div class="brandtext">
       <a class="findid_home" href="<c:url value='home.do'/>">RecipeCode</a>
    </div>
      <div class="error_box">
     <div class="tcenter">
	   <h5 class="find_pro">아이디 찾기</h5>
  <c:if test="${not empty result}">
	<p class= "find_suc">고객님의 정보와 일치하는 아이디입니다.</p>
	<div class= "boxcenter">
	<div class="id_result">
		<p class="result_findid">${result}</p>
	</div>
	</div>
		<ul class="findid_menu mt5">
            <li><a class="find_password logmn" href="<c:url value='/findpassword.do'/>">비밀번호 찾기</a></li>
            <li>|</li>
            <li><a class="register logmn" href="<c:url value='login.do'/>">로그인</a></li>
          </ul>
     </c:if>
     <div class="error_box">
     ${errors}
     <c:if test="${not empty errors}">
		<p class="findid_regi">${errors}</p>
	    <p class="findid_regi"><a href="<c:url value='register.do'/>">회원가입</a>으로 이동하시겠습니까?</p>
	</c:if>
    </div>
	</div>
    </div>
    	  <c:if test="${empty result}">
    <div class= "inputbox">
    <div class= "input_center">
      <form id="addForm" name="addForm"action="/findidProcess.do" method="post">
		<div class="form-group ">
		    <p class="input_name">이름</p>
		    <input type="text" class="form-control"
            		           id="username"
            		           name="username"							
						       placeholder="사용자 이름"  />
		</div>
		<div class="form-group">
		    <p class="input_name">전화번호</p>
			<input type="text" class="form-control"
            		               id="phonenum"
            		               name="phonenum"										
								   placeholder="휴대폰 번호('-'빼고 입력하시오)"  />
		</div>
		<div>
				<button class ="btn mt1">Search</button>
		</div>
      </form>
       </div>
     </div>
      </c:if>
   </div>
</div>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<!-- 유효성체크 플러그인 -->
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.21.0/dist/jquery.validate.min.js"></script>
<script src="/js/auth/findid-validation-config.js"></script>


<!-- 꼬리말 -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>