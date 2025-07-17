package egovframework.example.qna.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.common.Criteria;
import egovframework.example.qna.service.QnaVO;

@Mapper
public interface QnaMapper {

    // QnA 전체 목록 조회 (Criteria 조건 포함)
    List<QnaVO> selectQnaList(Criteria criteria);

    // QnA 총 개수 조회 (페이징용)
    int selectQnaListTotalCount(Criteria criteria);

    // 특정 QnA 상세 조회 (uuid 기준)
    QnaVO selectQnaDetail(String uuid);

    // 새로운 QnA 등록
    int insertQna(QnaVO qna);

    // 기존 QnA 수정
    int updateQna(QnaVO qna);

    // QnA 삭제
    int deleteQna(String uuid);
    
    // QnA 조회수 1 증가
    void incrementQnaCount(String uuid);

    // QnA에 대한 답변 등록
    int insertQnaAnswer(QnaVO qna);

    // QnA 답변 수정
    int updateQnaAnswer(QnaVO qna);
}
