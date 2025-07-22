<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
   <title>Community Add</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <!--    부트스트랩 css  -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
   <!--    개발자 css -->
   <link rel="stylesheet" href="/css/style.css">
   <link rel="stylesheet" href="/css/exstyle.css">
   <link rel="stylesheet" href="/css/Community.css">
   <link rel="stylesheet" href="/css/add_community.css">
</head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div class="add-community-wrapper">
  <h3>자유게시판 글쓰기</h3>

  <form action="<c:url value='/community/add.do'/>" method="post" enctype="multipart/form-data">
    <c:if test="${not empty message}">
      <div class="alert alert-info">${message}</div>
    </c:if>

    <div class="form-group">
      <label for="communityTitle" class="form-label">제목</label>
      <input type="text" name="communityTitle" id="communityTitle" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="uploadFile" class="form-label">이미지 업로드</label>
      <input type="file" name="uploadFile" id="uploadFile" class="form-control" accept="image/*">
          <img id="preview" src="#" alt="미리보기" style="display: none; max-width: 200px; margin-top: 10px;">
      
   
    </div>

    <div class="form-group">
      <label for="communityContent" class="form-label">내용</label>
      <textarea name="communityContent" id="communityContent" rows="8" class="form-control" required></textarea>
    </div>

    <div class="btn-group-responsive mt-3">
    <button type="submit" class="btn btn-mocha">등록</button>
      <a href="<c:url value='/community/community.do'/>" class="btn btn-secondary">취소</a>
    </div>
  </form>
</div>

<jsp:include page="/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("uploadFile").addEventListener("change", function (event) {
      const file = event.target.files[0];
      if (file && file.type.startsWith("image/")) {
        const reader = new FileReader();
        reader.onload = function (e) {
          const preview = document.getElementById("preview");
          preview.src = e.target.result;
          preview.style.display = "block";
        };
        reader.readAsDataURL(file);
      }
    });
  });
</script>

</body>
</html>