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
      <input type="hidden" name="filter3" value="${param.filter3}" />

      <div class="container">
        <!-- 분류 드롭다운 -->
<div class="d-flex justify-content-between align-items-center mb-3">
  <div>
    <label for="sortOption" class="form-label me-2">분류</label>
    <select class="form-select form-select-sm w-auto d-inline" id="sortOption" name="sortOption" onchange="fn_sort()">
      <option value="latest" ${param.sortOption == 'recent' ? 'selected' : ''}>최신순</option>
      <option value="likes" ${param.sortOption == 'likes' ? 'selected' : ''}>인기순</option>
      <option value="title" ${param.sortOption == 'title' ? 'selected' : ''}>가나다순</option>
    </select>
  </div>
  <div>
    <button type="button" class="btn btn-primary btn-sm" onclick="fn_create()">글쓰기</button>
  </div>
</div>

        <!-- 레시피 목록 -->
<div class="card-grid">
  <c:forEach var="recipe" items="${countries}">
    <a href="/country/edition.do?uuid=${recipe.uuid}" class="card text-decoration-none text-dark">
      <img src="${empty recipe.standardRecipeImageUrl ? '/images/no-image.png' : recipe.standardRecipeImageUrl}"
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
    💬 ${empty recipe.commentCount ? 0 : recipe.commentCount}
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
      const filter = "${param.filter3}";
      if (filter) {
        location.href = "/country/addition.do?filter3=" + filter;
      } else {
        alert("국가 필터 값이 없습니다.");
      }
    }

    function fn_sort() {
      $("#pageIndex").val(1);
      $("#listForm").submit();
    }
  </script>
</body>
</html>
