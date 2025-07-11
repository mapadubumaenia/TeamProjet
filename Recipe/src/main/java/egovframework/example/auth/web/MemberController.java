package egovframework.example.auth.web;

import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.auth.service.MemberService;
import egovframework.example.auth.service.MemberVO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;


	//	로그인 화면
	@GetMapping("/login.do")
	public String loginView() {
		return "auth/login";
	}

	// 로그인 처리
	@PostMapping("/loginProcess.do")
	public String login(HttpSession session,
			@ModelAttribute MemberVO loginVO) throws Exception {
		MemberVO memberVO=memberService.authenticateMember(loginVO);
		session.setAttribute("memberVO", memberVO);
		session.setAttribute("CSRF_TOKEN", UUID.randomUUID().toString());
		
		return "redirect:/";
	}
    
	//로그아웃
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/home.do";
	}
	
	//회원가입 페이지
	@GetMapping("/register.do")
	public String registerView() {
		return "auth/register";
	}
	
	//회원가입처리
	@PostMapping("/registeraddition.do")
	public String register(Model model, 
			@ModelAttribute MemberVO memberVO) throws Exception {
		log.info("테스트 : "+memberVO);
		MultipartFile profile = memberVO.getImage();
		
		if(profile != null && !profile.isEmpty()) {
			memberVO.setProfileImage(profile.getBytes());
		}else {
			ClassPathResource defaultImage = new ClassPathResource("static/images/default_profile.jpg");
			try (InputStream is = defaultImage.getInputStream()) {
	            byte[] defaultBytes = StreamUtils.copyToByteArray(is);
	            memberVO.setProfileImage(defaultBytes);
			}
		}
		
		memberService.register(memberVO); //  서비스의 회원가입 메소드 실행
		model.addAttribute("msg", "회원 가입을 성공했습니다."); //	성공메세지 전달
		
		return "auth/login";
	}
	
//	아이디 찾기 화면
	@GetMapping("/findid.do")
	public String findIdView() {
		return "auth/findid";
	}
	
	
	//아이디 찾기
	@PostMapping("/findidProcess.do")
	public String findId(@ModelAttribute MemberVO memberVO, Model model) throws Exception {
	    String userId = memberService.findId(memberVO);
	    
	    if (userId != null) {
	        model.addAttribute("result",userId);
	    } else {
	        model.addAttribute("errors", "일치하는 정보가 없습니다.");
	    }
		return "auth/findid";
	}
// 비밀번호 찾기 화면
	@GetMapping("/findpassword.do")
	public String findPasswordView() {
		return "auth/findpassword";
	}
//비밀번호 찾기 아이디 확인
	@PostMapping("/findpasswordProcess.do")
	public String findPassword(@ModelAttribute MemberVO memberVO, Model model) throws Exception {
	    MemberVO found = memberService.findPassword(memberVO);
	    if (found != null) {
	        model.addAttribute("userid", found.getUserId());
	        return "auth/changepassword"; // 비밀번호 재설정 폼
	    } else {
	        model.addAttribute("errors", "일치하는 회원이 없습니다.");
	        return "auth/findpassword";
	    }
	}
	
// 비밀번호 변경
	@PostMapping("/changepassProcess.do")
	public String resetPassword(@ModelAttribute MemberVO memberVO, Model model) throws Exception {
	    memberService.updatePassword(memberVO);
	    return "redirect:/login.do";
	}
	
//프로필 이미지 출력용
	@GetMapping("/member/profile-image.do")
	@ResponseBody
	public ResponseEntity<byte[]> getProfileImage(HttpSession session) {
	    MemberVO member = (MemberVO) session.getAttribute("memberVO");

	    byte[] imageBytes = member.getProfileImage();
	    if (imageBytes == null || imageBytes.length == 0) {
	        // 기본 이미지로 대체
	        try (InputStream is = new ClassPathResource("static/images/default-profile.png").getInputStream()) {
	            imageBytes = StreamUtils.copyToByteArray(is);
	        } catch (IOException e) {
	            return ResponseEntity.notFound().build();
	        }
	    }

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.IMAGE_PNG); // 또는 JPEG
	    return new ResponseEntity<>(imageBytes, headers, HttpStatus.OK);
	}
}
