<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${countryVO.recipeTitle}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/exstyle.css">
    <link rel="stylesheet" href="/css/country_detail.css">
</head>
<body>

<jsp:include page="/common/header.jsp"></jsp:include>

<div class="container mt-5 mb-5">

    <!-- ✅ 제목 및 작성 정보 -->
    <h2>${countryVO.recipeTitle}</h2>
    <p class="text-muted mb-4">작성자: ${countryVO.nickname}</p> <!-- 조회수: ${countryVO.viewCount}-->

    <!-- ✅ 대표 이미지 -->
    <c:if test="${not empty countryVO.standardRecipeImageUrl}">
        <img src="${countryVO.standardRecipeImageUrl}" alt="레시피 이미지" class="img-fluid rounded mb-4">
    </c:if>

    <!-- ✅ 레시피 소개 -->
    <h5 class="mt-4">레시피 소개</h5>
    <p>${countryVO.recipeIntro}</p>

    <!-- ✅ 재료 정보 -->
  <!--  <h5 class="mt-4">재료 정보</h5>
    <p>${countryVO.ingredientInfo}</p> -->

    <!-- ✅ 요리 설명 -->
    <h5 class="mt-4">요리 설명</h5>
    <pre class="bg-light p-3 border rounded">${countryVO.recipeContent}</pre>

    <!-- ✅ 카테고리 정보 -->
    <div class="mt-4 text-muted">
        나라 카테고리 ID: ${countryVO.countryCategoryId} /
        재료 카테고리 ID: ${countryVO.ingredientCategoryId} /
        상황 카테고리 ID: ${countryVO.situationCategoryId}
    </div>

    <!-- ✅ 수정/삭제 버튼 (작성자만 보이도록 조건 분기) -->
    <c:if test="${loginUser.userId == countryVO.userId}">
        <div class="mt-5 d-flex gap-2">
            <a href="/country/editForm.do?uuid=${countryVO.uuid}" class="btn btn-warning">수정</a>
            <a href="/country/delete.do?uuid=${countryVO.uuid}" class="btn btn-danger"
               onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
        </div>
    </c:if>

</div>

<jsp:include page="/common/footer.jsp"></jsp:include>

</body>
</html>