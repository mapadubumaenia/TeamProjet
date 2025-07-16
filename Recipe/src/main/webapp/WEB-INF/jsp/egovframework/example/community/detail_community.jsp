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
  <!-- 수정용 form -->
  <form id="updateForm" method="post" action="<c:url value='/community/update.do'/>" enctype="multipart/form-data">
    <input type="hidden" name="uuid" value="${community.uuid}">

    <c:if test="${not empty message}">
      <div class="alert alert-success">${message}</div>
    </c:if>

    <div class="card">
      <div class="card-header position-relative">
        <h3 class="mb-0" id="view-title">${community.communityTitle}</h3>
        <input type="text" class="form-control d-none" id="edit-title" name="communityTitle" value="${community.communityTitle}">
        <small class="text-muted">
          ${fn:substring(community.communityCreatedAt, 2, 16)} · ${community.userId}
        </small>
        <div class="button-box">
          <button type="button" class="btn btn-outline-danger btn-sm" id="delete-btn" onclick="submitDelete()">삭제</button>
          <button type="button" class="btn btn-sm edit-btn" id="edit-btn">수정</button>
        </div>
      </div>

      <div class="card-body">
        <div id="view-image">
          <c:if test="${not empty community.communityImage}">
            <img src="/community/image.do?uuid=${community.uuid}" class="img-fluid mb-3" alt="찾부 이미지" />
          </c:if>
        </div>

        <div id="edit-image" class="d-none mb-3">
          <label class="form-label">이미지 변경</label>
          <input type="file" class="form-control" name="uploadFile">
        </div>

        <p class="card-text pre-line" id="view-content">${community.communityContent}</p>
        <textarea class="form-control d-none pre-line" id="edit-content" name="communityContent">${community.communityContent}</textarea>

        <div class="mt-3 d-none" id="edit-buttons">
          <button type="submit" class="btn btn-success btn-sm" id="save-btn">저장</button>
          <button type="button" class="btn btn-secondary btn-sm" id="cancel-btn">취소</button>
        </div>
      </div>
    </div>
  </form>

  <!-- 삭제용 form -->
  <form id="deleteForm" method="post" action="<c:url value='/community/delete.do'/>">
    <input type="hidden" name="uuid" value="${community.uuid}" />
  </form>

  <!-- 댓글 영역 -->
  <div id="comment-area" class="mb-3 mt-4">
    <h5>댓글</h5>
    <!-- Ajax로 댓글 목록 + 등록/답글 UI를 list.jsp에서 로딩 -->
    <div id="commentListArea"></div>
  </div>

  <!-- 좋아요 버튼 -->
  <div style="display:inline;">
    <button id="like-button" type="button" class="btn btn-outline-danger btn-sm">
      ♥ 좋아요 <span id="like-count">${community.communityLikeCount}</span>
    </button>
    <input type="hidden" id="community-uuid" value="${community.uuid}" />
  </div>

  <a href="<c:url value='/community/community.do'/>" class="btn btn-secondary">목록으로</a>
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

  function submitDelete() {
    if (confirm('정말 삭제하시겠습니까?')) {
      document.getElementById('deleteForm').submit();
    }
  }

  document.getElementById("like-button").addEventListener("click", function () {
    const uuid = document.getElementById("community-uuid").value;
    const countSpan = document.getElementById("like-count");

    fetch("<c:url value='/community/like.do'/>", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: "uuid=" + encodeURIComponent(uuid)
    })
    .then(response => response.text())
    .then(result => {
      if (!isNaN(result)) {
        const updatedCount = parseInt(result);
        countSpan.textContent = updatedCount;
      }
    })
    .catch(error => console.error("좋아요 요청 실패:", error));
  });

  // ✅ 댓글 Ajax 로딩
  $(function () {
    const uuid = '${community.uuid}';
    const targetType = 'community';

    $("#commentListArea").load("/comment/list.do", {
      uuid: uuid,
      targetType: targetType,
      pageIndex: 1
    });
  });
</script>

</body>
</html>
