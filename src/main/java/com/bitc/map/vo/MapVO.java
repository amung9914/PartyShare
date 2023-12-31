package com.bitc.map.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MapVO {
	
	private int no;		// 맵 번호
	private int pnum;   // 파티번호
	private String lat; // 위도
	private String lng; // 경도
	private String partyImage1; //파티 이미지
	
	public MapVO(String lat, String lng) {
		this.lat = lat;
		this.lng = lng;
	}
}
