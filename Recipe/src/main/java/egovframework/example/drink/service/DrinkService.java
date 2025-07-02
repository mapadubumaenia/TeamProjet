package egovframework.example.drink.service;

import java.util.List;

import egovframework.example.common.Criteria;

public interface DrinkService {

	
	List<?> selectDrinkList(Criteria criteria); // 전체 조회

	int selectDrinkListTotCnt(Criteria criteria); // 총 갯수 구하기

	int insert(DrinkVO drinkVO); // insert

	DrinkVO selectDrink(String uuid); // 상세조회

	int delete(String uuid); // 삭제
	
	
	
	
}
