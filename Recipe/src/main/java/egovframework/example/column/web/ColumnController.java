// ColumnController.java
package egovframework.example.column.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import egovframework.example.column.service.ColumnService;
import egovframework.example.column.service.BannerAdVO;
import egovframework.example.drink.service.DrinkVO;
import egovframework.example.method.service.MethodVO;

@Controller
public class ColumnController {

    private static final int RECOMMEND_LIMIT = 12;

    @Autowired private ColumnService columnService;

    @GetMapping("/column.do")
    public String columnPage(Model model) {
        // 1) 광고판 배너
        List<BannerAdVO> bannerAds = columnService.selectBannerAds();
        model.addAttribute("bannerAds", bannerAds);

        // 2) 드링크 추천
        List<DrinkVO> topDrinks = columnService.selectTopLikedDrinks(RECOMMEND_LIMIT);
        model.addAttribute("topDrinks", topDrinks);

        // 3) 보관법 추천
        List<MethodVO> topStore = columnService.selectTopLikedByCategory("storage", RECOMMEND_LIMIT);
        model.addAttribute("topStore", topStore);

        // 4) 손질법 추천
        List<MethodVO> topPrep = columnService.selectTopLikedByCategory("trim", RECOMMEND_LIMIT);
        model.addAttribute("topPrep", topPrep);

        return "column/column";
    }
}