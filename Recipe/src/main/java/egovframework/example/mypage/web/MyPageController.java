package egovframework.example.mypage.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.auth.service.MemberVO;
import egovframework.example.common.Criteria;
import egovframework.example.mypage.service.MyPageService;
import egovframework.example.mypage.service.MyPostVO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class MyPageController {
  @Autowired
  MyPageService myPageService;
	
	@GetMapping("/mypage.do")
	public String myPageView(HttpSession session,Model model) {
		MemberVO member = (MemberVO) session.getAttribute("memberVO");
		if(member == null) {
			return "redirect:/login.do";
		}
		model.addAttribute("memberInfo", member);
		return "mypage/mypage_home";
		
	}
	
	
	@RequestMapping(value = "/mypage/myrecipes.do", produces = "text/html; charset=UTF-8")
	public String getMyRecipes(HttpSession session, Model model) {
	    MemberVO member = (MemberVO) session.getAttribute("memberVO");

        
	    List<MyPostVO> recipeList = myPageService.selectMyRecipes(member.getUserId());


	    model.addAttribute("recipeList", recipeList);
	    
	    
	    return "mypage/include/myrecipes"; // 부분 렌더링용 JSP
	}
	
	@GetMapping("/mypage/image.do")
	public void downloadImage(@RequestParam String uuid, HttpServletResponse response) throws IOException {
	    MyPostVO post = myPageService.selectOneByUuid(uuid);

	    if (post == null || post.getMainImage() == null) {
	        // post가 없거나 이미지가 없으면 기본 이미지로 리디렉션
	        response.sendRedirect("/images/default.jpg");
	        return;
	    }

	    byte[] imageBytes = post.getMainImage();

	    response.setContentType("image/png");
	    response.setHeader("Content-Disposition", "inline; filename=\"" + uuid + "\"");
	    response.setContentLength(imageBytes.length);

	    response.getOutputStream().write(imageBytes);
	    response.getOutputStream().flush();
	    response.getOutputStream().close();

	}
}
