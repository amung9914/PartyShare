package com.bitc.partyBoard.vo;

import com.bitc.common.utils.Criteria;

import lombok.Data;

@Data
public class PartyCommentDTO {
	private int pnum;
	private int bno;
	private Criteria cri;
}
