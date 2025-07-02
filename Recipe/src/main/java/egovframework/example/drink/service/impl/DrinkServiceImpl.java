package egovframework.example.drink.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.common.Criteria;
import egovframework.example.drink.service.DrinkService;

@Service
public class DrinkServiceImpl implements DrinkService {

	@Autowired
	DrinkMapper drinkMapper;

	//전체조회
	@Override
	public List<?> selectDrinkList(Criteria criteria) {
		
		return drinkMapper.selectDrinkList(criteria);
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
