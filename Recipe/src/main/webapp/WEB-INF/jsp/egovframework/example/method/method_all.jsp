<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <title>${param.methodType} 게시판</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <!-- Bootstrap CSS -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    crossorigin="anonymous"
  />
  <!-- 공用 스타일 -->
  <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/css/exstyle.css'/>"/>
  <!-- 드링크 시리즈용 스타일을 그대로 가져옵니다 -->
  <link rel="stylesheet" href="<c:url value='/css/Drinkstyle.css'/>"/>
  <!-- method 전용 오버라이드 -->
  <link rel="stylesheet" href="<c:url value='/css/Methodstyle.css'/>"/>
</head>
<body>
  <jsp:include page="/common/header.jsp"/>

  <form id="listForm" name="listForm" method="get" class="page mt3">
    <!-- hidden -->
    <input type="hidden" id="pageIndex" name="pageIndex"
           value="${not empty param.pageIndex ? param.pageIndex : 1}"/>
    <input type="hidden" name="methodType" value="${param.methodType}"/>

    <!-- 카테고리 버튼 -->
    <c:choose>
      <c:when test="${param.methodType=='storage'}">
        <div class="category-btn-group">
          <input type="radio" class="btn-check" name="category" id="catAll" value=""
                 autocomplete="off" ${param.category==''?'checked':''}/>
          <label class="btn btn-outline-primary" for="catAll">전체보기</label>
          <input type="radio" class="btn-check" name="category" id="catMeat" value="고기"
                 autocomplete="off" ${param.category=='고기'?'checked':''}/>
          <label class="btn btn-outline-primary" for="catMeat">고기</label>
          <input type="radio" class="btn-check" name="category" id="catVeg" value="야채"
                 autocomplete="off" ${param.category=='야채'?'checked':''}/>
          <label class="btn btn-outline-primary" for="catVeg">야채</label>
          <input type="radio" class="btn-check" name="category" id="catFish" value="생선"
                 autocomplete="off" ${param.category=='생선'?'checked':''}/>
          <label class="btn btn-outline-primary" for="catFish">생선</label>
        </div>
      </c:when>
      <c:when test="${param.methodType=='trim'}">
        <div class="category-btn-group">
          <input type="radio" class="btn-check" name="category" id="catAll" value=""
                 autocomplete="off" ${param.category==''?'checked':''}/>
          <label class="btn btn-outline-primary" for="catAll">전체보기</label>
          <input type="radio" class="btn-check" name="category" id="catFridge" value="냉장"
                 autocomplete="off" ${param.category=='냉장'?'checked':''}/>
          <label class="btn btn-outline-primary" for="catFridge">냉장</label>
          <input type="radio" class="btn-check" name="category" id="catFreezer" value="냉동"
                 autocomplete="off" ${param.category=='냉동'?'checked':''}/>
          <label class="btn btn-outline-primary" for="catFreezer">냉동</label>
          <input type="radio" class="btn-check" name="category" id="catRoom" value="실온"
                 autocomplete="off" ${param.category=='실온'?'checked':''}/>
          <label class="btn btn-outline-primary" for="catRoom">실온</label>
        </div>
      </c:when>
      <c:otherwise>
        <div class="category-btn-group">
          <input type="radio" class="btn-check" name="category" id="catA" value="A"
                 autocomplete="off" ${param.category=='A'?'checked':''}/>
          <label class="btn btn-outline-primary" for="catA">A</label>
          <input type="radio" class="btn-check" name="category" id="catB" value="B"
                 autocomplete="off" ${param.category=='B'?'checked':''}/>
          <label class="btn btn-outline-primary" for="catB">B</label>
          <input type="radio" class="btn-check" name="category" id="catC" value="C"
                 autocomplete="off" ${param.category=='C'?'checked':''}/>
          <label class="btn btn-outline-primary" for="catC">C</label>
        </div>
      </c:otherwise>
    </c:choose>

    <!-- 글쓰기 버튼 (절대 위치) -->
    <div class="drink-upload">
      <button type="button"
              class="btn btn-mocha"
              onclick="location.href='${pageContext.request.contextPath}/method/addition.do?methodType=${param.methodType}'">
        글쓰기
      </button>
    </div>

		<!-- 카드 리스트 -->
		<div id="methodListContainer" class="row">
			<c:forEach var="item" items="${methods}">
				<div class="col4 mb3">
					<a
						href="${pageContext.request.contextPath}/method/detail.do?uuid=${item.uuid}&methodType=${param.methodType}"
						class="card h-100 text-decoration-none position-relative"> <!-- 좋아요 표시: 이미지 위 왼쪽 -->
						<span class="like">❤️ ${item.likeCount}</span> <c:if
							test="${not empty item.methodUrl}">
							<img src="${item.methodUrl}" class="card-img-top"
								alt="${item.methodTitle}" />
						</c:if>

						<div
							class="card-body d-flex justify-content-center align-items-center">
							<h5 class="card-title mb-0">${item.methodTitle}</h5>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>

		<!-- 페이지네이션 -->
    <div class="flex-center">
      <ul id="pagination" class="pagination"></ul>
    </div>
  </form>

  <!-- scripts -->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    crossorigin="anonymous"
  ></script>
  <script src="<c:url value='/js/jquery.twbsPagination.js'/>"></script>
  <script>
    function fn_egov_link_page(pageNo) {
      $('#pageIndex').val(pageNo);
      $('#listForm').attr('action','<c:url value="/method/method.do"/>').submit();
    }
    $('.btn-check').on('change', () => fn_egov_link_page(1));
    $('#pagination').twbsPagination({
      totalPages: '${paginationInfo.totalPageCount}',
      startPage: '${paginationInfo.currentPageNo}',
      visiblePages: '${paginationInfo.recordCountPerPage}',
      initiateStartPageClick: false,
      onPageClick: (e, p) => fn_egov_link_page(p)
    });
  </script>

  <jsp:include page="/common/footer.jsp"/>
</body>
</html>