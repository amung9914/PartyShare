package com.bitc.partyBoard.vo;

import lombok.Data;

@Data
public class PartyReportVO {
	
	private String fromMid; // 신고하는사람아이디
	private String toMid;	// 신고당하는사람아이디
	private String category;//신고유형
	private String context; //상세내용
	private int pnum;		//파티번호
	private int bno;		//글번호
	private int cno;		//댓글번호
	
}
