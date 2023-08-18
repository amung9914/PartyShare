package com.bitc.partyBoard.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PartyBoardVO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private String category;
	private int origin;
	private int depth;
	private int seq;
	private Date regdate;
	private Date updatedate;
	private int viewCnt;
	private String showboard;
	private int mnum;
	private int pnum;
	
}
