<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="custom-header">
  <div class="brand">
    <a class="navbar-brand" href="/home.do">RecipeCode</a>
  </div>
  
<!-- 나중에 세션에따라 안 보이게 바꾸는 코딩 필요 -->  
  <div class="buttons">
        <!-- memberVO 가 세션에 없으면 메뉴을 보이고, 있으면 안보임 -->
        <c:if test="${sessionScope.memberVO == null}">
  	         <a class="link" href="<c:url value='/login.do'/>">로그인</a>
  	         <a class="link" href="<c:url value='/register.do'/>">회원가입</a>
        </c:if>
        
          <!-- {/* 로그인 끝 */} -->
          
          
          <!-- {/* 로그아웃 시작 */} -->
        <c:if test="${sessionScope.memberVO != null}">
             <img src="<c:url value='/member/profile-image.do'/>" 
             alt="프로필 이미지" 
             width="32" height="32"
             style="border-radius: 50%; object-fit: cover; margin-right: 8px;" />
          	 <p class="nickname">${sessionScope.memberVO.nickname}님</p>
  	         <a class="link" href="<c:url value='/logout.do'/>">로그아웃</a>
  	         <a class="link" href="<c:url value='/mypage.do'/>">마이페이지</a>
        </c:if>

  </div>
           <!-- {/* 로그아웃 끝 */} -->

  
  <div class="menu-toggle">
  <img alt="메뉴" src="/images/02.png" width="20">
  </div>
 
  <nav class="main-nav pr4">
    <ul class="menu">
      <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button">
             recipes
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<c:url value='/country/country.do'/>">나라별</a></li>
            <li><a class="dropdown-item" href="<c:url value='/dept/dept.do'/>">재료별</a></li>
            <li><a class="dropdown-item" href="<c:url value='/dept/dept.do'/>">상황별</a></li>
          </ul>
        </li>
      
      <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="<c:url value='/media/media.do'/>" role="button">
            media
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<c:url value='/media/movie.do'/>">영화</a></li>
            <li><a class="dropdown-item" href="<c:url value='/media/drama.do'/>">드라마</a></li>
            <li><a class="dropdown-item" href="<c:url value='/media/game.do'/>">게임</a></li>
          </ul>
      </li>

    	<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle"   href="<c:url value='/column.do'/>" role="button"> crumb </a>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item"
						href="<c:url value='/drink/drink.do'/>"> 드링크 </a></li>
					<li><a class="dropdown-item"
						href="<c:url value='/method/method.do'>
               <c:param name='methodType' value='storage'/>
             </c:url>">
							손질법 </a></li>
					<li><a class="dropdown-item"
						href="<c:url value='/method/method.do'>
               <c:param name='methodType' value='trim'/>
             </c:url>">
							보관법 </a></li>
				</ul></li>

			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" role="button"> cooklog
			</a>
				<ul class="dropdown-menu">
		  <li><a class="dropdown-item" 
href="<c:url value='/community/community.do'/>">자유게시판</a></li>
					<li><a class="dropdown-item"
						href="<c:url value='/dept/dept.do'/>">질문게시판</a></li>
				</ul></li>
		</ul>
  </nav>
  <div class="search-bar pt3">
  <form action="/search" method="get">
    <input type="text" name="query" placeholder="검색어를 입력하세요" aria-label="검색어 입력" />
    <button type="submit">검색</button>
  </form>
</div>
</div>

