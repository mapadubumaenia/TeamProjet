package egovframework.example.method.web;

import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.auth.service.MemberService;
import egovframework.example.auth.service.MemberVO;
import egovframework.example.drink.service.DrinkVO;
import egovframework.example.like.service.LikeService;
import egovframework.example.like.service.LikeVO;
import egovframework.example.method.service.MethodService;
import egovframework.example.method.service.MethodVO;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class MethodController {

    @Autowired
    private MethodService methodService;
    
    // MemberService 주입
    @Autowired
    private MemberService memberService;
    
 // ↓ 이 부분 추가 ↓
    @Autowired
    private LikeService likeService;

    // 1) 리스트 조회
    @GetMapping("/method/method.do")
    public String selectMethodList(
            @ModelAttribute MethodVO criteria,
            @RequestParam(name="methodType", required=false, defaultValue="storage") String methodType,
            @RequestParam(name="category", required=false, defaultValue="") String category,
            Model model) {

        criteria.setMethodType(methodType);

        
      //1)등차자동계산 클래스:PaginationInfo
      		// -필요정보: (1) 현재페이지번호(pageIndex), 2)보일개수  (pageUnit): 3 
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(criteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
      //등차를 자동 계산 결과: paginationInfo.getFirstRecordIndex 여기에있음
        criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

        
        // 카테고리 세팅
        if (!category.isEmpty()) {
            criteria.setCategory(category);
        }
        model.addAttribute("selectedCategory", category);
        model.addAttribute("methodType", methodType);

        
        
        // (1) 드링크 리스트 가져오기
	    @SuppressWarnings("unchecked")
	    List<MethodVO> methods = (List<MethodVO>) methodService.selectMethodList(criteria);
	    
	    // (2) 각 UUID마다 좋아요 수 조회해서 setLikeCount 호출
	    for (MethodVO d : methods) {
	        int cnt = likeService.countLikesByUuid(d.getUuid());
	        d.setLikeCount(cnt);
	    }
	    model.addAttribute("methods", methods);
        
        

        
        
      //페이지 번호 그리기: 페이지 플러그인(전체테이블 행 개수)
        int totCnt = methodService.selectMethodListTotCnt(criteria);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "method/method_all";
    }

    // 2) 등록 폼 열기
    @GetMapping("/method/addition.do")
    public String createMethodView(
            @RequestParam(name="methodType", required=false, defaultValue="storage") String methodType,
            Model model) {

        model.addAttribute("methodVO", new MethodVO());
        model.addAttribute("methodType", methodType);
        return "method/add_method";
    }

    // 3) INSERT
    @PostMapping("/method/add.do")
    public String insert(
            @RequestParam(name="methodType", required=false, defaultValue="storage") String methodType,
            @RequestParam(defaultValue = "") String methodTitle,
            @RequestParam(defaultValue = "") String methodContent,
            @RequestParam(defaultValue = "") String category,
            @RequestParam(required = false) MultipartFile image,
            HttpSession session
    ) throws Exception {
    	
    	
    	 // 2) VO 생성
        MethodVO methodVO = new MethodVO(methodTitle, methodContent, category, image.getBytes());
        
        methodVO.setMethodType(methodType);
        if (image != null && !image.isEmpty()) {
            methodVO.setMethodData(image.getBytes());
        }
        
        // 3) 세션에서 로그인된 회원 정보 꺼내기
	    MemberVO current = (MemberVO) session.getAttribute("memberVO");
	    if (current == null) {
	        throw new IllegalStateException("로그인 정보가 없습니다.");
	    }
	    methodVO.setUserId(current.getUserId());
        
        
     // 4) 서비스 호출 (UUID·URL 세팅 포함)
        methodService.insert(methodVO);
        return "redirect:/method/method.do?methodType=" + methodType;
    }

    // 4) 다운로드
    @GetMapping("/method/download.do")
    @ResponseBody
    public ResponseEntity<byte[]> findDownload(@RequestParam String uuid) {
        MethodVO methodVO = methodService.selectMethod(uuid);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDispositionFormData("attachment", methodVO.getUuid());
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<>(methodVO.getMethodData(), headers, HttpStatus.OK);
    }

    // 5) 삭제
    @PostMapping("/method/delete.do")
    public String delete(
            @RequestParam String uuid,
            @RequestParam(name="methodType", required=false, defaultValue="storage") String methodType
    ) {
        methodService.delete(uuid);
        return "redirect:/method/method.do?methodType=" + methodType;
    }

    

    // 7) 미리보기 모달
    @PostMapping("/method/preview.do")
    public String preview(
            @RequestParam(defaultValue = "") String methodTitle,
            @RequestParam(defaultValue = "") String methodContent,
            @RequestParam(defaultValue = "") String category,
            @RequestParam(required = false) MultipartFile image,
            Model model) throws IOException {

        MethodVO previewVO = new MethodVO();
        previewVO.setMethodTitle(methodTitle);
        previewVO.setMethodContent(methodContent);
        previewVO.setCategory(category);
        if (image != null && !image.isEmpty()) {
            byte[] bytes = image.getBytes();
            previewVO.setMethodData(bytes);
            String base64 = Base64.getEncoder().encodeToString(bytes);
            previewVO.setMethodUrl("data:" + image.getContentType() + ";base64," + base64);
        }
        model.addAttribute("preview", previewVO);
        return "method/previewFragment";
    }
    
    //상세조회 페이지
    @GetMapping("/method/detail.do")
    public String detailPage(
            @RequestParam String uuid,
            @RequestParam(name="methodType", required=false, defaultValue="storage") String methodType,
            Model model, HttpSession session   ) {

        // 1) 글 데이터
        MethodVO vo = methodService.selectMethod(uuid);
        model.addAttribute("method", vo);
        model.addAttribute("methodType", methodType);
        
        
        // 3) (선택) 현재 로그인한 닉네임
        MemberVO current = (MemberVO) session.getAttribute("memberVO");
        if (current != null) {
            model.addAttribute("currentNickname", current.getNickname());
        }
        
        
        // ─── ② 최근 본 항목 로직 (옵션) ───────────────────
        @SuppressWarnings("unchecked")
        List<String> recent = (List<String>) session.getAttribute("recentMethods");
        if (recent == null) recent = new LinkedList<>();
        recent.remove(uuid);
        recent.add(0, uuid);
        if (recent.size() > 5) recent = recent.subList(0, 5);
        session.setAttribute("recentMethods", recent);
        List<MethodVO> recentMethods = recent.stream()
            .map(id -> methodService.selectMethod(id))
            .collect(Collectors.toList());
        model.addAttribute("recentMethods", recentMethods);
        // ────────────────────────────────────────────

        // 5) 좋아요 상태 & 카운트
        boolean isLiked = false;
        if (current != null) {
            LikeVO likeVO = new LikeVO();
            likeVO.setUserId(current.getUserId());
            likeVO.setTargetType("column");
            likeVO.setUuid(uuid);
            isLiked = likeService.countLikeByUser(likeVO) > 0;
        }
        int likeCount = likeService.countLikesByUuid(uuid);

        model.addAttribute("isLiked", isLiked);
        model.addAttribute("likeCount", likeCount);
        
        
        return "method/detail";  // /WEB-INF/views/method/detail.jsp
    }

    
    // ★ 좋아요 토글 AJAX 엔드포인트
    @PostMapping("/method/like.do")
    @ResponseBody
    public ResponseEntity<Map<String,Object>> toggleLike(
            @RequestParam String uuid,
            HttpSession session) {

    	MemberVO current = (MemberVO) session.getAttribute("memberVO");
        if (current == null) {
            // 로그인 안 된 상태 → 401 Unauthorized
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        LikeVO likeVO = new LikeVO();
        likeVO.setUserId(current.getUserId());
        likeVO.setTargetType("column");
        likeVO.setUuid(uuid);

        boolean nowLiked;
        if (likeService.countLikeByUser(likeVO) > 0) {
            likeService.deleteLike(likeVO);
            nowLiked = false;
        } else {
            likeService.insertLike(likeVO);
            nowLiked = true;
        }

        int total = likeService.countLikesByUuid(uuid);
        Map<String,Object> resp = new HashMap<>();
        resp.put("liked", nowLiked);
        resp.put("count", total);

        return ResponseEntity.ok(resp);
    }
    
    
    
    
    
    
    
}