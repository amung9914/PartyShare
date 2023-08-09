package com.bitc.partyshare.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Component
@Getter @Setter @ToString
public class PartyVO {
	
	// 파티 DB 필드
	private int pnum;				// 파티 번호
	private String pname;			// 파티 이름
	private int host;				// 파티 호스트
	private String sido;			// 파티 장소(시)
	private String sigungu;			// 파티 장소(구)
	private String address;			// 파티 장소(도로명 주소)
	private String detailAddress;	// 파티 장소(상세 주소)
	private String startDate;			// 파티 시작 날짜
	private String endDate;			// 파티 종료 날짜
	private String pcontext;		// 파티 소개
	private String mainCategory;	// 파티 메인 카테고리
	private String subCategory;		// 파티 서브 카테고리
	private String finish;			// 파티 종료 여부
	private int viewCnt;			// 파티 조회수
	private String partyImage1;		// 파티 이미지1
	private String partyImage2;		// 파티 이미지2
	private String partyImage3;		// 파티 이미지3
	
	
	 	
}
