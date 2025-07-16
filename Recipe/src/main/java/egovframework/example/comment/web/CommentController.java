package egovframework.example.comment.web;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import egovframework.example.auth.service.MemberVO;
import egovframework.example.comment.service.CommentService;
import egovframework.example.comment.service.CommentVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequiredArgsConstructor
@RequestMapping("/comment")
public class CommentController {

    private final CommentService commentService;

    /**
     * 댓글 목록 조회 (GET, POST 모두 허용)
     */
    @RequestMapping(value = "/list.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String list(@ModelAttribute CommentVO commentVO, Model model) {
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(commentVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(10);
        paginationInfo.setPageSize(10);

        commentVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        commentVO.setPageUnit(paginationInfo.getRecordCountPerPage());

        List<CommentVO> commentList = commentService.selectCommentList(commentVO);
        model.addAttribute("commentList", commentList);

        log.debug("댓글 목록 확인: {}", commentList);

        return "comment/list"; // 댓글 fragment JSP
    }

    /**
     * 댓글 등록
     */
    @PostMapping("/insert.do")
    @ResponseBody
    public String insertComment(@RequestBody CommentVO commentVO, HttpSession session) {
        MemberVO loginUser = (MemberVO) session.getAttribute("memberVO");
        if (loginUser == null) return "unauthorized";

        commentVO.setUserId(loginUser.getUserId());
        commentVO.setCreatedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd HH:mm")));
        commentService.insertComment(commentVO);
        return "success";
    }

    /**
     * 댓글 삭제
     */
    @PostMapping("/delete.do")
    @ResponseBody
    public String deleteComment(@RequestParam("commentId") int commentId) {
        int result = commentService.deleteComment(commentId);
        return result > 0 ? "success" : "fail";
    }

    /**
     * 댓글 수정
     */
    @PostMapping("/update.do")
    @ResponseBody
    public String updateComment(@RequestBody CommentVO commentVO) {
        return commentService.updateComment(commentVO);
    }
}
