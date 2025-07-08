<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- /WEB-INF/views/method/detailFragment.jsp -->
<div class="row gx-3">
  <!-- 좌측: 이미지 -->
  <div class="col-md-5 text-center">
    <c:if test="${not empty method.methodUrl}">
      <img
        src="<c:url value='/method/download.do'>
               <c:param name='uuid' value='${method.uuid}'/>
             </c:url>"
        class="img-fluid rounded"
        alt="이미지"
      />
    </c:if>
  </div>

  <!-- 우측: 제목·카테고리·내용·등록일·삭제버튼 -->
  <div class="col-md-7">
    <h4>${method.methodTitle}</h4>
    <p><strong>카테고리:</strong> ${method.category}</p>
    <p class="mt-3">${method.methodContent}</p>
    <small class="text-muted">등록일: ${method.methodCreatedAt}</small>
    <div class="mt-4">
      <form action="${pageContext.request.contextPath}/method/delete.do" method="post">
        <input type="hidden" name="uuid" value="${method.uuid}"/>
        <input type="hidden" name="methodType" value="${param.methodType}"/>
      </form>
    </div>
  </div>
</div>