package egovframework.example.like.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import egovframework.example.like.service.LikeService;
import egovframework.example.like.service.LikeVO;
import lombok.extern.log4j.Log4j2;

@RestController
@Log4j2
public class LikeController {

	@Autowired
	private LikeService likeService;

	/**
	 * 좋아요 토글 처리 (좋아요 누르면 등록, 다시 누르면 취소)
	 */
	@PostMapping("/like/toggle.do")
	public String toggleLike(@RequestBody LikeVO likeVO) {
		int count = likeService.countLikeByUser(likeVO);
		if (count == 0) {
			likeService.insertLike(likeVO);
			log.info("좋아요 등록: {}", likeVO);
			return "liked";
		} else {
			likeService.deleteLike(likeVO);
			log.info("좋아요 취소: {}", likeVO);
			return "unliked";
		}
	}

	/**
	 * 게시물의 총 좋아요 수 가져오기
	 */
	@GetMapping("/like/count.do")
	public int countLikes(@RequestParam("uuid") String uuid) {
		int total = likeService.countLikesByUuid(uuid);
		log.info("총 좋아요 수: {}", total);
		return total;
	}
}