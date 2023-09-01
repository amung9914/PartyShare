package com.bitc.partyBoard.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PartyBoardVO {
	private int bno; 		// 글번호
	private String title; 	// 제목
	private String content;	// 내용
	private String writer; 	// 닉네임 == mnick
	private String mid;		// 작성자아이디
	private String category;// 카테고리
	private int origin;		// 원본글
	private int depth;		// 들여쓰기깊이
	private int seq;		// 글레벨
	private Date regdate;	// 작성일
	private Date updatedate;// 수정일
	private int viewCnt;	// 조회수
	private String showboard;// 차단여부
	private int mnum;		// 글쓴이 고유번호
	private int pnum;		// 파티번호
	
}
