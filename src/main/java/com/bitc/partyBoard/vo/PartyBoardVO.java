package com.bitc.partyBoard.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PartyBoardVO {
	private int bno;
	private int pnum;
	private String category;
	private String title;
	private String context;
	private Date date;
	private String mnick;
	private int viewCnt;
	
}
