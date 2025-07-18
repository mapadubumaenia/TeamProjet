<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${countryVO.recipeTitle}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/exstyle.css">
<link rel="stylesheet" href="/css/update_country.css">
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="container mt-5 mb-5">
	<form id="addForm" name="addForm" method="post">
		<input type="hidden" name="uuid" value="${countryVO.uuid}" />
		<input type="hidden" id="csrf" name="csrf" value="${sessionScope.CSRF_TOKEN}" />
		<input type="hidden" name="targetType" value="standard">
		
		<div class="card shadow p-4">
			<div class="row">
				<!-- ✅ 이미지 -->
				<div class="col-md-5">
					<c:if test="${not empty countryVO.standardRecipeImageUrl}">
						<img src="${countryVO.standardRecipeImageUrl}" alt="레시피 이미지"
							class="img-fluid rounded w-100">
					</c:if>
				</div>

				<!-- ✅ 제목, 작성자, 카테고리 -->
				<div class="col-md-7">
					<h2 class="mb-2">${countryVO.recipeTitle}</h2>
					<p class="text-muted mb-1">작성자: ${countryVO.nickname}</p>
					<p class="text-muted small">나라 ID:
						${countryVO.countryCategoryId} / 재료 ID:
						${countryVO.ingredientCategoryId} / 상황 ID:
						${countryVO.situationCategoryId}</p>
					<button type="button" id="likeBtn"
						class="btn btn-mocha ${isLiked ? 'text-danger' : ''}">
						<span id="likeIcon">${isLiked ? '&#9829;' : '&#9825;'}</span> 좋아요
						<span id="likeCount" class="badge bg-white text-dark ms-1">
							${countryVO.likeCount} </span>
					</button>
					<button type="button" class="btn btn-mocha" onclick="copyUrl()">
						URL 복사</button>
					<!-- ✅ 레시피 소개 -->
					<h5 class="mt-4">레시피 소개</h5>
					<p>${countryVO.recipeIntro}</p>

				</div>
			</div>

			<!-- ✅ 요리 설명 전체 영역 -->
			<div class="mt-5">
			<!-- ✅ 재료 정보 -->
					<h5 class="mt-4">재료 정보</h5>
					<p>${countryVO.ingredient}</p>
				<h5 class="mb-3">요리 설명</h5>
				<pre class="bg-light p-3 border rounded">${countryVO.recipeContent}</pre>
			</div>

			<!-- ✅ 수정/삭제 버튼 (작성자만 노출) -->
			<c:if test="${memberVO.userId == countryVO.userId}">
				<div class="mt-4 text-end">
					<a href="/country/addition.do?uuid=${countryVO.uuid}"
						class="btn btn-warning me-2">수정</a>
					<button class="btn btn-danger" onclick="fn_delete()">삭제</button>
				</div>
			</c:if>

			<!-- 댓글 영역 -->
			<div id="comment-area" class="mb-3 mt-4">
				<h5>댓글</h5>
				<div id="commentListArea"></div>
			</div>

			<div class="mt-4">
				<button type="button" class="btn btn-outline-secondary"
					onclick="history.back()">목록으로 돌아가기</button>
			</div>

<hr>
			<c:if test="${not empty recentCountries}">
				<div class="recent-recipes-wrapper">
					<h4 class="recent-text">최근 본 레시피</h4>
					<div class="recent-recipes">
						<c:forEach var="r" items="${recentCountries}">
							<a href="<c:url value='/country/edition.do'><c:param name='uuid' value='${r.uuid}'/></c:url>"
								class="recent-card text-decoration-none">
								<img src="${r.standardRecipeImageUrl}" class="card-img-top" alt="${r.recipeTitle}" />
								<div class="card-body">
									<p class="card-title fw-bold">${r.recipeTitle}</p>
									<p class="text-muted small">♥ ${r.likeCount}개</p>
								</div>
							</a>
						</c:forEach>
					</div>
				</div>
			</c:if>
		</div>
	</form>
</div>

<jsp:include page="/common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
<script>
  // ✅ 삭제 기능
function fn_delete() {
    $("#addForm").attr("action",'<c:out value="/country/delete.do" />')
    .submit();
}

  // ✅ URL 복사 기능
  function copyUrl() {
    const url = window.location.href;
    navigator.clipboard.writeText(url)
      .then(() => alert('URL이 복사되었습니다:\n' + url))
      .catch(err => alert('복사에 실패했습니다.'));
  }

  // ✅ 좋아요 버튼 기능 (문서 로드 후 실행)
  $(function () {
    $('#likeBtn').on('click', function () {
      $.ajax({
        url: '/country/like.do',
        method: 'POST',
        data: { uuid: '${countryVO.uuid}' },
        success: function (resp) {
          const isLiked = resp.liked;
          $('#likeIcon').html(isLiked ? '&#9829;' : '&#9825;');
          $('#likeCount').text(resp.count);
          $('#likeBtn').toggleClass('text-danger', isLiked);
        },
        error: function (xhr) {
          if (xhr.status === 401) {
            alert('로그인 후 이용해 주세요.');
          } else {
            alert('오류가 발생했습니다.');
          }
        }
      });
    });

    // ✅ 댓글 목록 로딩
    const uuid = '${countryVO.uuid}';
    const targetType = 'standard';

    $("#commentListArea").load(
      '<c:url value="/comment/list.do"/>',
      { uuid, targetType, pageIndex: 1 }
    );
  });
</script>

</body>
</html>