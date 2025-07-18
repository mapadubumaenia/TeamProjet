package egovframework.example.country.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.auth.service.MemberVO;
import egovframework.example.common.Criteria;
import egovframework.example.country.service.CountryService;
import egovframework.example.country.service.CountryVO;
import egovframework.example.like.service.LikeService;
import egovframework.example.like.service.LikeVO;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CountryController {
    
    @Autowired
    private CountryService countryService;
    
    @Autowired
    private LikeService likeService;

    // ✅ (1) 게시판 목록 조회 + 페이징 + 필터
    @GetMapping("/country/country.do")
    public String selectCountryList(@ModelAttribute Criteria criteria,
            @RequestParam(value = "filter3", required = false) Integer filter3,
            Model model) {

        // ✅ '전체'인 경우 필터 제외
        if (filter3 != null && filter3 != 19) {
            criteria.setFilterCountryCategoryId(filter3);
        } else {
            criteria.setFilterCountryCategoryId(null); // 전체 보기
        }

        // 기본 정렬 옵션 설정
        criteria.setSortOption(criteria.getSortOption() == null ? "latest" : criteria.getSortOption());

        // 페이징 처리 정보 설정
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(criteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
        criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

        // 게시글 목록 조회
        List<?> countries = countryService.selectCountryList(criteria);
        model.addAttribute("countries", countries);

        // 전체 게시글 수 조회 후 페이지네이션 정보 반영
        int totcnt = countryService.selectCountryListTotCnt(criteria);
        paginationInfo.setTotalRecordCount(totcnt);
        model.addAttribute("paginationInfo", paginationInfo);

        // 카테고리 필터 여부에 따라 다른 JSP 리턴
        return criteria.getFilterCountryCategoryId() != null ? "country/country_all" : "country/country_main";
    }

 // ✅ (2) 글쓰기 페이지 이동
    @GetMapping("/country/addition.do")
    public String createCountryView(@RequestParam(required = false) Integer filter3,
                                    @RequestParam(required = false) String uuid,
                                    Model model, HttpSession session) {
        // 로그인 안 되어 있으면 로그인 페이지로 이동
        MemberVO member = (MemberVO) session.getAttribute("memberVO");
        if (member == null) return "redirect:/login.do";

        // 카테고리 정보 전달
        model.addAttribute("memberVO", member);
        model.addAttribute("countryCategories", countryService.getCountryCategories());
        model.addAttribute("ingredientCategories", countryService.getIngredientCategories());
        model.addAttribute("situationCategories", countryService.getSituationCategories());
        model.addAttribute("filter3", filter3);

       

        // uuid가 있으면 수정 모드 (글 내용 조회)
        if (uuid != null) {
            CountryVO countryVO = countryService.selectCountry(uuid);
            if (countryVO.getStandardRecipeImage() != null) {
                countryVO.setStandardRecipeImageUrl("/country/download.do?uuid=" + uuid);
            }
            model.addAttribute("countryVO", countryVO);
        }

        return "country/add_country"; // 등록 or 수정 페이지
    }

    // ✅ (3) 글 등록 처리
    @PostMapping("/country/add.do")
    public String insert(HttpSession session,
                         @RequestParam(defaultValue = "") String nickname,
                         @RequestParam(defaultValue = "") String recipeTitle,
                         @RequestParam(defaultValue = "") String recipeIntro,
                         @RequestParam(defaultValue = "") String ingredient,
                         @RequestParam(defaultValue = "") String recipeContent,
                         @RequestParam(defaultValue = "1") Integer countryCategoryId,
                         @RequestParam(defaultValue = "7") Integer ingredientCategoryId,
                         @RequestParam(defaultValue = "15") Integer situationCategoryId,
                         @RequestParam(required = false) MultipartFile standardRecipeImage,
                         @RequestParam(defaultValue = "1") Integer filter3
    ) throws Exception {
        // 로그인한 사용자 정보 가져오기
        MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
        String userId = memberVO.getUserId();

        // VO 생성 및 저장
        CountryVO countryVO = new CountryVO(
            userId, recipeTitle, countryCategoryId, ingredientCategoryId, situationCategoryId,
            recipeContent, standardRecipeImage.getBytes(), nickname, ingredient, recipeIntro
        );

        countryService.insert(countryVO);

        return "redirect:/country/country.do";
    }

 // ✅ (4) 수정 페이지 이동 (기존 게시글 상세 조회)
    @RequestMapping(value = "/country/edition.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateCountryView(HttpServletRequest request, Model model, HttpSession session) {
        // 중복 전달 방지를 위한 처리
        String[] uuidParams = request.getParameterValues("uuid");
        String uuid = (uuidParams != null && uuidParams.length > 0) ? uuidParams[0] : null;

        if (uuid == null) {
            throw new IllegalArgumentException("uuid 파라미터가 없습니다.");
        }

        CountryVO countryVO = countryService.selectCountry(uuid);

        if (countryVO.getStandardRecipeImage() != null) {
            countryVO.setStandardRecipeImageUrl("/country/download.do?uuid=" + uuid);
        }
        model.addAttribute("countryVO",countryVO);
        
     // ✅ [① 최근 본 레시피 - 세션 저장]
        List<String> recent = (List<String>) session.getAttribute("recent");
        if (recent == null) {
            recent = new java.util.ArrayList<>();
        }
        recent.remove(uuid);          // 중복 제거
        recent.add(0, uuid);          // 맨 앞에 추가
        if (recent.size() > 5) {
            recent = recent.subList(0, 5);
        }
        session.setAttribute("recent", recent);

        // ✅ [② UUID → CountryVO 리스트로 변환]
        List<CountryVO> recentCountries = recent.stream()
            .map(id -> countryService.selectCountry(id))
            .collect(java.util.stream.Collectors.toList());

        // ✅ [③ 모델에 추가]
        model.addAttribute("recentCountries", recentCountries);


        // 좋아요 상태 조회
        MemberVO current = (MemberVO) session.getAttribute("memberVO");
        boolean isLiked = false;

        if (current != null) {
            LikeVO likeVO = new LikeVO();
            likeVO.setUserId(current.getUserId());
            likeVO.setTargetType("standard");
            likeVO.setUuid(uuid);
            isLiked = likeService.countLikeByUser(likeVO) > 0;
        }

        int likeCount = likeService.countLikesByUuid(uuid);

        model.addAttribute("isLiked", isLiked);
        model.addAttribute("likeCount", likeCount);

        return "country/update_country";
    }



    // ✅ (5) 수정 처리
    @PostMapping("/country/edit.do")
    public String update(HttpSession session,
                         @RequestParam(defaultValue = "") String uuid,
                         @RequestParam(defaultValue = "") String nickname,
                         @RequestParam(defaultValue = "") String recipeTitle,
                         @RequestParam(defaultValue = "") String recipeIntro,
                         @RequestParam(defaultValue = "") String ingredient,
                         @RequestParam(defaultValue = "") String recipeContent,
                         @RequestParam(defaultValue = "1") Integer countryCategoryId,
                         @RequestParam(defaultValue = "7") Integer ingredientCategoryId,
                         @RequestParam(defaultValue = "15") Integer situationCategoryId,
                         @RequestParam(required = false) MultipartFile standardRecipeImage,
                         @RequestParam(defaultValue = "1") Integer filter3
    ) throws Exception {

        MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
        String userId = memberVO.getUserId();

        CountryVO countryVO = new CountryVO(
            uuid, userId, recipeTitle, countryCategoryId, ingredientCategoryId, situationCategoryId,
            recipeContent, standardRecipeImage.getBytes(), nickname, ingredient, recipeIntro
        );

        countryService.update(countryVO);

        return "redirect:/country/country.do";
    }

    // ✅ (6) 삭제 처리
    @PostMapping("/country/delete.do")
    public String delete(@ModelAttribute CountryVO countryVO) {
        countryService.delete(countryVO);
        return "redirect:/country/country.do";
    }

    // ✅ (7) 이미지 다운로드 처리
    @GetMapping("/country/download.do")
    @ResponseBody
    public ResponseEntity<byte[]> downloadImage(@RequestParam("uuid") String uuid) {
        CountryVO countryVO = countryService.selectCountry(uuid);

        if (countryVO == null || countryVO.getStandardRecipeImage() == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG);
        headers.setContentDispositionFormData("inline", uuid + ".jpg");

        return new ResponseEntity<>(countryVO.getStandardRecipeImage(), headers, HttpStatus.OK);
    }
//    좋아요 기능
    @PostMapping("/country/like.do")
    @ResponseBody
    public ResponseEntity<?> toggleLike(@RequestParam String uuid, HttpSession session) {
        MemberVO current = (MemberVO) session.getAttribute("memberVO");
        if (current == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        LikeVO likeVO = new LikeVO();
        likeVO.setUserId(current.getUserId());
        likeVO.setTargetType("standard"); // 게시판 구분값
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

        countryService.updateLikeCount(uuid, total);
        
        Map<String, Object> result = new HashMap<>();
        result.put("liked", nowLiked);
        result.put("count", total);

        return ResponseEntity.ok(result);
    }
    

}
