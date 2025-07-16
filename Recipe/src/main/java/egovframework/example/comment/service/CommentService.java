package egovframework.example.comment.service;

import java.util.List;

import org.springframework.stereotype.Service;

import egovframework.example.common.Criteria;



@Service
public interface CommentService {
	    List<CommentVO> selectCommentList(Criteria criteria);

	    int selectCommentListTotCnt(Criteria criteria);

	    void insertComment(CommentVO commentVO);
	    
	    CommentVO selectComment(String uuid);

		int delete(String uuid);
		
		int deleteComment(int commentId);
		
		// 댓글 수정
		String updateComment(CommentVO commentVO);

		
}
