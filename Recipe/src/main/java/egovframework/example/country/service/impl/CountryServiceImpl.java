package egovframework.example.country.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import egovframework.example.common.Criteria;
import egovframework.example.country.service.CountryService;
import egovframework.example.country.service.CountryVO;
import egovframework.example.like.service.LikeVO;
import egovframework.example.like.service.impl.LikeMapper;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class CountryServiceImpl implements CountryService{

	@Autowired
	private CountryMapper countryMapper;
	
	@Autowired
	private LikeMapper likeMapper;
	
//	전체조회
	@Override
	public List<?> selectCountryList(Criteria criteria) {
		// TODO Auto-generated method stub
		return countryMapper.selectCountryList(criteria);
	}
//	총갯수
	@Override
	public int selectCountryListTotCnt(Criteria criteria) {
		// TODO Auto-generated method stub
		return countryMapper.selectCountryListTotCnt(criteria);
	}
	
	
//	입력
	@Override
	public int insert(CountryVO countryVO) {
		log.info("테스트1 : "+countryVO);
		// TODO Auto-generated method stub
		// TODO 1) UUID 만들기(기본키) : 자바에서 중복안되게 만들어주는 글자(랜덤)
		String newUuid = UUID.randomUUID().toString();
//				2) 다운로드 URL 만들기
		String downloadURL = generateDownloadUrl(newUuid);
//				3) FileDbVO 에 위의 UUID, URL 저장(setter)
		countryVO.setUuid(newUuid);
		log.info("테스트2 : "+newUuid);
		log.info("테스트3 : "+downloadURL);
		countryVO.setStandardRecipeImageUrl(downloadURL);
//				4) DB insert(fileDbVO)
		return countryMapper.insert(countryVO);
	}
	   public String generateDownloadUrl(String uuid) {
//		      인터넷주소 체계        : http://localhost:8080/경로(path)?쿼리스트링
//		      기본주소(ContextPath): http://localhost:8080
//		      URL 만드는 클래스      : ServletUriComponentsBuilder
		        return ServletUriComponentsBuilder      
		          .fromCurrentContextPath()    // 기본주소  http://localhost:8080
		          .path("/country/download.do") // 경로    /fileDb/download.do
		          .query("uuid="+uuid)         // 쿼리스트링 ?uuid=uuid
		          .toUriString();
		     // 기본주소  http://localhost:8080/fileDb/download.do?uuid=uuid
		   }

	@Override
	public CountryVO selectCountry(String uuid) {
		// TODO Auto-generated method stub
		return countryMapper.selectCountry(uuid);
	}
//	삭제
	@Override
	public int delete(CountryVO countryVO) {
		// TODO Auto-generated method stub
		return countryMapper.delete(countryVO);
	}
//	입력
	@Override
	public int update(CountryVO countryVO) {
		log.info("테스트1 : "+countryVO);
		// TODO Auto-generated method stub
		// TODO 1) UUID 만들기(기본키) : 자바에서 중복안되게 만들어주는 글자(랜덤)
//				2) 다운로드 URL 만들기
		String downloadURL = generateDownloadUrl(countryVO.getUuid());
//				3) FileDbVO 에 위의 UUID, URL 저장(setter)
		log.info("테스트3 : "+downloadURL);
		countryVO.setStandardRecipeImageUrl(downloadURL);
//				4) DB insert(fileDbVO)
		return countryMapper.update(countryVO);
	}
//	나라선택
	@Override
	public List<CountryVO> getCountryCategories() {
		// TODO Auto-generated method stub
		return countryMapper.selectCountryCategories();
	}
//	재료선택
	@Override
	public List<CountryVO> getIngredientCategories() {
		// TODO Auto-generated method stub
		return countryMapper.selectIngredientCategories();
	}
//	상황선택
	@Override
	public List<CountryVO> getSituationCategories() {
		// TODO Auto-generated method stub
		return countryMapper.selectSituationCategories();
	}
	// ✅ 좋아요 토글 기능
	@Override
	public boolean toggleLike(String uuid, String userId) {
	    // 공용 LikeVO 객체 생성 및 값 세팅
	    LikeVO likeVO = new LikeVO();
	    likeVO.setUserId(userId);
	    likeVO.setTargetType("standard");
	    likeVO.setUuid(uuid);

	    int count = likeMapper.countLikeByUser(likeVO);
	    boolean liked;

	    if (count > 0) {
	        likeMapper.deleteLike(likeVO);
	        liked = false;
	    } else {
	        likeMapper.insertLike(likeVO);
	        liked = true;
	    }

	    // 좋아요 수 다시 세서 DB에 업데이트
	    int totalLikes = likeMapper.countLikesByUuid(uuid);
	    countryMapper.updateLikeCount(uuid, totalLikes);  // ← 여기 추가!

	    return liked;
	}

	// ✅ 현재 게시물의 총 좋아요 수 반환
	@Override
	public int getLikeCount(String uuid) {
	    return likeMapper.countLikesByUuid(uuid);
	}
	
//	좋아요 DB
	@Override
	public int updateLikeCount(String uuid, int likeCount) {
		// TODO Auto-generated method stub
		return countryMapper.updateLikeCount(uuid, likeCount);
	}
}
