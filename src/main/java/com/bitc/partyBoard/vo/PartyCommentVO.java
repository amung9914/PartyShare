package com.bitc.partyBoard.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PartyCommentVO {

	private int cno;
	private int bno;
	private int pnum;
	private String commentText;
	private String mnick;
	private String mid;
	private Date regdate;
	private Date updatedate;
	
}
