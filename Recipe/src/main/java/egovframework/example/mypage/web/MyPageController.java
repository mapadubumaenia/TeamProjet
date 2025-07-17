package egovframework.example.mypage.web;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.auth.service.MemberVO;
import egovframework.example.mypage.service.MyPageService;
import egovframework.example.mypage.service.MyPostVO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class MyPageController {
  @Autowired
  MyPageService myPageService;
	//메인페이지
	@GetMapping("/mypage.do")
	public String myPageView(HttpSession session,Model model) {
		MemberVO member = (MemberVO) session.getAttribute("memberVO");
		if(member == null) {
			return "redirect:/login.do";
		}
		model.addAttribute("memberInfo", member);
		return "mypage/mypage_home";
		
	}
	
	//내가 작성한 레시피
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
	
	//좋아요한 레시피
	//내가 작성한 댓글
	//좋아요한 댓글
	
	
	
	
	
	//겅보 조회 및 수정
	//비밀번호확인
	@PostMapping("/mypage/checkPassword.do")
	@ResponseBody
	public ResponseEntity<String> checkPassword(@RequestParam("password") String password, HttpSession session) {
	    MemberVO member = (MemberVO) session.getAttribute("memberVO");
	    
	    if (member == null) {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("notLoggedIn");
	    }

	    boolean isMatch = myPageService.checkPassword(member.getUserId(), password);

	    if (isMatch) {
	        return ResponseEntity.ok("success");
	    } else {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("wrongPassword");
	    }
	}
	
	
	//정보수정화면
	@RequestMapping(value = "/mypage/updateForm.do", produces = "text/html; charset=UTF-8")
	public String updateForm(HttpSession session, Model model) {
	    MemberVO member = (MemberVO) session.getAttribute("memberVO");
	    
	    if (member == null) return "redirect:/login.do";

	    MemberVO updated = myPageService.getMemberById(member.getUserId());
	    model.addAttribute("memberVO", updated);
	    return "mypage/include/updateForm";
	}
	
	
	//정보수정
	 @PostMapping("/mypage/updateMember.do")
	    public String updateMember(@ModelAttribute MemberVO memberVO, HttpSession session, RedirectAttributes rttr) {
		
			 MemberVO sessionMember = (MemberVO) session.getAttribute("memberVO");
			 String userId = sessionMember.getUserId();
			 
			 
			//이미지처리
	        
			try {
				 MultipartFile imageFile = memberVO.getImage();
	        if (imageFile != null && !imageFile.isEmpty()) {
	                memberVO.setProfileImage(imageFile.getBytes());
	        }else {
	            // 이미지 미업로드 시 기존 이미지 유지
	            byte[] existingImage = myPageService.getProfileImage(userId);
	            memberVO.setProfileImage(existingImage);
	        }
	            rttr.addFlashAttribute("message", "수정이 완료되었습니다.");
	        }
			catch (IOException e) {
	            rttr.addFlashAttribute("message", "이미지 업로드 중 오류 발생");
	        }
	      //비밀번호 
		 
		    if(memberVO.getPassword() == null || memberVO.getPassword().isEmpty()) {
		        // 기존유지
		    	   String existingPassword = myPageService.getPasswordByUserId(memberVO.getUserId());
		           memberVO.setPassword(existingPassword);
		        
		    } else {
		        //  새 비밀번호 해싱
			        String hashedPassword = BCrypt.hashpw(memberVO.getPassword(), BCrypt.gensalt());
			        memberVO.setPassword(hashedPassword);
		    }
		    session.setAttribute("memberVO", memberVO);
		    myPageService.updateMember(memberVO);
		    
	        return "redirect:/mypage.do";
	    }
	 
	// ✔️ 프로필 이미지 출력
	    @GetMapping("/mypage/profile-image.do")
		@ResponseBody
		public ResponseEntity<byte[]> getProfileImage(HttpSession session) {
		    MemberVO member = (MemberVO) session.getAttribute("memberVO");

		    if (member == null) {
		        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		    }
		    
		    byte[] imageBytes = myPageService.getProfileImage(member.getUserId());
		    
		    if (imageBytes == null || imageBytes.length == 0) {
		        imageBytes = myPageService.getProfileImage(member.getUserId());
		    }
		    
		    if (imageBytes == null || imageBytes.length == 0) {
		        // 기본 이미지로 대체
		        try (InputStream is = new ClassPathResource("static/images/default_profile.jpg").getInputStream()) {
		            imageBytes = StreamUtils.copyToByteArray(is);
		        } catch (IOException e) {
		            return ResponseEntity.notFound().build();
		        }
		    }

		    //자동 Content-Type 감지
		    String contentType = "application/octet-stream";
		    try (InputStream is = new ByteArrayInputStream(imageBytes)) {
		        String detectedType = URLConnection.guessContentTypeFromStream(is);
		        if (detectedType != null) {
		            contentType = detectedType;
		        }
		    } catch (IOException e) {
		        // fallback 유지
		    }
		    
		    
		    HttpHeaders headers = new HttpHeaders();
		    headers.setContentType(MediaType.parseMediaType(contentType));
		    return new ResponseEntity<>(imageBytes, headers, HttpStatus.OK);
		}
	    
	//회원탈퇴
		@PostMapping("/mypage/deleteMember.do")
		public String deleteMember(HttpSession session, RedirectAttributes rttr) {
		    MemberVO member = (MemberVO) session.getAttribute("memberVO");
		    if (member == null) {
		        return "redirect:/login.do";
		    }

		    try {
		        myPageService.deleteMember(member.getUserId());
		        session.invalidate(); // 세션 무효화
		        rttr.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");
		        return "redirect:/"; // 홈으로
		    } catch (Exception e) {
		        rttr.addFlashAttribute("message", "탈퇴 중 오류가 발생했습니다.");
		        return "redirect:/mypage.do";
		    }
		}
	
}
