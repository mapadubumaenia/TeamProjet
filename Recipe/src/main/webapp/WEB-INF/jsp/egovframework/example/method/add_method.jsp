<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
  <title>글쓰기</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Bootstrap CSS -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
    crossorigin="anonymous">
  <!-- Developer CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/exstyle.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Drinkstyle.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Methodstyle.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/add_method.css">
</head>
<body>
  <jsp:include page="/common/header.jsp"/>

  <div class="container mt-4">
    <form id="addForm"
          method="post"
          enctype="multipart/form-data"
          action="${pageContext.request.contextPath}/method/add.do?methodType=${param.methodType}">
      
      <input type="hidden" name="csrf" value="${sessionScope.CSRF_TOKEN}">
      <div class="mb-3">
        <label for="methodTitle" class="form-label">제목</label>
        <input type="text" class="form-control" id="methodTitle" name="methodTitle" required/>
      </div>

      <c:choose>
        <c:when test="${param.methodType == 'storage'}">
          <div class="mb-3">
            <label for="category" class="form-label">카테고리</label>
            <select class="form-select" id="category" name="category" required>
              <option value="" disabled selected>-- 선택 --</option>
              <option value="고기">고기</option>
              <option value="야채">야채</option>
              <option value="생선">생선</option>
            </select>
          </div>
        </c:when>
        <c:when test="${param.methodType == 'trim'}">
          <div class="mb-3">
            <label for="category" class="form-label">카테고리</label>
            <select class="form-select" id="category" name="category" required>
              <option value="" disabled selected>-- 선택 --</option>
              <option value="냉장">냉장</option>
              <option value="냉동">냉동</option>
              <option value="실온">실온</option>
            </select>
          </div>
        </c:when>
      </c:choose>

      <div class="mb-3">
        <label for="image" class="form-label">이미지</label>
        <input class="form-control"
               type="file"
               id="image"
               name="image"/>
      </div>
      
      <div class="mb-3">
        <label for="methodContent" class="form-label">내용</label>
        <textarea class="form-control"
                  id="methodContent"
                  name="methodContent"
                  rows="6"></textarea>
      </div>

      <div class="d-flex gap-2">
        <button type="button"
                id="previewBtn"
                class="btn btn-secondary">
          미리보기
        </button>
        <button type="submit" class="btn btn-primary">저장</button>
        <a href="${pageContext.request.contextPath}/method/method.do?methodType=${param.methodType}"
           class="btn btn-outline-secondary">
          취소
        </a>
      </div>
    </form>
  </div>

  <!-- Preview Modal -->
  <div class="modal fade" id="previewModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">미리보기</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body" id="previewModalBody">
          <!-- AJAX로 previewFragment.jsp가 로드됩니다 -->
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
  
  <br>

<jsp:include page="/common/footer.jsp"/>

 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 토글 애니메이션 js -->
	<script src="/js/nav.js"></script>
  <!-- jQuery, Bootstrap JS 순서 중요 -->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"
          integrity="sha256-..." crossorigin="anonymous"></script>
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-..." crossorigin="anonymous"></script>

  <script>
    $(function(){
      $('#previewBtn').on('click', function(){
        var formData = new FormData($('#addForm')[0]);
        // methodType 전달이 필요하면:
        formData.append('methodType', '${param.methodType}');
        $.ajax({
          url: '<c:url value="/method/preview.do"/>',
          type: 'POST',
          data: formData,
          processData: false,
          contentType: false,
          success: function(html){
            $('#previewModalBody').html(html);
            var previewModal = new bootstrap.Modal($('#previewModal'));
            previewModal.show();
          },
          error: function(){
            alert('미리보기 로드에 실패했습니다.');
          }
        });
      });
    });
  </script>
</body>


</html>