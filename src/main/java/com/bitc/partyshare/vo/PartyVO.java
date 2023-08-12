package com.bitc.partyshare.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
	private String description;		// ex. 기상천외한
	private String category;		// ex. 운동
	private String finish;			// 파티 종료 여부
	private int viewCnt;			// 파티 조회수
	private String partyImage1;		// 파티 이미지1
	private String partyImage2;		// 파티 이미지2
	private String partyImage3;		// 파티 이미지3
	
	public String getFormatStartDate() {
        String newStartDate = this.startDate;
     try {
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDateDt = inputFormat.parse(this.startDate);
        
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
        newStartDate = outputFormat.format(startDateDt);
     } catch (ParseException e) {
        System.out.println("getStartDate에서 오류 발생");
     }
     return newStartDate;
  }
  
  public String getFormatEndDate() {
        String newEndDate = this.endDate;
     try {
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date endDateDt = inputFormat.parse(this.endDate);
        
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
        newEndDate = outputFormat.format(endDateDt);
     } catch (ParseException e) {
        System.out.println("getEndDate에서 오류 발생");
     }
     return newEndDate;
  }
  
  
	 	
}
