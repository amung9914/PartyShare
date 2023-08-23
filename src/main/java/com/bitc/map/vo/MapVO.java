package com.bitc.map.vo;

import lombok.Data;

@Data
public class MapVO {
	private int pnum;
	private String lat; // 위도
	private String lng; // 경도
	private String partyImage1;
}
