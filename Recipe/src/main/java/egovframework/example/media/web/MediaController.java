/**
 * 
 */
package egovframework.example.media.web;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.auth.service.MemberVO;
import egovframework.example.common.Criteria;
import egovframework.example.like.service.LikeService;
import egovframework.example.like.service.LikeVO;
import egovframework.example.media.service.MediaService;
import egovframework.example.media.service.MediaVO;
import lombok.extern.log4j.Log4j2;

/**
 * @author user
 *
 */
@Log4j2
@Controller
public class MediaController {

	@Autowired
	private MediaService mediaService;
	
	@Autowired
	private LikeService likeService;

//  전체조회
	@GetMapping("/media/media.do")
	public String media(@ModelAttribute Criteria criteria, Model model) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(criteria.getPageIndex());
		paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
		criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

		@SuppressWarnings("unchecked")
	    List<MediaVO> all = (List<MediaVO>) mediaService.allMedia(criteria);
	    int totCnt = mediaService.allMediaTotCnt(criteria);
	    paginationInfo.setTotalRecordCount(totCnt);

	    // 좋아요 수 조회 후 setLikeCount 호출
	    for (MediaVO d : all) {
	        int cnt = likeService.countLikesByUuid(d.getUuid());
	        d.setLikeCount(cnt);
	    }

		model.addAttribute("all", all);
		model.addAttribute("paginationInfo", paginationInfo);

		return "media/media_all";
	}

//	전체조회 (영드게)
	@GetMapping("/media/movie.do")
	public String movie(@ModelAttribute Criteria criteria, Model model) {
		toModel(1, criteria, model);
		return "media/movie_all";
	}

	@GetMapping("/media/drama.do")
	public String drama(@ModelAttribute Criteria criteria, Model model) {
		toModel(2, criteria, model);
		return "media/drama_all";
	}

	@GetMapping("/media/game.do")
	public String game(@ModelAttribute Criteria criteria, Model model) {
		toModel(3, criteria, model);
		return "media/game_all";
	}

	private void toModel(int mediaCategory, Criteria criteria, Model model) {
		criteria.setMediaCategory(mediaCategory);
//	   - 필요정보: (1) 현재페이지번호(pageIndex),(2) 보일 개수(pageUnit): 3
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(criteria.getPageIndex());
		paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
		criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

		@SuppressWarnings("unchecked")
	    List<MediaVO> ask = (List<MediaVO>) mediaService.MediaList(criteria);
	    int totCnt = mediaService.MediaListTotCnt(criteria);
	    paginationInfo.setTotalRecordCount(totCnt);

	    // 좋아요 수 조회 후 setLikeCount 호출
	    for (MediaVO d : ask) {
	        int cnt = likeService.countLikesByUuid(d.getUuid());
	        d.setLikeCount(cnt);
	    }
	    
		model.addAttribute("ask", ask);
		model.addAttribute("paginationInfo", paginationInfo);
	
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	    HttpSession session = request.getSession(false);
	    if (session != null) {
	        @SuppressWarnings("unchecked")
	        List<MediaVO> recentMedia = (List<MediaVO>) session.getAttribute("recentMedia");
	        model.addAttribute("recentMedia", recentMedia);
	    }
	
	}

//상세조회페이지 열기
	@GetMapping("/media/open.do")
	public String open(@RequestParam String uuid, Model model, HttpSession session) {
		MediaVO mediaVO = mediaService.selectMedia(uuid);
		model.addAttribute("mediaVO", mediaVO);
		model.addAttribute("data", mediaVO);

		MemberVO current = (MemberVO) session.getAttribute("memberVO");	
		boolean isLiked = false;
		
        if (current != null) {
            model.addAttribute("currentNickname", current.getNickname());
		
		/* 좋아요 카운트 */
            LikeVO likeVO = new LikeVO();
            likeVO.setUserId(current.getUserId());
            likeVO.setTargetType("media");
            likeVO.setUuid(uuid);
            
            isLiked = likeService.countLikeByUser(likeVO) > 0;
        }
        /* 좋아요 카운트 조회 */
        int likeCount = likeService.countLikesByUuid(uuid);

        model.addAttribute("isLiked", isLiked);
        model.addAttribute("likeCount", likeCount);

     // 최근 본 미디어 목록 처리 
        @SuppressWarnings("unchecked")
        List<String> recentMedia = (List<String>) session.getAttribute("recentMedia");
        if (recentMedia == null) {
            recentMedia = new LinkedList<>();
        }
        // 중복 제거 후 가장 앞에 추가
        recentMedia.remove(uuid);
        recentMedia.add(0, uuid);
        // 최대 5개 유지
        if (recentMedia.size() > 5) {
            recentMedia = recentMedia.subList(0, 5);
        }
        session.setAttribute("recentMedia", recentMedia);

        // UUID 리스트 → MediaVO 리스트 매핑
        List<MediaVO> recentMediaList = recentMedia.stream()
            .map(id -> mediaService.selectMedia(id)) //uuid로 조회
            .filter(Objects::nonNull)                //null 제거
            .collect(Collectors.toList());
        model.addAttribute("recentMediaList", recentMediaList);

		return "media/open/media_open";
	}
// 좋아요 토글 AJAX 
	@PostMapping("/media/like.do")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> toggleLike(
	        @RequestParam String uuid,
	        HttpSession session) {
		// 로그인 확인
	    MemberVO current = (MemberVO) session.getAttribute("memberVO");
	    if (current == null) {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
	    }
	    
	    LikeVO likeVO = new LikeVO();
	    likeVO.setUserId(current.getUserId());
	    likeVO.setTargetType("media");
	    likeVO.setUuid(uuid);
	    // 좋아요 상태 토글
	    boolean nowLiked;
	    if (likeService.countLikeByUser(likeVO) > 0) {
	        likeService.deleteLike(likeVO);
	        nowLiked = false;
	    } else {
	        try {
	            likeService.insertLike(likeVO);
	            nowLiked = true;
	        } catch (DuplicateKeyException e) {
	            // 중복 insert 시도된 경우, 이미 좋아요 된 상태로 간주
	            nowLiked = true;
	        }
	    }
	    //총 좋아요 수
	    int total = likeService.countLikesByUuid(uuid);
	    
	    Map<String,Object> resp = new HashMap<>();
	    resp.put("liked", nowLiked);
	    resp.put("count", total);

	    return ResponseEntity.ok(resp);
	}

//추가페이지 열기
	@GetMapping("/media/addition.do")
	public String addition() {
		return "media/add_upload";
	}

//	@RequestParam(required = false) : 첨부파일 없어도 에러 발생 안하게 하는 옵션
//	첨부파일 다루기: (필수) 예외처리 필수
//	image.getBytes() : byte[] 배열로 변경
	@PostMapping("/media/add.do")
	public String insert(@RequestParam(defaultValue = "") String title,
			@RequestParam(defaultValue = "") int mediaCategory, 
			@RequestParam(defaultValue = "") String ingredient,
			@RequestParam(defaultValue = "") String content, 
			@RequestParam(required = false) MultipartFile recipeImage, HttpSession session,RedirectAttributes redirectAttributes)
			throws Exception {
		
		MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
		
		if (memberVO==null) {
			redirectAttributes.addFlashAttribute("error","로그인 후 업로드할 수 있습니다.");
			return "redirect:/login.do";
		}
		
		String userId = memberVO.getUserId();
		
		log.info("테스트 : " + title);
		log.info("테스트 : " + mediaCategory);
//		TODO: userId 하드코딩(mafa): 나중에 세션으로 처리
//		MediaVO mediaVO = new MediaVO("mafa",title, content, ingredient, mediaCategory, recipeImage.getBytes());
		MediaVO mediaVO = new MediaVO(userId, title, mediaCategory, ingredient, content, recipeImage.getBytes());
//		서비스의 insert 메소드 실행
		mediaService.insert(mediaVO);
		
//카테고리별로 이동하는 페이지 다르게 지정		
		 String redirectUrl;
		    switch (mediaCategory) {
		        case 1: redirectUrl = "redirect:/media/movie.do"; break;
		        case 2: redirectUrl = "redirect:/media/drama.do"; break;
		        case 3: redirectUrl = "redirect:/media/game.do"; break;
		        default: redirectUrl = "redirect:/media/media.do"; break;
		    }
		
		return redirectUrl;	
	}

//	다운로드 메소드: 사용자가 다운로드URL을 웹브라우저에서 실행하면 이 메소드가 첨부파일을 전달해줌
//	@ResponseBody: JSON으로(JS 객체) 데이터를 JSP로 전달해줌
	@GetMapping("/media/download.do")
	@ResponseBody
	public ResponseEntity<byte[]> fileDownload(@RequestParam(defaultValue = "") String uuid) {
		MediaVO mediaVO = mediaService.selectMedia(uuid);

		HttpHeaders headers = new HttpHeaders();

		headers.setContentDispositionFormData("attachment", mediaVO.getUuid());

		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

		return new ResponseEntity<byte[]>(mediaVO.getRecipeImage(), headers, HttpStatus.OK);
	}
	
//	수정페이지 열기(상세조회)
	@GetMapping("/media/edition.do")
	public String update(@RequestParam String uuid, Model model,HttpSession session) {

		MediaVO mediaVO=mediaService.selectMedia(uuid);
		MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
		
		if (memberVO==null || !memberVO.getUserId().equals(mediaVO.getUserId())) {
			return "redirect:/login.do";
		}

		model.addAttribute("mediaVO", mediaVO);
		return "media/update_media";
	}
	
//	수정: 버튼 클릭시 실행
	@PostMapping("/media/edit.do")
	public String updateedit(@RequestParam String uuid,
			@RequestParam(defaultValue = "") String title,
			@RequestParam(defaultValue = "") int mediaCategory, 
			@RequestParam(defaultValue = "") String ingredient,
			@RequestParam(defaultValue = "") String content, 
			@RequestParam(required = false) MultipartFile recipeImage,
			 HttpSession session) throws Exception {
//	서비스의 수정 실행
MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
		
		if (memberVO==null) {
			return "redirect:/login.do";
		}
		String userId = memberVO.getUserId();
		
		byte[] imageBytes;

	    if (recipeImage != null && !recipeImage.isEmpty()) {
	        // 새 이미지가 업로드된 경우
	        imageBytes = recipeImage.getBytes();
	    } else {
	        // 업로드된 파일이 없으면 기존 이미지 유지
	        MediaVO original = mediaService.selectMedia(uuid);
	        imageBytes = original.getRecipeImage();
	    }

		MediaVO mediaVO2 = new MediaVO(uuid, userId, title, mediaCategory, ingredient, content, imageBytes);
		mediaService.update(mediaVO2);
		
		//카테고리별로 이동하는 페이지 다르게 지정		
		 String redirectUrl;
		    switch (mediaCategory) {
		        case 1: redirectUrl = "redirect:/media/movie.do"; break;
		        case 2: redirectUrl = "redirect:/media/drama.do"; break;
		        case 3: redirectUrl = "redirect:/media/game.do"; break;
		        default: redirectUrl = "redirect:/media/media.do"; break;
		    }
		
		return redirectUrl;	
	}
	
//삭제
	@PostMapping("/media/delete.do")
	public String delete(@RequestParam("uuid") String uuid, HttpSession session, RedirectAttributes redirectAttributes) {

		MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");

		MediaVO mediaVO=mediaService.selectMedia(uuid);

		if (memberVO != null && mediaVO != null && mediaVO.getUserId().equals(memberVO.getUserId())) {
			mediaService.delete(mediaVO);
			return "redirect:/media/media.do";
		} else {
	        redirectAttributes.addFlashAttribute("error", "동일 작성자가 아닙니다.");
	        return "redirect:/media/detail.do?uuid=" + uuid; // 상세페이지로 다시 이동
	    }
	}


	
}
