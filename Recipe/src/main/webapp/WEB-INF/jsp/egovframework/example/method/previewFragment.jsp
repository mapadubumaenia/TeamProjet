<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row gx-3">
  <div class="col-md-5 text-center">
    <c:choose>
      <c:when test="${not empty preview.methodData}">
        <img src="${preview.methodUrl}" class="img-fluid rounded" alt="미리보기 이미지"/>
      </c:when>
      <c:otherwise>
        <p>이미지 없음</p>
      </c:otherwise>
    </c:choose>
  </div>
  <div class="col-md-7">
    <h4>${preview.methodTitle}</h4>
    <p><strong>카테고리:</strong> ${preview.category}</p>
    <hr/>
    <p class="mt-3">${preview.methodContent}</p>
  </div>
</div>