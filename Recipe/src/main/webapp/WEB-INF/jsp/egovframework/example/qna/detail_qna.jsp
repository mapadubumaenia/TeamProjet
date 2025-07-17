<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <title>게시글 상세</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/exstyle.css">
  <link rel="stylesheet" href="/css/Community.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div class="container mt-5">
    <h2 class="fw-bold mb-4">QnA 상세보기</h2>

    <!-- 본문 정보 -->
    <div class="mb-3">
        <h4 class="fw-semibold">${qna.qnaTitle}</h4>
        <div class="text-muted small">
            작성자: <strong>${qna.userNickname}</strong> |
            작성일: ${qna.qnaCreatedAt} |
            조회수: ${qna.count}
        </div>
    </div>

    <!-- 본문 내용 -->
    <div class="border p-4 rounded bg-light mb-3">
        <p style="white-space:pre-line;">${qna.qnaContent}</p>
        <c:if test="${qna.qnaImage != null}">
            <div class="mt-3">
                <img src="/qna/image.do?uuid=${qna.uuid}" class="img-fluid rounded" alt="QnA 이미지"/>
            </div>
        </c:if>
    </div>

    <!-- 수정/삭제 버튼 (작성자 본인일 경우만 노출) -->
    <c:if test="${sessionScope.memberVO != null && sessionScope.memberVO.userId == qna.userId}">
        <div class="mb-4">
            <a href="/qna/editForm.do?uuid=${qna.uuid}" class="btn btn-outline-primary me-2">수정</a>
            <form action="/qna/delete.do" method="post" style="display:inline;">
                <input type="hidden" name="uuid" value="${qna.uuid}" />
                <button type="submit" class="btn btn-outline-danger"
                        onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
            </form>
        </div>
    </c:if>

 <!-- 답변 영역 -->
<c:if test="${not empty qna.answerContent}">
    <div class="border rounded p-3 mb-4 bg-white">
        <h5 class="fw-bold">답변</h5>
        <div class="text-muted small mb-2">
            답변자: <strong>${qna.answerNickname}</strong> |
            작성일: ${qna.answerCreatedAt}
        </div>

        <!-- 답변 내용 표시 -->
        <div id="answerView" style="white-space:pre-line;">${qna.answerContent}</div>

        <c:if test="${qna.answerImage != null}">
            <div class="mt-3" id="answerImageView">
                <img src="/qna/image.do?uuid=${qna.uuid}&answer=true" class="img-fluid rounded" alt="답변 이미지"/>
            </div>
        </c:if>

        <!-- 수정 폼: 기본 숨김 -->
        <c:if test="${sessionScope.memberVO != null && sessionScope.memberVO.userId == qna.answerUserId}">
            <div class="mt-3">
                <button type="button" class="btn btn-outline-secondary" onclick="toggleAnswerEdit()">답변 수정</button>
            </div>

            <form id="answerEditForm" action="/qna/updateAnswer.do" method="post" enctype="multipart/form-data" class="mt-3" style="display:none;">
                <input type="hidden" name="uuid" value="${qna.uuid}" />
                <div class="mb-2">
                    <textarea name="answerContent" class="form-control" rows="4" required>${qna.answerContent}</textarea>
                </div>
                <div class="mb-2">
                    <input type="file" name="uploadFile" accept="image/*" class="form-control">
                </div>
                <button type="submit" class="btn btn-primary">수정 완료</button>
            </form>
        </c:if>
    </div>
</c:if>


    <!-- 답변 작성 영역 (답변이 없고, 로그인한 경우만 표시) -->
    <c:if test="${empty qna.answerContent && sessionScope.memberVO != null}">
        <div class="border rounded p-4 bg-light">
            <h5 class="fw-bold mb-3">답변 작성</h5>
            <form action="/qna/answer.do" method="post" enctype="multipart/form-data">
                <input type="hidden" name="uuid" value="${qna.uuid}" />
                <div class="mb-3">
                    <textarea name="answerContent" class="form-control" rows="5" placeholder="답변을 입력하세요." required></textarea>
                </div>
                <div class="mb-3">
                    <input type="file" name="uploadFile" accept="image/*" class="form-control">
                </div>
                <button type="submit" class="btn btn-primary">답변 등록</button>
            </form>
        </div>
    </c:if>
</div>

  <!-- 댓글 영역 -->
  <div id="comment-area" class="mb-3 mt-4">
    <h5>댓글</h5>
    <!-- Ajax로 댓글 목록 + 등록/답글 UI를 list.jsp에서 로딩 -->
    <div id="commentListArea"></div>
  </div>



<jsp:include page="/common/footer.jsp" />

</body>
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
      viewTitle?.classList.add('d-none');
      editTitle?.classList.remove('d-none');
      viewContent?.classList.add('d-none');
      editContent?.classList.remove('d-none');
      viewImage?.classList.add('d-none');
      editImage?.classList.remove('d-none');
      editBtn.classList.add('d-none');
      editButtons?.classList.remove('d-none');
      commentArea?.classList.add('d-none');
      if (deleteBtn) deleteBtn.classList.add('d-none');
    });
  }

  if (cancelBtn) {
    cancelBtn.addEventListener('click', function () {
      viewTitle?.classList.remove('d-none');
      editTitle?.classList.add('d-none');
      viewContent?.classList.remove('d-none');
      editContent?.classList.add('d-none');
      viewImage?.classList.remove('d-none');
      editImage?.classList.add('d-none');
      editBtn?.classList.remove('d-none');
      editButtons?.classList.add('d-none');
      commentArea?.classList.remove('d-none');
      if (deleteBtn) deleteBtn.classList.remove('d-none');
    });
  }

  function submitDelete() {
    if (confirm('정말 삭제하시겠습니까?')) {
      document.getElementById('deleteForm')?.submit();
    }
  }

  function toggleAnswerEdit() {
    const form = document.getElementById("answerEditForm");
    const view = document.getElementById("answerView");
    const image = document.getElementById("answerImageView");

    if (form?.style.display === "none") {
      form.style.display = "block";
      if (view) view.style.display = "none";
      if (image) image.style.display = "none";
    } else {
      form.style.display = "none";
      if (view) view.style.display = "block";
      if (image) image.style.display = "block";
    }
  }

  // ✅ 댓글 Ajax 로딩
  $(function () {
    const uuid = '${qna.uuid}';
    const targetType = 'community';

    $("#commentListArea").load("/comment/list.do", {
      uuid: uuid,
      targetType: targetType,
      pageIndex: 1
    });
  });
</script>

