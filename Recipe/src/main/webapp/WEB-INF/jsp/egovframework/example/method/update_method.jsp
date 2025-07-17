<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <title>보관/손질법 수정</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/css/exstyle.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/css/update_method.css'/>"/>
</head>
<body>
  <jsp:include page="/common/header.jsp"/>

  <div class="container my-5">
    <form action="<c:url value='/method/edit.do'/>" method="post" enctype="multipart/form-data" class="mx-auto" style="max-width:600px;">
      <input type="hidden" name="uuid" value="${methodVO.uuid}"/>
      <input type="hidden" name="methodType" value="${param.methodType}"/>
      <input type="hidden" name="csrf" value="${sessionScope.CSRF_TOKEN}"/>

      <div class="mb-3">
        <label class="form-label">제목</label>
        <input type="text" name="methodTitle" class="form-control" value="${methodVO.methodTitle}" required/>
      </div>

      <div class="mb-3">
        <label class="form-label">내용</label>
        <textarea name="methodContent" class="form-control" rows="5" required>${methodVO.methodContent}</textarea>
      </div>

    <div class="mb-3">
  <label class="form-label">카테고리</label>
  <select name="category" class="form-select" required>
    <option value="">-- 선택하세요 --</option>
    <c:choose>
      <c:when test="${methodType == 'storage'}">
        <option value="고기"    ${method.category == '고기'   ? 'selected':''}>고기</option>
        <option value="야채"    ${method.category == '야채'   ? 'selected':''}>야채</option>
        <option value="생선"    ${method.category == '생선'   ? 'selected':''}>생선</option>
      </c:when>
      <c:otherwise>
        <option value="냉장"    ${method.category == '냉장'   ? 'selected':''}>냉장</option>
        <option value="냉동"    ${method.category == '냉동'   ? 'selected':''}>냉동</option>
        <option value="실온"    ${method.category == '실온'   ? 'selected':''}>실온</option>
      </c:otherwise>
    </c:choose>
  </select>
</div>

      <c:if test="${not empty methodVO.methodUrl}">
        <div class="mb-3">
          <p>기존 이미지:</p>
          <img src="${methodVO.methodUrl}" class="img-fluid mb-2" alt="기존 이미지"/>
        </div>
      </c:if>

      <div class="mb-3">
        <label class="form-label">이미지 변경</label>
        <input type="file" name="image" class="form-control"/>
      </div>

      <div class="d-flex justify-content-center gap-2">
        <button type="submit" class="btn btn-mocha">저장</button>
        <button type="button" class="btn btn-outline-secondary" onclick="history.back()">취소</button>
      </div>
    </form>
  </div>

  <jsp:include page="/common/footer.jsp"/>
</body>
</html>