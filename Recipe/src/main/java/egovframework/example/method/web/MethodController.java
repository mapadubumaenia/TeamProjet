package egovframework.example.method.web;

import java.io.IOException;
import java.util.Base64;
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

import egovframework.example.method.service.MethodService;
import egovframework.example.method.service.MethodVO;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class MethodController {

    @Autowired
    private MethodService methodService;

    // 1) 리스트 조회
    @GetMapping("/method/method.do")
    public String selectMethodList(
            @ModelAttribute MethodVO criteria,
            @RequestParam(name="methodType", required=false, defaultValue="storage") String methodType,
            @RequestParam(name="category", required=false, defaultValue="") String category,
            Model model) {

        criteria.setMethodType(methodType);

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(criteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(criteria.getPageUnit());
        criteria.setFirstIndex(paginationInfo.getFirstRecordIndex());

        if (!category.isEmpty()) {
            criteria.setCategory(category);
        }
        model.addAttribute("selectedCategory", category);
        model.addAttribute("methodType", methodType);

        List<?> methods = methodService.selectMethodList(criteria);
        model.addAttribute("methods", methods);

        int totCnt = methodService.selectMethodListTotCnt(criteria);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "method/method_all";
    }

    // 2) 등록 폼 열기
    @GetMapping("/method/addition.do")
    public String createMethodView(
            @RequestParam(name="methodType", required=false, defaultValue="storage") String methodType,
            Model model) {

        model.addAttribute("methodVO", new MethodVO());
        model.addAttribute("methodType", methodType);
        return "method/add_method";
    }

    // 3) INSERT
    @PostMapping("/method/add.do")
    public String insert(
            @RequestParam(name="methodType", required=false, defaultValue="storage") String methodType,
            @RequestParam(defaultValue = "") String methodTitle,
            @RequestParam(defaultValue = "") String methodContent,
            @RequestParam(defaultValue = "") String category,
            @RequestParam(required = false) MultipartFile image
    ) throws Exception {
        MethodVO methodVO = new MethodVO(methodTitle, methodContent, category, image.getBytes());
        methodVO.setMethodType(methodType);
        if (image != null && !image.isEmpty()) {
            methodVO.setMethodData(image.getBytes());
        }
        methodService.insert(methodVO);
        return "redirect:/method/method.do?methodType=" + methodType;
    }

    // 4) 다운로드
    @GetMapping("/method/download.do")
    @ResponseBody
    public ResponseEntity<byte[]> findDownload(@RequestParam String uuid) {
        MethodVO methodVO = methodService.selectMethod(uuid);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDispositionFormData("attachment", methodVO.getUuid());
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<>(methodVO.getMethodData(), headers, HttpStatus.OK);
    }

    // 5) 삭제
    @PostMapping("/method/delete.do")
    public String delete(
            @RequestParam String uuid,
            @RequestParam(name="methodType", required=false, defaultValue="storage") String methodType
    ) {
        methodService.delete(uuid);
        return "redirect:/method/method.do?methodType=" + methodType;
    }

    // 6) 상세 프래그먼트
    @GetMapping("/method/detailFragment.do")
    public String detailFragment(
            @RequestParam String uuid,
            @RequestParam(name="methodType", required=false, defaultValue="storage") String methodType,
            Model model) {
        MethodVO detail = methodService.selectMethod(uuid);
        model.addAttribute("method", detail);
        model.addAttribute("methodType", methodType);
        return "method/detailFragment";
    }

    // 7) 미리보기 모달
    @PostMapping("/method/preview.do")
    public String preview(
            @RequestParam(defaultValue = "") String methodTitle,
            @RequestParam(defaultValue = "") String methodContent,
            @RequestParam(defaultValue = "") String category,
            @RequestParam(required = false) MultipartFile image,
            Model model) throws IOException {

        MethodVO previewVO = new MethodVO();
        previewVO.setMethodTitle(methodTitle);
        previewVO.setMethodContent(methodContent);
        previewVO.setCategory(category);
        if (image != null && !image.isEmpty()) {
            byte[] bytes = image.getBytes();
            previewVO.setMethodData(bytes);
            String base64 = Base64.getEncoder().encodeToString(bytes);
            previewVO.setMethodUrl("data:" + image.getContentType() + ";base64," + base64);
        }
        model.addAttribute("preview", previewVO);
        return "method/previewFragment";
    }
}