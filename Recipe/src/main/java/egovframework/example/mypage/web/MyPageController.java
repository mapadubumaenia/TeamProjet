package egovframework.example.mypage.web;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
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
import egovframework.example.common.Criteria;
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
	@RequestMapping(value ="/mypage/myrecipes.do", produces = "text/html; charset=UTF-8")
	public String getMyRecipes(HttpSession session,
		    Model model,
		    @RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex) {

		    MemberVO member = (MemberVO) session.getAttribute("memberVO");
		    if (member == null) {
		        return "redirect:/login.do";
		    }

		    Criteria criteria = new Criteria();
		    criteria.setPageIndex(pageIndex);
		    criteria.setUserId(member.getUserId());


		    // 페이징 계산
		    PaginationInfo paginationInfo = new PaginationInfo();
		    paginationInfo.setCurrentPageNo(criteria.getPageIndex());
		    paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
		    criteria.setStartRow((pageIndex - 1) * criteria.getPageUnit());
		    criteria.setEndRow(pageIndex * criteria.getPageUnit());
		    

		    List<MyPostVO> recipeList = myPageService.selectMyRecipes(criteria);
		    int totalCount = myPageService.selectMyRecipesCount(criteria);
		    paginationInfo.setTotalRecordCount(totalCount);

		    System.out.println("pageIndex: " + criteria.getPageIndex());
		    System.out.println("startRow: " + criteria.getStartRow());
		    System.out.println("endRow: " + criteria.getEndRow());
		    
		    // model에 포함시켜야 JSP에 반영됨
		    model.addAttribute("paginationInfo", paginationInfo);
		    model.addAttribute("recipeList", recipeList);
		    model.addAttribute("criteria", criteria); // 꼭 포함!
		    
	    return "mypage/include/myrecipes"; // 부분 렌더링용 JSP
	}
	
	@GetMapping("/mypage/image.do")
	@ResponseBody
	public ResponseEntity<byte[]> downloadImage(@RequestParam String uuid) {
	    MyPostVO post = myPageService.selectOneByUuid(uuid);

	    byte[] imageBytes = null;

	    if (post != null && post.getMainImage() != null) {
	        imageBytes = post.getMainImage();
	    }

	    // 이미지가 없는 경우 기본 이미지로 대체
	    if (imageBytes == null || imageBytes.length == 0) {
	        try (InputStream is = new ClassPathResource("static/images/default.jpg").getInputStream()) {
	            imageBytes = StreamUtils.copyToByteArray(is);
	        } catch (IOException e) {
	            return ResponseEntity.notFound().build();
	        }
	    }

	    // MIME 타입 자동 감지
	    String contentType = "application/octet-stream";
	    try (InputStream is = new ByteArrayInputStream(imageBytes)) {
	        String detectedType = URLConnection.guessContentTypeFromStream(is);
	        if (detectedType != null) {
	            contentType = detectedType;
	        }
	    } catch (IOException e) {
	        // 무시하고 기본값 사용
	    }

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.parseMediaType(contentType));

	    return new ResponseEntity<>(imageBytes, headers, HttpStatus.OK);
	}
	
	//좋아요한 레시피
	@RequestMapping(value ="/mypage/likedrecipes.do", produces = "text/html; charset=UTF-8")
	public String getLikedRecipes(
	    HttpSession session,
	    Model model,
	    @RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex) {

	    MemberVO member = (MemberVO) session.getAttribute("memberVO");
	    if (member == null) {
	        return "redirect:/login.do";
	    }

	    Criteria criteria = new Criteria();
	    criteria.setPageIndex(pageIndex);
	    criteria.setUserId(member.getUserId());


	    // 페이징 계산
	    PaginationInfo paginationInfo = new PaginationInfo();
	    paginationInfo.setCurrentPageNo(criteria.getPageIndex());
	    paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
	    criteria.setStartRow((pageIndex - 1) * criteria.getPageUnit());
	    criteria.setEndRow(pageIndex * criteria.getPageUnit());
	    

	    List<MyPostVO> recipeList = myPageService.selectLikedRecipes(criteria);
	    int totalCount = myPageService.selectLikedRecipesCount(criteria);
	    paginationInfo.setTotalRecordCount(totalCount);

	    System.out.println("pageIndex: " + criteria.getPageIndex());
	    System.out.println("startRow: " + criteria.getStartRow());
	    System.out.println("endRow: " + criteria.getEndRow());
	    
	    // model에 포함시켜야 JSP에 반영됨
	    model.addAttribute("paginationInfo", paginationInfo);
	    model.addAttribute("recipeList", recipeList);
	    model.addAttribute("criteria", criteria); // 꼭 포함!
	    
	    return "mypage/include/likedrecipes";
	}
	//내가 작성한 댓글
	//좋아요한 댓글
	
	
	
	
	
	//겅보 조회 및 수정
	//비밀번호확인
	@PostMapping("/mypage/checkPassword.do")
	@ResponseBody    //컨트롤러의 반환값을 JSON이나 XML 같은 HTTP 응답 본문(Response Body)으로 직접 보내기
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
			 
			 
			// 닉네임 중복 확인
	        if (myPageService.isNicknameDuplicate(memberVO.getNickname(), userId)) {
	        rttr.addFlashAttribute("message", "이미 사용 중인 닉네임입니다.");			       
	        return "redirect:/mypage.do";
	        }
			 
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
		    
		    
		    myPageService.updateMember(memberVO);
		    
		    session.setAttribute("memberVO", memberVO);
		    rttr.addFlashAttribute("message", "수정이 완료되었습니다.");
		    
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
