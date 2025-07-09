package egovframework.example.cmmn.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthenticInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
//		로그인체크
		HttpSession session = request.getSession(false);
//		memberVO가 없으면 로그인 페이지로 자동이동
		if(session == null || session.getAttribute("memberVO") == null) {
			response.sendRedirect("/login.do"); // 로그인 강제이동
			return false;
		}
//		보안코딩: POST(입력/수정/삭제) 일때만
		if("POST".equals(request.getMethod())) {
//			1) 세션에서 CSRF_TOKEN 을 가져오기
			String sessionToken = (String) session.getAttribute("CSRF_TOKEN");
//			2) JSP에서 csrf 이름으로 쿼리스트링 정보 가져오기
			String requestToken = request.getParameter("csrf");
//			3) 1,2를 같은 지 비교: 다르면 에러처리
            if (sessionToken == null || !sessionToken.equals(requestToken)) {
            	throw new Exception("csrf 위반입니다.");
            }
		}
		
		return true; //통과
	}
	
	
}
