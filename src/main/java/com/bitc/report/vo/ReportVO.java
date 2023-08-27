package com.bitc.report.vo;

import java.util.Date;

import lombok.Data;

@Data 
public class ReportVO {
	private int 	no;
	private String 	fromMid;		//신고자
	private String  toMid; 		//대상	
	private Date 	date;		 	//날짜
	private String 	category;  	//  -- 신고 카테고리 
	private String 	context;   	//  -- 신고 내용 
	
	private int bno;  // 신고 대상이 게시글인 경우 	commentVO 
	private int cno;  // 신고 대상이 댓글인 경우		boardVO
	
}
