<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="now" class="java.util.Date" scope="page" />
<!DOCTYPE html>
<html>
<head>
  <title>QnA 상세</title>
  <!-- Bootstrap, 스타일, 스타일2, 커뮤니티 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/exstyle.css">
  <link rel="stylesheet" href="/css/Community.css">
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- 공통 헤더 include -->
<jsp:include page="/common/header.jsp" />

<div class="container mt-5">
  <h2 class="fw-bold mb-4">QnA 상세보기</h2>

  <!-- [1] 질문 수정 폴메인 -->
  <form id="updateForm" method="post" action="<c:url value='/qna/update.do'/>" enctype="multipart/form-data">
    <input type="hidden" name="uuid" value="${qna.uuid}">

    <!-- 메시지 가능하면 표시 -->
    <c:if test="${not empty message}">
      <div class="alert alert-success">${message}</div>
    </c:if>

    <!-- 질문 컨트롤 데이터 표시 -->
    <div class="card">
      <div class="card-header position-relative">
        <!-- 제목 -->
        <h3 class="mb-0" id="view-title">${qna.qnaTitle}</h3>
        <!-- 수정 시 input -->
        <input type="text" class="form-control d-none" id="edit-title" name="qnaTitle" value="${qna.qnaTitle}">
        <small class="text-muted">
          ${fn:substring(qna.qnaCreatedAt, 2, 16)} · ${qna.userId} · 조회수 ${qna.count}
        </small>

        <!-- 로그인 사용자가 자신 문서일 경우 수정/삭제 버튼 표시 -->
        <c:if test="${not empty sessionScope.memberVO and sessionScope.memberVO.userId eq qna.userId}">
          <div class="button-box">
            <button type="button" class="btn btn-outline-danger btn-sm" id="delete-btn" onclick="submitDelete()">삭제</button>
            <button type="button" class="btn btn-sm edit-btn" id="edit-btn">수정</button>
          </div>
        </c:if>
      </div>

      <div class="card-body">
        <!-- 문서 이미지 보기 -->
        <div id="view-image">
          <c:if test="${not empty qna.qnaImage}">
            <img src="/qna/image.do?uuid=${qna.uuid}" class="img-fluid mb-3" alt="질문 이미지" />
          </c:if>
        </div>



        <!-- 이미지 수정 입력형 -->
        <div id="edit-image" class="d-none mb-3">
          <label class="form-label">이미지 변경</label>
          <input type="file" class="form-control" name="uploadFile" id="uploadFile" accept="image/*">
          <img id="qnaPreview" class="img-fluid mt-3" style="display:none;" alt="미리보기 이미지" />
        </div>

        <!-- 내용 -->
        <p class="card-text pre-line" id="view-content">${qna.qnaContent}</p>
        <textarea class="form-control d-none pre-line" id="edit-content" name="qnaContent">${qna.qnaContent}</textarea>

        <!-- 저장/취소 버튼 -->
        <div class="mt-3 d-none" id="edit-buttons">
          <button type="submit" class="btn btn-success btn-sm" id="save-btn">저장</button>
          <button type="button" class="btn btn-secondary btn-sm" id="cancel-btn">취소</button>
        </div>
      </div>
    </div>
  </form>

  <!-- [2] 답변 영역 -->
  <div class="card mt-4">
    <div class="card-header position-relative">
      <h3 class="mb-0">답변</h3>
      <small class="text-muted">
        ${fn:substring(qna.answerCreatedAt, 2, 16)} · ${qna.answerNickname}
      </small>
      <!-- 답변 작성/수정 버튼 -->
      <c:choose>
        <c:when test="${empty qna.answerContent and not empty sessionScope.memberVO}">
          <div class="button-box">
            <button class="btn btn-sm btn-outline-primary" onclick="toggleAnswerEdit()">작성</button>
          </div>
        </c:when>
        <c:when test="${not empty qna.answerContent and sessionScope.memberVO.userId eq qna.answerUserId}">
          <div class="button-box">
            <button class="btn btn-sm btn-outline-primary" onclick="toggleAnswerEdit()">수정</button>
          </div>
        </c:when>
      </c:choose>
    </div>
    <div class="card-body">
      <!-- 답변 이미지 -->
      <c:if test="${not empty qna.answerImage}">
        <div id="answerImageView">
          <img src="/qna/image.do?uuid=${qna.uuid}&answer=true" class="img-fluid mb-3" alt="답변 이미지" />
        </div>
      </c:if>

      <!-- 답변 보기 경우 -->
      <div id="answerView" class="mt-2">
        <c:choose>
          <c:when test="${empty qna.answerContent}">
            <p class="text-muted">아직 답변이 등록되지 않았습니다.</p>
          </c:when>
          <c:otherwise>
            <p class="pre-line">${qna.answerContent}</p>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- 답변 작성/수정 form -->
      <form id="answerEditForm" method="post"
      action="<c:url value='${empty qna.answerContent ? "/qna/answer/add.do" : "/qna/answer/update.do"}'/>"
      enctype="multipart/form-data" style="display: none;">
  
  <!-- 답변 UUID -->
  <input type="hidden" name="uuid" value="${qna.uuid}">

  <!-- 답변 이미지 업로드 -->
  
  <div class="mb-3">
  <label class="form-label">답변 이미지</label>
  <input class="form-control" type="file" name="answerUploadFile" id="answerUploadFile" accept="image/*">
  <img id="answerPreview" class="img-fluid mt-3" style="display: none;" alt="답변 미리보기 이미지" />
</div>

  <!-- 답변 텍스트 입력 -->
  <div class="mb-2">
    <label class="form-label">답변 내용</label>
    <textarea class="form-control" name="answerContent" rows="4">${qna.answerContent}</textarea>
  </div>

  <button type="submit" class="btn btn-success btn-sm">저장</button>
  <button type="button" class="btn btn-secondary btn-sm" onclick="toggleAnswerEdit()">취소</button>
</form>
    </div>
  </div>

  <!-- [3] 댓글 영역 -->
  <form id="deleteForm" method="post" action="<c:url value='/qna/delete.do'/>">
    <input type="hidden" name="uuid" value="${qna.uuid}" />
  </form>

  <div class="card mt-4" id="comment-area">
    <div class="card-header">
      <h5 class="mb-0">댓글</h5>
    </div>
    <div class="card-body" id="commentListArea">
      <!-- Ajax 로드 -->
    </div>
  </div>

  <!-- [4] 목록보기 버튼 -->
  <a href="<c:url value='/qna/qna.do'/>" class="btn btn-secondary mt-3">목록으로</a>
</div>

<jsp:include page="/common/footer.jsp" />
<script>
  const editBtn = document.getElementById('edit-btn');
  const saveBtn = document.getElementById('save-btn');
  const cancelBtn = document.getElementById('cancel-btn');
  const deleteBtn = document.getElementById('delete-btn');

  const viewTitle = document.getElementById('view-title');
  const editTitle = document.getElementById('edit-title');

  const viewContent = document.getElementById('view-content');
  const editContent = document.getElementById('edit-content');

  const viewImage = document.getElementById('view-image');
  const editImage = document.getElementById('edit-image');

  const editButtons = document.getElementById('edit-buttons');
  const commentArea = document.getElementById('comment-area');

  if (editBtn) {
    editBtn.addEventListener('click', function () {
      viewTitle.classList.add('d-none');
      editTitle.classList.remove('d-none');
      viewContent.classList.add('d-none');
      editContent.classList.remove('d-none');
      viewImage.classList.add('d-none');
      editImage.classList.remove('d-none');
      editBtn.classList.add('d-none');
      editButtons.classList.remove('d-none');
      commentArea.classList.add('d-none');
      if (deleteBtn) deleteBtn.classList.add('d-none');
    });
  }

  if (cancelBtn) {
    cancelBtn.addEventListener('click', function () {
      viewTitle.classList.remove('d-none');
      editTitle.classList.add('d-none');
      viewContent.classList.remove('d-none');
      editContent.classList.add('d-none');
      viewImage.classList.remove('d-none');
      editImage.classList.add('d-none');
      editBtn.classList.remove('d-none');
      editButtons.classList.add('d-none');
      commentArea.classList.remove('d-none');
      if (deleteBtn) deleteBtn.classList.remove('d-none');
    });
  }

  function submitDelete() {
    if (confirm('정말 삭제하시겠습니까?')) {
      document.getElementById('deleteForm').submit();
    }
  }

  function toggleAnswerEdit() {
	  const form = document.getElementById("answerEditForm");
	  const view = document.getElementById("answerView");
	  const image = document.getElementById("answerImageView");

	  const textarea = form.querySelector("textarea[name='answerContent']");
	  if (form.style.display === "none") {
	    // 열기: 원래 내용 세팅
	    textarea.value = '${qna.answerContent}';
	    form.style.display = "block";
	    if (view) view.style.display = "none";
	    if (image) image.style.display = "none";
	  } else {
	    // 닫기
	    form.style.display = "none";
	    if (view) view.style.display = "block";
	    if (image) image.style.display = "block";
	  }
	}


  // 댓글 Ajax 로딩
  $(function () {
    const uuid = '${qna.uuid}';
    $("#commentListArea").load("/comment/list.do", {
      uuid: uuid,
      targetType: 'qna',
      pageIndex: 1
    });
  });

  // 질문 이미지 미리보기
  document.getElementById("uploadFile")?.addEventListener("change", function (e) {
    const file = e.target.files[0];
    const preview = document.getElementById("qnaPreview");
    if (file && preview) {
      const reader = new FileReader();
      reader.onload = function (event) {
        preview.src = event.target.result;
        preview.style.display = "block";
      };
      reader.readAsDataURL(file);
    }
  });

  // 답변 이미지 미리보기
  document.getElementById("answerUploadFile")?.addEventListener("change", function (e) {
    const file = e.target.files[0];
    const preview = document.getElementById("answerPreview");
    if (file && preview) {
      const reader = new FileReader();
      reader.onload = function (event) {
        preview.src = event.target.result;
        preview.style.display = "block";
      };
      reader.readAsDataURL(file);
    }
  });
</script>
</body>
</html>
