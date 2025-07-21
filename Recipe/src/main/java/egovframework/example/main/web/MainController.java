/**
 * 
 */
package egovframework.example.main.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import egovframework.example.main.service.MainService;
import egovframework.example.main.service.MainVO;



/**
 * @author user
 *
 */
@Controller
public class MainController {
	
	@Autowired
	private MainService mainService;

	 public MainController(MainService mainService) {
	        this.mainService = mainService;
	    }

	@GetMapping("/main.do")
	public String mainPage(Model model) {
		List<MainVO> recommendedRecipes = mainService.selectRandomRecommendedRecipes();
		List<MainVO> trimming = mainService.selectRandomTrimmingMethods();
		List<MainVO> storage = mainService.selectRandomStorageMethods();
		List<MainVO> recentRecipes = mainService.selectRecentRecipes();
		List<MainVO> selectTopLiked=mainService.selectTopLiked();
		
		model.addAttribute("recommendedRecipes", recommendedRecipes);
		model.addAttribute("trimming", trimming);
		model.addAttribute("storage", storage);
		model.addAttribute("recentRecipes", recentRecipes);
		model.addAttribute("selectTopLiked",selectTopLiked);
		
		return "main/main";
	}
	
}
