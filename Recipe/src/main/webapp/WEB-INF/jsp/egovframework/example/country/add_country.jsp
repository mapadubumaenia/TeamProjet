<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <input type="hidden" name="userId" value="${loginUser.userId}" />
        <input type="hidden" name="nickname" value="${loginUser.nickname}" />

        <!-- ✅ 제목 -->
        <div class="mb-3">
            <label for="recipeTitle" class="form-label">레시피 제목</label>
            <input type="text" class="form-control" id="recipeTitle" name="recipeTitle" required>
        </div>
        
    <!-- ✅ 레시피 소개 -->
    <div class="mb-3">
        <label for="recipeIntro" class="form-label">레시피 소개</label>
        <textarea class="form-control" id="recipeIntro" name="recipeIntro" rows="3" placeholder="레시피를 간단히 소개해주세요."></textarea>
    </div>

    <!-- ✅ 재료 정보 -->
    <div class="mb-3">
        <label for="ingredientInfo" class="form-label">재료 정보</label>
        <textarea class="form-control" id="ingredientInfo" name="ingredientInfo" rows="3" placeholder="재료를 입력해주세요. 예) 감자 2개, 소금 약간 등"></textarea>
    </div>
    
        <!-- ✅ 내용 -->
        <div class="mb-3">
            <label for="recipeContent" class="form-label">레시피 내용</label>
            <textarea class="form-control" id="recipeContent" name="recipeContent" rows="6" required></textarea>
        </div>

        <!-- ✅ 이미지 업로드 -->
        <div class="mb-3">
            <label for="standardRecipeImage" class="form-label">대표 이미지</label>
            <input type="file" class="form-control" id="standardRecipeImage" name="uploadFile">
        </div>

        <!-- ✅ 나라 카테고리 -->
        <div class="mb-3">
            <label for="countryCategoryId" class="form-label">나라 카테고리</label>
            <select class="form-select" id="countryCategoryId" name="countryCategoryId" required>
                <option value="">선택</option>
                <c:forEach var="item" items="${countryCategories}">
                    <option value="${item.id}">${item.name}</option>
                </c:forEach>
            </select>
        </div>

        <!-- ✅ 재료 카테고리 -->
        <div class="mb-3">
            <label for="ingredientCategoryId" class="form-label">재료 카테고리</label>
            <select class="form-select" id="ingredientCategoryId" name="ingredientCategoryId" required>
                <option value="">선택</option>
                <c:forEach var="item" items="${ingredientCategories}">
                    <option value="${item.id}">${item.name}</option>
                </c:forEach>
            </select>
        </div>

        <!-- ✅ 상황 카테고리 -->
        <div class="mb-3">
            <label for="situationCategoryId" class="form-label">상황 카테고리</label>
            <select class="form-select" id="situationCategoryId" name="situationCategoryId" required>
                <option value="">선택</option>
                <c:forEach var="item" items="${situationCategories}">
                    <option value="${item.id}">${item.name}</option>
                </c:forEach>
            </select>
        </div>

        <!-- ✅ 등록 버튼 -->
        <div class="mb-4 text-center">
            <button type="button" class="btn btn-primary" onclick="fn_save()">등록하기</button>
            <button type="button" class="btn btn-secondary" onclick="fn_cancel()">작성 취소</button>
        </div>
    </form>
</div>

<!-- ✅ JS -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
function fn_save() {
    $("#addForm").attr("action", "<c:out value='/country/add.do' />").submit();
}
function fn_cancel() {
    // 뒤로 가거나 목록 페이지로 이동 가능
    history.back();
}
</script>

<jsp:include page="/common/footer.jsp"></jsp:include>
</body>
</html>
