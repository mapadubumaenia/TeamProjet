<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <title>보관/손질법 상세</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <!-- Bootstrap & 공용 스타일 -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    crossorigin="anonymous"
  />
  <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/css/exstyle.css'/>"/>
  <!-- 드링크/메서드 공용 스타일 -->
  <link rel="stylesheet" href="<c:url value='/css/Drinkstyle.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/css/Methodstyle.css'/>"/>
</head>
<body>
  <jsp:include page="/common/header.jsp"/>

  <div class="container my-5">
    <!-- 상세 카드 -->
    <div class="card mb-5 shadow-sm">
      <div class="row g-0">
        <c:if test="${not empty method.methodUrl}">
          <div class="col-md-5">
            <img
              src="<c:url value='/method/download.do'><c:param name='uuid' value='${method.uuid}'/></c:url>"
              class="img-fluid rounded-start h-100 w-100 object-fit-cover"
              alt="이미지"
            />
          </div>
        </c:if>
        <div class="col-md-7">
					<div class="card-body">
						<h2 class="card-title mb-3">${method.methodTitle}</h2>
						<div
							class="card-subheader d-flex justify-content-between align-items-center mb-3">
							<span class="badge bg-info text-dark">${method.category}</span>
							<div class="d-flex align-items-center">
								<c:if test="${not empty authorImgB64}">
									<img src="data:image/png;base64,${authorImgB64}" alt="작성자 프로필"
										class="rounded-circle me-2" width="40" height="40" />
								</c:if>
								<small class="text-muted mb-0"> 작성자: <strong>${method.userNickname}</strong>
								</small>
							</div>
						</div>
						<hr />
						<p class="card-text">${method.methodContent}</p>
						<p class="createdAt">
							<strong>${method.methodCreatedAt}</strong>
						</p>
					</div>
				</div>
      </div>
    </div>

    <!-- 버튼 그룹 -->
    <div class="d-flex justify-content-center gap-3 mb-4">
     <input type="hidden" id="csrf" name="csrf" value="${sessionScope.CSRF_TOKEN}"/>
      <button type="button" class="btn btn-mocha" onclick="copyUrl()">
        URL 복사
      </button>
      <button type="button" class="btn btn-mocha" onclick="copyContent()">
        내용 복사
      </button>
       <button
    type="button"
    id="likeBtn"
    class="btn btn-mocha ${isLiked ? 'text-danger' : ''}"
  >
    <span id="likeIcon">${isLiked ? '&#9829;' : '&#9825;'}</span>
    좋아요
    <span id="likeCount" class="badge bg-white text-dark ms-1">
      ${likeCount}
    </span>
  </button>
    </div>

    <!-- 댓글 섹션 -->
    <div class="card shadow-sm mb-5">
      <div class="card-header bg-white d-flex justify-content-between align-items-center">
        <h5 class="mb-0">
          댓글 <span class="badge bg-secondary">${fn:length(comments)}</span>
        </h5>
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
          <li class="list-group-item text-center text-muted">
            등록된 댓글이 없습니다.
          </li>
        </c:if>
      </ul>
      <div class="card-body">
        <form action="<c:url value='/method/addComment.do'/>" method="post">
          <input type="hidden" name="uuid" value="${method.uuid}"/>
          <div class="mb-3">
            <textarea
              name="commentContent"
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

    <!-- 최근 본 항목 -->
    <c:if test="${not empty recentMethods}">
      <div class="recent-recipes-wrapper mb-5">
        <h4 class="recent-text">최근 본 항목</h4>
        <div class="recent-recipes">
          <c:forEach var="r" items="${recentMethods}">
            <a
              href="<c:url value='/method/detail.do'>
                      <c:param name='uuid' value='${r.uuid}'/>
                      <c:param name='methodType' value='${methodType}'/>
                    </c:url>"
              class="card text-decoration-none"
            >
              <img src="${r.methodUrl}" class="card-img-top" alt="${r.methodTitle}"/>
              <div class="card-body">
                <p class="card-title">${r.methodTitle}</p>
              </div>
            </a>
          </c:forEach>
        </div>
      </div>
    </c:if>
  </div>

  <jsp:include page="/common/footer.jsp"/>

  <!-- Bootstrap JS -->
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    crossorigin="anonymous"
  ></script>
  <!-- 버튼 스크립트 -->
  <script>
    function copyUrl() {
      navigator.clipboard.writeText(location.href)
        .then(() => alert('URL이 복사되었습니다.'));
    }
    function copyContent() {
      navigator.clipboard.writeText(document.querySelector('.card-text').innerText)
        .then(() => alert('내용이 복사되었습니다.'));
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
  
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   
   <script>
  $('#likeBtn').on('click', function(){
    $.ajax({
      url: '<c:url value="/method/like.do"/>',
      method: 'POST',
      data: { 
        uuid: '${method.uuid}', 
        csrf: $('#csrf').val()      // ← CSRF 토큰 추가
      },
      dataType: 'json'
    })
    .done(function(resp){
      $('#likeIcon').html(resp.liked ? '&#9829;' : '&#9825;');
      $('#likeCount').text(resp.count);
      $('#likeBtn').toggleClass('text-danger', resp.liked);
    })
    .fail(function(xhr){
      if (xhr.status === 401) {
        alert('로그인 후 이용해 주세요.');
      } else {
        alert('오류가 발생했습니다.');
      }
    });
  });
</script>
</body>
</html>