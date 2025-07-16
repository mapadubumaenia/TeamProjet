package egovframework.example.comment.service.impl;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.comment.service.CommentVO;
import egovframework.example.common.Criteria;

@Mapper
public interface CommentMapper {
	  // 댓글 목록 조회 (페이징 포함)
	public List<CommentVO> selectCommentList(Criteria criteria);
	
    // 댓글 총 개수 조회
	public int selectCommentListTotCnt(Criteria criteria);

    // 댓글 등록
	public int insertComment(CommentVO commentVO);
    
	// 특정 댓글 상세 조회
	public CommentVO selectComment(String uuid);
	
	//게시글 삭제시 댓글 삭제
	public int delete (String uuid);
	
	// 댓글 삭제
	int deleteComment(int commentId);
	
	// 댓글 수정
	int updateComment(CommentVO commentVO);
	
	int deleteCommentsByUuid(String uuid);
 
	}

