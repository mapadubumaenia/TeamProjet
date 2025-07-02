package egovframework.example.drink.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.common.Criteria;
import egovframework.example.drink.service.DrinkVO;

@Mapper
public interface DrinkMapper {

	
	
	     public List<?> selectDrinkList(Criteria criteria);  //전체 조회
	     public int  selectDrinkListTotCnt(Criteria criteria);  //총 갯수 구하기
		 public int insert(DrinkVO drinkVO);     // insert
		 public DrinkVO selectDrink(String uuid);     //상세조회
		 public int delete(String uuid);      //삭제
	
		 
		 
		 
		 
		 
		 
		 
	
}
