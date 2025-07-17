<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
	<form id="listForm" method="get">
		<input type="hidden" name="pageIndex" id="pageIndex" value="1" />
	</form>
	<!-- 본문 -->
	
<div class="card-grid">
  <c:forEach var="recipe" items="${recipeList}">
    <!-- 링크 URL 분기 -->
    <c:set var="urlPrefix" value="${recipe.contentType eq 'media' ? '/media/open.do?uuid=' : '/country/edition.do?uuid='}" />
    
    <!-- 이미지 경로는 모두 동일: BLOB 서블릿 핸들러 호출 -->
    <c:set var="imgSrc" value="/mypage/image.do?uuid=${recipe.uuid}" />
          <!-- 카드 출력 -->
    <a href="${urlPrefix}${recipe.uuid}" class="card text-decoration-none text-dark">
      <img src="${imgSrc}" class="card-img-top" alt="이미지">
      <div class="card-body">
        <h5 class="card-title">${recipe.title}</h5>
        <div class="card-rating text-muted mb-1">
          <span class="me-2">❤️ ${empty recipe.likeCount ? 0 : recipe.likeCount}</span>
        </div>
      </div>
    </a>
  </c:forEach>
</div>
