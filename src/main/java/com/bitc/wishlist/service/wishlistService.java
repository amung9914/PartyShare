package com.bitc.wishlist.service;

import java.util.List;

import com.bitc.partyDetail.vo.PartyVO;
import com.bitc.wishlist.vo.WishlistVO;

public interface wishlistService {
	
	// 위시리스트에 담은 파티 읽어오기
	public List<WishlistVO> readWishlist(int mNum) throws Exception;
	
	// 별칭별 위시리스트에 속한 파티 목록 읽어오기
	public List<PartyVO> readPerWishlist(String alias) throws Exception;

	// 위시리스트에 파티 추가하기
	public int addWishlist(int mNum, int pNum, String alias) throws Exception;
	
	// 위시리스트에서 파티 삭제하기
	public int deleteWishlist(int mNum, int pNum) throws Exception;
	
}
