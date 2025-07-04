<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
   <title>Title</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <!--    부트스트랩 css  -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
   <!--    개발자 css -->
   <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/exstyle.css">
    <link rel="stylesheet" href="/css/Drinkstyle.css">
  


</head>
<body>

   <jsp:include page="/common/header.jsp" />
   <form class="page mt3" id="listForm" name="listForm" method="get">
   
  
   
    <!-- 수정페이지 열기때문에 필요 -->
       <input type="hidden" id="uuid" name="uuid">
       
       <!--컨트롤러로 보낼 페이지 번호  -->
       <input type="hidden" id="pageIndex" name="pageIndex">


        <!-- ★여기에 바로 카테고리 그룹을 넣습니다-->
  <div class="category-btn-group" role="group" aria-label="카테고리 선택">
    <input type="radio" class="btn-check" name="category" id="btnAll" value=""
           autocomplete="off" ${selectedCategory==''?'checked':''}>
    <label class="btn btn-outline-primary" for="btnAll">전체보기</label>

    <input type="radio" class="btn-check" name="category" id="btnCocktail" value="cocktail"
           autocomplete="off" ${selectedCategory=='cocktail'?'checked':''}>
    <label class="btn btn-outline-primary" for="btnCocktail">칵테일</label>

    <input type="radio" class="btn-check" name="category" id="btnSmoothie" value="smoothie"
           autocomplete="off" ${selectedCategory=='smoothie'?'checked':''}>
    <label class="btn btn-outline-primary" for="btnSmoothie">스무디&쥬스</label>

    <input type="radio" class="btn-check" name="category" id="btnCoffee" value="coffee"
           autocomplete="off" ${selectedCategory=='coffee'?'checked':''}>
    <label class="btn btn-outline-primary" for="btnCoffee">커피&티</label>
  </div>

      
      <br>
      <br>
      
      

      
        <!-- 여기부터 drinkListContainer 시작 -->
  <div id="drinkListContainer">
    <div class="row">
      <c:forEach var="data" items="${drinks}">
        <div class="col4">
          <div class="card" data-uuid="${data.uuid}">
            <img src="${data.columnUrl}" class="card-img-top" alt="${data.columnTitle}">
            <div class="card-body">
              <h5 class="card-title">${data.columnTitle}</h5>

            </div>
          </div>
        </div>
      </c:forEach>
    </div>
    <div class="flex-center">
      <ul class="pagination" id="pagination"></ul>
    </div>
  </div>
  <!-- drinkListContainer 끝 -->
         

   </form>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<!-- 페이징 라이브러리 -->
<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>

<jsp:include page="/common/footer.jsp" />

<script type="text/javascript">
     /*전체조회  */
function fn_egov_selectList() {
	 $("#pageIndex").val(1); 
	$("#listForm").attr("action",'<c:out value="/drink/drink.do" />')
	    .submit();
}

    /*페이지 번호 클릭시 전체조회  */
	/*현재페이지 번호 저장  */
	function fn_egov_link_page(pageNo) {
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", '<c:out value="/drink/drink.do" />')
				.submit();
	}
    /* 삭제 */
   function fn_delete(uuid) {
    	/*전체조회: mrthod="get"이다, 하지만 삭제는 post로 보내랴함.변경해서 전달  */
    	$("#uuid").val(uuid);
    	$("#listForm").attr("action",'<c:out value="/drink/delete.do"/>')
    	     .attr("method","post")
	    .submit();
	
    }
    
</script>

<!-- 카테고리 버튼 함수 -->
<script>
$(function(){
  $('.category-btn-group .btn-check').on('change', function(){
    const category = $(this).val();
    // query parameter 형태로 GET 요청
    const url = '<c:url value="/drink/drink.do"/>' + '?category=' + encodeURIComponent(category);

    // 전체 페이지가 아닌 #drinkListContainer 부분만 GET으로 로드
    $('#drinkListContainer').load(
      url + ' #drinkListContainer'
    );
  });
});
</script>



<script type="text/javascript">
<!-- 페이징 처리 -->
$('#pagination').twbsPagination({
    totalPages: "${paginationInfo.totalPageCount}",
    startPage: parseInt("${paginationInfo.currentPageNo}"),
    visiblePages: "${paginationInfo.recordCountPerPage}",
    initiateStartPageClick: false,
    onPageClick: function (event, page) {
    	/*여기에 재조회 함수  */
    	fn_egov_link_page(page);
    	
    }
});

</script>

<!-- 카드 클릭시 모달 뛰우는 ajax 스크립트  -->
<script>
  $(function(){
    // 카드 클릭 시 AJAX 호출 & 모달 띄우기
    $(document).on('click', '.col4 .card', function(){
      const uuid = $(this).data('uuid');
      const $body = $('#drinkDetailBody');

      // 로딩 스피너
      $body.html(`
        <div class="text-center py-5">
          <div class="spinner-border text-secondary" role="status">
            <span class="visually-hidden">Loading...</span>
          </div>
        </div>
      `);

      // 모달 오픈
      const modal = new bootstrap.Modal(document.getElementById('drinkDetailModal'));
      modal.show();

      // AJAX 요청
      $.ajax({
        url: '<c:url value="/drink/detailFragment.do"/>',
        data: { uuid: uuid },
        success: function(html){
          $body.html(html);
        },
        error: function(){
          $body.html('<div class="alert alert-danger">데이터를 불러오는 중 오류가 발생했습니다.</div>');
        }
      });
    });
  });
</script>



<!-- 상세 모달 (drink_all.jsp 맨 아래) -->
<div class="modal fade" id="drinkDetailModal" tabindex="-1" aria-hidden="true" 
 >      <!--주위 어두워지는거 끄는 함수  -->
   <div class="modal-dialog modal-lg modal-dialog-centered">  <!-- 중앙에 모달 띄우기 -->
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">음료 상세 정보</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body" id="drinkDetailBody">
        <div class="text-center py-5">
          <div class="spinner-border text-secondary" role="status">
            <span class="visually-hidden">Loading...</span>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>



</body>
</html>
