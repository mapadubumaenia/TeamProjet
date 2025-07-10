package egovframework.example.drink.web;

import java.io.IOException;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
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
import java.util.LinkedList;

import egovframework.example.auth.service.MemberService;
import egovframework.example.auth.service.MemberVO;
import egovframework.example.common.Criteria;
import egovframework.example.drink.service.DrinkService;
import egovframework.example.drink.service.DrinkVO;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class DrinkController {

	@Autowired
	private DrinkService drinkService;
	
    // MemberService 주입
    @Autowired
    private MemberService memberService;
	
	
	@GetMapping("/drink/drink.do")
	public String selectDrinkList( @ModelAttribute Criteria criteria,
			@RequestParam(name="category", required=false, defaultValue="") String category,
	          Model model) {
		
		
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
		
		//전체조회 서비스 메소드 실행
		List<?> drinks= drinkService.selectDrinkList(criteria);
		log.info("테스트: "+drinks);
		model.addAttribute("drinks", drinks);
		
	
		//페이지 번호 그리기: 페이지 플러그인(전체테이블 행 개수)
				int totCnt=drinkService.selectDrinkListTotCnt(criteria);
				paginationInfo.setTotalRecordCount(totCnt);
				log.info("테스트2 :"+totCnt);
				model.addAttribute("paginationInfo",paginationInfo);
		
				
				
				
		return "drink/drink_all";
}
	
	
	    //추가페이지 열기
	@GetMapping("/drink/addition.do")
	   public String createDrinkView(Model model) {
		model.addAttribute("drinkVO",new DrinkVO());
		return "drink/add_drink";
	}
	
	    //insert:업로드
	// @RequestParam(required = false: 첨부파일 없어도 에러 발생 안하게 하는 옵션
	//  파일 처리를 한다면 예외처리를 해야한다(try catch or throw)
    //  첨부파일 다루기: (필수) 예외처리 필수
	//  image.getBytes() :byte 배열로 변경
	@PostMapping("/drink/add.do")
	public String insert(
	        @RequestParam(defaultValue = "") String columnTitle,
	        @RequestParam(defaultValue = "") String columnContent,
	        @RequestParam(defaultValue = "") String category,
	        @RequestParam(defaultValue = "") String columnIngredient,
	        @RequestParam(required = false) MultipartFile image,
	        HttpSession session
	) throws Exception {
	    // 1) MultipartFile이 없으면 null 처리
	    byte[] data = (image != null && !image.isEmpty()) ? image.getBytes() : null;

	    // 2) VO 생성
	    DrinkVO drinkVO = new DrinkVO(columnTitle, columnContent, category, columnIngredient, data);

	    // 3) 세션에서 로그인된 회원 정보 꺼내기
	    MemberVO current = (MemberVO) session.getAttribute("memberVO");
	    if (current == null) {
	        throw new IllegalStateException("로그인 정보가 없습니다.");
	    }
	    drinkVO.setUserId(current.getUserid());

	    // 4) 서비스 호출 (UUID·URL 세팅 포함)
	    drinkService.insert(drinkVO);

	    return "redirect:/drink/drink.do";
	}
	
	
	// 다운로드 메소드: 사용자가 다운로드 URL을 웹브라우저에서 실행하면 이 메소드가 첨부파일을 전달해줌
	   //@ResponseBody: json(js객체)으로 데이터를 jsp로 전달해줌
	   //JSON :예)[{속성: 값}]
	   @GetMapping("/drink/download.do")
	   @ResponseBody
	public ResponseEntity<byte[]> findDownload(@RequestParam(defaultValue = "") String uuid) {
		//1) 상세조회: 첨부파일을 가져 오려고
		DrinkVO drinkVO=drinkService.selectDrink(uuid);
		//2) 첨부파일을 보낼때(통신규칙)  (1) 첨부파일 보내요! 라고 알려줘야함 (2)첨부파일 문서형식 지정해야함
		//  =>html 문서: 헤더(문서혁식,암호화등)+바디(실제 데이터)
		HttpHeaders headers=new HttpHeaders();
		
		//첨부파일 보낸다는 의미 1)attachment(첨부파일) 2)fileDbVO.getUuid()(첨부파일명)
		headers.setContentDispositionFormData("attachment", drinkVO.getUuid()); 
		
		//첨부파일 문서 형식(이진파일)
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		
		//사용법: new ResponseEntity<byte[]>(데이터,헤더(생략가능),신호);
		//ResponseEntity: 데이터와 함께 신호도 같이 전송가능합니다.
		//신호 예)HttpStatus.OK(200), NOT_FOUND(404) 등
		return new ResponseEntity<byte[]>(drinkVO.getColumnData(), 
				headers, HttpStatus.OK);
	}
	
	
	
	
	//삭제
	@PostMapping("/drink/delete.do")
	public String delete(@RequestParam(defaultValue = "") String uuid) {
		
		drinkService.delete(uuid);
		return "redirect:/drink/drink.do";
	}
	


   
    // 미리보기 모달 컨트롤러
    @PostMapping("/drink/preview.do")
    public String preview(
            @RequestParam(defaultValue = "") String columnTitle,
            @RequestParam(defaultValue = "") String columnContent,
            @RequestParam(defaultValue = "") String category,
            @RequestParam(defaultValue = "") String columnIngredient,
            @RequestParam(required = false) MultipartFile image,
            Model model) throws IOException {
        DrinkVO previewVO = new DrinkVO();
        previewVO.setColumnTitle(columnTitle);
        previewVO.setColumnContent(columnContent);
        previewVO.setCategory(category);
        previewVO.setColumnIngredient(columnIngredient);
        if (image != null && !image.isEmpty()) {
            byte[] bytes = image.getBytes();
            previewVO.setColumnData(bytes);
            String base64 = Base64.getEncoder().encodeToString(bytes);
            String mime = image.getContentType();
            // data URL 형태로
            previewVO.setColumnUrl("data:" + mime + ";base64," + base64);
        }
        
        model.addAttribute("preview", previewVO);
        return "drink/previewFragment";
    }
	
	//상세조회 페이지
    @GetMapping("/drink/detail.do")
    public String detailPage(@RequestParam String uuid, Model model, HttpSession session) {
        // 1) 글 데이터
        DrinkVO vo = drinkService.selectDrink(uuid);
        model.addAttribute("drink", vo);
        
        // 재료칸 줄바꿈 자동화
        String raw = vo.getColumnIngredient();                              // "우유\n바나나\n꿀"
        List<String> ingredients = Arrays.stream(raw.split("\\r?\\n"))     // 운영체제 개행 모두 대응
                                        .filter(s -> !s.isBlank())        // 빈 줄 제거
                                        .collect(Collectors.toList());
        model.addAttribute("ingredients", ingredients);
        // ───────────────────

        // 2) 댓글 목록이 필요하면 service 호출해서 model.addAttribute("comments", comments);

        // 3) (선택) 현재 로그인한 닉네임
        MemberVO current = (MemberVO) session.getAttribute("memberVO");
        if (current != null) {
            model.addAttribute("currentNickname", current.getNickname());
        }

     // ─── ④ 최근 본 레시피 세션 갱신 & 모델 담기 ─────────
        // (1) 세션에서 List<String> recentRecipes 가져오기
        @SuppressWarnings("unchecked")
        List<String> recent = (List<String>) session.getAttribute("recentRecipes");
        if (recent == null) {
            recent = new LinkedList<>();
        }
        // (2) 중복 제거 후 맨 앞에 추가
        recent.remove(uuid);
        recent.add(0, uuid);
        // (3) 최대 5개 유지
        if (recent.size() > 5) {
            recent = recent.subList(0, 5);
        }
        session.setAttribute("recentRecipes", recent);

        // (4) UUID → DrinkVO 로 매핑
        List<DrinkVO> recentDrinks = recent.stream()
            .map(id -> drinkService.selectDrink(id))
            .collect(Collectors.toList());
        model.addAttribute("recentDrinks", recentDrinks);
        // ────────────────────────────────────────────────
        
        
        
        
        return "drink/detail";   // /WEB-INF/views/drink/detail.jsp
    }
	
	
	
	
}
