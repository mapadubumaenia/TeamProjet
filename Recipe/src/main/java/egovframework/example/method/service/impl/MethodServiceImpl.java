package egovframework.example.method.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import egovframework.example.common.Criteria;
import egovframework.example.method.service.MethodService;
import egovframework.example.method.service.MethodVO;


@Service
public class MethodServiceImpl implements MethodService {
	
	@Autowired
	MethodMapper methodMapper;
	
	
	

	//전체조회
	@Override
	public List<?> selectMethodList(Criteria criteria) {
		// TODO Auto-generated method stub
		return methodMapper.selectMethodList(criteria);
	}

	
	
	
	
	//페이지 총 갯수 구하기
	@Override
	public int selectMethodListTotCnt(Criteria criteria) {
		// TODO Auto-generated method stub
		return methodMapper.selectMethodListTotCnt(criteria);
	}

	
	//업로드
	@Override
	public int insert(MethodVO methodVO) {
		// 1)uuid 만들기(기본키): 자바에서 중복안되게 만들어 주는 글자(랜덤)
		String newUuid=UUID.randomUUID().toString();
//	     2)다운로드 url 만들기 (개발자 알아서 정해야함)
		String downloadURL=generateDownloadUrl(newUuid);
//	     3)FileDbVO 에 위의 uuid, url 저장(setter로 저장)
		methodVO.setUuid(newUuid);
		methodVO.setMethodUrl(downloadURL);
//	     4)DB insert(FileDbVO)
		return methodMapper.insert(methodVO);
	}

//	다운로드 URL을 만들어주는 메소드
	public String generateDownloadUrl(String uuid){
		 //  인터넷 주소 체계=> http://localhost:8080/경로(path)?쿼리스트링
		 //  기본주소(ContextPath): http://localhost:8080
		 //  URL 만드는 클래스:ServletUriComponentsBuilder
	        return ServletUriComponentsBuilder      
	          .fromCurrentContextPath()          //기본주소:http://localhost:8080
	          .path("/method/download.do")       //경로  :/fileDb/download.do
	          .query("uuid="+uuid)               //쿼리스트링: ?uuid="+ uuid
	          .toUriString();                 // 위에꺼 조합 http://localhost:8080/fileDb/download.do?uuid=uuid값
	   }
	
	
	
	
	
	
	//상세조회
	@Override
	public MethodVO selectMethod(String uuid) {
		// TODO Auto-generated method stub
		return methodMapper.selectMethod(uuid);
	}

	
	//삭제
	@Override
	public int delete(String uuid) {
		// TODO Auto-generated method stub
		return methodMapper.delete(uuid);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
