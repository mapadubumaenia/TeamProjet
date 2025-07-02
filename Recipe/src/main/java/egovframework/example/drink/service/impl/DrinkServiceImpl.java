package egovframework.example.drink.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.common.Criteria;
import egovframework.example.drink.service.DrinkService;
import egovframework.example.drink.service.DrinkVO;

@Service
public class DrinkServiceImpl implements DrinkService {

	@Autowired
	DrinkMapper drinkMapper;

	//전체조회
	@Override
	public List<?> selectDrinkList(Criteria criteria) {
		
		return drinkMapper.selectDrinkList(criteria);
	}

	//페이지 총 갯수 구하기
	@Override
	public int selectDrinkListTotCnt(Criteria criteria) {
		// TODO Auto-generated method stub
		return drinkMapper.selectDrinkListTotCnt(criteria);
	}

	
//	업로드
	@Override
	public int insert(DrinkVO drinkVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	//상세조회
	@Override
	public DrinkVO selectDrink(int column_id) {
		// TODO Auto-generated method stub
		return drinkMapper.selectDrink(column_id);
	}

	
	//삭제
	@Override
	public int delete(int column_id) {
		// TODO Auto-generated method stub
		return drinkMapper.delete(column_id);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
