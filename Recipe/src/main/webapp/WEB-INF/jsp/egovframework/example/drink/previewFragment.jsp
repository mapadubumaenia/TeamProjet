<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row gx-3">
  <div class="col-md-5 text-center">
    <c:choose>
      <c:when test="${not empty preview.columnData}">
        <img src="${preview.columnUrl}"
             class="img-fluid rounded"
             alt="미리보기 이미지"/>
      </c:when>
      <c:otherwise>
        <p>이미지 없음</p>
      </c:otherwise>
    </c:choose>
  </div>
  <div class="col-md-7">
    <h4>${preview.columnTitle}</h4>
    <p><strong>재료:</strong> ${preview.columnIngredient}</p>
    <p class="mt-3">${preview.columnContent}</p>
    <small class="text-muted">카테고리: ${preview.category}</small>
  </div>
</div>