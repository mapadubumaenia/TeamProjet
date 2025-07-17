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
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">QnA 게시판</h2>
        <button class="btn btn-primary" onclick="location.href='/qna/addition.do'">QnA 글쓰기</button>
    </div>

    <form id="listForm" action="/qna/qna.do" method="get">
        <input type="hidden" id="pageIndex" name="pageIndex" value="${paginationInfo.currentPageNo}" />
    </form>

    <table class="table table-hover text-center align-middle">
        <thead class="table-light">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="qna" items="${qnaList}" varStatus="status">
            <tr onclick="location.href='/qna/detail.do?uuid=${qna.uuid}'" style="cursor:pointer;">
                <td>${paginationInfo.totalRecordCount - (paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage - status.index}</td>
                <td class="text-start">${qna.qnaTitle}</td>
                <td>${qna.userNickname}</td>
                <td>${qna.qnaCreatedAt}</td>
                <td>${qna.count}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty qnaList}">
            <tr>
                <td colspan="5" class="text-center">등록된 QnA가 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div id="pagination" class="d-flex justify-content-center mt-4"></div>
</div>








<jsp:include page="/common/footer.jsp" />


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