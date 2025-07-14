<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RecipeCode</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 파비콘 추가 -->
    <link rel="icon" href="/images/01.png" type="image/png">
    <!--     부트스트랩 css  -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!--     개발자 css -->
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/exstyle.css">
    <link rel="stylesheet" href="/css/mypagestyle.css">
    <link rel="stylesheet" href="/css/country_all.css">
</head>
<body>
<!-- 머리말 -->
<jsp:include page="/common/header.jsp" />

<!-- 본문 -->
<div class="page mt5">

<div class="mymenu">
<div class="accordion" id="accordionExample">

  <div class="accordion-item">
    <h2 class="accordion-header" id="headingOne">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
        레시피
      </button>
    </h2>
    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <button class = "my_btn" onclick="loadMyRecipes()">내가 쓴 레시피</button><br>
        <button class = "my_btn btn_content">스크랩</button><br>
        <button class = "my_btn btn_content">좋아요</button>
      </div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingTwo">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
        댓글
      </button>
    </h2>
    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <button class = "my_btn ">내가 쓴 댓글</button><br>
        <button class = "my_btn btn_comment">좋아요</button>
      </div>
    </div>
  </div>
    <div class="accordion-item">
    <h2 class="accordion-header" id="headingThree">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
        <strong>회원정보</strong>
      </button>
    </h2>
    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <button class = "my_btn btn_info">조회 / 수정</button>
      </div>
    </div>
  </div>
</div>
 <div id="myPageContent"></div>
</div>





</div>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<!-- 토글 애니메이션 js -->
<script src="/js/nav.js"></script>

<!-- AJAX용 -->
<script>   //내가 작성한 레시피
function loadMyRecipes() {
  fetch('/mypage/myrecipes.do')
    .then(res => res.text())
    .then(html => {
      document.getElementById("myPageContent").innerHTML = html;
    });
}
</script>

<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<!-- 부트스트랩 js -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
	<!-- 토글 애니메이션 js -->
	<script src="/js/nav.js"></script>
	<!-- 페이징 라이브러리 -->
	<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>

	<script type="text/javascript">
		/* 페이지번호 클릭시 전체조회 */
		function fn_egov_link_page(page) {
			/* 현재페이지번호 저장 */
			$("#pageIndex").val(page);
			$("#listForm").attr("action", '<c:out value="/media/game.do" />')
					.submit();
		}
		/* 전체조회 */
		function fn_egov_selectList() {
			$("#pageIndex").val(1); // 최초 화면에서는 페이지번호를 1페이지로 지정
			$("#listForm").attr("action", '<c:out value="/media/game.do" />')
					.submit();
		}
	</script>

	<script type="text/javascript">
		/* 페이징 처리 */
		$('#pagination').twbsPagination({
			totalPages : "${paginationInfo.totalPageCount}",
			startPage : parseInt("${paginationInfo.currentPageNo}"),
			visiblePages : 5,
			first : null,
			last : null,
			prev : '<',
			next: '>',
			initiateStartPageClick : false,
			onPageClick : function(event, page) {
				/* 재조회 함수 실행 */
				fn_egov_link_page(page);
			}
		});
	</script>

<!-- 꼬리말 -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>