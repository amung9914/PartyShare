package com.bitc.partyDetail.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class MapVO {

	private int no;		// 맵 번호
	private int pnum; 	// 파티 번호
	private String lat;	// 위도
	private String lng;	// 경도
	
}
