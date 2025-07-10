<!-- /WEB-INF/views/method/method_all.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
   <title>${param.methodType} 게시판</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <!-- Bootstrap CSS -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
   <!-- Developer CSS -->
   <link rel="stylesheet" href="/css/style.css">
   <link rel="stylesheet" href="/css/exstyle.css">
   <link rel="stylesheet" href="/css/Drinkstyle.css">
   <link rel="stylesheet" href="/css/Methodstyle.css">
</head>
<body>

  <jsp:include page="/common/header.jsp" />
  <form class="page mt-3" id="listForm" name="listForm" method="get">

    <!-- hidden params -->
    <input type="hidden" id="uuid" name="uuid" />
    <input type="hidden" id="pageIndex" name="pageIndex" 
    value="${not empty param.pageIndex ? param.pageIndex : 1}" />
    <input type="hidden" name="methodType" value="${param.methodType}" />

   <!-- /WEB-INF/views/method/method_all.jsp -->
   
   
   
<c:choose>


  <c:when test="${param.methodType == 'storage'}">
    <div class="category-btn-group mb-3" role="group">
    
     <input type="radio" class="btn-check" name="category" id="catAll"   value=""  autocomplete="off" ${param.category==''?'checked':''}>
      <label class="btn btn-outline-primary" for="catAll">전체보기</label>
    
      <input type="radio" class="btn-check" name="category" id="catMeat"   value="고기"  autocomplete="off" ${param.category=='고기'?'checked':''}>
      <label class="btn btn-outline-primary" for="catMeat">고기</label>

      <input type="radio" class="btn-check" name="category" id="catVeg"    value="야채"  autocomplete="off" ${param.category=='야채'?'checked':''}>
      <label class="btn btn-outline-primary" for="catVeg">야채</label>

      <input type="radio" class="btn-check" name="category" id="catFish"  value="생선" autocomplete="off" ${param.category=='생선'?'checked':''}>
      <label class="btn btn-outline-primary" for="catFish">생선</label>
    </div>
  </c:when>

  <c:when test="${param.methodType == 'trim'}">
    <div class="category-btn-group mb-3" role="group">
    
    <input type="radio" class="btn-check" name="category" id="catAll"   value=""  autocomplete="off" ${param.category==''?'checked':''}>
      <label class="btn btn-outline-primary" for="catAll">전체보기</label>
    
      <input type="radio" class="btn-check" name="category" id="catFridge" value="냉장" autocomplete="off" ${param.category=='냉장'?'checked':''}>
      <label class="btn btn-outline-primary" for="catFridge">냉장</label>

      <input type="radio" class="btn-check" name="category" id="catFreezer" value="냉동" autocomplete="off" ${param.category=='냉동'?'checked':''}>
      <label class="btn btn-outline-primary" for="catFreezer">냉동</label>

      <input type="radio" class="btn-check" name="category" id="catRoom"    value="실온" autocomplete="off" ${param.category=='실온'?'checked':''}>
      <label class="btn btn-outline-primary" for="catRoom">실온</label>
    </div>
  </c:when>

  <c:otherwise>
    <div class="category-btn-group mb-3" role="group">
      <input type="radio" class="btn-check" name="category" id="catA" value="A" autocomplete="off" ${param.category=='A'?'checked':''}>
      <label class="btn btn-outline-primary" for="catA">A</label>
      <input type="radio" class="btn-check" name="category" id="catB" value="B" autocomplete="off" ${param.category=='B'?'checked':''}>
      <label class="btn btn-outline-primary" for="catB">B</label>
      <input type="radio" class="btn-check" name="category" id="catC" value="C" autocomplete="off" ${param.category=='C'?'checked':''}>
      <label class="btn btn-outline-primary" for="catC">C</label>
    </div>
  </c:otherwise>
</c:choose>

    <!-- upload button -->
    <div class="mb-3 drink-upload">
      <button type="button" class="btn btn-mocha" onclick="location.href='${pageContext.request.contextPath}/method/addition.do?methodType=${param.methodType}'">
        글쓰기
      </button>
    </div>

    <!-- list container -->
    <div id="methodListContainer" class="row">
      <c:forEach var="item" items="${methods}">
        <div class="col4">
          <div class="card" data-uuid="${item.uuid}">
            <img src="${item.methodUrl}" class="card-img-top" alt="${item.methodTitle}">
            <div class="card-body">
              <h5 class="card-title">${item.methodTitle}</h5>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

    <!-- pagination -->
    <div class="flex-center">
      <ul class="pagination" id="pagination"></ul>
    </div>

  </form>

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
  <!-- pagination library -->
  <script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>

  <jsp:include page="/common/footer.jsp" />

  <script type="text/javascript">
    function fn_egov_selectList() {
      $('#pageIndex').val(1);
      $('#listForm').attr('action', '<c:url value="/method/method.do"/>')
                    .submit();
    }

    function fn_egov_link_page(pageNo) {
      $('#pageIndex').val(pageNo);
      $('#listForm').attr('action', '<c:url value="/method/method.do"/>')
                    .submit();
    }
  </script>

  <script>
    $('.category-btn-group .btn-check').on('change', function() {
      const category = $(this).val();
      $('#listForm').attr('action', '<c:url value="/method/method.do"/>?category=' + encodeURIComponent(category))
                    .submit();
    });
  </script>

  <script type="text/javascript">
    $('#pagination').twbsPagination({
      totalPages: "${paginationInfo.totalPageCount}",
      startPage: parseInt("${paginationInfo.currentPageNo}"),
      visiblePages: "${paginationInfo.recordCountPerPage}",
      initiateStartPageClick: false,
      onPageClick: function (event, page) {
        fn_egov_link_page(page);
      }
    });
  </script>

  <!-- detail modal -->
  <div class="modal fade" id="methodDetailModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">상세 정보</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body" id="methodDetailBody">
          <div class="text-center py-5">
            <div class="spinner-border text-secondary" role="status"></div>
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>

  <script>
    $(document).on('click', '.card', function() {
      const uuid = $(this).data('uuid');
      const url = '<c:url value="/method/detailFragment.do"/>?uuid=' + uuid + '&methodType=${param.methodType}';
      const $body = $('#methodDetailBody');
      $body.html(`<div class="text-center py-5"><div class="spinner-border text-secondary" role="status"></div></div>`);
      const modal = new bootstrap.Modal(document.getElementById('methodDetailModal'));
      modal.show();
      $.ajax({
        url: url,
        success: function(html) { $body.html(html); },
        error:   function() { $body.html('<div class="alert alert-danger">오류 발생</div>'); }
      });
    });
  </script>

</body>
</html>
