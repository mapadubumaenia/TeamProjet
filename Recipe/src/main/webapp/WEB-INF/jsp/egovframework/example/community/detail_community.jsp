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
  <form id="answerEditForm" method="post"
      action="<c:url value='${empty qna.answerContent ? "/qna/answer/add.do" : "/qna/answer/update.do"}'/>"
      enctype="multipart/form-data" style="display: none;">
  <input type="hidden" name="uuid" value="${qna.uuid}">

  <!-- ✅ 답변 이미지 업로드 영역 -->
  <div class="mb-3">
    <label class="form-label">답변 이미지</label>
    <!-- ✅ name=uploadFile 반드시 일치해야 함 -->
    <input class="form-control" type="file" name="uploadFile" id="answerUploadFile" accept="image/*">
    <!-- ✅ 미리보기 이미지 -->
    <img id="answerPreview" class="img-fluid mt-3" style="display:none;" alt="답변 미리보기 이미지" />
  </div>

  <!-- 답변 텍스트 영역 -->
  <div class="mb-2">
    <label class="form-label">답변 내용</label>
    <textarea class="form-control" name="answerContent" rows="4">${qna.answerContent}</textarea>
  </div>

  <!-- 저장/취소 버튼 -->
  <button type="submit" class="btn btn-success btn-sm">저장</button>
  <button type="button" class="btn btn-secondary btn-sm" onclick="toggleAnswerEdit()">취소</button>
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
