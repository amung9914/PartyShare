package com.bitc.report.vo;

import java.util.Date;

import lombok.Data;

@Data 
public class ReportVO {
	private int 	no;			// 신고 번호
	private String 	fromMid;	// 신고자
	private String  toMid; 		// 신고 대상	
	private String 	date;		// 신고 일시
	private String 	category;  	// 신고 분류 카테고리 
	private String 	context;   	// 신고 상세 내용 
	
	private int bno;  // 신고 대상이 게시글인 경우 (게시글 번호)
	private int cno;  // 신고 대상이 댓글인 경우 (댓글 번호)
	
}
