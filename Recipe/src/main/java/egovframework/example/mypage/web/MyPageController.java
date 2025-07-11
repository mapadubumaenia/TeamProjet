package egovframework.example.mypage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import egovframework.example.mypage.service.MyPageService;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class MyPageController {
  @Autowired
  MyPageService myPageService;
	
	@GetMapping("/mypage.do")
	public String myPageView() {
		return "mypage/mypage_home";
		
	}
}
