package com.bitc.wishlist.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitc.party.vo.PartyVO;
import com.bitc.wishlist.dao.wishlistMapper;
import com.bitc.wishlist.vo.WishListDTO;
import com.bitc.wishlist.vo.WishlistVO;

@Service
public class wishlistServiceImpl implements wishlistService{

	@Autowired
	private wishlistMapper dao;

	@Override
	public List<WishlistVO> readWishlist(int mNum) throws Exception {
		return dao.readWishlist(mNum);
	}

	@Override
	public List<PartyVO> readPerWishlist(String alias) throws Exception {
		return dao.readPerWishlist(alias);
	}

	@Override
	public int addWishlist(int mNum, int pNum, String alias) throws Exception {
		return dao.addWishlist(mNum, pNum, alias);
	}

	@Override
	public int deleteWishlist(int mNum, int pNum) throws Exception {
		return dao.deleteWishlist(mNum, pNum);
	}

	@Override
	public List<WishListDTO> getWishList(int mnum) throws Exception{
		// alias, partyImage1
		List<WishListDTO> list = new ArrayList<>();
		// alias 중복제거 wishlist
		List<WishlistVO> wishlist = dao.getWishlist(mnum);
		for(WishlistVO w : wishlist) {
			String partyImage1 = dao.getPartyImage1(w.getPnum());
			String alias = w.getAlias();
			WishListDTO dto = new WishListDTO(alias, partyImage1);
			list.add(dto);
		}
		System.out.println(list);
		return list;
	}
	
}
