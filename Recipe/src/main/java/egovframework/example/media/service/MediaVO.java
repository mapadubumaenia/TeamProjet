/**
 * 
 */
package egovframework.example.media.service;

import java.sql.Date;

import egovframework.example.common.Criteria;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author user
 * USER_ID	VARCHAR2(50 BYTE)
TITLE	VARCHAR2(100 BYTE)
RECIPE_CREATED_AT	DATE
LIKE_COUNT	NUMBER
 */
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MediaVO extends Criteria {
	private Integer mediaid;
	private String userid;
	private String title;
	private Date created;
	private Integer likecount;
	
}
