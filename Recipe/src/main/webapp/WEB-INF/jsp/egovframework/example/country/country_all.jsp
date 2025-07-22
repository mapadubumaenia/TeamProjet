<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/exstyle.css">
  <link rel="stylesheet" href="/css/country_all.css">
</head>
<body>
  <jsp:include page="/common/header.jsp" />

  <div class="page custom-page mt3">
    <form id="listForm" name="listForm" method="get">
      <input type="hidden" id="pageIndex" name="pageIndex" value="${criteria.pageIndex}" />
	  <input type="hidden" name="filterCountry" value="${param.filterCountry}" />
	  <input type="hidden" name="filterIngredient" value="${param.filterIngredient}" />
 	  <input type="hidden" name="filterSituation" value="${param.filterSituation}" />


<div class="container mt-5 mb-4">

  <!-- ✅ 에디터 추천 -->
  <div class="editor-pick d-flex justify-content-between align-items-center mb-4">
    <!-- 에디터 텍스트 -->
    <div class="editor-meta">
      <h6 class="subtitle">EDITORS’ PICK</h6>
      <h2 class="title">가볍게 먹기 좋은 오늘의 추천 레시피</h2>
      <p class="description">집에 있는 재료로 간단하게 만들 수 있는 김치볶음밥 레시피를 추천합니다.</p>
      <a href="/country/edition.do?uuid=e518a11a-bcdc-46f5-bd2f-1a9efa831e25&country=1&ingredient=13&situation=15" class="btn btn-outline-dark btn-sm mt-2">이 레시피 바로 가기</a>
    </div>
    <!-- 에디터 이미지 -->
    <div class="editor-image">
      <img src="/images/recipe/friedrice.jpg" alt="추천 이미지" />
    </div>
  </div>

<!-- ✅ 필터 상태 출력 -->
<c:if test="${not empty countryCategoryName || not empty ingredientCategoryName || not empty situationCategoryName}">
  <div class="mb-2">
    <p class="fs-6 fw-semibold text-dark-emphasis mb-0">
      🔍
      <c:if test="${not empty countryCategoryName}">
        국가별 > <strong>${countryCategoryName}</strong>
      </c:if>
      <c:if test="${not empty ingredientCategoryName}">
        재료별 > <strong>${ingredientCategoryName}</strong>
      </c:if>
      <c:if test="${not empty situationCategoryName}">
        상황별 > <strong>${situationCategoryName}</strong>
      </c:if>
    </p>
  </div>
</c:if>

  <!-- ✅ 정렬 + 글쓰기 버튼: 한 줄에 -->
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div>
      <label for="sortOption" class="form-label me-2">분류</label>
      <select class="form-select form-select-sm w-auto d-inline" id="sortOption" name="sortOption" onchange="fn_sort()">
        <option value="recent" ${param.sortOption == 'recent' ? 'selected' : ''}>최신순</option>
        <option value="likes" ${param.sortOption == 'likes' ? 'selected' : ''}>좋아요순</option>
        <option value="title" ${param.sortOption == 'title' ? 'selected' : ''}>가나다순</option>
        <option value="comments" ${param.sortOption == 'comments' ? 'selected' : ''}>댓글 많은순</option>
      </select>
    </div>
    <div>
    <button type="button" class="btn btn-primary btn-sm" onclick="fn_create()">글쓰기</button>
  </div>
</div>

        <!-- 레시피 목록 -->
<div class="card-grid">
  <c:forEach var="recipe" items="${countries}">
    <a href="/country/edition.do?uuid=${recipe.uuid}
&country=${recipe.countryCategoryId}
&ingredient=${recipe.ingredientCategoryId}
&situation=${recipe.situationCategoryId}"
class="card text-decoration-none text-dark">
     <img src="${fn:trim(recipe.standardRecipeImageUrl) eq '' ? '/images/recipe/no-image.png' : recipe.standardRecipeImageUrl}"
     class="card-img-top" alt="이미지">


      
      <div class="card-body">
        <h5 class="card-title">${recipe.recipeTitle}</h5>
        <div class="card-nickname">${recipe.nickname}</div>

        <!-- ✅ 별점 + 댓글 수 출력 -->
<div class="card-rating text-muted mb-1">
<span class="me-2">
  ❤️ <c:choose>
         <c:when test="${empty recipe.likeCount}">
           0
         </c:when>
         <c:otherwise>
           ${recipe.likeCount}
         </c:otherwise>
      </c:choose>
</span>
  <span>
    💬 
    <c:choose>
      <c:when test="${empty recipe.commentCount}">
        0
      </c:when>
      <c:otherwise>
        ${recipe.commentCount}
      </c:otherwise>
    </c:choose>
  </span>
</div>
      </div>
    </a>
  </c:forEach>
</div>


        <!-- 페이지네이션 -->
        <div class="row mt-4 mb-5">
          <div class="col d-flex justify-content-center">
            <nav aria-label="Page navigation">
              <ul class="pagination" id="pagination">
                <li class="page-item"><a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
              </ul>
            </nav>
          </div>
        </div>
      </div> <!-- container 끝 -->
    </form>
  </div>

  <jsp:include page="/common/footer.jsp" />

  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="/js/jquery.twbsPagination.js"></script>

  <script>
    function fn_egov_link_page(page) {
      $("#pageIndex").val(page);
      $("#listForm").attr("action", '<c:out value="/country/country.do" />').submit();
    }

    function fn_egov_selectList() {
      $("#pageIndex").val(1);
      $("#listForm").attr("action", '<c:out value="/country/country.do" />').submit();
    }

    function fn_select(uuid) {
      $("#uuid").val(uuid);
      $("#listForm").attr("action", '<c:out value="/country/edition.do" />').submit();
    }

    $('#pagination').twbsPagination({
      totalPages: ${paginationInfo.totalPageCount},
      startPage: parseInt(${paginationInfo.currentPageNo}),
      visiblePages: ${paginationInfo.recordCountPerPage},
      initiateStartPageClick: false,
      onPageClick: function (event, page) {
        fn_egov_link_page(page);
      }
    });

    function fn_create() {
    	const country = "${param.filterCountry}";
    	const ingredient = "${param.filterIngredient}";
    	const situation = "${param.filterSituation}";

    	  const params = [];
    	  if (country) params.push("filterCountry=" + country);
    	  if (ingredient) params.push("filterIngredient=" + ingredient);
    	  if (situation) params.push("filterSituation=" + situation);

    	  const query = params.length > 0 ? "?" + params.join("&") : "";
    	  location.href = "/country/addition.do" + query;
    	}

    function fn_sort() {
      $("#pageIndex").val(1);
      $("#listForm").submit();
    }
  </script>
</body>
</html>
