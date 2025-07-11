<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${countryVO.recipeTitle}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/exstyle.css">
    <link rel="stylesheet" href="/css/update_country.css">
    
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="container mt-5 mb-5">
    <div class="card shadow p-4">
        <div class="row">
            <!-- ✅ 이미지 -->
            <div class="col-md-5">
                <c:if test="${not empty countryVO.standardRecipeImageUrl}">
                    <img src="${countryVO.standardRecipeImageUrl}" alt="레시피 이미지" class="img-fluid rounded w-100">
                </c:if>
            </div>

            <!-- ✅ 제목, 작성자, 카테고리 -->
            <div class="col-md-7">
                <h2 class="mb-2">${countryVO.recipeTitle}</h2>
                <p class="text-muted mb-1">작성자: ${countryVO.nickname}</p>
                <p class="text-muted small">
                    나라 ID: ${countryVO.countryCategoryId} /
                    재료 ID: ${countryVO.ingredientCategoryId} /
                    상황 ID: ${countryVO.situationCategoryId}
                </p>
					<button id="like-button" type="button"
						class="btn btn-outline-danger btn-sm like-button">
						♥ 좋아요 <span id="like-count">${country.likeCount}</span>
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
        <c:if test="${loginUser.userId == countryVO.userId}">
            <div class="mt-4 text-end">
                <a href="/country/editForm.do?uuid=${countryVO.uuid}" class="btn btn-warning me-2">수정</a>
                <a href="/country/delete.do?uuid=${countryVO.uuid}" class="btn btn-danger"
                   onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
            </div>
        </c:if>
        <div class="mt-4">
    <button type="button" class="btn btn-outline-secondary" onclick="history.back()">목록으로 돌아가기</button>
</div>

<input type="hidden" id="country-uuid" value="${country.uuid}" />
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
</body>
</html>