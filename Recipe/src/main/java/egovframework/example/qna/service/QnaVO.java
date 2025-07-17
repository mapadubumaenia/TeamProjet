/**
 * 
 */
package egovframework.example.qna.service;

import java.util.Date;

/**
 * @author user
 *
 */
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
public class QnaVO extends Criteria{
	private String uuid;
	private String userId;
	private int communityCategoryId;
	private String qnaTitle;
	private String qnaCreatedAt;
	private int qnaLikeCount;
	private String qnaContent;
	private int count;
	private byte[] qnaImage;          
	private String qnaUrl;
	private String contentType;
	private String answerUserId;
	private String answerContent;
	private String answerCreatedAt;
	private byte[] answerImage;  
	private String userNickname;
	private String answerNickname;
	
	
	public String getUserNickname() {
	    return userNickname;
	}

	public void setUserNickname(String userNickname) {
	    this.userNickname = userNickname;
	}
	

}
