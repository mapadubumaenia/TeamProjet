/**
 * 
 */
package egovframework.example.main.service.impl;


import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.main.service.MainVO;


/**
 * @author user
 *
 */
@Mapper
public interface MainMapper {
	public List<MainVO> selectRandomRecommendedRecipes();
	public List<MainVO> selectRandomTrimmingMethods();  // 손질법
	public List<MainVO> selectRandomStorageMethods();   // 보관법
	public List<MainVO> selectRecentRecipes();          // 최근
	public List<MainVO> selectTopLiked();
}
