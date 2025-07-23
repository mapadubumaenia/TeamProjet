<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <title>통합 검색 결과</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="icon" href="/images/01.png" type="image/png">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/exstyle.css">
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div class="container mt-5">
  <h3 class="mb-4 fw-bold">통합 검색 결과</h3>

  <c:choose>
    <c:when test="${not empty groupedResult}">
      <c:forEach var="type" items="${typeList}">
        <c:if test="${not empty groupedResult[type]}">
          <h5 class="fw-bold mt-5">${type} 관련 결과</h5>
          <div id="carousel-${type}" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
              <c:set var="items" value="${groupedResult[type]}" />
              <c:forEach var="i" begin="0" end="${(fn:length(items) - 1) / 4}" varStatus="status">
                <div class="carousel-item ${status.first ? 'active' : ''}">
                  <div class="row row-cols-1 row-cols-md-4 g-4">
                    <c:forEach var="j" begin="0" end="3">
                      <c:set var="index" value="${i * 4 + j}" />
                      <c:if test="${index lt fn:length(items)}">
                        <c:set var="item" value="${items[index]}" />
                        <div class="col">
                          <a href="<c:url value='${item.type eq "drink" ? "/drink/detail.do?uuid=" :
                                                   item.type eq "country" ? "/country/edition.do?uuid=" :
                                                   item.type eq "media" ? "/media/open.do?uuid=" :
                                                   item.type eq "method" ? "/method/detail.do?uuid=" : ""}'/>${item.uuid}"
                             style="text-decoration: none; color: inherit;">
                            <div class="card h-100 shadow-sm">
                             <img src="${pageContext.request.contextPath}/search/image.do?uuid=${item.uuid}" 
     class="card-img-top"
     alt="${item.title}"
     style="width: 100%; height: 180px; object-fit: cover;">
                              <div class="card-body">
                                <h6 class="card-title">${item.title}</h6>
                                <p class="card-text small text-muted mb-1">작성자: ${item.nickname}</p>
                                <p class="card-text small text-muted mb-1">❤ ${item.likeCount}</p>
                                <p class="card-text small text-muted mb-1">
                                  작성일: <fmt:formatDate value="${item.createdAt}" pattern="yyyy-MM-dd"/>
                                </p>
                              </div>
                            </div>
                          </a>
                        </div>
                      </c:if>
                    </c:forEach>
                  </div>
                </div>
              </c:forEach>
            </div>

            <!-- 캐러셀 버튼을 아래로 내리고 색상 변경 -->
            <c:if test="${fn:length(items) > 4}">
              <div class="d-flex justify-content-between mt-2">
                <button class="carousel-control-prev position-static" type="button"
                        data-bs-target="#carousel-${type}" data-bs-slide="prev"
                        style="background-color: transparent; border: none;">
                  <span class="carousel-control-prev-icon" style="filter: invert(1);"></span>
                </button>
                <button class="carousel-control-next position-static" type="button"
                        data-bs-target="#carousel-${type}" data-bs-slide="next"
                        style="background-color: transparent; border: none;">
                  <span class="carousel-control-next-icon" style="filter: invert(1);"></span>
                </button>
              </div>
            </c:if>
          </div>
        </c:if>
      </c:forEach>

     
      <script>
        function goPage(pageNo) {
          const url = new URL(window.location.href);
          url.searchParams.set('pageIndex', pageNo);
          location.href = url.toString();
        }
      </script>
    </c:when>
    <c:otherwise>
      <p>검색 결과가 없습니다.</p>
    </c:otherwise>
  </c:choose>
</div>

<jsp:include page="/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/nav.js"></script>
</body>
</html>
