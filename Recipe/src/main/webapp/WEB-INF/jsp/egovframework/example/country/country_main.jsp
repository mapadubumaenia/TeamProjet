<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>추천 테마</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="icon" href="/images/01.png" type="image/png">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/exstyle.css">
  <link rel="stylesheet" href="/css/country_main.css">
</head>
<body>
<jsp:include page="/common/header.jsp"></jsp:include>

<!-- 추천 테마 타이틀 -->
<div id="country" class="custom-container my-5">
  <div class="section-divider"></div>
  <h1 class="fw-bold">나라별 레시피</h1>
</div>

<!-- 국가별 카드들 -->
<div class="custom-container mb-5">
  <div class="row g-4">
    <!-- KOREA -->
    <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/korea_main.jpg" class="card-img" alt="한국">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">KOREA</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">요즘 대세 K-food 레시피</h5>
        </div>
        <p class="hover-text text-white mt-2">한식 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterCountry=1" class="stretched-link"></a>
      </div>
    </div>

    <!-- CHINA -->
    <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/china_main.jpg" class="card-img" alt="중국">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">CHINA</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">정통 중식 요리를 집에서 즐겨보세요</h5>
        </div>
        <p class="hover-text text-white mt-2">중식 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterCountry=2" class="stretched-link"></a>
      </div>
    </div>

    <!-- JAPAN -->
    <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/japan_main.jpg" class="card-img" alt="일본">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">JAPAN</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">간단하지만 섬세한 일식 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">일식 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterCountry=3" class="stretched-link"></a>
      </div>
    </div>

    <!-- FRANCE -->
    <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/france_main.jpg" class="card-img" alt="프랑스">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">FRANCE</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">고급스러운 프렌치 요리를 손쉽게</h5>
        </div>
        <p class="hover-text text-white mt-2">프랑스 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterCountry=4" class="stretched-link"></a>
      </div>
    </div>

    <!-- ITALY -->
    <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/italy_main.jpg" class="card-img" alt="이탈리아">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">ITALY</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">누구나 좋아하는 이탈리안 파스타 피자</h5>
        </div>
        <p class="hover-text text-white mt-2">이태리 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterCountry=5" class="stretched-link"></a>
      </div>
    </div>

    <!-- MIDDLE EAST -->
    <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/turkey_main.jpg" class="card-img" alt="중동">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">MIDDLE EAST</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">이국적인 향신료가 살아있는 중동 요리</h5>
        </div>
        <p class="hover-text text-white mt-2">중동 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterCountry=6" class="stretched-link"></a>
      </div>
    </div>

    <!-- GLOBAL -->
    <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/global_main.jpg" class="card-img" alt="기타">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">GLOBAL</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">다양한 나라의 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">다양한 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterCountry=7" class="stretched-link"></a>
      </div>
    </div>
<!-- 커밍순 카드 (hover 없음, 클릭 불가) -->
<div class="col-md-4">
  <div class="card border-0 shadow-sm d-flex align-items-center justify-content-center theme-card no-hover" style="background-color: #f1f1f1; height: 360px;">
    <div class="text-center px-4">
      <h5 class="fw-bold mb-2 text-muted">COMING SOON</h5>
      <p class="text-muted mb-0">더 많은 국가의 레시피를 준비하고 있어요.</p>
    </div>
  </div>
</div>

<!-- 커밍순 카드 (hover 없음, 클릭 불가) -->
<div class="col-md-4">
  <div class="card border-0 shadow-sm d-flex align-items-center justify-content-center theme-card no-hover" style="background-color: #f1f1f1; height: 360px;">
    <div class="text-center px-4">
      <h5 class="fw-bold mb-2 text-muted">COMING SOON</h5>
      <p class="text-muted mb-0">더 많은 국가의 레시피를 준비하고 있어요.</p>
    </div>
  </div>
</div>
  </div>
</div>

<!-- 재료별 테마 타이틀 -->
<div id="ingredient" class="custom-container my-5">
  <div class="section-divider"></div>
  <h1 class="fw-bold">재료별 레시피</h1>
</div>

<!-- 재료별 카드들 -->
<div class="custom-container mb-5">
  <div class="row g-4">
	    <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/pork_main.jpg" class="card-img" alt="돼지고기">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">PORK</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">돼지고기 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">돼지고기 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterIngredient=8" class="stretched-link"></a>
      </div>
    </div> 

	    <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/beef_main.jpg" class="card-img" alt="소고기">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">BEEF</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">소고기 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">소고기 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterIngredient=9" class="stretched-link"></a>
      </div>
    </div> 
	    <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/chiken_main.jpg" class="card-img" alt="닭고기">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">CHIKEN</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">닭고기 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">닭고기 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterIngredient=10" class="stretched-link"></a>
      </div>
    </div> 
    
       <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/seafood_main.jpg" class="card-img" alt="해산물">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">SEA FOOD</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">해산물 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">해산물 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterIngredient=11" class="stretched-link"></a>
      </div>
    </div> 
    
           <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/vegetable_main.jpg" class="card-img" alt="야채">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">VEGETABLES</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">야채 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">야채 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterIngredient=12" class="stretched-link"></a>
      </div>
    </div> 

       <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/others_main.jpg" class="card-img" alt="기타재료">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">OTHERS</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">기타재료 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">기타재료 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterIngredient=13" class="stretched-link"></a>
      </div>
    </div> 
  </div>
</div>

<!-- 상황별 테마 타이틀 -->
<div id="situation" class="custom-container my-5">
  <div class="section-divider"></div>
  <h1 class="fw-bold">상황별 레시피</h1>
</div>

<!-- 상황별 카드들 -->
<div class="custom-container mb-5">
  <div class="row g-4">
       <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/party_main.jpg" class="card-img" alt="파티요리">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">PARTIES</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">파티요리 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">파티요리 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterSituation=14" class="stretched-link"></a>
      </div>
    </div> 
    
       <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/simple_main.jpg" class="card-img" alt="심플요리">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">SIMPLES</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">간단요리 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">간단요리 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterSituation=15" class="stretched-link"></a>
      </div>
    </div> 
    
       <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/holiday_main.jpg" class="card-img" alt="명절요리">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">HOLIDAY</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">명절 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">명절 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterSituation=16" class="stretched-link"></a>
      </div>
    </div> 
      <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/diet_main.jpg" class="card-img" alt="다이어트요리">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">DIET RECIPES</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">다이어트 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">다이어트 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterSituation=17" class="stretched-link"></a>
      </div>
    </div> 
    
          <div class="col-md-4">
      <div class="card border-0 shadow-sm position-relative theme-card">
        <img src="/images/recipe/more_main.jpg" class="card-img" alt="기타요리">
        <div class="badge position-absolute top-0 start-0 m-3 bg-mocha text-white px-3 py-1">MORE</div>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
          <h5 class="text-white fw-bold">기타 레시피 모음</h5>
        </div>
        <p class="hover-text text-white mt-2">기타 레시피 모음 바로가기</p>
        <a href="/country/country.do?filterSituation=18" class="stretched-link"></a>
      </div>
    </div> 
    <div class="col-md-4">
  <div class="card border-0 shadow-sm d-flex align-items-center justify-content-center theme-card no-hover" style="background-color: #f1f1f1; height: 360px;">
    <div class="text-center px-4">
      <h5 class="fw-bold mb-2 text-muted">COMING SOON</h5>
      <p class="text-muted mb-0">더 많은 레시피를 준비중이에요.</p>
    </div>
  </div>
</div>
    
  </div>
</div>

 <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 토글 애니메이션 js -->
	<script src="/js/nav.js"></script>
<jsp:include page="/common/footer.jsp"></jsp:include>
</body>
</html>
