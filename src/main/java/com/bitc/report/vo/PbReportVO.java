package com.bitc.report.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class PbReportVO {
	private	int 	no;			//pk ai		
	private	Date 	date;
	private	String 	fromMid;
	private	String 	toMid;
	private	String 	category; 
	private	String	context;
	private	String	readed;		//관리자가 읽음 
	private int pnum;			//파티번호
	private int bno;			// 게시글 번호
	private int cno;			// 댓글 번호
}
