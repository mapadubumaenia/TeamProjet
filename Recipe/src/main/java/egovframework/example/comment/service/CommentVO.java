/**
 * 
 */
package egovframework.example.comment.service;



import egovframework.example.common.Criteria;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CommentVO extends Criteria {
	private int commentId;       // 댓글 고유번호 (PK)
    private String uuid;         // 대상 글 UUID (FK)
    private String userId;       // 작성자 ID (FK)
    private String nickname;     // 작성자 닉네임 (조회용)
    private String targetType;   // 댓글 대상 타입 (ex: community, qna 등)
    private String content;      // 댓글 내용
    private String createdAt;    // 작성 일시 (TO_CHAR 변환 결과)
    private int firstIndex;      // 페이징 시작 인덱스 (OFFSET에 사용됨)
    private int pageUnit;        // 페이지당 출력할 댓글 수 (FETCH NEXT에 사용됨)
    private Integer parentId;
    
    
    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    
    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }
    
    
	}

