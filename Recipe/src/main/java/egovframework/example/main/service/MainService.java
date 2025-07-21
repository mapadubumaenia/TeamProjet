/**
 * 
 */
package egovframework.example.main.service;

import java.util.List;

/**
 * @author user
 *
 */
public interface MainService {
	List<MainVO> selectRandomRecommendedRecipes();
	List<MainVO> selectRandomTrimmingMethods();  // 손질법
	List<MainVO> selectRandomStorageMethods();   // 보관법
	List<MainVO> selectRecentRecipes();
	List<MainVO> selectTopLiked();
}
