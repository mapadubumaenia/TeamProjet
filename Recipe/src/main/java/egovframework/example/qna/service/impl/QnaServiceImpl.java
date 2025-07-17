/**
 * 
 */
package egovframework.example.qna.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.common.Criteria;
import egovframework.example.qna.service.QnaService;
import egovframework.example.qna.service.QnaVO;

/**
 * @author user
 *
 */
@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired 
    private QnaMapper qnaMapper;

	@Override
	public List<QnaVO> selectQnaList(Criteria criteria) {
		// TODO Auto-generated method stub
		return qnaMapper.selectQnaList(criteria);
	}

	@Override
	public int selectQnaListTotalCount(Criteria criteria) {
		// TODO Auto-generated method stub
		return qnaMapper.selectQnaListTotalCount(criteria);
	}

	@Override
	public QnaVO selectQnaDetail(String uuid) {
		// TODO Auto-generated method stub
		return qnaMapper.selectQnaDetail(uuid);
	}

	@Override
	public int insertQna(QnaVO vo) {
		// TODO Auto-generated method stub
		return qnaMapper.insertQna(vo);
	}

	@Override
	public int updateQna(QnaVO vo) {
		// TODO Auto-generated method stub
		return qnaMapper.updateQna(vo);
	}

	@Override
	public int deleteQna(String uuid) {
		// TODO Auto-generated method stub
		return qnaMapper.deleteQna(uuid);
	}

	@Override
	public void incrementQnaCount(String uuid) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int insertQnaAnswer(QnaVO vo) {
		// TODO Auto-generated method stub
		return qnaMapper.insertQnaAnswer(vo);
	}

	@Override
	public int updateQnaAnswer(QnaVO vo) {
		// TODO Auto-generated method stub
		return qnaMapper.updateQnaAnswer(vo);
	}

	
	
	
	
	
}
