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
       <a class="register_home" href="<c:url value='main.do'/>">RecipeCode</a>
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

      <form id="addForm" name="addForm"action="/registeraddition.do" method="post"  enctype="multipart/form-data">
		 	<div class="profile">
         <div class="form-group">
         <img id="previewImage" src="/images/default_profile.jpg" 
          alt="미리보기" width="70" height="70" 
          style="object-fit: cover; border: 1px solid #ccc; border-radius: 50%;" />
          </div>
		  <div class="form-group file_select">
          <input type="file"
                 class="form-control"
                 id="image"
                 name="image"
                 >
          </div>
          </div>
	    <div class="input-group">
             <input type="text" class="form-control"
             	               id="userId"
            		           name="userId"
                               placeholder="아이디"
                               aria-label="userId" aria-describedby="button-addon2">
             <button class="btn btn-outline-secondary" onclick="checkid()" type="button" id="button-addon2">중복확인</button>
        </div>
        <div id="id-check-result" class="form-text"></div>
        <div class="input-group">
             <input type="text" class="form-control"
             	               id="nickname"
            		           name="nickname"
                               placeholder="사용자별명"
                               aria-label="nickname" aria-describedby="button-addon2">
             <button class="btn btn-outline-secondary" onclick="checknickname()" type="button" id="button-addon2">중복확인</button>
        </div>
        <div id="nickname-check-result" class="form-text"></div>
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
				<button class ="regibtn">Register</button>
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

<!-- 미리보기기능 -->
<script>
  document.getElementById("image").addEventListener("change", function (event) {
    const file = event.target.files[0];
    const preview = document.getElementById("previewImage");

    if (file) {
      const reader = new FileReader();

      reader.onload = function (e) {
        preview.src = e.target.result; // base64로 바꿔서 미리보기에 표시
      };

      reader.readAsDataURL(file); // 파일 → base64 변환 시작
    } else {
      preview.src = "/images/default_profile.jpg"; // 선택 안 했을 경우 기본 이미지
    }
  });
</script>

<!--아이디 중복확인 -->
<script>
function checkid() {
    const userId = document.getElementById('userId').value.trim();
    const resultElement = document.getElementById('id-check-result');
    
//  아이디입력X
    if (!userId) {
        resultElement.textContent = '아이디를 입력해주세요.';
        resultElement.style.color = 'red';
        return;
    }
    
    
//  글자수 제한
     if (userId.length < 4) {
        resultElement.textContent = '아이디는 4자 이상이어야 합니다.';
        resultElement.style.color = 'red';
        return;
    }
    
//  중복확인
    fetch('/checkUserId.do?userid=' + encodeURIComponent(userId))
    .then(response => response.json())
    .then(data => {
            if (data.exists) {
                resultElement.textContent = '이미 사용 중인 아이디입니다.';
                resultElement.style.color = 'red';
            } else {
                resultElement.textContent = '사용 가능한 아이디입니다.';
                resultElement.style.color = 'green';
            }
        })
        .catch(error => {
            console.error('오류 발생:', error);
            resultElement.textContent = '중복 확인 중 오류가 발생했습니다.';
            resultElement.style.color = 'red';
        });
}
</script>

<!--별명 중복확인 -->
<script>
function checknickname() {
    const nickname = document.getElementById('nickname').value.trim();
    const resultElement = document.getElementById('nickname-check-result');
    
//  아이디입력X
    if (!nickname) {
        resultElement.textContent = '별명을 입력해주세요.';
        resultElement.style.color = 'red';
        return;
    }
    
    
//  글자수 제한
     if (nickname.length < 2) {
        resultElement.textContent = '별명은 2자 이상이어야 합니다.';
        resultElement.style.color = 'red';
        return;
    }
    
    //금지어
     if (containsForbiddenWord(nickname)) {
    	    resultElement.textContent = '금지어가 포함된 별명은 사용할 수 없습니다.';
    	    resultElement.style.color = 'red';
    	    return false;
    	  }
//  중복확인
    fetch('/checkNickname.do?nickname=' + encodeURIComponent(nickname))
    .then(response => response.json())
    .then(data => {
            if (data.exists) {
                resultElement.textContent = '이미 사용 중인 별명입니다.';
                resultElement.style.color = 'red';
            } else {
                resultElement.textContent = '사용 가능한 별명입니다.';
                resultElement.style.color = 'green';
            }
        })
        .catch(error => {
            console.error('오류 발생:', error);
            resultElement.textContent = '중복 확인 중 오류가 발생했습니다.';
            resultElement.style.color = 'red';
        });
}

function containsForbiddenWord(nickname) {
	  // 정규표현식 기반 유사 욕설 필터
	  const forbiddenPatterns = [
	    /시[\s\W_]*[ㅂb1i!l][\s\W_]*[ㅏa@][\s\W_]*[ㄹr]/i,       
	    /ㅅ[\s\W_]*[ㅂb1i!l]/i,                                 
	    /병[\s\W_]*[ㅅs]/i,                                
	    /ㅂ[\s\W_]*[ㅅs]/i,                                     
	    /fuck|f[\s\W_]*u[\s\W_]*c[\s\W_]*k/i,             
	    /shit|s[\s\W_]*h[\s\W_]*i[\s\W_]*t/i,                   
	    /좆|좇|자지|보지|딸딸이/i,                              
	    /개새[\s\W_]*끼/i                                      
	  ];

	  return forbiddenPatterns.some(pattern => pattern.test(nickname));
	}
</script>

<!-- 꼬리말 -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>