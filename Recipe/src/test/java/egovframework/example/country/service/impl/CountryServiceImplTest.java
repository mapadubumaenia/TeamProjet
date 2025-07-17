package egovframework.example.country.service.impl;

import static org.junit.jupiter.api.Assertions.fail;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import egovframework.example.common.Criteria;
import egovframework.example.country.service.CountryService;
import egovframework.example.country.service.CountryVO;
import lombok.extern.log4j.Log4j2;

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
@Log4j2
class CountryServiceImplTest {
	   
	   @Autowired
	   CountryService countryService;

	@Test
	void testSelectCountryList() {
//      여기서 각 메소드별 테스트하면 됩니다.: 전체조회
//	    1)테스트 조건
	   Criteria criteria = new Criteria();
	   criteria.setSearchKeyword("");//검색어
	   criteria.setFirstIndex(0); // 2페이지(0)
	   criteria.setPageUnit(3); // 화면 보일 개수(3)
//	    2)검증(확인)
	   List<?> list = countryService.selectCountryList(criteria);
//	    3)검증(확인):로그, DB 확인, assert~
	   log.info(list);
	}
	@Test
	void testSelectCountryListTotCnt() {
//      여기서 각 메소드별 테스트하면 됩니다.: 전체조회
//	    1)테스트 조건
	   Criteria criteria = new Criteria();
	   criteria.setSearchKeyword("");//검색어
	   criteria.setFirstIndex(0); // 2페이지(0)
	   criteria.setPageUnit(3); // 화면 보일 개수(3)
//	    2)검증(확인)
	   List<?> list = countryService.selectCountryList(criteria);
//	    3)검증(확인):로그, DB 확인, assert~
	   log.info(list);
	}

	@Test
	void testInsert() {
		
//		 1)테스트 조건 
		 CountryVO countryVO = new CountryVO();
		 countryVO.setUuid("1234567890"); countryVO.setUserId("1");
		 countryVO.setRecipeTitle("dd"); countryVO.setCountryCategoryId(1);
		 countryVO.setIngredientCategoryId(1); countryVO.setSituationCategoryId(1);
		 countryVO.setStandardRecipeImageUrl("222222");
		 countryVO.setRecipeCreatedAt("222222"); countryVO.setLikeCount(22);
		 countryVO.setRecipeContent("222222"); 
		 // 2)실제 메소드실행
		 countryService.insert(countryVO); // 3)검증(확인) : 로그, DB확인, assert~ (DB확인)
		 }
	@Test
	void testSelectCountry() {
//		1)테스트 조건(given):
		String uuid = "11111111";
//		2)실제 메소드 실행(when)
		CountryVO countryVO = countryService.selectCountry(uuid);
//		3)검증(확인)(then): 로그, DB확인, assert~ (DB확인)
		log.info(countryVO);
	}
	@Test
	void testDelete() {
//		1)테스트 조건
		CountryVO countryVO = new CountryVO();
		countryVO.setUuid("11111111");
//		2)실제 메소드실행
		countryService.delete(countryVO);
//		3)검증(확인) : 로그, DB확인, assert~ (DB확인)
	}
//	수정
	@Test
	void testUpdate() {
//		1)테스트 조건
		CountryVO countryVO = new CountryVO();
		 countryVO.setUuid("1234567890"); 
		 countryVO.setUserId("1");
		 countryVO.setRecipeTitle("dd"); 
		 countryVO.setCountryCategoryId(1);
		 countryVO.setIngredientCategoryId(1); 
		 countryVO.setSituationCategoryId(1);
		 countryVO.setStandardRecipeImageUrl("222222");
		 countryVO.setRecipeCreatedAt("222222"); 
		 countryVO.setLikeCount(22);
		 countryVO.setRecipeContent("222222"); 
//		2)실제 메소드실행
		countryService.update(countryVO);
//		3)검증(확인) : 로그, DB확인, assert~ (DB확인)
	}

}
