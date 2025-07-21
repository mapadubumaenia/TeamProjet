<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<div class="home">
<!-- 테마 슬라이드 배너 -->
<div class="slider-wrapper">
  <div class="slider" id="themeSlider">
    <div class="slide"><a href=""><img src="images/roman.jpg" alt="레시피"></a><span>레시피</span></div>
    <div class="slide"><a href=""><img src="images/girl.jpg" alt="미디어"></a><span>미디어</span></div>
    <div class="slide"><a href=""><img src="images/chris.jpg" alt="드링크"></a><span>드링크</span></div>
  </div>
</div>

<!-- 추천 레시피 -->
<div class="orderby-wrapper">
  <h2 class="orderby-title">추천 레시피</h2>
  <div class="orderby">
    <div class="grid-container">
      <c:if test="${not empty ask[0]}">
        <div class="large-image gridimg">
          <a href="media/open.do?uuid=${ask[0].uuid}">
            <img src="${ask[0].recipeImageUrl != null ? ask[0].recipeImageUrl : '/images/default.jpg'}" />
            <div class="overlay-text"><div class="title">${ask[0].title}</div></div>
          </a>
        </div>
      </c:if>

      <div class="right-column">
        <div class="small-images-row">
          <c:forEach begin="1" end="2" var="i">
            <c:if test="${not empty ask[i]}">
              <div class="small-img gridimg">
                <a href="media/open.do?uuid=${ask[i].uuid}">
                  <img src="${ask[i].recipeImageUrl != null ? ask[i].recipeImageUrl : '/images/default.jpg'}" />
                  <div class="overlay-text"><div class="title">${ask[i].title}</div></div>
                </a>
              </div>
            </c:if>
          </c:forEach>
        </div>
        <c:if test="${not empty ask[3]}">
          <div class="bottom-image gridimg">
            <a href="media/open.do?uuid=${ask[3].uuid}">
              <img src="${ask[3].recipeImageUrl != null ? ask[3].recipeImageUrl : '/images/default.jpg'}" />
              <div class="overlay-text"><div class="title">${ask[3].title}</div></div>
            </a>
          </div>
        </c:if>
      </div>
    </div>
  </div>
</div>

<!-- 최신 레시피 -->
<div class="recent-section">
  <h2 class="section-title">최신 레시피</h2>
  <div class="recent-grid">
    <c:forEach var="item" items="${recentList}">
      <div class="recent-card">
        <a href="media/open.do?uuid=${item.uuid}">
          <img src="${item.recipeImageUrl}" alt="${item.title}">
          <div class="text-area">
            <h4>${item.title}</h4>
            <p>${item.ingredient}</p>
          </div>
        </a>
      </div>
    </c:forEach>
  </div>
</div>

<!-- 인기 랭킹 -->
<div class="ranking-section">
  <h2 class="section-title">인기 레시피 TOP 5</h2>
  <ol class="ranking-list">
    <c:forEach var="rank" items="${rankList}" varStatus="status">
      <li><a href="media/open.do?uuid=${rank.uuid}">${status.index + 1}위 - ${rank.title}</a></li>
    </c:forEach>
  </ol>
</div>

<!-- 커뮤니티 -->
<div class="community-section">
  <h2 class="section-title">커뮤니티 이야기</h2>
  <ul class="community-list">
    <c:forEach var="community" items="${communityList}">
      <li><a href="community/view.do?id=${community.id}">${community.title}</a></li>
    </c:forEach>
  </ul>
</div>
</div>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<!-- 토글 애니메이션 js -->
<script src="/js/nav.js"></script>

<!-- 테마 슬라이드 자동 전환 -->
<script>
  let slideIndex = 0;
  const slides = document.querySelectorAll('#themeSlider .slide');

  function showSlides() {
    slides.forEach((slide, idx) => {
      slide.style.display = idx === slideIndex ? 'block' : 'none';
    });
    slideIndex = (slideIndex + 1) % slides.length;
  }

  setInterval(showSlides, 3000);
  window.onload = showSlides;
</script>

<!-- 꼬리말 -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>