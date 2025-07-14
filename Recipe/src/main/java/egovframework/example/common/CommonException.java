package egovframework.example.common;



import javax.servlet.http.HttpServletRequest;

/*
 * @ControllerAdvice :컨트롤러에서 에러가 발생하면 무조건 여기로 오게하는 어노테이션(클래스)
 * 전역 에러처리
 * @ExceptionHandler(특정 예외클래스):  특정 예외클래스에 해당하는 에러가 발생하면 밑에 메소드가 실행됨
 * 
 * Exception => 모든에러
 */
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.log4j.Log4j;

@Log4j
@ControllerAdvice
public class CommonException {
   
//  컨트롤러에서 어떤 에러가 발생하더라도 이 함수가 실행됨
    @ExceptionHandler(Exception.class)
    public String internalServerErrorException(Exception e
    		, Model model, HttpServletRequest request
    		) {
        String errors = e.getMessage();   //에러 내용
        log.info("에러: " + errors);        //에러를 모델에 담기
    	if (errors.contains("UQ_USERS_PHONE")) {
            model.addAttribute("errors", "중복된 전화번호입니다");
        }
    	else if (errors.contains("UQ_EMAIL")) {
            model.addAttribute("errors", "중복된 이메일입니다");
        }
    	 else if(errors.contains("UQ_REGISTER")) {
             model.addAttribute("errors","중복된 정보입니다");
         }
    	 else if(errors.contains("UQ_NICKNAME")) {
             model.addAttribute("errors", "중복된 별명입니다");
         }
    	
    	 else {
    	        model.addAttribute("errors", errors);  
    	 }
        String uri = request.getRequestURI();
        log.info("요청 URI: " + uri);

        if (uri.contains("/login") || uri.contains("/loginProcess")) {
            return "auth/login";      // 로그인 에러는 로그인 페이지로
        } else if (uri.contains("/register")) {
            return "auth/register";   // 회원가입 에러는 회원가입 페이지로
        }
        else if (uri.contains("/findid" )) {
            return "auth/findid";   // 아이디찾기 에러는 아이디찾기 페이지로
        }
        else if (uri.contains("/findpassword" )) {
            return "auth/findpassword";   // 아이디찾기 에러는 아이디찾기 페이지로
        }
        

        return "errors"; // 기본 에러 페이지
    	
    }
}
    
