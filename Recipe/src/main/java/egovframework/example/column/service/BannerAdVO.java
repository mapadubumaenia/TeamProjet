package egovframework.example.column.service;

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

public class BannerAdVO {

	 private int    adId;
	    private String imageUrl;
	    private String targetUrl;
	    private int    displayOrder;
	
}
