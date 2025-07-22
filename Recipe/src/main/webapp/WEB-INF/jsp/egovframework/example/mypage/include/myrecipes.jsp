<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<form id="listForm" method="get">
		<input type="hidden" name="pageIndex" id="pageIndex" value="1" />
	</form>
	<!-- 본문 -->
<input type="hidden" id="totalPagesVal" value="${paginationInfo.totalPageCount}" />
<input type="hidden" id="currentPageVal" value="${paginationInfo.currentPageNo}" />
  <h2>작성한 레시피</h2>
<div class="card-grid">
  <c:forEach var="recipe" items="${recipeList}">
    <!-- 링크 URL 분기 -->
    <c:choose>
  <c:when test="${recipe.contentType eq 'media'}">
    <c:set var="urlPrefix" value="/media/open.do?uuid=" />
  </c:when>
  <c:when test="${recipe.contentType eq 'standard'}">
    <c:set var="urlPrefix" value="/country/edition.do?uuid=" />
  </c:when>
  <c:when test="${recipe.contentType eq 'column'}">
    <c:set var="urlPrefix" value="/drink/detail.do?uuid=" />
  </c:when>
   </c:choose>
    <!-- 이미지 경로는 모두 동일: BLOB 서블릿 핸들러 호출 -->
    <c:set var="imgSrc" value="/mypage/image.do?uuid=${recipe.uuid}" />
          <!-- 카드 출력 -->
    <a href="${urlPrefix}${recipe.uuid}" class="card text-decoration-none text-dark">
      <img src="${imgSrc}" class="card-img-top" alt="이미지">
      <div class="card-body">
        <h5 class="card-title">${recipe.title}</h5>
        <div class="card-rating text-muted mb-1">
          <!-- 추가데이터값 넣기 <span class="me-2">❤️ ${empty recipe.likeCount ? 0 : recipe.likeCount}</span>-->
        </div>
      </div>
    </a>
  </c:forEach>
</div>

	<div class="d-flex justify-content-center mt-3">
		<nav aria-label="Page navigation example">
			<ul class="pagination" id="pagination">
			</ul>
		</nav>
	</div>

	

