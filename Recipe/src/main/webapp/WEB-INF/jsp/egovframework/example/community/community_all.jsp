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
  <link rel="stylesheet" href="/css/Community.css">
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div class="container mt-5">

  <form id="listForm" method="get" action="<c:url value='/community/community.do'/>">
    <!-- 페이징 및 검색 상태 유지용 -->
    <input type="hidden" id="pageIndex" name="pageIndex" value="${empty criteria.pageIndex ? 1 : criteria.pageIndex}" />

    <!-- 게시판 테이블 -->
    <table class="table table-striped">
      <thead>
        <tr>
          <th>번호</th>
          <th>작성자</th>
          <th>제목</th>
          <th>조회수</th>
          <th>좋아요</th>
          <th>작성일</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${CommuNts}" varStatus="status">
          <tr>
            <td>${paginationInfo.totalRecordCount - (criteria.pageIndex - 1) * criteria.pageUnit - status.index}</td>
            <td>${item.userId}</td>
            <td>
              <a href="<c:url value='/community/detail.do'/>?uuid=${item.uuid}">
                ${item.communityTitle}
              </a>
            </td>
            <td>${item.communityCount}</td>
            <td>${item.communityLikeCount}</td>
            <td>${item.communityCreatedAt}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

<!-- 페이지네이션 + 글쓰기 버튼 -->
<div class="d-flex justify-content-between align-items-center mt-3">
  <ul class="pagination mb-0" id="pagination"></ul>
  <a href="<c:url value='/community/addition.do'/>" class="btn btn-custom-brown">글쓰기</a>
</div>

    <!-- 검색창 -->
    <div class="search-bar mt-4 text-center">
      <input type="text" name="searchKeyword" value="${criteria.searchKeyword}" placeholder="제목으로 검색" />
      <input type="hidden" name="pageIndex" value="1" />
      <button type="submit" class="btn btn-outline-secondary btn-sm">검색</button>
    </div>
  </form>
</div>

<jsp:include page="/common/footer.jsp" />

<!-- JS -->
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
