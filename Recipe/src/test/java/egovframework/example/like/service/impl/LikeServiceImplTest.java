package egovframework.example.like.service.impl;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import egovframework.example.like.service.LikeService;
import egovframework.example.like.service.LikeVO;
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
class LikeServiceImplTest {

    @Autowired
    private LikeService likeService;

    @Test
    void testInsertLike() {
        LikeVO likeVO = new LikeVO();
        likeVO.setUserId("idone");
        likeVO.setTargetType("standard");
        likeVO.setUuid("11111111"); // 

        likeService.insertLike(likeVO);
        log.info("✅ insert 성공");
    }

    @Test
    void testCountLikeByUser() {
        LikeVO likeVO = new LikeVO();
        likeVO.setUserId("testuser");
        likeVO.setTargetType("recipe");
        likeVO.setUuid("1234567890");

        int count = likeService.countLikeByUser(likeVO);
        log.info("✅ 좋아요 여부 확인: " + count);
    }

    @Test
    void testDeleteLike() {
        LikeVO likeVO = new LikeVO();
        likeVO.setUserId("testuser");
        likeVO.setTargetType("recipe");
        likeVO.setUuid("1234567890");

        likeService.deleteLike(likeVO);
        log.info("✅ delete 성공");
    }

    @Test
    void testCountLikesByUuid() {
        String uuid = "1234567890";

        int totalLikes = likeService.countLikesByUuid(uuid);
        log.info("✅ 총 좋아요 수: " + totalLikes);
    }
}
