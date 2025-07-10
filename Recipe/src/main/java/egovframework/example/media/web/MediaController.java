/**
 * 
 */
package egovframework.example.media.web;

import java.util.List;

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

import egovframework.example.common.Criteria;
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

//  전체조회
	@GetMapping("/media/media.do")
	public String media(@ModelAttribute Criteria criteria, Model model) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(criteria.getPageIndex());
		paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
		criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

		List<?> all = mediaService.allMedia(criteria);
		int totCnt = mediaService.allMediaTotCnt(criteria);
		paginationInfo.setTotalRecordCount(totCnt);

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
//	1) 등차자동계산 클래스: PaginationInfo
//	   - 필요정보: (1) 현재페이지번호(pageIndex),(2) 보일 개수(pageUnit): 3
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(criteria.getPageIndex());
		paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
		criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
//	전체조회 서비스 메소드 실행
		List<?> ask = mediaService.MediaList(criteria);
		int totCnt = mediaService.MediaListTotCnt(criteria);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("ask", ask);
		model.addAttribute("paginationInfo", paginationInfo);
	}

//상세조회페이지 열기(영화)
	@GetMapping("/media/open.do")
	public String open(@RequestParam String uuid, Model model) {
		MediaVO mediaVO = mediaService.selectMedia(uuid);
		model.addAttribute("mediaVO", mediaVO);
		model.addAttribute("data", mediaVO);

		return "media/open/movie_open";
	}

	//상세조회페이지 열기(드라마)
	 @GetMapping("/media/open2.do") 
	 public String open2(@RequestParam String uuid, Model model) { 
		 MediaVO mediaVO = mediaService.selectMedia(uuid);
		 model.addAttribute("mediaVO", mediaVO); 
		 model.addAttribute("data", mediaVO);
	 
	  return "media/open/drama_open"; }
	
 //상세조회페이지 열기(게임)
	  @GetMapping("/media/open3.do") 
	  public String open3(@RequestParam String uuid, Model model) { 
		  MediaVO mediaVO = mediaService.selectMedia(uuid);
		  model.addAttribute("mediaVO", mediaVO); 
		  model.addAttribute("data", mediaVO);
	  
	  return "media/open/game_open"; }

 
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
			@RequestParam(required = false) MultipartFile recipeImage)
			throws Exception {
		log.info("테스트 : " + title);
		log.info("테스트 : " + mediaCategory);
		log.info("테스트 : " + ingredient);
		log.info("테스트 : " + content);
//		TODO: userId 하드코딩(mafa): 나중에 세션으로 처리
//		MediaVO mediaVO = new MediaVO(title, content, ingredient, mediaCategory, recipeImage.getBytes());
		MediaVO mediaVO = new MediaVO("mafa", title, mediaCategory, content, recipeImage.getBytes(),ingredient);
//		서비스의 insert 메소드 실행
		mediaService.insert(mediaVO);
		return "redirect:/media/media.do";
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
	public String updateDeptView(@RequestParam String uuid, Model model) {
//		서비스의 상세조회
		MediaVO mediaVO=mediaService.selectMedia(uuid);
		model.addAttribute("mediaVO", mediaVO);
		return "media/update_media";
	}
	
//	수정: 버튼 클릭시 실행
	@PostMapping("/media/edit.do")
	public String update(@RequestParam String uuid,
			 @ModelAttribute MediaVO mediaVO) {
//		서비스의 수정 실행
		mediaService.update(mediaVO);
		return "redirect:/media/media.do";
	}

}
