<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <title>게시판 목록</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/exstyle.css">
  <link rel="stylesheet" href="/css/Community_all.css">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="community-wrapper">
  <h3>자유게시판</h3>
  <div class="container mt-5">
    <form id="listForm" method="get" action="<c:url value='/community/community.do'/>">
      <input type="hidden" id="pageIndex" name="pageIndex" value="${empty criteria.pageIndex ? 1 : criteria.pageIndex}" />

      <!-- 카드 레이아웃 출력 영역 -->
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
        <c:forEach var="item" items="${CommuNts}" varStatus="status">
          <div class="col">
            <div class="card h-100 shadow-sm">
              <div class="card-body">
                <div class="card-title">
                  <a href="<c:url value='/community/detail.do'/>?uuid=${item.uuid}">
                    ${item.communityTitle}
                  </a>
                </div>
                <div class="card-meta">작성자: ${item.userNickname}</div>
                <div class="card-meta">작성일: ${item.communityCreatedAt}</div>
                <div class="card-meta">조회수: ${item.communityCount} | 좋아요: ♥ ${item.likeCount} | 댓글: ${item.commentCount}</div>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>

      <!-- 페이지네이션 + 글쓰기 버튼 -->
      <div class="d-flex justify-content-between align-items-center mt-4">
        <ul class="pagination mb-0" id="pagination"></ul>
        <a href="<c:url value='/community/addition.do'/>" class="btn btn-mocha">글쓰기</a>
      </div>

      <!-- 검색창 -->
      <div class="search-bar mt-4 text-center">
        <input type="text" name="searchKeyword" value="${criteria.searchKeyword}" placeholder="제목으로 검색" />
        <input type="hidden" name="pageIndex" value="1" />
        <button type="submit" class="btn btn-outline-secondary btn-sm">검색</button>
      </div>
    </form>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/jquery.twbsPagination.js"></script>

<script type="text/javascript">
  $(document).ready(function () {
    $('#pagination').twbsPagination({
      totalPages: ${paginationInfo.totalPageCount},
      startPage: ${paginationInfo.currentPageNo},
      visiblePages: 5,
      initiateStartPageClick: false,
      onPageClick: function (event, page) {
        $("#pageIndex").val(page);
        $("#listForm").submit();
      }
    });
  });
</script>

</body>
</html>
