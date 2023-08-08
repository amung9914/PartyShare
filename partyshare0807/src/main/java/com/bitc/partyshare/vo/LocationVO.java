package com.bitc.partyshare.vo;

import lombok.Data;

@Data
public class LocationVO {
	private String sido; // 시도
	private String sigungu; //시군구
	private String address; // 도로명주소 또는 지번주소
	private String detailAddress; // 상세주소
}
