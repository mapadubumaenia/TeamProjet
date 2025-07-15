package egovframework.example.country.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.common.Criteria;
import egovframework.example.country.service.CountryService;
import egovframework.example.country.service.CountryVO;
import lombok.extern.log4j.Log4j;

/**
 * 국가 관련 컨트롤러 (필터 유지 버전)
 */
@Log4j
@Controller
public class CountryController {

	@Autowired
	private CountryService countryService;

	/**
	 * 국가 목록 전체 조회 + 페이징 + 필터 적용
	 */
	@GetMapping("/country/country.do")
	public String selectCountryList(@ModelAttribute Criteria criteria,
			@RequestParam(value = "filter3", required = false) Integer filter3, Model model) {
		if (filter3 != null) {
			criteria.setFilterCountryCategoryId(filter3);
		}
		criteria.setSortOption(criteria.getSortOption() == null ? "latest" : criteria.getSortOption());

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(criteria.getPageIndex());
		paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
		criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

		List<?> countries = countryService.selectCountryList(criteria);
		log.info("국가 목록 조회 결과: " + countries);
		model.addAttribute("countries", countries);

		int totcnt = countryService.selectCountryListTotCnt(criteria);
		paginationInfo.setTotalRecordCount(totcnt);
		log.info("전체 국가 수: " + totcnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return criteria.getFilterCountryCategoryId() != null ? "country/country_all" : "country/country_main";
	}

	/**
	 * 등록 페이지 이동 (세션 체크 + 필터 유지)
	 */
	@GetMapping("/country/addition.do")
	public String createCountryView(@RequestParam(required = false) Integer filter3,
			Model model, HttpSession session) {
		if (session.getAttribute("loginUser") == null) {
			return "redirect:/login";
		}

		model.addAttribute("countryCategories", countryService.getCountryCategories());
		model.addAttribute("ingredientCategories", countryService.getIngredientCategories());
		model.addAttribute("situationCategories", countryService.getSituationCategories());
		model.addAttribute("filter3", filter3); // JSP에서 사용할 수 있도록 전달

		return "country/add_country";
	}

	/**
	 * 국가 정보 등록 처리 (필터 유지 + 이미지 업로드)
	 */
	@PostMapping("/country/add.do")
	public String insert(@ModelAttribute CountryVO countryVO,
	                     @RequestParam(required = false) Integer filter3,
	                     @RequestParam("standardRecipeImage") MultipartFile file) {
	    try {
	        if (!file.isEmpty()) {
	            countryVO.setStandardRecipeImage(file.getBytes());
	        }
	        countryService.insert(countryVO);
	    } catch (IOException e) {
	        e.printStackTrace(); // 또는 로그 처리
	    }

	    return filter3 != null ? "redirect:/country/country.do?filter3=" + filter3 : "redirect:/country/country.do";
	}

	/**
	 * 수정 페이지 이동 (상세 조회)
	 */
	@GetMapping("/country/edition.do")
	public String updateCountryView(@RequestParam String uuid, Model model) {
		CountryVO countryVO = countryService.selectCountry(uuid);
		model.addAttribute("countryVO", countryVO);
		return "country/update_country";
	}

	/**
	 * 수정 처리
	 */
	@PostMapping("/country/edit.do")
	public String update(@RequestParam String uuid, @ModelAttribute CountryVO countryVO) {
		countryService.update(countryVO);
		return "redirect:/country/country.do";
	}

	/**
	 * 삭제 처리
	 */
	@PostMapping("/country/delete.do")
	public String delete(@ModelAttribute CountryVO countryVO) {
		countryService.delete(countryVO);
		return "redirect:/country/country.do";
	}

	@GetMapping("/login.do")
	public String loginView() {
	    return "auth/login";
	}
}
