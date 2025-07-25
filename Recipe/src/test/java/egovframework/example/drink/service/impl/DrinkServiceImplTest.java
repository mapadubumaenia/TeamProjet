package egovframework.example.drink.service.impl;



import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import egovframework.example.common.Criteria;
import egovframework.example.drink.service.DrinkService;

import egovframework.example.drink.service.DrinkVO;

import lombok.extern.log4j.Log4j2;


@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
      "classpath:/egovframework/spring/context-aspect.xml",
       "classpath:/egovframework/spring/context-common.xml",
       "classpath:/egovframework/spring/context-datasource.xml",
       "classpath:/egovframework/spring/context-idgen.xml",
       "classpath:/egovframework/spring/context-mapper.xml",
       "classpath:/egovframework/spring/context-sqlMap.xml",
       "classpath:/egovframework/spring/context-transaction.xml"
})
class DrinkServiceImplTest {

	@Autowired
	DrinkService drinkService;
	
	@Test
	void testSelectDrinkList() {
		
		//여기서 각 메소드별 테스트하면됨
				//1)테스트 조건
				Criteria criteria= new Criteria();
				criteria.setSearchKeyword("");        //검색어
				criteria.setFirstIndex(0);             //2페이지(3)
				criteria.setPageUnit(3);               //화면에 보일 개수 (3)
				
				
				
			    //2)실제 메소드 실행
				List<?> list = drinkService.selectDrinkList(criteria);
			    //3)검증(확인): 로그, DB확인,
				log.info(list);
		
		
	}


	// 페이지 총 갯수 구하기
	@Test
	void testSelectDrinkListTotCnt() {
		
		//여기서 각 메소드별 테스트하면됨
		//1)테스트 조건
		Criteria criteria= new Criteria();
		criteria.setSearchKeyword("");        //검색어
		
		
	    //2)실제 메소드 실행
		int count =drinkService.selectDrinkListTotCnt(criteria);
	    //3)검증(확인): 로그, DB확인,
		log.info(count);
		
	}
	
	
	//상세조회
	@Test
	void testSelectDrink() {
		//여기서 각 메소드별 테스트하면됨
		//1)테스트 조건:(given)
		String uuid="123456576878";
		
	    //2)실제 메소드 실행 (when)
		DrinkVO drinkVO=drinkService.selectDrink(uuid);
	    //3)검증(확인): 로그,아니면 DB에서확인, (then)
		log.info(drinkVO);
	}
	
	
	@Test
	void testDelete() {
		//여기서 각 메소드별 테스트하면됨
				//1)테스트 조건: 
			    String uuid="123456576878";

				// 2)실제 메소드 실행
			    drinkService.delete(uuid);
				// 3)검증(확인): 로그,아니면 DB에서확인,
	}
	
	

}
