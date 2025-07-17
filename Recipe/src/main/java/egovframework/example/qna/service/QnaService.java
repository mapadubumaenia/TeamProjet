package egovframework.example.qna.service;

import java.util.List;

import egovframework.example.common.Criteria;

public interface QnaService {

    // 전체 QnA 목록 조회 (Criteria 조건 포함)
    List<QnaVO> selectQnaList(Criteria criteria);

    // QnA 총 개수 조회 (페이징용)
    int selectQnaListTotalCount(Criteria criteria);

    // QnA 상세 조회
    QnaVO selectQnaDetail(String uuid);

    // QnA 등록
    int insertQna(QnaVO vo);

    // QnA 수정
    int updateQna(QnaVO vo);

    // QnA 삭제
    int deleteQna(String uuid);

    // 조회수 증가
    void incrementQnaCount(String uuid);

    // QnA 답변 등록
    int insertQnaAnswer(QnaVO vo);

    // QnA 답변 수정
    int updateQnaAnswer(QnaVO vo);
}
