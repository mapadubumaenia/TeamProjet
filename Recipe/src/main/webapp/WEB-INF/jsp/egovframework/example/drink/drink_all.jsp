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

      <div class="drink-upload">
      <button type="button"
        class="btn btn-mocha"
        onclick="location.href='<c:url value='/drink/addition.do'/>'">
  레시피 올리기
</button></div>
      
      <br>
      <br>
      
      

      
        <!-- 여기부터 drinkListContainer 시작 -->
		<div id="drinkListContainer" class="row">
			<c:forEach var="data" items="${drinks}">
  <div class="col4">
    <div class="card position-relative">
      <!-- 좋아요 표시 -->
      <span class="like">❤️ ${data.likeCount}</span>

      <a href="<c:url value='/drink/detail.do?uuid=${data.uuid}'/>">
        <!-- 카드 이미지 -->
        <img src="${data.columnUrl}"
             class="card-img-top"
             alt="${data.columnTitle}" />
        <div class="card-body d-flex align-items-center justify-content-center">
          <h5 class="card-title mb-0">${data.columnTitle}</h5>
        </div>
      </a>
    </div>
  </div>
</c:forEach>
		</div>
		<!-- drinkListContainer 끝 -->
         
 <c:set var="totalPages" value="${paginationInfo.totalPageCount}" />

<c:if test="${totalPages > 1}">
  <div id="paginationWrap" class="flex-center">
    <ul class="pagination" id="pagination"></ul>
  </div>
</c:if>



   </form>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<!-- 페이징 라이브러리 -->
<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>

<!-- 토글 애니메이션 js -->
	<script src="/js/nav.js"></script>
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
    /* 삭제 버튼은 아직 구현안했음(필요없으면 안할예정) */
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

   
  });
});
</script>



<script>
(function () {
  var totalPages  = parseInt("${paginationInfo.totalPageCount}", 10) || 0;
  var currentPage = parseInt("${paginationInfo.currentPageNo}",   10) || 1;

  if (totalPages > 1) {
    $('#pagination').twbsPagination({
      totalPages: totalPages,
      startPage: currentPage,
      visiblePages: Math.min(5, totalPages),
      first: null,
      last : null,
      prev : '<',
      next : '>',
      initiateStartPageClick: false,
      onPageClick: function (e, page) {
        fn_egov_link_page(page);
      }
    });
  }
})();
</script>

<script>
$(function(){
  $('.category-btn-group .btn-check').on('change', function(){
    const category = $(this).val() || '';
    $('#pageIndex').val(1);
    location.href = '<c:url value="/drink/drink.do"/>' + '?category=' + encodeURIComponent(category) + '&pageIndex=1';
  });
});
</script>





</body>
</html>
