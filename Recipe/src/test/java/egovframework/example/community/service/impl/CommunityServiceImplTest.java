package egovframework.example.community.service.impl;

import static org.junit.jupiter.api.Assertions.fail;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import egovframework.example.common.Criteria;
import egovframework.example.community.service.CommunityService;
import egovframework.example.community.service.CommunityVO;
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
class CommunityServiceImplTest {

	@Autowired
	CommunityService communityService;
	
	@Test
	void testSelectCommunityList() {
		Criteria criteria=new Criteria();
		criteria.setSearchKeyword("");    // 검색어
		criteria.setFirstIndex(0);         // 2페이지(3)
		criteria.setPageUnit(0);           // 화면 보일 개수(3)
		
//		2) 실제 메소드실행
		List<?> list=communityService.selectCommuList(criteria);
//		3) 검증(확인): 로그 , DB 확인, assert~
	log.info(list);
	}

	@Test
	void testSelectCommunityListToCnt() {
		Criteria criteria = new Criteria();
		criteria.setSearchKeyword("");
		
		int count = communityService.selectCommuListToCnt(criteria);
		log.info(count);
	}

	@Test
	void testInsert() {
		String uuid="12345678";
		
		CommunityVO communityVO = new CommunityVO();
		
		communityService.insert(communityVO);
	}

	

	@Test
	void testUpdate() {
		fail("Not yet implemented");
	}

	@Test
	void testDelete() {
		fail("Not yet implemented");
	}

}
