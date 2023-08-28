package com.bitc.wishlist.vo;

import java.util.List;

import com.bitc.party.vo.PartyVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class WishlistVO {
	
	int no;
	int mnum;
	int pnum;
	String alias;
	List<PartyVO> parties;
	
}
