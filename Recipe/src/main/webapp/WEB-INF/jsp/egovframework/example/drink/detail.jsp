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
						alt="음료 이미지" />
				</div>
				<div class="col-md-7">
					<div class="card-body">
						<h2 class="card-title mb-3">${drink.columnTitle}</h2>
						<div
							class="card-subheader d-flex justify-content-between align-items-center mb-3">
							<span class="badge bg-info text-dark">${drink.category}</span>
							<div class="d-flex align-items-center">
								<c:if test="${not empty authorImgB64}">
									<img src="data:image/png;base64,${authorImgB64}" alt="작성자 프로필"
										class="rounded-circle me-2" width="40" height="40" />
								</c:if>
								<small class="text-muted mb-0"> 작성자: <strong>${drink.userNickname}</strong>
								</small>
							</div>
						</div>
						<hr />
						<p class="card-text">${drink.columnContent}</p>
						<p class="createdAt">
							<strong>${drink.columnCreatedAt}</strong>
						</p>
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
			<input type="hidden" id="csrf" name="csrf"
				value="${sessionScope.CSRF_TOKEN}" />
			<button type="button" class="btn btn-mocha" onclick="copyUrl()">
				URL 복사</button>
			<button type="button" class="btn btn-mocha" onclick="copyContent()">
				레시피 복사</button>
			<button type="button" id="likeBtn"
				class="btn btn-mocha ${isLiked ? 'text-danger' : ''}">
				<span id="likeIcon">${isLiked ? '&#9829;' : '&#9825;'}</span> 좋아요 <span
					id="likeCount" class="badge bg-white text-dark ms-1">
					${likeCount} </span>
			</button>
			<!-- 수정하기 버튼 (로그인된 작성자만 보이도록) -->
  <c:if test="${sessionScope.memberVO.userId == drink.userId}">
    <button
      type="button"
      class="btn btn-outline-secondary"
      onclick="location.href='${pageContext.request.contextPath}/drink/edition.do?uuid=${drink.uuid}'">
      수정하기
    </button>
  </c:if>
			
		</div>



		<!-- 댓글 영역 -->
  <div id="comment-area" class="mb-3 mt-4">
    <h5>댓글</h5>
    <div id="commentListArea"></div>
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
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $('#likeBtn').on('click', function(){
    $.ajax({
      url: '<c:url value="/drink/like.do"/>',
      method: 'POST',
      data: { 
        uuid: '${drink.uuid}', 
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
  
          <script>
  $(function () {
    const uuid = '${drink.uuid}';
    const targetType = 'column';

    $("#commentListArea").load(
      '<c:url value="/comment/list.do"/>',
      { uuid, targetType, pageIndex: 1 }
    );
  });
</script>
          
</body>
</html>