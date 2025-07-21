package egovframework.example.search.web;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.common.Criteria;
import egovframework.example.search.service.SearchService;
import egovframework.example.search.service.SearchVO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequestMapping("/search")
public class SearchController {

    @Autowired
    private SearchService searchService;

    // 통합 검색 (페이징 포함)
    @GetMapping("/search.do")
    public String search(@ModelAttribute Criteria criteria, Model model) {

        log.info("통합 검색 요청: {}", criteria.getSearchKeyword());

        // 1. 페이징 설정
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(criteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
        paginationInfo.setPageSize(criteria.getPageSize());
        criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

        // 2. 검색 결과 목록
        List<SearchVO> resultList = searchService.searchAllByTitle(criteria);
        int totalCount = searchService.searchAllByTitleTotCnt(criteria);
        paginationInfo.setTotalRecordCount(totalCount);

        // 3. type 기준으로 그룹화
        Map<String, List<SearchVO>> groupedResult = resultList.stream()
            .collect(Collectors.groupingBy(SearchVO::getType));

        // 4. 모델 전달
        model.addAttribute("groupedResult", groupedResult); // <- 변경된 구조
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("searchKeyword", criteria.getSearchKeyword());
        model.addAttribute("typeList", List.of("country", "media", "drink", "method"));
        
        return "search/search_all";  // /WEB-INF/jsp/search/search_all.jsp
    }
    
    
    
    @GetMapping("/image.do")
    public ResponseEntity<byte[]> getImage(@RequestParam("uuid") String uuid) {
        SearchVO vo = searchService.getSearchResultByUuid(uuid);
        byte[] imageData = vo.getImage();

        if (imageData == null || imageData.length == 0) {
            return ResponseEntity.notFound().build();
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG); // 필요에 따라 변경
        return new ResponseEntity<>(imageData, headers, HttpStatus.OK);
    }
}
