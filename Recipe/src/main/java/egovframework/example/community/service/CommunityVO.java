package egovframework.example.community.service;

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
public class CommunityVO extends Criteria {
	private String uuid;
	private String userId;
	private int communityCategoryId;
	private String communityTitle;
	private String communityContent;
	private String communityCreatedAt;
	private int communityCount;
	private byte[] communityImage;
	private String communityUrl;
	private String contentType;
	private String userNickname;
	private int commentCount;
	
	public String getUserNickname() {
	    return userNickname;
	}

	public void setUserNickname(String userNickname) {
	    this.userNickname = userNickname;
	}
	
	public int getCommentCount() {
	    return commentCount;
	}

	public void setCommentCount(int commentCount) {
	    this.commentCount = commentCount;
	}
	
}