<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8"/>
  <title>레시피 수정</title>
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    rel="stylesheet"/>
  <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/css/exstyle.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/css/update_drink.css'/>"/>
</head>
<body>
  <jsp:include page="/common/header.jsp"/>

  <div class="container my-5">
    <form
      action="<c:url value='/drink/edit.do'/>"
      method="post"
      enctype="multipart/form-data"
      class="mx-auto"
      style="max-width:600px;"
    >
      <input type="hidden" name="uuid" value="${drinkVO.uuid}"/>
       <input type="hidden" name="csrf" value="${sessionScope.CSRF_TOKEN}">

      <div class="mb-3">
        <label class="form-label">제목</label>
        <input
          type="text"
          name="columnTitle"
          class="form-control"
          value="${drinkVO.columnTitle}"
          required/>
      </div>

      <div class="mb-3">
        <label class="form-label">내용</label>
        <textarea
          name="columnContent"
          class="form-control"
          rows="5"
          required>${drinkVO.columnContent}</textarea>
      </div>

      <div class="mb-3">
  <label class="form-label">카테고리</label>
  <select name="category" class="form-select" required>
    <option value="">-- 선택하세요 --</option>
    <option value="cocktail"
      ${drinkVO.category=='cocktail'?'selected':''}>
      칵테일
    </option>
    <option value="smoothie"
      ${drinkVO.category=='smoothie'?'selected':''}>
      스무디&amp;쥬스
    </option>
    <option value="coffee"
      ${drinkVO.category=='coffee'?'selected':''}>
      커피&amp;티
    </option>
  </select>
</div>

      <div class="mb-3">
        <label class="form-label">재료</label>
        <textarea
          name="columnIngredient"
          class="form-control"
          rows="3"
          required>${drinkVO.columnIngredient}</textarea>
      </div>

      <c:if test="${not empty drinkVO.columnUrl}">
        <div class="mb-3">
          <p>기존 이미지:</p>
          <img
            src="${drinkVO.columnUrl}"
            class="img-fluid mb-2"
            alt="기존 이미지"/>
        </div>
      </c:if>

      <div class="mb-3">
        <label class="form-label">이미지 변경</label>
        <input
          type="file"
          name="image"
          class="form-control"/>
      </div>

      <div class="d-flex justify-content-center gap-2">
        <button
          type="submit"
          class="btn btn-mocha">
          저장
        </button>
        <button
          type="button"
          class="btn btn-outline-secondary"
          onclick="history.back()">
          취소
        </button>
      </div>
    </form>
  </div>

  <jsp:include page="/common/footer.jsp"/>
</body>
</html>