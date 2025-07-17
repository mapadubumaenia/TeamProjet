<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>댓글 목록</title>
  <style>
    .reply-box { margin-left: 2rem; }
    .reply-input { margin-top: 5px; }
  </style>
</head>
<body>

<!-- 댓글이 없을 경우 -->
<c:if test="${empty commentList}">
  <p>등록된 댓글이 없습니다.</p>
</c:if>

<!-- 댓글 등록 영역 (최상위 댓글) -->
<c:if test="${not empty sessionScope.memberVO}">
  <div class="mb-3">
    <textarea id="main-comment-content" class="form-control" rows="3" placeholder="댓글을 입력하세요."></textarea>
    <button id="main-comment-submit" class="btn btn-primary mt-2">댓글 등록</button>
  </div>
</c:if>

<!-- 댓글 목록 출력 -->
<c:forEach var="comment" items="${commentList}">
  <div class="comment-box border rounded p-2 mb-2 ${comment.parentId != null ? 'reply-box' : ''}">
    <!-- 닉네임 + 작성일 -->
    <strong>${not empty comment.nickname ? comment.nickname : '탈퇴한 사용자'}</strong>
    <small class="text-muted float-end">${comment.createdAt}</small>

    <!-- 댓글 내용 -->
    <div class="comment-content mt-1" id="content-${comment.commentId}">
      ${comment.content}
    </div>

    <!-- 버튼 영역 -->
    <div class="comment-buttons mt-2">
      <c:if test="${sessionScope.memberVO.userid eq comment.userId}">
        <button class="btn btn-sm btn-secondary edit-btn" data-id="${comment.commentId}" data-content="${comment.content}">수정</button>
        <button class="btn btn-sm btn-success save-btn" data-id="${comment.commentId}" style="display: none;">등록</button>
        <button class="btn btn-sm btn-light cancel-btn" data-id="${comment.commentId}" style="display: none;">취소</button>
        <button class="btn btn-sm btn-danger delete-btn" data-id="${comment.commentId}">삭제</button>
      </c:if>
<c:if test="${not empty sessionScope.memberVO}">
  <c:set var="nicknameSafe" value="${empty comment.nickname ? '알수없음' : fn:trim(comment.nickname)}" />
  <button class="btn btn-sm btn-outline-primary reply-btn"
          data-id="${comment.commentId}" 
          data-nickname="${nicknameSafe}">
    답글
  </button>
</c:if>
    </div>

    <!-- 답글 입력창 -->
    <div class="reply-input mt-2" id="reply-box-${comment.commentId}" style="display: none;"></div>
  </div>
</c:forEach>

<!-- 댓글 처리 스크립트 -->
<script>
  // 삭제
  $(document).on("click", ".delete-btn", function () {
    const commentId = $(this).data("id");
    if (!confirm("댓글을 삭제하시겠습니까?")) return;
    $.post("/comment/delete.do", { commentId }, function (res) {
      if (res === "success") {
        alert("삭제되었습니다."); location.reload();
      } else alert("삭제 실패");
    });
  });

  // 수정 버튼 클릭
  $(document).on("click", ".edit-btn", function () {
    const commentId = $(this).data("id");
    const content = $(this).data("content");
    const commentBox = $(this).closest(".comment-box");
    const contentDiv = commentBox.find("#content-" + commentId);
    const textarea = $("<textarea>", {
      class: "form-control edit-content", rows: 2
    }).val(content);
    contentDiv.html(textarea);
    $(this).hide();
    commentBox.find(".save-btn, .cancel-btn").show();
  });

  // 수정 취소
  $(document).on("click", ".cancel-btn", function () {
    const commentId = $(this).data("id");
    const commentBox = $(this).closest(".comment-box");
    const originalContent = commentBox.find(".edit-btn").data("content");
    commentBox.find("#content-" + commentId).text(originalContent);
    commentBox.find(".save-btn, .cancel-btn").hide();
    commentBox.find(".edit-btn").show();
  });

  // 수정 등록
  $(document).on("click", ".save-btn", function () {
    const commentId = $(this).data("id");
    const commentBox = $(this).closest(".comment-box");
    const textarea = commentBox.find("textarea.edit-content");
    const newContent = textarea.val();
    const userId = "${sessionScope.memberVO.userid}";
    if (!newContent || newContent.trim() === "") {
      alert("내용을 입력해주세요.");
      return;
    }
    commentBox.find(".edit-btn").data("content", newContent);
    $.ajax({
      url: "/comment/update.do",
      type: "POST",
      contentType: "application/json",
      data: JSON.stringify({ commentId, content: newContent, userId }),
      success: function (res) {
        if (res === "success") {
          alert("수정되었습니다."); location.reload();
        } else if (res === "unauthorized") {
          alert("권한이 없습니다.");
        } else alert("수정 실패");
      }
    });
  });

  // 답글 버튼 → textarea + @닉네임
  $(document).on("click", ".reply-btn", function () {
    const parentId = $(this).data("id");
    const nickname = $(this).data("nickname");
    const replyBox = $("#reply-box-" + parentId);

    if (replyBox.children().length > 0) {
      replyBox.empty().hide();
      return;
    }

    const nicknameText = "@" + nickname + " ";
    const textarea = $("<textarea>", {
      class: "form-control", rows: 2
    }).val(nicknameText + " ");

    const submitBtn = $("<button>", {
      class: "btn btn-sm btn-primary mt-1",
      text: "등록"
    }).on("click", function () {
      const content = textarea.val();
      if (!content || content.trim() === "") {
        alert("내용을 입력해주세요.");
        return;
      }
      $.ajax({
        url: "/comment/insert.do",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
          uuid: "${param.uuid}",
          userId: "${sessionScope.memberVO.userid}",
          targetType: "community",
          content: content,
          parentId: parentId
        }),
        success: function (res) {
          if (res === "success") {
            alert("답글이 등록되었습니다."); location.reload();
          } else alert("등록 실패");
        }
      });
    });

    replyBox.empty().append(textarea).append(submitBtn).show();
  });

  // 일반 댓글 등록
  $("#main-comment-submit").on("click", function () {
    const content = $("#main-comment-content").val();
    if (!content || content.trim() === "") {
      alert("내용을 입력해주세요.");
      return;
    }

    $.ajax({
      url: "/comment/insert.do",
      type: "POST",
      contentType: "application/json",
      data: JSON.stringify({
        uuid: "${param.uuid}",
        userId: "${sessionScope.memberVO.userid}",
        targetType: "community",
        content: content,
        parentId: null
      }),
      success: function (res) {
        if (res === "success") {
          alert("댓글이 등록되었습니다.");
          location.reload();
        } else {
          alert("댓글 등록 실패");
        }
      }
    });
  });
</script>

</body>
</html>
