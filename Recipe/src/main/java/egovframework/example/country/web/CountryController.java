package egovframework.example.country.web;

import java.util.List;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.common.Criteria;
import egovframework.example.country.service.CountryService;
import egovframework.example.country.service.CountryVO;
import lombok.extern.log4j.Log4j;

/**
 * 국가 관련 컨트롤러
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
		// filter3 파라미터가 있을 경우 Criteria에 설정
		if (filter3 != null) {
			criteria.setFilterCountryCategoryId(filter3);
		}
		// 정렬 옵션이 null이면 기본값 설정 (전역적으로 해줌)
		criteria.setSortOption(criteria.getSortOption() == null ? "latest" : criteria.getSortOption());

		// 페이지네이션 설정
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(criteria.getPageIndex());
		paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
		criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

		// 목록 조회 및 모델에 담기
		List<?> countries = countryService.selectCountryList(criteria);
		log.info("국가 목록 조회 결과: " + countries);
		model.addAttribute("countries", countries);

		// 전체 데이터 수 조회 및 페이지네이션 정보 설정
		int totcnt = countryService.selectCountryListTotCnt(criteria);
		paginationInfo.setTotalRecordCount(totcnt);
		log.info("전체 국가 수: " + totcnt);
		model.addAttribute("paginationInfo", paginationInfo);

		// ✅ 필터가 있으면 country_all.jsp, 아니면 country_main.jsp
		if (criteria.getFilterCountryCategoryId() != null) {
			return "country/country_all";
		} else {
			return "country/country_main";
		}
	}

	/**
	 * 등록 페이지 이동
	 */
	@GetMapping("/country/addition.do")
	public String createCountryView() {
		return "country/add_country";
	}

	/**
	 * 국가 정보 등록 처리
	 */
	@PostMapping("/country/add.do")
	public String insert(@ModelAttribute CountryVO countryVO) {
		log.info("추가할 국가 정보: " + countryVO);
		countryService.insert(countryVO);
		return "redirect:/country/country.do";
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
}
