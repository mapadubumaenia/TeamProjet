<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세조회 - ${mediaVO.title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 파비콘 추가 -->
<link rel="icon" href="/images/01.png" type="image/png">
<!-- 	부트스트랩 css  -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<!-- 	개발자 css -->
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/exstyle.css">
<link rel="stylesheet" href="/css/openmedia.css">
</head>
<body>
	<!-- 머리말 -->
	<jsp:include page="/common/header.jsp" />
	
	<input type="hidden" id="uuid" value="${mediaVO.uuid}" />
	<input type="hidden" id="csrf" name="csrf" value="${sessionScope.CSRF_TOKEN}">

	<!-- 본문 -->
	<div class="container">
    <h2>${mediaVO.title}</h2>
    <p><strong>작성자:</strong> ${mediaVO.userId}</p>
    <p><strong>등록일:</strong> ${mediaVO.recipeCreatedAt}</p>
        
    <div class="media-header">
    <div>
 <button id="likeBtn" class="btn btn-outline-danger">
  <span id="likeIcon">${isLiked ? '&#9829;' : '&#9825;'}</span>
<span id="likeCount">${likeCount}</span>
</button>
<button id="shareBtn" class="btn btn-outline-danger">🔗공유</button>
</div>

<div id="copyAlert">링크가 복사되었습니다!</div>
    <div class="image-wrapper">
    <img src="${mediaVO.recipeImageUrl}" alt="${mediaVO.title} 이미지" class="img-fluid mb-4" /></div>
    <p><strong>준비물:</strong> ${mediaVO.ingredient}</p>
    <pre>${mediaVO.content}</pre> 
      </div>
  <div class="obuttons">
   <a href="<c:out value='/media/edition.do?uuid=${data.uuid}'/>" class="btn btn-outline-dark ">수정</a>

   <c:choose>
				<c:when test="${mediaVO.mediaCategory == 1}">
					<a href="/media/movie.do" class="btn btn-outline-dark">영화 페이지로</a>
				</c:when>
				<c:when test="${mediaVO.mediaCategory == 2}">
					<a href="/media/drama.do" class="btn btn-outline-dark">드라마 페이지로</a>
				</c:when>
				<c:when test="${mediaVO.mediaCategory == 3}">
					<a href="/media/game.do" class="btn btn-outline-dark">게임 페이지로</a>
				</c:when>
				<c:otherwise>
					<a href="/media/media.do" class="btn btn-outline-dark">전체 목록으로</a>
				</c:otherwise>
			</c:choose>
   </div> 
   
   <!-- 댓글 영역 -->
<div class="comment-inline">
  <h5>댓글</h5>

  <!-- 댓글 입력창 -->
  <form class="comment-form" method="post" action="/comment/add.do">
    <div class="mb-2">
      <textarea class="form-control" name="content" rows="3" placeholder="댓글을 입력하세요" required></textarea>
    </div>
    <div class="text-end">
      <button type="submit" class="btn btn-outline-dark btn-sm">등록</button>
    </div>
  </form>

  <!-- 댓글 목록 -->
  <div class="comment-list mt-3">
    <c:forEach var="comment" items="${commentList}">
      <div class="comment-item">
        <div class="comment-meta">
          <span class="comment-writer">${comment.userId}</span>
          <span class="comment-date">${comment.createdAt}</span>
        </div>
        <div class="comment-content">${comment.content}</div>
      </div>
    </c:forEach>
  </div>
</div>
   </div>
		
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<!-- 부트스트랩 js -->
	<script 
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
	<!-- 토글 애니메이션 js -->
	<script src="/js/nav.js"></script>
	<!-- 페이징 라이브러리 -->
	<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>

<!-- 좋아요 -->
<script>
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

<script>
$('#likeBtn').on('click', function() {
    $.ajax({
      url: '<c:url value="/media/like.do"/>',
      method: 'POST',
      data: {
        uuid: $('#uuid').val(),
        csrf: $('#csrf').val()
      },
      dataType: 'json'
    })
    .done(function(resp) {
      // 서버가 알려주는 좋아요 상태로 아이콘, 색깔, 카운트 동기화
      $('#likeIcon').html(resp.liked ? '&#9829;' : '&#9825;');
      $('#likeCount').text(resp.count);
      $('#likeBtn').toggleClass('text-danger', resp.liked);
    })
    .fail(function(xhr) {
      if (xhr.status === 401) {
        alert('로그인 후 이용해 주세요.');
      } else {
        alert('오류가 발생했습니다.');
      }
    });
  });
</script>

<!-- url복사 -->
<script>
  const shareBtn = document.getElementById('shareBtn');
  const copyAlert = document.getElementById('copyAlert');

  shareBtn.addEventListener('click', () => {
    const currentUrl = window.location.href;

    navigator.clipboard.writeText(currentUrl)
      .then(() => {
        copyAlert.style.display = 'block';
        setTimeout(() => {
          copyAlert.style.display = 'none';
        }, 2000);
      })
      .catch(err => {
        console.error('URL 복사 실패:', err);
      });
  });
</script>


	<!-- 꼬리말 -->
	<jsp:include page="/common/footer.jsp" />
</body>
</html>