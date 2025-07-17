<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8"/>
  <title>Column</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/exstyle.css">
  <link rel="stylesheet" href="/css/column.css">
  <link rel="stylesheet" href="/css/all.css">
  <link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"
  />
  <style>
    /* 슬라이더용 스타일 */
    .slider-container { overflow: hidden; position: relative; margin-bottom: 2rem; }
    .slider-track {
      display: flex;
      will-change: transform;
    }
    .slider-track .col4 {
      flex: 0 0 auto;
      margin: 0 0.5%;
    }
  </style>
</head>
<body>
  <jsp:include page="/common/header.jsp"/>


<!-- ===== 1) 메인 배너 (Team Swiper) ===== -->
 
  <div style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff" class="swiper mySwiper mb-5">
    <div class="swiper-wrapper">
     <a class="swiper-slide"
   href="<c:url value='/drink/drink.do'/>"
   style="background-image: url('<c:url value="/images/column/drink2.jpg"/>');
          background-size: cover; background-position: center;">
  <div class="overlay">
    <div class="overlay-content">
      <div class="title"    data-swiper-parallax="-300">드링크</div>
      <div class="subtitle" data-swiper-parallax="-200">Subtitle</div>
      <div class="text"     data-swiper-parallax="-100">
        <p>다양한 드링크 레시피를 만나보세요.</p>
      </div>
    </div>
  </div>
</a>
   <!-- 2) 손질법 -->
<a class="swiper-slide"
   href="<c:url value='/method/method.do'>
            <c:param name='methodType' value='storage'/>
         </c:url>"
   style="background-image: url('<c:url value="/images/column/sonjil2.jpg"/>');
          background-size: cover; background-position: center;">
  <div class="overlay">
    <div class="overlay-content">
      <div class="title"    data-swiper-parallax="-300">손질법</div>
      <div class="subtitle" data-swiper-parallax="-200">Subtitle</div>
      <div class="text"     data-swiper-parallax="-100">
        <p>재료 손질의 꿀팁을 알려드려요.</p>
      </div>
    </div>
  </div>
</a>

<!-- 3) 보관법 -->
<a class="swiper-slide"
   href="<c:url value='/method/method.do'>
            <c:param name='methodType' value='trim'/>
         </c:url>"
   style="background-image: url('<c:url value="/images/column/bogan5.jpg"/>');
          background-size: cover; background-position: center;">
  <div class="overlay">
    <div class="overlay-content">
      <div class="title"    data-swiper-parallax="-300">보관법</div>
      <div class="subtitle" data-swiper-parallax="-200">Subtitle</div>
      <div class="text"     data-swiper-parallax="-100">
        <p>신선한 식재료들을 안전하게 보관해요.</p>
      </div>
    </div>
  </div>
</a>
    </div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-pagination"></div>
  </div>

  <div class="page mt3">
    <!-- 드링크 추천 -->
    <h3 class="section-header">추천 드링크</h3>
    <div class="slider-container">
      <div class="slider-track">
        <!-- 실제 카드 목록 -->
        <c:forEach var="d" items="${topDrinks}">
          <div class="slider-item col4 mb3">
            <a href="<c:url value='/drink/detail.do'><c:param name='uuid' value='${d.uuid}'/></c:url>">
              <div class="card">
                <img src="${d.columnUrl}" class="card-img-top" alt="${d.columnTitle}"/>
                <div class="card-body d-flex">
                  <h5 class="card-title">${d.columnTitle}</h5>
                  <span class="like-badge">&#10084; ${d.likeCount}</span>
                </div>
              </div>
            </a>
          </div>
        </c:forEach>
        <!-- 반복 복제: seamless 루프를 위해 같은 리스트 한 번 더 -->
        <c:forEach var="d" items="${topDrinks}">
          <div class="slider-item col4 mb3">
            <!-- ... 동일 카드 마크업 ... -->
            <a href="<c:url value='/drink/detail.do'><c:param name='uuid' value='${d.uuid}'/></c:url>">
              <div class="card">
                <img src="${d.columnUrl}" class="card-img-top" alt="${d.columnTitle}"/>
                <div class="card-body d-flex">
                  <h5 class="card-title">${d.columnTitle}</h5>
                  <span class="like-badge">&#10084; ${d.likeCount}</span>
                </div>
              </div>
            </a>
          </div>
        </c:forEach>
      </div>
    </div>

    <!-- 보관법 추천 (같은 구조) -->
    <h3 class="section-header">손질법</h3>
   <div class="slider-container reverse"><!-- ← 여기 -->
      <div class="slider-track">
        <c:forEach var="m" items="${topStore}">
          <div class="slider-item col4 mb3">
            <a href="<c:url value='/method/detail.do'>
                         <c:param name='uuid' value='${m.uuid}'/>
                         <c:param name='methodType' value='storage'/>
                       </c:url>">
              <div class="card">
                <img src="${m.methodUrl}" class="card-img-top" alt="${m.methodTitle}"/>
                <div class="card-body d-flex">
                  <h5 class="card-title">${m.methodTitle}</h5>
                  <span class="like-badge">&#10084; ${m.likeCount}</span>
                </div>
              </div>
            </a>
          </div>
        </c:forEach>
        <c:forEach var="m" items="${topStore}">
          <!-- 복제 -->
          <div class="slider-item col4 mb3"> … </div>
        </c:forEach>
      </div>
    </div>

    <!-- 손질법 추천 -->
    <h3 class="section-header">보관법</h3>
    <div class="slider-container">
      <div class="slider-track">
        <c:forEach var="m" items="${topPrep}">
          <div class="slider-item col4 mb3">
            <a href="<c:url value='/method/detail.do'>
                         <c:param name='uuid' value='${m.uuid}'/>
                         <c:param name='methodType' value='trim'/>
                       </c:url>">
              <div class="card">
                <img src="${m.methodUrl}" class="card-img-top" alt="${m.methodTitle}"/>
                <div class="card-body d-flex">
                  <h5 class="card-title">${m.methodTitle}</h5>
                  <span class="like-badge">&#10084; ${m.likeCount}</span>
                </div>
              </div>
            </a>
          </div>
        </c:forEach>
        <c:forEach var="m" items="${topPrep}">
          <!-- 복제 -->
          <div class="slider-item col4 mb3"> … </div>
        </c:forEach>
      </div>
    </div>
  </div>

  <jsp:include page="/common/footer.jsp"/>
   <!-- JQuery, Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
  <script>
    // Swiper 초기화
    const swiper = new Swiper('.mySwiper', {
      speed: 1000,
      parallax: true,
      loop: true,
      pagination: { el: '.swiper-pagination', clickable: true },
      navigation: { nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev' },
    });
  </script>
  
</body>
</html>