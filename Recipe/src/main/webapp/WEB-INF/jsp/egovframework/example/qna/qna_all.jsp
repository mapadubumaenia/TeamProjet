<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <title>QnA 목록</title>
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="/js/jquery.twbsPagination.js"></script>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/exstyle.css">
  <link rel="stylesheet" href="/css/Community.css">
  <link rel="stylesheet" href="/css/qna_all.css">
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div class="qna-wrapper">
  <h3>질문 게시판</h3>

  <form id="listForm" method="get" action="<c:url value='/qna/qna.do'/>" class="mb-4">
    

    <!-- 카드형 목록 -->
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
      <c:forEach var="item" items="${qnaList}" varStatus="status">
        <div class="col">
          <div class="card h-100 shadow-sm">
            <div class="card-body">
              <div class="card-title">
                <a href="<c:url value='/qna/detail.do'/>?uuid=${item.uuid}">
                  ${item.qnaTitle}
                </a>
              </div>
              <div class="card-meta">작성자: ${item.userNickname}</div>
              <div class="card-meta">작성일: ${item.qnaCreatedAt}</div>
              <div class="card-meta">답변자: 
                <c:out value="${item.answerNickname != null ? item.answerNickname : '-'}"/>
              </div>
              <div class="card-meta">
                답변일: 
                <c:choose>
                  <c:when test="${item.answerCreatedAt != null}">
                    ${item.answerCreatedAt}
                  </c:when>
                  <c:otherwise>-</c:otherwise>
                </c:choose>
              </div>
              <div class="card-meta">조회수: ${item.count} | 댓글수: ${item.commentCount}</div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

    <!-- 페이지네이션 + 글쓰기 버튼 -->
    <div class="d-flex justify-content-between align-items-center mt-4">
      <ul class="pagination mb-0" id="pagination"></ul>
      <a href="<c:url value='/qna/addition.do'/>" class="btn btn-mocha">글쓰기</a>
    </div>
    <br>
    <!-- 검색창 -->
    <div class="search-bar mb-4 text-center">
      <input type="text" name="searchKeyword" value="${criteria.searchKeyword}" placeholder="제목으로 검색" />
      <input type="hidden" id="pageIndex" name="pageIndex" value="${criteria.pageIndex}" />
      <button type="submit" class="btn btn-outline-secondary btn-sm">검색</button>
    </div>
    
  </form>
</div>

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