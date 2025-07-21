package egovframework.example.community.web;

import egovframework.example.auth.service.MemberVO;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.common.Criteria;
import egovframework.example.community.service.CommunityService;
import egovframework.example.community.service.CommunityVO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private CommunityService communityService;

    /**
     * 커뮤니티 목록 조회 (페이징 포함)
     */
    @GetMapping("/community.do")
    public String selectCommunityList(@ModelAttribute Criteria criteria, Model model) {
        // 페이징 처리 설정
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(criteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
        criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

        // 게시글 목록 및 전체 건수 조회
        List<?> commuNts = communityService.selectCommuList(criteria);
        int toCnt = communityService.selectCommuListToCnt(criteria);
        paginationInfo.setTotalRecordCount(toCnt);

        model.addAttribute("CommuNts", commuNts);
        model.addAttribute("paginationInfo", paginationInfo);
        return "community/community_all";
    }

    /**
     * 글쓰기 페이지 이동
     */
    @GetMapping("/addition.do")
    public String createCommunityView() {
        return "community/add_community";
    }

 // 게시글 등록
    @PostMapping("/addition.do")
    public String insertCommunity(@ModelAttribute CommunityVO communityVO,
                                  @RequestParam("uploadFile") MultipartFile file,
                                  HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("memberVO") == null) {
                throw new IllegalStateException("로그인된 사용자만 글을 작성할 수 있습니다.");
            }

            MemberVO loginMember = (MemberVO) session.getAttribute("memberVO");

            communityVO.setUserId(loginMember.getUserId());
            communityVO.setUserNickname(loginMember.getNickname()); // ✅ 닉네임 저장
            communityVO.setContentType("community"); // ✅ 기본값 설정

            if (!file.isEmpty()) {
                String contentType = file.getContentType();
                if (contentType == null || !contentType.startsWith("image/")) {
                    throw new IllegalArgumentException("이미지 파일만 업로드 가능합니다.");
                }
                communityVO.setCommunityImage(file.getBytes());
            }

            communityVO.setUuid(UUID.randomUUID().toString());
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy-MM-dd HH:mm");
            communityVO.setCommunityCreatedAt(LocalDateTime.now().format(formatter));

            communityService.insert(communityVO);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/community/community.do";
    }





    /**
     * 게시글 수정
     */
    @PostMapping("/update.do")
    public String updateCommunity(@ModelAttribute CommunityVO communityVO,
                                  @RequestParam("uploadFile") MultipartFile file,
                                  RedirectAttributes redirectAttributes) {
        try {
            // 이미지 수정 시 이미지 바이트 처리
            if (!file.isEmpty()) {
                String contentType = file.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    communityVO.setCommunityImage(file.getBytes());
                }
            }

            // DB 수정
            communityService.update(communityVO);
            redirectAttributes.addFlashAttribute("message", "수정이 완료되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "수정 중 오류 발생");
        }

        return "redirect:/community/detail.do?uuid=" + communityVO.getUuid() + "&t=" + System.currentTimeMillis();
    }

    /**
     * 게시글 상세 조회
     */
    @GetMapping("/detail.do")
    public String detail(@RequestParam("uuid") String uuid, Model model) {
        // 조회수 증가
        communityService.increaseViewCount(uuid);

        // 게시글 상세 정보 조회
        CommunityVO community = communityService.selectCommunity(uuid);
        if (community == null) {
            return "redirect:/community/community.do";
        }

        model.addAttribute("community", community);
        return "community/detail_community";
    }

 

    /**
     * 이미지 출력
     */
    @GetMapping("/image.do")
    @ResponseBody
    public ResponseEntity<byte[]> getImage(@RequestParam("uuid") String uuid) {
        CommunityVO vo = communityService.selectCommunity(uuid);
        byte[] image = vo.getCommunityImage();

        if (image == null || image.length == 0) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        // 고정된 이미지 타입 (PNG)
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);

        return new ResponseEntity<>(image, headers, HttpStatus.OK);
    }

    /**
     * 게시글 삭제
     */
    @PostMapping("/delete.do")
    public String delete(@RequestParam(defaultValue = "") String uuid) {
        log.info("삭제 UUID: {}", uuid);
        communityService.delete(uuid);
        return "redirect:/community/community.do";
    }

    /**
     * 댓글 추가 (세션 기반 저장)
     */
    @PostMapping("/commentInsert.do")
    public String insertComment(HttpServletRequest request,
                                @RequestParam String uuid,
                                @RequestParam String writer,
                                @RequestParam String content) {
        HttpSession session = request.getSession();
        Map<String, List<Map<String, String>>> allComments =
                (Map<String, List<Map<String, String>>>) session.getAttribute("allComments");

        if (allComments == null) {
            allComments = new HashMap<>();
        }

        // 새 댓글 추가
        List<Map<String, String>> commentList = allComments.getOrDefault(uuid, new ArrayList<>());
        Map<String, String> newComment = new HashMap<>();
        newComment.put("writer", writer);
        newComment.put("content", content);
        newComment.put("timestamp", LocalDateTime.now().toString());

        commentList.add(newComment);
        allComments.put(uuid, commentList);
        session.setAttribute("allComments", allComments);

        return "redirect:/community/detail.do?uuid=" + uuid;
    }

    /**
     * 게시글 수정 폼 진입
     */
    @GetMapping("/editForm.do")
    public String editForm(@RequestParam String uuid, Model model) {
        CommunityVO vo = communityService.selectCommunity(uuid);
        model.addAttribute("community", vo);
        return "community/edit_community";
    }
}
