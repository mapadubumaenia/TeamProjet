<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row gx-3">
  <div class="col-md-5 text-center">
    <img
      src="<c:url value='/drink/download.do?uuid=${drink.uuid}'/>"
      class="img-fluid rounded"
      alt="음료 이미지"
    />
  </div>
  <div class="col-md-7">
    <h4>${drink.columnTitle}</h4>
    <p><strong>재료:</strong> ${drink.columnIngredient}</p>
    <br>
    <p class="mt-3">${drink.columnContent}</p>
    <small class="text-muted">등록일: ${drink.columnCreatedAt}</small>
  </div>
</div>