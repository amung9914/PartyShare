package com.bitc.wishlist.vo;

import java.util.List;

import com.bitc.party.vo.PartyVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class WishlistVO {
	
	int no;						// 위시리스트 번호
	int mnum;					// 위시리스트를 등록한 멤버 번호
	int pnum;					// 위시리스트에 등록한 파티 번호
	String alias;				// 위시리스트 별칭
	List<PartyVO> parties;		// 위시리스트에 등록된 PartyVO 리스트
	
}
