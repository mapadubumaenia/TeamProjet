/**
 * 
 */
package egovframework.example.media.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.common.Criteria;
import egovframework.example.media.service.MediaService;

/**
 * @author user
 *
 */
@Service
public class MediaServiceImpl implements MediaService{
	@Autowired
	private MediaMapper mediaMapper;
	
//전체조회	
	@Override
	public List<?> MediaList(Criteria criteria) {
		// TODO Auto-generated method stub
		return mediaMapper.MediaList(criteria);
	}

}
