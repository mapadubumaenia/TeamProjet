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
			<input type="hidden" id="uuid" name="uuid" value="${countryVO.uuid}" />
			<input type="hidden" id="csrf" name="csrf" value="${sessionScope.CSRF_TOKEN}" />
			
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
						<!-- ✅ 레시피 소개 -->
						<h5 class="mt-4">레시피 소개</h5>
						<p>${countryVO.recipeIntro}</p>

						<!-- ✅ 재료 정보 -->
						<h5 class="mt-4">재료 정보</h5>
						<p>${countryVO.ingredient}</p>
					</div>
				</div>

				<!-- ✅ 요리 설명 전체 영역 -->
				<div class="mt-5">
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
				<div class="mt-4">
					<button type="button" class="btn btn-outline-secondary"
						onclick="history.back()">목록으로 돌아가기</button>
				</div>
			</div>
		</form>
	</div>


	<jsp:include page="/common/footer.jsp" />

	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 	<script type="text/javascript">
		/* 삭제 : /country/delete.do */
		function fn_delete() {
			$("#addForm")
					.attr("action", '<c:out value="/country/delete.do" />')
					.submit();
		}
		
		
		  $(function() {
			    $('#likeBtn').on('click', function(){
			        $.ajax({
			            url: '/country/like.do',
			            method: 'POST',
			            contentType: 'application/json', 
			            data: JSON.stringify({
			                uuid: '${countryVO.uuid}',
			                targetType: 'standard'
			            }),
			            dataType: 'text'
			        })
			        .done(function(resp){
			            const isLiked = resp === 'liked';
			            $('#likeIcon').html(isLiked ? '&#9829;' : '&#9825;');
			            $.get('/like/count.do?uuid=${countryVO.uuid}', function(count){
			                $('#likeCount').text(count);
			            });
			            $('#likeBtn').toggleClass('text-danger', isLiked);
			        })
			        .fail(function(xhr){
			            if (xhr.responseText === 'unauthorized') {
			                alert('로그인 후 이용해 주세요.');
			            } else {
			                alert('오류가 발생했습니다.');
			            }
			        });
			    });
			  });


	</script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(function() {
    $('#likeBtn').on('click', function(){
        console.log("❤️ 좋아요 버튼 클릭됨"); // 디버깅용 로그

        $.ajax({
            url: '/country/like.do',  // ✅ 반드시 이 경로여야 함
            method: 'POST',
            data: { uuid: '${countryVO.uuid}' },
            success: function(resp) {
                console.log("✅ 서버 응답: ", resp); // 디버깅용 로그
                const isLiked = resp.liked;
                $('#likeIcon').html(isLiked ? '&#9829;' : '&#9825;');
                $('#likeCount').text(resp.count);
                $('#likeBtn').toggleClass('text-danger', isLiked);
            },
            error: function(xhr) {
                console.error("❌ 오류 발생:", xhr);
                if (xhr.status === 401) {
                    alert('로그인 후 이용해 주세요.');
                } else {
                    alert('오류가 발생했습니다.');
                }
            }
        });
    });
  });
</script>

</body>
</html>