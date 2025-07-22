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
    <!-- Swiper CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
    <!--     개발자 css -->
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/exstyle.css">
    <link rel="stylesheet" href="/css/home.css">
</head>
<body>
<!-- 머리말 -->
<jsp:include page="/common/header.jsp" />

<!-- 본문 -->

<div class="main-banner">
  <video autoplay loop muted playsinline>
    <source src="/video/3119659.mp4" type="video/mp4">
  </video>
</div>

<!-- 최신 레시피 -->
<div class="recent-section">
  <h2 class="section-title">최신 레시피</h2>
  <div class="recent-grid">
<c:forEach var="recipe" items="${recentRecipes}">
  <c:choose>
    <c:when test='${recipe.type eq "media"}'>
      <c:set var="recipeUrl" value="${pageContext.request.contextPath}/media/open.do?uuid=${recipe.uuid}" />
    </c:when>
    <c:when test='${recipe.type eq "standard"}'>
      <c:set var="recipeUrl" value="${pageContext.request.contextPath}/country/edition.do?uuid=${recipe.uuid}" />
    </c:when>
    <c:when test='${recipe.type eq "column"}'>
      <c:set var="recipeUrl" value="${pageContext.request.contextPath}/drink/detail.do?uuid=${recipe.uuid}" />
    </c:when>
    <c:otherwise>
      <c:set var="recipeUrl" value="#" />
    </c:otherwise>
  </c:choose>

  <a href="${recipeUrl}" class="recipe-link">
    <div class="recipe-card">
      <c:choose>
        <c:when test='${not empty recipe.imageUrl}'>
          <img src="${recipe.imageUrl}" alt="${recipe.title}" />
        </c:when>
        <c:otherwise>
          <img src="${pageContext.request.contextPath}/images/default.jpg" alt="${recipe.title}" />
        </c:otherwise>
      </c:choose>
      <h3>${recipe.title}</h3>
    </div>
  </a>
</c:forEach>

  </div>
</div>

<!-- 테마 슬라이드 배너 -->
<div class="slider-wrapper horizontal-box">
<div class="theme-info">
 <h3>3가지 주요 요리 테마</h3>
    <p>레시피, 미디어 속 요리, 그리고 드링크까지! <br>
    다양한 방식으로 요리를 즐겨보세요.</p>
</div>
  <div class="swiper themeSwiper">
    <div class="swiper-wrapper">
      <div class="swiper-slide">
        <a href="<c:url value='/country/country.do'/>">
          <img src="images/roman.jpg" alt="레시피" />
          <span>레시피</span>
        </a>
      </div>
      <div class="swiper-slide">
        <a href="<c:url value='/media/media.do'/>">
          <img src="images/girl.jpg" alt="미디어" />
          <span>미디어</span>
        </a>
      </div>
      <div class="swiper-slide">
        <a href="<c:url value='/drink/drink.do'/>">
          <img src="images/chris.jpg" alt="드링크" />
          <span>드링크</span>
        </a>
      </div>
    </div>
  </div>

</div>

<!-- 인기 레시피 -->
<div class="popular-recipes">
  <h2>인기 레시피 TOP 4</h2>
  <div class="recipe-grid">
    <c:forEach var="recipe" items="${selectTopLiked}">
      <c:choose>
        <c:when test='${recipe.type eq "media"}'>
          <c:set var="recipeUrl" value="${pageContext.request.contextPath}/media/open.do?uuid=${recipe.uuid}" />
        </c:when>
        <c:when test='${recipe.type eq "standard"}'>
          <c:set var="recipeUrl" value="${pageContext.request.contextPath}/country/edition.do?uuid=${recipe.uuid}" />
        </c:when>
        <c:when test='${recipe.type eq "column"}'>
          <c:set var="recipeUrl" value="${pageContext.request.contextPath}/drink/detail.do?uuid=${recipe.uuid}" />
        </c:when>
        <c:otherwise>
          <c:set var="recipeUrl" value="#" />
        </c:otherwise>
      </c:choose>

      <div class="recipe-card">
        <a href="${recipeUrl}">
          <img src="${recipe.imageUrl}" alt="${recipe.title}" class="recipe-thumbnail" />
            <h3 class="recipe-title">${recipe.title}</h3>
        </a>
      </div>
    </c:forEach>
  </div>
</div>





<!-- 추천레시피 -->
<div class="recommended">
<div class="section-header">
<h2>추천 레시피</h2>
<p>요리는 기억이 되고, 기억은 이야기가 됩니다. <br> 레시피 하나하나에 담긴 정성과 이야기를 따라
오늘은 어떤 맛을 만나볼까요?</p></div>

<div class="swiper mySwiper">
  <div class="swiper-wrapper">
    <c:forEach var="recipe" items="${recommendedRecipes}">
      <div class="swiper-slide">
        <a href="<c:choose>
                    <c:when test='${recipe.type eq "media"}'>${pageContext.request.contextPath}/media/open.do?uuid=${recipe.uuid}</c:when>
                    <c:when test='${recipe.type eq "standard"}'>${pageContext.request.contextPath}/country/edition.do?uuid=${recipe.uuid}</c:when>
                    <c:when test='${recipe.type eq "column"}'>${pageContext.request.contextPath}/drink/detail.do?uuid=${recipe.uuid}</c:when>
                    <c:otherwise>#</c:otherwise>
                 </c:choose>">
          <img src="<c:choose>
                      <c:when test='${not empty recipe.imageUrl}'>${recipe.imageUrl}</c:when>
                      <c:otherwise>${pageContext.request.contextPath}/images/default.jpg</c:otherwise>
                   </c:choose>" alt="${recipe.title}" />
          <div class="overlay-text">
            <div class="title">${recipe.title}</div>
          </div>
        </a>
      </div>
    </c:forEach>
  </div>
</div>

</div>

<!-- 손질법 보관법 -->
<div class="method-section">
<button class="accordion-toggle">Tips!</button>
<div class="accordion-content">
  <h2>손질법</h2>
  <div class="method-list">
    <c:forEach var="item" items="${trimming}">
      <div class="method-item">
        <c:choose>
          <c:when test="${item.type eq 'trim'}">
            <a href="${pageContext.request.contextPath}/method/detail.do?uuid=${item.uuid}">
          </c:when>
          <c:otherwise>
            <a href="#">
          </c:otherwise>
        </c:choose>
              <img class="method-image" src="${item.imageUrl != null ? item.imageUrl : pageContext.request.contextPath + '/images/default.jpg'}" alt="${item.title}" />
              <div class="method-title">${item.title}</div>
            </a>
      </div>
    </c:forEach>
  </div>

  <h2>보관법</h2>
  <div class="method-list">
    <c:forEach var="item" items="${storage}">
      <div class="method-item">
        <c:choose>
          <c:when test="${item.type eq 'storage'}">
            <a href="${pageContext.request.contextPath}/method/detail.do?uuid=${item.uuid}">
          </c:when>
          <c:otherwise>
            <a href="#">
          </c:otherwise>
        </c:choose>
              <img class="method-image" src="${item.imageUrl != null ? item.imageUrl : pageContext.request.contextPath + '/images/default.jpg'}" alt="${item.title}" />
              <div class="method-title">${item.title}</div>
            </a>
      </div>
    </c:forEach>
  </div>

</div>
</div>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<!-- 토글 애니메이션 js -->
<script src="/js/nav.js"></script>
<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

<script>
  const swiper = new Swiper('.mySwiper', {
    effect: 'coverflow', 
    grabCursor: true,
    centeredSlides: true,
    slidesPerView: 'auto',
    initialSlide: 0,
    coverflowEffect: {
      rotate: 50,
      stretch: 0,
      depth: 100,
      modifier: 1,
      slideShadows: true,
    },
  });
</script>

<!-- 테마 슬라이드 자동 전환 -->
<script>
  const themeSwiper = new Swiper('.themeSwiper', {
    loop: true,
    autoplay: {
      delay: 5000,
      disableOnInteraction: false,
    },
    effect: 'fade',
    fadeEffect: {
      crossFade: true,
    },
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
  });
</script>

<!-- 팁 -->
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const toggle = document.querySelector(".accordion-toggle");
    const content = document.querySelector(".accordion-content");

    toggle.addEventListener("click", function () {
      content.classList.toggle("open");
    });
  });
</script>


<!-- 꼬리말 -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>