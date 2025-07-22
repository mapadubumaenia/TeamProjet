<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>QnA 질문 작성</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/exstyle.css">
    <link rel="stylesheet" href="/css/Community.css">
     <link rel="stylesheet" href="/css/add_qna.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<jsp:include page="/common/header.jsp" />

<h3 class="text-center my-4" style="color: #c9a383;"> 질문 작성</h3>

<div class="comubody">
  <div class="container mt-4">
    <form action="/qna/addition.do" method="post" enctype="multipart/form-data">
      <input type="hidden" name="communityCategoryId" value="2"/>
      <input type="hidden" name="contentType" value="qna"/>

      <!-- 제목 -->
      <div class="mb-3">
        <label for="qnaTitle" class="form-label">제목</label>
        <input type="text" class="form-control" id="qnaTitle" name="qnaTitle" required>
      </div>

      <!-- 내용 -->
      <div class="mb-3">
        <label for="qnaContent" class="form-label">내용</label>
        <textarea class="form-control" id="qnaContent" name="qnaContent" rows="8" required></textarea>
      </div>

      <!-- 이미지 업로드 -->
      <div class="mb-3">
        <label for="uploadFile" class="form-label">이미지 첨부 (선택)</label>
        <input class="form-control" type="file" id="uploadFile" name="uploadFile" accept="image/*">
      </div>

      <!-- 버튼 -->
      <div class="btn-group-responsive mt-3">
        <button type="submit" class="btn btn-mocha">등록</button>
        <a href="/qna/qna.do" class="btn btn-secondary">취소</a>
      </div>
    </form>
  </div>
</div>
<jsp:include page="/common/footer.jsp" />
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>
