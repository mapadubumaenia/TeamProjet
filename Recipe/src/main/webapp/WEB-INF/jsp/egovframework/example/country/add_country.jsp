<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>추천 테마 - 레시피 작성</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/exstyle.css">
    <link rel="stylesheet" href="/css/add_country.css">
</head>
<body>

<jsp:include page="/common/header.jsp"></jsp:include>

<div class="page mt-4 container">
    <h2 class="mb-4">레시피 작성</h2>

    <form id="addForm" name="addForm" method="post" enctype="multipart/form-data">
        <!-- ✅ 로그인 사용자 정보 -->
        <input type="hidden" name="userId" value="${memberVO.userId}" />
        <input type="hidden" name="nickname" value="${memberVO.nickname}" />
        <input type="hidden" name="filterCountry" value="${param.filterCountry}" />
		<input type="hidden" name="filterIngredient" value="${param.filterIngredient}" />
		<input type="hidden" name="filterSituation" value="${param.filterSituation}" />
        <input type="hidden" name="uuid" value="${countryVO.uuid}" />

        <!-- ✅ 제목 -->
        <div class="mb-3">
            <label for="recipeTitle" class="form-label">레시피 제목</label>
            <input type="text" class="form-control" id="recipeTitle" name="recipeTitle" placeholder="제목을 입력하세요." value="${countryVO.recipeTitle}" required>
        </div>

        <!-- ✅ 레시피 소개 -->
        <div class="mb-3">
            <label for="recipeIntro" class="form-label">레시피 소개</label>
            <textarea class="form-control" id="recipeIntro" name="recipeIntro" rows="3" placeholder="레시피를 간단히 소개해주세요.">${countryVO.recipeIntro}</textarea>
        </div>

        <!-- ✅ 재료 정보 -->
        <div class="mb-3">
            <label for="ingredient" class="form-label">재료 정보</label>
            <textarea class="form-control" id="ingredient" name="ingredient" rows="3" placeholder="재료를 입력해주세요. 예) 감자 2개, 소금 약간 등">${countryVO.ingredient}</textarea>
        </div>

        <!-- ✅ 내용 -->
        <div class="mb-3">
            <label for="recipeContent" class="form-label" >레시피 내용</label>
            <textarea class="form-control" id="recipeContent" name="recipeContent" rows="6" required>${countryVO.recipeContent}</textarea>
        </div>

			<!-- ✅ 이미지 업로드 (커스텀 스타일 적용) -->
			<div class="mb-3">
				<label for="standardRecipeImage" class="form-label"></label>

				<!-- ✅ 커스텀 버튼 역할을 하는 label -->
				<label class="custom-file-upload"> 이미지 업로드 <input
					type="file" name="standardRecipeImage" id="standardRecipeImage">
				</label>

				<!-- ✅ 선택된 파일명 표시 -->
				<span id="file-name" class="ms-2 text-muted">선택된 파일 없음</span>

				<!-- ✅ 미리보기 이미지 -->
				<c:if test="${not empty countryVO.standardRecipeImageUrl}">
					<div class="mt-2">
						<img src="${countryVO.standardRecipeImageUrl}"
							class="img-thumbnail" style="max-width: 200px;">
					</div>
				</c:if>
			</div>

			<!-- ✅ 나라 카테고리 -->
        <div class="mb-3">
            <label for="countryCategoryId" class="form-label">나라 카테고리</label>
            <select class="form-select" id="countryCategoryId" name="countryCategoryId" required>
                <option value="">선택</option>
                <c:forEach var="item" items="${countryCategories}">
                    <option value="${item.id}" ${item.id == countryVO.countryCategoryId ? 'selected' : ''}>${item.name}</option>
                </c:forEach>
            </select>
        </div>

        <!-- ✅ 재료 카테고리 -->
        <div class="mb-3">
            <label for="ingredientCategoryId" class="form-label">재료 카테고리</label>
            <select class="form-select" id="ingredientCategoryId" name="ingredientCategoryId" required>
                <option value="">선택</option>
                <c:forEach var="item" items="${ingredientCategories}">
                    <option value="${item.id}" ${item.id == countryVO.ingredientCategoryId ? 'selected' : ''}>${item.name}</option>
                </c:forEach>
            </select>
        </div>

        <!-- ✅ 상황 카테고리 -->
        <div class="mb-3">
            <label for="situationCategoryId" class="form-label">상황 카테고리</label>
            <select class="form-select" id="situationCategoryId" name="situationCategoryId" required>
                <option value="">선택</option>
                <c:forEach var="item" items="${situationCategories}">
                    <option value="${item.id}" ${item.id == countryVO.situationCategoryId ? 'selected' : ''}>${item.name}</option>
                </c:forEach>
            </select>
        </div>

        <!-- ✅ 등록 버튼 -->
        <div class="mb-4 text-center">
            <button type="button" class="btn btn-primary" onclick="fn_save()">
                <c:choose>
                    <c:when test="${empty countryVO.uuid}">등록하기</c:when>
                    <c:otherwise>수정하기</c:otherwise>
                </c:choose>
            </button>
            <button type="button" class="btn btn-secondary" onclick="fn_cancel()">작성 취소</button>
        </div>
    </form>
</div>


<!-- ✅ JS -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 토글 애니메이션 js -->
<script src="/js/nav.js"></script>
<script type="text/javascript">
function fn_save() {
    const actionUrl = '${empty countryVO.uuid ? "/country/add.do" : "/country/edit.do"}';
    $("#addForm").attr("action", actionUrl).submit();
}
function fn_cancel() {
    history.back();
}
</script>

<script>
  document.getElementById("standardRecipeImage").addEventListener("change", function () {
    const fileName = this.files[0] ? this.files[0].name : "선택된 파일 없음";
    document.getElementById("file-name").textContent = fileName;
  });
</script>

<jsp:include page="/common/footer.jsp"></jsp:include>
</body>
</html>
