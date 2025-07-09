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
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div class="container mt-5">

  <!-- ✅ 수정용 form -->
  <form id="updateForm" method="post" action="<c:url value='/community/update.do'/>" enctype="multipart/form-data">
    <input type="hidden" name="uuid" value="${community.uuid}">

    <c:if test="${not empty message}">
      <div class="alert alert-success">${message}</div>
    </c:if>

    <div class="card">
      <div class="card-header position-relative">
        <!-- 제목 -->
        <h3 class="mb-0" id="view-title">${community.communityTitle}</h3>
        <input type="text" class="form-control d-none" id="edit-title" name="communityTitle" value="${community.communityTitle}">
        <small class="text-muted">
          ${fn:substring(community.communityCreatedAt, 2, 16)} · ${community.userId}
        </small>

        <!-- ✅ 수정/삭제 버튼 묶음 -->
        <div class="button-box">
        <form id="deleteForm" method="post" action="...">
          <button type="button" class="btn btn-outline-danger btn-sm" onclick="submitDelete()">삭제</button>
          </form>
          <button type="button" class="btn btn-sm edit-btn" id="edit-btn">수정</button>
        </div>
      </div>

      <div class="card-body">
        <!-- 이미지 출력 -->
        <div id="view-image">
          <c:if test="${not empty community.communityImage}">
            <img src="/community/image.do?uuid=${community.uuid}" class="img-fluid mb-3" alt="첨부 이미지" />
          </c:if>
        </div>

        <!-- 이미지 수정 -->
        <div id="edit-image" class="d-none mb-3">
          <label class="form-label">이미지 변경</label>
          <input type="file" class="form-control" name="uploadFile">
        </div>

        <!-- 내용 -->
        <p class="card-text pre-line" id="view-content">${community.communityContent}</p>
        <textarea class="form-control d-none pre-line" id="edit-content" name="communityContent">${community.communityContent}</textarea>

        <!-- 저장/취소 버튼 -->
        <div class="mt-3 d-none" id="edit-buttons">
          <button type="submit" class="btn btn-success btn-sm" id="save-btn">저장</button>
          <button type="button" class="btn btn-secondary btn-sm" id="cancel-btn">취소</button>
        </div>
      </div>
    </div>
  </form>

  <!-- ✅ 삭제용 숨겨진 form -->
  <form id="deleteForm" method="post" action="<c:url value='/community/delete.do'/>">
    <input type="hidden" name="uuid" value="${community.uuid}" />
  </form>

  <!-- 댓글 영역 -->
  <div id="comment-area">
    <div class="mb-3 mt-4">
      <h5>댓글</h5>
      <c:set var="allComments" value="${sessionScope.allComments}" />
      <c:set var="commentList" value="${allComments[community.uuid]}" />
      <c:if test="${not empty commentList}">
        <c:forEach var="reply" items="${commentList}">
          <div class="comment-box border rounded p-2 mb-2">
            <strong>${reply.writer}</strong>
            <small class="text-muted float-end">
              ${fn:substring(fn:replace(reply.timestamp, 'T', ' '), 2, 16)}
            </small>
            <div>${reply.content}</div>
          </div>
        </c:forEach>
      </c:if>
    </div>

    <!-- 댓글 작성 -->
    <form method="post" action="/community/commentInsert.do" class="mb-4">
      <input type="hidden" name="uuid" value="${community.uuid}" />
      <input type="text" name="writer" class="form-control mb-2" placeholder="작성자" required />
      <textarea name="content" class="form-control mb-2" placeholder="댓글 내용" required></textarea>
      <button type="submit" class="btn btn-outline-primary">댓글 등록</button>
    </form>
   <!-- 좋아요 버튼 영역 -->
<div style="display:inline;">
 <button type="button" id="like-button" class="btn btn-outline-danger btn-sm">
  ♥ 좋아요 <span id="like-count">${community.communityLikeCount}</span>
</button>
  <input type="hidden" id="community-uuid" value="${community.uuid}" />
</div>
    

    <a href="<c:url value='/community/community.do'/>" class="btn btn-secondary">목록으로</a>
  </div>

</div>

<jsp:include page="/common/footer.jsp" />

<!-- ✅ 수정/취소 버튼 JS -->
<script>
  const editBtn = document.getElementById('edit-btn');
  const saveBtn = document.getElementById('save-btn');
  const cancelBtn = document.getElementById('cancel-btn');

  const viewTitle = document.getElementById('view-title');
  const editTitle = document.getElementById('edit-title');

  const viewContent = document.getElementById('view-content');
  const editContent = document.getElementById('edit-content');

  const viewImage = document.getElementById('view-image');
  const editImage = document.getElementById('edit-image');

  const editButtons = document.getElementById('edit-buttons');
  const commentArea = document.getElementById('comment-area');

  const deleteBtn = document.querySelector('#deleteForm button'); // ✅ 삭제 버튼 선택

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

    // ✅ 삭제 버튼 숨김
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

    // ✅ 삭제 버튼 다시 표시
    if (deleteBtn) deleteBtn.classList.remove('d-none');
  });

  function submitDelete() {
    if (confirm('정말 삭제하시겠습니까?')) {
      document.getElementById('deleteForm').submit();
    }
  }

  // ✅ 좋아요 버튼 처리
  document.getElementById("like-button").addEventListener("click", function () {
    const uuid = document.getElementById("community-uuid").value;

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
        const countSpan = document.getElementById("like-button");
        const count = parseInt(result);
        countSpan.innerHTML = `♥ 좋아요 ${count}`; // 버튼 내부로 숫자 업데이트
      }
    })
    .catch(error => console.error("좋아요 요청 실패:", error));
  });
</script>

</body>
</html>
