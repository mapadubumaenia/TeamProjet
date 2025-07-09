package egovframework.example.community.web;

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

    @GetMapping("/community.do")
    public String selectCommunityList(@ModelAttribute Criteria criteria, Model model) {
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(criteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
        criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

        List<?> commuNts = communityService.selectCommuList(criteria);
        int toCnt = communityService.selectCommuListToCnt(criteria);
        paginationInfo.setTotalRecordCount(toCnt);

        model.addAttribute("CommuNts", commuNts);
        model.addAttribute("paginationInfo", paginationInfo);
        return "community/community_all";
    }

    @GetMapping("/addition.do")
    public String createCommunityView() {
        return "community/add_community";
    }

    @PostMapping("/addition.do")
    public String insertCommunity(@ModelAttribute CommunityVO communityVO,
                                  @RequestParam("uploadFile") MultipartFile file) {
        try {
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

    @PostMapping("/update.do")
    public String updateCommunity(@ModelAttribute CommunityVO communityVO,
                                  @RequestParam("uploadFile") MultipartFile file,
                                  RedirectAttributes redirectAttributes) {
        try {
            if (!file.isEmpty()) {
                String contentType = file.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    communityVO.setCommunityImage(file.getBytes());
                }
            }

            communityService.update(communityVO);
            redirectAttributes.addFlashAttribute("message", "수정이 완료되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "수정 중 오류 발생");
        }

        return "redirect:/community/detail.do?uuid=" + communityVO.getUuid() + "&t=" + System.currentTimeMillis();
    }

    @GetMapping("/detail.do")
    public String detail(@RequestParam("uuid") String uuid, Model model) {
        communityService.increaseViewCount(uuid); // 조회수 증가
        CommunityVO community = communityService.selectCommunity(uuid); // 상세조회
        if (community == null) {
            return "redirect:/community/community.do";
        }
        model.addAttribute("community", community);
        return "community/detail_community";
    }
    
    
    @PostMapping("/like.do")
    @ResponseBody
    public int increaseLikeCount(@RequestParam("uuid") String uuid) {
        return communityService.increaseLikeCount(uuid);
    }

    @GetMapping("/image.do")
    @ResponseBody
    public ResponseEntity<byte[]> getImage(@RequestParam("uuid") String uuid) {
        CommunityVO vo = communityService.selectCommunity(uuid);
        byte[] image = vo.getCommunityImage();

        if (image == null || image.length == 0) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG); // 고정

        return new ResponseEntity<>(image, headers, HttpStatus.OK);
    }

    @PostMapping("/delete.do")
    public String delete(@RequestParam(defaultValue = "") String uuid) {
        log.info("삭제 UUID: {}", uuid);
        communityService.delete(uuid);
        return "redirect:/community/community.do";
    }

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

    @GetMapping("/editForm.do")
    public String editForm(@RequestParam String uuid, Model model) {
        CommunityVO vo = communityService.selectCommunity(uuid);
        model.addAttribute("community", vo);
        return "community/edit_community";
    }
}
