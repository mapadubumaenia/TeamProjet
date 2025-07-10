<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <title>레시피 상세</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <!-- Bootstrap CSS -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
    crossorigin="anonymous"
  />
   <!-- ① Google Fonts -->
  <link 
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" 
    rel="stylesheet"
  />
  
  <!-- 커스텀 CSS -->
  <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/css/exstyle.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/css/Drinkstyle.css'/>"/>
</head>
<body>
  <jsp:include page="/common/header.jsp"/>

   <div class="container my-5">
    <!-- 1) 레시피 카드 -->
    <div class="card mb-5 shadow-sm">
      <div class="row g-0">
        <div class="col-md-5">
          <img
            src="<c:url value='/drink/download.do'>
                   <c:param name='uuid' value='${drink.uuid}'/>
                 </c:url>"
            class="img-fluid rounded-start h-100 w-100 object-fit-cover"
            alt="음료 이미지"
          />
        </div>
        <div class="col-md-7">
          <div class="card-body">
            <h2 class="card-title mb-3">${drink.columnTitle}</h2>
            <p class="text-muted mb-1">
              작성자: <strong>${drink.userNickname}</strong>
              &nbsp;|&nbsp;
              등록일: <strong>${drink.columnCreatedAt}</strong>
            </p>
            <p class="mb-2">
              <span class="badge bg-info text-dark">카테고리</span>
              ${drink.category}
            </p>
            <hr/>
            <p class="card-text">${drink.columnContent}</p>
          </div>
        </div>
      </div>
    </div>
    
<div class="mb-5 px-4 py-3 columnIngredient">
  <h5 class="mb-2">재료</h5>
  <ul class="list-unstyled ingredient-list">
    <c:forEach var="ing" items="${ingredients}">
      <li>• ${ing}</li>
    </c:forEach>
  </ul>
</div>
    

  <!-- ★ 버튼 그룹 삽입 -->
    <div class="d-flex justify-content-center gap-3 mb-4">
      <button type="button" class="btn btn-mocha" onclick="copyUrl()">
        URL 복사
      </button>
      <button type="button" class="btn btn-mocha" onclick="copyContent()">
        레시피 복사
      </button>
      <button type="button" id="likeBtn" class="btn btn-mocha" onclick="toggleLike()">
        <span id="likeIcon">&#9825;</span> 좋아요
        <span id="likeCount" class="badge bg-white text-dark ms-1">0</span>
      </button>
    </div>



    <!-- 댓글 카드 -->
    <div class="card shadow-sm">
      <div class="card-header bg-white d-flex justify-content-between align-items-center">
        <h5 class="mb-0">댓글 <span class="badge bg-secondary">${fn:length(comments)}</span></h5>
      </div>
      <ul class="list-group list-group-flush">
        <c:forEach var="c" items="${comments}">
          <li class="list-group-item">
            <div class="d-flex justify-content-between">
              <h6 class="mb-1">${c.userNickname}</h6>
              <small class="text-muted">${c.createdAt}</small>
            </div>
            <p class="mb-0">${c.commentContent}</p>
          </li>
        </c:forEach>
        <c:if test="${empty comments}">
          <li class="list-group-item text-center text-muted">등록된 댓글이 없습니다.</li>
        </c:if>
      </ul>
      <div class="card-body">
        <form action="<c:url value='/drink/addComment.do'/>" method="post">
          <input type="hidden" name="uuid" value="${drink.uuid}"/>
          <div class="mb-3">
            <textarea
              name="commentContent"
              id="commentContent"
              class="form-control"
              rows="3"
              placeholder="댓글을 입력하세요…"
              required
            ></textarea>
          </div>
          <button type="submit" class="btn btn-primary">댓글 등록</button>
        </form>
      </div>
    </div>
  </div>
  
   <c:if test="${not empty recentDrinks}">
  <div class="recent-recipes-wrapper">
  <h4 class="recent-text">최근 본 레시피</h4>
    <div class="recent-recipes">
      <c:forEach var="r" items="${recentDrinks}">
        <a href="<c:url value='/drink/detail.do'><c:param name='uuid' value='${r.uuid}'/></c:url>"
           class="card text-decoration-none">
          <img src="${r.columnUrl}" class="card-img-top" alt="${r.columnTitle}"/>
          <div class="card-body">
            <p class="card-title">${r.columnTitle}</p>
          </div>
        </a>
      </c:forEach>
    </div>
  </div>
</c:if>
  

  <jsp:include page="/common/footer.jsp"/>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
          crossorigin="anonymous"></script>
          
           <!-- 버튼 스크립트 -->
  <script>
    function copyUrl() {
      const url = window.location.href;
      navigator.clipboard.writeText(url)
        .then(() => alert('URL이 복사되었습니다:\n' + url));
    }

    function copyContent() {
      const text = document.querySelector('.card-text').innerText;
      navigator.clipboard.writeText(text)
        .then(() => alert('레시피 내용이 복사되었습니다.'));
    }

    let liked = false;
    function toggleLike() {
      liked = !liked;
      const icon = document.getElementById('likeIcon');
      const btn = document.getElementById('likeBtn');
      const count = document.getElementById('likeCount');
      let n = parseInt(count.innerText, 10);
      if (liked) {
        icon.innerHTML = '&#9829;';      // 꽉 찬 하트
        btn.classList.add('text-danger');
        count.innerText = ++n;
      } else {
        icon.innerHTML = '&#9825;';      // 빈 하트
        btn.classList.remove('text-danger');
        count.innerText = --n;
      }
    }
  </script>
          
</body>
</html>