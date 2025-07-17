<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RecipeCode</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 파비콘 추가 -->
    <link rel="icon" href="/images/01.png" type="image/png">
    <!--     부트스트랩 css  -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!--     개발자 css -->
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/exstyle.css">
    <link rel="stylesheet" href="/css/mypagestyle.css">
    <link rel="stylesheet" href="/css/mypost.css">
</head>
<body>
<!-- 머리말 -->
<jsp:include page="/common/header.jsp" />

<!-- 본문 -->
<div class="page mt5">

<div class="mymenu">
<div class="accordion" id="accordionExample">

  <div class="accordion-item">
    <h2 class="accordion-header" id="headingOne">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
        레시피
      </button>
    </h2>
    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <button class = "my_btn" onclick="loadMyRecipes()">내가 쓴 레시피</button><br>
        <button class = "my_btn btn_content">스크랩</button><br>
        <button class = "my_btn btn_content">좋아요</button>
      </div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingTwo">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
        댓글
      </button>
    </h2>
    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <button class = "my_btn ">내가 쓴 댓글</button><br>
        <button class = "my_btn btn_comment">좋아요</button>
      </div>
    </div>
  </div>
    <div class="accordion-item">
    <h2 class="accordion-header" id="headingThree">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
        <strong>회원정보</strong>
      </button>
    </h2>
    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <button class = "my_btn btn_info" onclick="passforedit()" >조회 / 수정</button>
      </div>
    </div>
  </div>
</div>
 <div id="myPageContent" class="myPageContent">
   <c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
  </c:if>
 
 </div>
</div>




</div>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<!-- 토글 애니메이션 js -->
<script src="/js/nav.js"></script>	
	
	
<!-- AJAX용 -->
<!-- 내가 작성한 레시피 -->
<script>   
function loadMyRecipes() {
  fetch('/mypage/myrecipes.do')
    .then(res => res.text())
    .then(html => {
      document.getElementById("myPageContent").innerHTML = html;
    });
}
</script>

<!-- 개인정보 조회 및 수정 -->
<script>  
let passwordModal;

function passforedit() {
  // 모달 열기
  $("#checkPasswordInput").val("");
  $("#pwError").hide();
  
  passwordModal = new bootstrap.Modal(document.getElementById('passwordCheckModal'));
  passwordModal.show();
}

 
function confirmPassword() {
  const password = $("#checkPasswordInput").val();

  $.ajax({
    type: "POST",
    url: "/mypage/checkPassword.do",
    data: { password: password },
    success: function(response) {
    	passwordModal.hide();
    	
    	
      if (response === "success") {
    	  fetch('/mypage/updateForm.do')
    	    .then(res => res.text())
    	    .then(html => {
    	      document.getElementById("myPageContent").innerHTML = html;
    	    
    	      setTimeout(() => {
                  bindImagePreview();
                }, 100); 
    	    });
      }
    },
    error: function(xhr) {
            if (xhr.status === 400 && xhr.responseText === "wrongPassword") {
                $("#pwError").show();
            } else if (xhr.status === 401 && xhr.responseText === "notLoggedIn") {
                alert("로그인이 필요합니다.");
                location.href = "/login.do";
            } else {
                alert("예상치 못한 오류가 발생했습니다.");
            }
        }
  });
}
</script>
<!-- 이미지 미리보기 -->
<script>

document.addEventListener("submit", function (e) {
	  console.log("📨 submit 이벤트 발생");
	}, true);

  document.addEventListener("DOMContentLoaded", function () {

    const fileInput = document.getElementById("image");
    const previewImage = document.getElementById("previewImage");

    fileInput.addEventListener("change", function (event) {
      const file = event.target.files[0];

      if (file) {
        const reader = new FileReader();
        reader.onload = function (e) {
    
          previewImage.src = e.target.result;
        };
        reader.readAsDataURL(file);
      } else {
        previewImage.src = "/mypage/profile-image.do";
      }
    });
  });
  
  function bindImagePreview() {

	  
	    const fileInput = document.getElementById("image");
	    const previewImage = document.getElementById("previewImage");

	    console.log("fileInput:", fileInput);
	    console.log("previewImage:", previewImage);
	    
	    if (!fileInput || !previewImage){ 
	        console.warn("fileInput 또는 previewImage가 null입니다.");
	    	return;
	    }
	    fileInput.addEventListener("change", function (event) {
	      const file = event.target.files[0];

	      if (file) {
	        const reader = new FileReader();
	        reader.onload = function (e) {
	        	console.log("미리보기 변경:", e.target.result);
	          previewImage.src = e.target.result;
	        };
	        reader.readAsDataURL(file);
	      } else {
	        previewImage.src = "/mypage/profile-image.do";
	      }
	    });
	  }
</script>

<!-- 꼬리말 -->
<jsp:include page="/common/footer.jsp" />

<!-- 비밀번호 확인 모달 -->
<div class="modal fade" id="passwordCheckModal" tabindex="-1" aria-labelledby="passwordCheckModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content p-3">
      <div class="modal-header">
        <h5 class="modal-title" id="passwordCheckModalLabel">비밀번호 확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <input type="password" class="form-control" id="checkPasswordInput" placeholder="비밀번호 입력">
        <div id="pwError" class="text-danger mt-2" style="display:none;">비밀번호가 일치하지 않습니다.</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="confirmPassword()">확인</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>