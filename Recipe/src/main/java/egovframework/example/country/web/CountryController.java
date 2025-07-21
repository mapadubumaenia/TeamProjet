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
            @RequestParam(value = "filterCountry", required = false) Integer filterCountry,
            @RequestParam(value = "filterIngredient", required = false) Integer filterIngredient,
            @RequestParam(value = "filterSituation", required = false) Integer filterSituation,
            Model model) {

        // ✅ 각 필터 값 세팅 (전체 = null 처리)
    criteria.setFilterCountryCategoryId((filterCountry != null && filterCountry != 19) ? filterCountry : null);
    criteria.setFilterIngredientCategoryId((filterIngredient != null && filterIngredient != 19) ? filterIngredient : null);
    criteria.setFilterSituationCategoryId((filterSituation != null && filterSituation != 19) ? filterSituation : null);

        // 정렬 옵션 기본값 설정
        criteria.setSortOption(criteria.getSortOption() == null ? "recent" : criteria.getSortOption());

        // 페이징 처리
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(criteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
        criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

        // 게시글 목록 및 전체 개수
        List<?> countries = countryService.selectCountryList(criteria);
        int totcnt = countryService.selectCountryListTotCnt(criteria);
        
     // ✅ 선택된 필터 이름 조회 및 모델에 추가
        if (criteria.getFilterCountryCategoryId() != null) {
            String countryCategoryName = countryService.getCategoryNameById(criteria.getFilterCountryCategoryId());
            model.addAttribute("countryCategoryName", countryCategoryName);
        }
        if (criteria.getFilterIngredientCategoryId() != null) {
            String ingredientCategoryName = countryService.getCategoryNameById(criteria.getFilterIngredientCategoryId());
            model.addAttribute("ingredientCategoryName", ingredientCategoryName);
        }
        if (criteria.getFilterSituationCategoryId() != null) {
            String situationCategoryName = countryService.getCategoryNameById(criteria.getFilterSituationCategoryId());
            model.addAttribute("situationCategoryName", situationCategoryName);
        }

        // 모델에 데이터 전달
        model.addAttribute("countries", countries);
        paginationInfo.setTotalRecordCount(totcnt);
        model.addAttribute("paginationInfo", paginationInfo);

        // ✅ JSP 분기: 나라/재료/상황 중 하나라도 선택되었으면 country_all.jsp
        boolean hasFilter = criteria.getFilterCountryCategoryId() != null
                         || criteria.getFilterIngredientCategoryId() != null
                         || criteria.getFilterSituationCategoryId() != null;

        return hasFilter ? "country/country_all" : "country/country_main";
    }

 // ✅ (2) 글쓰기 페이지 이동
    @GetMapping("/country/addition.do")
    public String createCountryView(@RequestParam(required = false) Integer filterCountry,
                                    @RequestParam(required = false) Integer filterIngredient,
                                    @RequestParam(required = false) Integer filterSituation,
                                    @RequestParam(required = false) String uuid,
                                    Model model, HttpSession session) {

        // 로그인 체크
        MemberVO member = (MemberVO) session.getAttribute("memberVO");
        if (member == null) return "redirect:/login.do";

        // 카테고리 정보 전달
        model.addAttribute("memberVO", member);
        model.addAttribute("countryCategories", countryService.getCountryCategories());
        model.addAttribute("ingredientCategories", countryService.getIngredientCategories());
        model.addAttribute("situationCategories", countryService.getSituationCategories());

        // 필터값 전달 (등록 후 되돌아갈 때 필요)
        model.addAttribute("filterCountry", filterCountry);
        model.addAttribute("filterIngredient", filterIngredient);
        model.addAttribute("filterSituation", filterSituation);

        // 수정 모드
        if (uuid != null) {
            CountryVO countryVO = countryService.selectCountry(uuid);
            if (countryVO.getStandardRecipeImage() != null) {
                countryVO.setStandardRecipeImageUrl("/country/download.do?uuid=" + uuid);
            }
            model.addAttribute("countryVO", countryVO);
        }

        return "country/add_country";
    }
 // ✅ (3) 글 등록 처리
    @PostMapping("/country/add.do")
    public String insert(HttpSession session,
                         @RequestParam(defaultValue = "") String nickname,
                         @RequestParam(defaultValue = "") String recipeTitle,
                         @RequestParam(defaultValue = "") String recipeIntro,
                         @RequestParam(defaultValue = "") String ingredient,
                         @RequestParam(defaultValue = "") String recipeContent,
                         @RequestParam(defaultValue = "7") Integer countryCategoryId,
                         @RequestParam(defaultValue = "13") Integer ingredientCategoryId,
                         @RequestParam(defaultValue = "18") Integer situationCategoryId,
                         @RequestParam(required = false) MultipartFile standardRecipeImage,
                         @RequestParam(required = false) Integer filterCountry,
                         @RequestParam(required = false) Integer filterIngredient,
                         @RequestParam(required = false) Integer filterSituation
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

        StringBuilder redirectUrl = new StringBuilder("redirect:/country/country.do");
        boolean hasParam = false;

        if (filterCountry != null) {
            redirectUrl.append("?filterCountry=").append(filterCountry);
            hasParam = true;
        }
        if (filterIngredient != null) {
            redirectUrl.append(hasParam ? "&" : "?");
            redirectUrl.append("filterIngredient=").append(filterIngredient);
            hasParam = true;
        }
        if (filterSituation != null) {
            redirectUrl.append(hasParam ? "&" : "?");
            redirectUrl.append("filterSituation=").append(filterSituation);
        }

        return redirectUrl.toString();
    }

 // ✅ (4) 수정 페이지 이동 (기존 게시글 상세 조회)
    @RequestMapping(value = "/country/edition.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateCountryView(HttpServletRequest request,
                                    Model model,
                                    HttpSession session,
                                    @RequestParam(required = false) Integer filterCountry,
                                    @RequestParam(required = false) Integer filterIngredient,
                                    @RequestParam(required = false) Integer filterSituation) {

        // uuid 파라미터 확인
        String[] uuidParams = request.getParameterValues("uuid");
        String uuid = (uuidParams != null && uuidParams.length > 0) ? uuidParams[0] : null;

        if (uuid == null) {
            throw new IllegalArgumentException("uuid 파라미터가 없습니다.");
        }

        // 게시글 조회
        CountryVO countryVO = countryService.selectCountry(uuid);
        if (countryVO.getStandardRecipeImage() != null) {
            countryVO.setStandardRecipeImageUrl("/country/download.do?uuid=" + uuid);
        }
        model.addAttribute("countryVO", countryVO);

        // ✅ 최근 본 레시피 저장
        List<String> recent = (List<String>) session.getAttribute("recent");
        if (recent == null) {
            recent = new java.util.ArrayList<>();
        }
        recent.remove(uuid);
        recent.add(0, uuid);
        if (recent.size() > 5) {
            recent = recent.subList(0, 5);
        }
        session.setAttribute("recent", recent);

        // 최근 레시피 목록 가져오기
        List<CountryVO> recentCountries = recent.stream()
            .map(id -> countryService.selectCountry(id))
            .collect(java.util.stream.Collectors.toList());
        model.addAttribute("recentCountries", recentCountries);

        // 좋아요 상태
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

        // ✅ 필터 상태 전달 (다시 목록으로 돌아갈 때 사용)
        model.addAttribute("filterCountry", filterCountry);
        model.addAttribute("ingredient", filterIngredient);
        model.addAttribute("situation", filterSituation);

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
                         @RequestParam(required = false) Integer filterCountry,
                         @RequestParam(required = false) Integer filterIngredient,
                         @RequestParam(required = false) Integer filterSituation
    ) throws Exception {

        MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
        String userId = memberVO.getUserId();

        CountryVO countryVO = new CountryVO(
            uuid, userId, recipeTitle, countryCategoryId, ingredientCategoryId, situationCategoryId,
            recipeContent, standardRecipeImage.getBytes(), nickname, ingredient, recipeIntro
        );

        countryService.update(countryVO);

        StringBuilder redirectUrl = new StringBuilder("redirect:/country/country.do");
        boolean hasParam = false;

        if (filterCountry != null) {
            redirectUrl.append("?filterCountry=").append(filterCountry);
            hasParam = true;
        }
        if (filterIngredient != null) {
            redirectUrl.append(hasParam ? "&" : "?");
            redirectUrl.append("filterIngredient=").append(filterIngredient);
            hasParam = true;
        }
        if (filterSituation != null) {
            redirectUrl.append(hasParam ? "&" : "?");
            redirectUrl.append("filterSituation=").append(filterSituation);
        }
        
        System.out.println("▶▶ Redirect URL: " + redirectUrl.toString());
        return redirectUrl.toString();
    }

 // ✅ (6) 삭제 처리
    @PostMapping("/country/delete.do")
    public String delete(@ModelAttribute CountryVO countryVO,
                         @RequestParam(required = false) Integer filterCountry,
                         @RequestParam(required = false) Integer filterIngredient,
                         @RequestParam(required = false) Integer filterSituation) {

        countryService.delete(countryVO);

        // ✅ 필터값 유지해서 목록으로 redirect
        String redirectUrl = "/country/country.do?";
        if (filterCountry != null) redirectUrl += "filterCountry=" + filterCountry + "&";
        if (filterIngredient != null) redirectUrl += "ingredient=" + filterIngredient + "&";
        if (filterSituation != null) redirectUrl += "situation=" + filterSituation + "&";

        // 마지막 & 제거
        if (redirectUrl.endsWith("&")) {
            redirectUrl = redirectUrl.substring(0, redirectUrl.length() - 1);
        }

        return "redirect:" + redirectUrl;
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
