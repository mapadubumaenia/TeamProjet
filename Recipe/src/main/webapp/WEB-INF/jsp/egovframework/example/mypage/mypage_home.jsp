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
    <link rel="stylesheet" href="/css/informedit.css">
</head>
<body>


<!-- 머리말 -->
<jsp:include page="/common/header.jsp" />

<!-- 본문 -->
<div class="page mypage mt5">

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
        <button class = "my_btn btn_content" onclick="likedRecipes()">좋아요</button>
      </div>
    </div>
  </div>
    <div class="accordion-item">
    <h2 class="accordion-header" id="headingThree">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
       회원정보
      </button>
    </h2>
    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <button class = "my_btn" onclick="passforedit()" >조회 / 수정</button>
      </div>
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
<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
  <!-- jquery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 유효성체크 플러그인 -->
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.21.0/dist/jquery.validate.min.js"></script>
<!-- 토글 애니메이션 js -->
<script src="/js/nav.js"></script>	
<!-- 페이징 라이브러리 -->
<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>

<!-- AJAX용 -->
<!-- 내가 작성한 레시피 -->
<script>   
function loadMyRecipes(page = 1) {
  fetch(`/mypage/myrecipes.do?pageIndex=${'${page}'}`)
  .then(res => res.text())
  .then(html => {
    document.getElementById("myPageContent").innerHTML = html;

    const totalPages = parseInt(document.getElementById("totalPagesVal").value);
    const currentPage = parseInt(document.getElementById("currentPageVal").value);

    // 기존 페이징 제거
    if ($('#pagination').data('twbs-pagination')) {
      $('#pagination').twbsPagination('destroy');
    }

    if (totalPages >= 1) {
      $('#pagination').twbsPagination({
        totalPages: totalPages,
        startPage: currentPage,
        visiblePages: 5,
        first: null,
        last: null,
        prev: '<',
        next: '>',
        initiateStartPageClick: false,
        onPageClick: function (event, page) {
        	loadMyRecipes(page); // 재호출
        }
      });
    }
  });
}
</script>

<script>
/* 페이지번호 클릭시 전체조회 */
//좋아요누른 레시피  
function likedRecipes(page = 1) {
	  fetch(`/mypage/likedrecipes.do?pageIndex=${'${page}'}`)
	    .then(res => res.text())
	    .then(html => {
	      document.getElementById("myPageContent").innerHTML = html;

	      const totalPages = parseInt(document.getElementById("totalPagesVal").value);
	      const currentPage = parseInt(document.getElementById("currentPageVal").value);

	      // 기존 페이징 제거
	      if ($('#pagination').data('twbs-pagination')) {
	        $('#pagination').twbsPagination('destroy');
	      }

	      if (totalPages >= 1) {
	        $('#pagination').twbsPagination({
	          totalPages: totalPages,
	          startPage: currentPage,
	          visiblePages: 5,
	          first: null,
	          last: null,
	          prev: '<',
	          next: '>',
	          initiateStartPageClick: false,
	          onPageClick: function (event, page) {
	            likedRecipes(page); // 재호출
	          }
	        });
	      }
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
              bindFormValidation(); 
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
	  console.log("submit 이벤트 발생");
	}, true);

  document.addEventListener("DOMContentLoaded", function () {

    const fileInput = document.getElementById("image");
    const previewImage = document.getElementById("previewImage");
    
    if (fileInput && previewImage) {
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
    }
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


<script>
function bindFormValidation() {
$.validator.addMethod("pwRule", function(value, element) {
  return this.optional(element) || /^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{6,}$/.test(value);
	}, "＊비밀번호는 영문자와 숫자를 포함하여 6자 이상이어야 합니다.");

  $("#addForm").validate({
    rules: {
      password: {
        required: false,
        minlength: 6,
        maxlength: 15,
        pattern: /^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{6,}$/,
      },
      repassword: {
        required: false,
        minlength: 6,
        maxlength: 15,
        equalTo: "#password",
      },
      email: {
        required: true,
        email: true,
      },
      phoneNum: {
        required: true,
        digits: true,
      },
    },
    messages: {
      password: {
        required: "＊필수 입력 항목입니다.",
        minlength: "＊최소 {0}글자 이상 입력하세요.",
        maxlength: "＊최대 {0}글자 이하 입력하세요.",
        pattern: "＊비밀번호는 영문자와 숫자를 포함하여 입력하세요.",
      },
      repassword: {
        required: "＊필수 입력 항목입니다.",
        minlength: "＊최소 {0}글자 이상 입력하세요.",
        equalTo: "＊동일한 비밀번호를 입력해 주세요.",
      },
      email: {
        required: "＊필수 입력 항목입니다.",
        email: "＊올바른 이메일 형식으로 입력하세요.",
      },
      phoneNum: {
        required: "＊필수 입력 항목입니다.",
        digits: "＊반드시 숫자만 입력하세요.",
      },
    },
    submitHandler: function(form) {
      const formData = new FormData(form);
      $.ajax({
        url: $(form).attr("action"),
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
          alert("회원 정보가 성공적으로 수정되었습니다.");
          location.reload();
        },
        error: function(xhr) {
          alert("회원정보 수정 중 오류가 발생했습니다.");
          console.error(xhr.responseText);
        }
      });
    }
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
        resultElement.textContent = '아이디는 2자 이상이어야 합니다.';
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
        <button type="button" class="btn btn-primary btn_confirm" onclick="confirmPassword()">확인</button>
        <button type="button" class="btn btn-secondary btn_cancel" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>