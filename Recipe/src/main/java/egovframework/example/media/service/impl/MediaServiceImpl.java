/**
 * 
 */
package egovframework.example.media.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import egovframework.example.common.Criteria;
import egovframework.example.media.service.MediaService;
import egovframework.example.media.service.MediaVO;
import lombok.extern.log4j.Log4j2;

/**
 * @author user
 *
 */
@Log4j2
@Service
public class MediaServiceImpl implements MediaService {
	@Autowired
	private MediaMapper mediaMapper;

//전체조회	
	@Override
	public List<?> allMedia(Criteria criteria) {
		// TODO Auto-generated method stub
		return mediaMapper.allMedia(criteria);
	}

	@Override
	public Integer allMediaTotCnt(Criteria criteria) {
		// TODO Auto-generated method stub
		return mediaMapper.allMediaTotCnt(criteria);
	}

	@Override
	public List<?> MediaList(Criteria criteria) {
		// TODO Auto-generated method stub
		return mediaMapper.MediaList(criteria);
	}

//총개수
	@Override
	public int MediaListTotCnt(Criteria criteria) {
		// TODO Auto-generated method stub
		return mediaMapper.MediaListTotCnt(criteria);
	}

//상세조회	
	@Override
	public MediaVO selectMedia(String uuid) {
		// TODO Auto-generated method stub
		return mediaMapper.selectMedia(uuid);
	}

	@Override
	public int insert(MediaVO mediaVO) {
		// TODO Auto-generated method stub
		String newUuid = UUID.randomUUID().toString();
		String fileDownloadURL = generateDownloadUrl(newUuid);
		mediaVO.setUuid(newUuid);
		mediaVO.setRecipeImageUrl(fileDownloadURL);

		return mediaMapper.insert(mediaVO);
	}

	public String generateDownloadUrl(String uuid) {
		return ServletUriComponentsBuilder.fromCurrentContextPath().path("/media/download.do").query("uuid=" + uuid)
				.toUriString();
	}

	@Override
	public int update(MediaVO mediaVO) {
		// TODO Auto-generated method stub
		log.info("테스트: "+mediaVO);
//		TODO: 다운로드 URL 필요
		String fileDownloadURL = generateDownloadUrl(mediaVO.getUuid());
		mediaVO.setRecipeImageUrl(fileDownloadURL);
		log.info("테스트2: "+mediaVO);
		return mediaMapper.update(mediaVO);
	}

	@Override
	public int delete(MediaVO mediaVO) {
		// TODO Auto-generated method stub
		return mediaMapper.delete(mediaVO);
	}


}
