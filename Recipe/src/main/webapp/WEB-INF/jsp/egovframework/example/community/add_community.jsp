<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
   <title>Community Add</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <!--    부트스트랩 css  -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
   <!--    개발자 css -->
   <link rel="stylesheet" href="/css/style.css">
   <link rel="stylesheet" href="/css/exstyle.css">
   <link rel="stylesheet" href="/css/Community.css">
</head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div class="container mt-4">
<br>
<br>
    
        
       <form method="post" action="/community/addition.do" enctype="multipart/form-data">
    <input type="hidden" name="communityCategoryId" value="1" />

    

    <div class="mb-3">
        <label for="communityTitle" class="form-label">제목</label>
        <input type="text" class="form-control" id="communityTitle" name="communityTitle" required />
    </div>

    <div class="mb-3">
        <label for="communityImage" class="form-label">이미지 첨부</label>
        <input type="file" class="form-control" id="communityImage" name="uploadFile" accept="image/*" />
    </div>

    <div class="mb-3">
        <label for="communityContent" class="form-label">내용</label>
        <textarea class="form-control" id="communityContent" name="communityContent" rows="10" required></textarea>
    </div>

    <button type="submit" class="btn btn-primary">등록</button>
    <a href="<c:url value='/community/community.do'/>" class="btn btn-secondary">목록으로</a>
</form>
    
</div>




</body>
</html>