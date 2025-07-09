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
	private int communityCategoriesId;
	private String communityTitle;
	private String communityContent;
	private String communityCreatedAt;
	private int communityLikeCount;
	private int communityCount;
	private byte[] communityImage;
	private String communityUrl;
	
}