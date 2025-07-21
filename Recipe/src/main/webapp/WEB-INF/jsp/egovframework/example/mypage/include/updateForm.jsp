<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container mt-4">
  <h2>회원 정보 수정</h2>

  <c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
  </c:if>
<div class="informpage">
  <div class="informbox">
  <form id="addForm" name="addForm" action="/mypage/updateMember.do" method="post" enctype="multipart/form-data">
  <div class="profile edit_box mb-3">
         <div class="form-group edit_box">
         <img id="previewImage" src="/member/profile-image.do" 
          alt="미리보기" width="100" height="100" 
          style="object-fit: cover; border: 1px solid #ccc; border-radius: 50%;" />
          </div>
		  <div class="form-group file_select edit_box">
          <input type="file"
                 class="form-control edittext_box"
                 id="image"
                 name="image"
                 >
          </div>
   </div>
    <div class="mb-3 edit_box">
 <label for="userId" class="form-label">아이디</label>
      <input type="text" class="form-control edittext_box" id="userId" name="userId" value="${memberVO.userId}" readonly>
    </div>

    <div class="mb-3 edit_box">
      <label for="userName" class="form-label">이름</label>
      <input type="text" class="form-control edittext_box" id="userName" name="userName" value="${memberVO.userName}" readonly>
    </div>
        <div class="form-group edit_box">
         <label for="userNickname" class="form-label">닉네임</label>
        </div>
        <div class="input-group edit_box mb-3">
             <input type="text" class="form-control"
             	               id="nickname"
            		           name="nickname"
                               placeholder="사용자별명"
                               value="${memberVO.nickname}"
                               aria-label="nickname"
                               aria-describedby="button-addon2">
             <button class="btn btn-outline-secondary btn_confirm btn_nick" onclick="checknickname()" type="button" id="button-addon2">중복확인</button>
        </div>
        <div id="nickname-check-result" class="form-text"></div>
        
		<div class="form-group edit_box mb-3">
		      <label for="password" class="form-label">새 비밀번호</label>
			<input type="password" class="form-control edittext_box"
            		               id="password"
            		               name="password"										
								   placeholder="변경시에만 입력"  />
		</div>
		<div class="form-group edit_box mb-3">
		      <label for="repassword" class="form-label">비밀번호확인</label>
			<input type="password" class="form-control edittext_box"
            		               id="repassword"
            		               name="repassword"										
								   placeholder="비밀번호 확인"  />
		</div>
		<div class="form-group edit_box mb-3">
		      <label for="phoneNum" class="form-label">전화번호</label>
			<input type="text" class="form-control edittext_box"
            		            id="phoneNum"
            		            name="phoneNum"
            		            value="${memberVO.phoneNum}"								
							    placeholder="휴대폰 번호('-'빼고입력하시오)" required  />
		</div>
		<div class="mb-3 edit_box">
             <label for="email" class="form-label">이메일</label>
             <input type="email" class="form-control edittext_box" 
                                 id="email" name="email" 
                                 value="${memberVO.email}" required>
        </div>
 	    <div class="form-group edit_box">
		<button type="submit" class="btn btn-primary btn_confirm">수정</button>
        </div>
		</div>
     </div>
     </form>
     <div class="removepage">
		 <h2>회원탈퇴</h2>
<div class="mt-4">
    <button type="button" class="btn btn-danger"  data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">회원 탈퇴</button>
</div>
  </div>
  </div>
  
  
<script>
function confirmDelete() {
    if (confirm("정말로 회원을 탈퇴하시겠습니까? 탈퇴 후 복구는 불가능합니다.")) {
        // POST 방식으로 탈퇴 요청
        fetch('/mypage/deleteMember.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: ''
        })
        .then(response => {
            if (response.redirected) {
                window.location.href = response.url;
            } else {
                alert("탈퇴에 실패했습니다.");
            }
        })
        .catch(() => alert("서버 오류로 탈퇴하지 못했습니다."));
    }
}
</script>

<!-- 탈퇴 확인 모달 -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content p-3">
      <div class="modal-header">
        <h5 class="modal-title text-danger" id="deleteConfirmModalLabel">회원 탈퇴 확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        정말로 탈퇴하시겠습니까?<br>
        탈퇴 시 회원님의 모든 정보는 삭제되며 복구할 수 없습니다.
      </div>
      <div class="modal-footer">
        <form action="/mypage/deleteMember.do" method="post">
          <button type="submit" class="btn btn-danger">탈퇴하기</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        </form>
      </div>
    </div>
  </div>
</div>