package egovframework.example.qna.web;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.auth.service.MemberVO;
import egovframework.example.common.Criteria;
import egovframework.example.qna.service.QnaService;
import egovframework.example.qna.service.QnaVO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequestMapping("/qna")
public class QnaController {

    @Autowired
    private QnaService qnaService;

    // QnA 목록 조회
    @GetMapping("/qna.do")
    public String selectQnaList(@ModelAttribute Criteria criteria, Model model) {
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(criteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
        criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

        List<?> qnaList = qnaService.selectQnaList(criteria);
        int totalCount = qnaService.selectQnaListTotalCount(criteria);
        paginationInfo.setTotalRecordCount(totalCount);

        model.addAttribute("qnaList", qnaList);
        model.addAttribute("paginationInfo", paginationInfo);
        return "qna/qna_all";
    }

    // QnA 글쓰기 폼 이동
    @GetMapping("/addition.do")
    public String createQnaView() {
        return "qna/add_qna";
    }

    // QnA 등록
    @PostMapping("/addition.do")
    public String insertQna(@ModelAttribute QnaVO qnaVO,
                            @RequestParam("uploadFile") MultipartFile file,
                            HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("memberVO") == null) {
                throw new IllegalStateException("로그인된 사용자만 글을 작성할 수 있습니다.");
            }

            MemberVO loginMember = (MemberVO) session.getAttribute("memberVO");
            qnaVO.setUserId(loginMember.getUserId());
            qnaVO.setUserNickname(loginMember.getNickname());
            qnaVO.setContentType("qna");

            if (!file.isEmpty()) {
                String contentType = file.getContentType();
                if (contentType == null || !contentType.startsWith("image/")) {
                    throw new IllegalArgumentException("이미지 파일만 업로드 가능합니다.");
                }
                qnaVO.setQnaImage(file.getBytes());
            }

            qnaVO.setUuid(UUID.randomUUID().toString());
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy-MM-dd HH:mm");
            qnaVO.setQnaCreatedAt(LocalDateTime.now().format(formatter));

            qnaService.insertQna(qnaVO);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/qna/qna.do";
    }

    // QnA 상세 조회
    @GetMapping("/detail.do")
    public String detail(@RequestParam("uuid") String uuid, Model model) {
        qnaService.incrementQnaCount(uuid);

        QnaVO qna = qnaService.selectQnaDetail(uuid);
        if (qna == null) {
            return "redirect:/qna/qna.do";
        }
        model.addAttribute("qna", qna);
        model.addAttribute("community", qna);
        
        return "qna/detail_qna";
    }

    // QnA 수정 폼
    @GetMapping("/editForm.do")
    public String editForm(@RequestParam String uuid, Model model) {
        QnaVO vo = qnaService.selectQnaDetail(uuid);
        model.addAttribute("qna", vo);
        return "qna/edit_qna";
    }

    // QnA 수정
    @PostMapping("/update.do")
    public String updateQna(@ModelAttribute QnaVO qnaVO,
                            @RequestParam("uploadFile") MultipartFile file,
                            RedirectAttributes redirectAttributes) {
        try {
            if (!file.isEmpty()) {
                String contentType = file.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    qnaVO.setQnaImage(file.getBytes());
                }
            }

            qnaService.updateQna(qnaVO);
            redirectAttributes.addFlashAttribute("message", "수정이 완료되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "수정 중 오류 발생");
        }

        return "redirect:/qna/detail.do?uuid=" + qnaVO.getUuid() + "&t=" + System.currentTimeMillis();
    }

    // QnA 삭제
    @PostMapping("/delete.do")
    public String delete(@RequestParam(defaultValue = "") String uuid) {
        log.info("삭제 UUID: {}", uuid);
        qnaService.deleteQna(uuid);
        return "redirect:/qna/qna.do";
    }

    // QnA 이미지 출력
    @GetMapping("/image.do")
    @ResponseBody
    public ResponseEntity<byte[]> getImage(@RequestParam("uuid") String uuid) {
        QnaVO vo = qnaService.selectQnaDetail(uuid);
        byte[] image = vo.getQnaImage();

        if (image == null || image.length == 0) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);

        return new ResponseEntity<>(image, headers, HttpStatus.OK);
    }

    // QnA 답변 등록
    @PostMapping("/answer.do")
    public String insertAnswer(@ModelAttribute QnaVO vo,
                               @RequestParam("uploadFile") MultipartFile file,
                               HttpServletRequest request,
                               RedirectAttributes redirectAttributes) {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("memberVO") == null) {
                throw new IllegalStateException("로그인된 사용자만 답변할 수 있습니다.");
            }

            MemberVO loginMember = (MemberVO) session.getAttribute("memberVO");
            vo.setAnswerUserId(loginMember.getUserId());

            if (!file.isEmpty()) {
                String contentType = file.getContentType();
                if (contentType == null || !contentType.startsWith("image/")) {
                    throw new IllegalArgumentException("이미지 파일만 업로드 가능합니다.");
                }
                vo.setAnswerImage(file.getBytes());
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy-MM-dd HH:mm");
            vo.setAnswerCreatedAt(LocalDateTime.now().format(formatter));

            qnaService.insertQnaAnswer(vo);
            redirectAttributes.addFlashAttribute("message", "답변이 등록되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "답변 등록 중 오류 발생");
        }

        return "redirect:/qna/detail.do?uuid=" + vo.getUuid();
    }


    // QnA 답변 수정
    @PostMapping("/updateAnswer.do")
    public String updateAnswer(@ModelAttribute QnaVO vo,
                               @RequestParam("uploadFile") MultipartFile file,
                               RedirectAttributes redirectAttributes) {
        try {
            if (!file.isEmpty()) {
                String contentType = file.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    vo.setAnswerImage(file.getBytes());
                } else {
                    throw new IllegalArgumentException("이미지 파일만 업로드 가능합니다.");
                }
            }

            qnaService.updateQnaAnswer(vo);
            redirectAttributes.addFlashAttribute("message", "답변이 수정되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "답변 수정 중 오류 발생");
        }

        return "redirect:/qna/detail.do?uuid=" + vo.getUuid() + "&t=" + System.currentTimeMillis();
    }
    
    

}
