/**
 * 
 */
package egovframework.example.comment.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.comment.service.CommentService;
import egovframework.example.comment.service.CommentVO;
import egovframework.example.common.Criteria;

/**
 * @author user
 *
 */
@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
     private CommentMapper commentMapper;

	@Override
	public List<CommentVO> selectCommentList(Criteria criteria) {
		// TODO Auto-generated method stub
		return commentMapper.selectCommentList(criteria);
	}

	@Override
	public int selectCommentListTotCnt(Criteria criteria) {
		// TODO Auto-generated method stub
		return commentMapper.selectCommentListTotCnt(criteria);
	}

	@Override
	public void insertComment(CommentVO commentVO) {
		 int result = commentMapper.insertComment(commentVO);
		    System.out.println("insert 결과: " + result); // 1이면 성공, 0이면 실패
		
		
	}

	@Override
	public int delete(String uuid) {
		// TODO Auto-generated method stub
		return commentMapper.delete(uuid);
	}

	@Override
	public CommentVO selectComment(String uuid) {
		// TODO Auto-generated method stub
		return commentMapper.selectComment(uuid);
	}

	@Override
	public int deleteComment(int commentId) {
		// TODO Auto-generated method stub
		return commentMapper.deleteComment(commentId);
	}

	@Override
	public String updateComment(CommentVO commentVO) {
	    int result = commentMapper.updateComment(commentVO);
	    return result > 0 ? "success" : "fail";
	}
	
	




	

	
	
	
	

	
	
	
}
