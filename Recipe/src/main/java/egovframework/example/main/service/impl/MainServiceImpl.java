/**
 * 
 */
package egovframework.example.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.main.service.MainService;
import egovframework.example.main.service.MainVO;

/**
 * @author user
 *
 */
@Service
public class MainServiceImpl implements MainService  {
	@Autowired
	private MainMapper mainMapper;
//전체랜덤(추천)
	@Override
	public List<MainVO> selectRandomRecommendedRecipes() {
		// TODO Auto-generated method stub
		return mainMapper.selectRandomRecommendedRecipes();
	}
//손질보관 랜덤
	@Override
	public List<MainVO> selectRandomTrimmingMethods() {
		// TODO Auto-generated method stub
		return mainMapper.selectRandomTrimmingMethods();
	}

	@Override
	public List<MainVO> selectRandomStorageMethods() {
		// TODO Auto-generated method stub
		return mainMapper.selectRandomStorageMethods();
	}
//최근레시피
	@Override
	public List<MainVO> selectRecentRecipes() {
		// TODO Auto-generated method stub
		return mainMapper.selectRecentRecipes();
	}
//인기순	
	@Override
	public List<MainVO> selectTopLiked() {
		// TODO Auto-generated method stub
		return mainMapper.selectTopLiked();
	}


	
	
	

}
