package com.bitc.partyBoard.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PartyCommentVO {

	private int cno;			// 댓글번호
	private int bno;			// 글번호
	private int pnum;			// 파티번호
	private String commentText;	// 댓글내용
	private String mnick;		// 작성자닉네임
	private String mid;			// 작성자아이디
	private Date regdate;		// 작성일
	private Date updatedate;	// 업데이트날짜
	private String showBoard;	// 차단여부
}
