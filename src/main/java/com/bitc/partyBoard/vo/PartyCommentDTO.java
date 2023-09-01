package com.bitc.partyBoard.vo;

import com.bitc.common.utils.Criteria;

import lombok.Data;

@Data
public class PartyCommentDTO {
	private int pnum;		// 파티번호
	private int bno;		// 글번호
	private Criteria cri;	
}
