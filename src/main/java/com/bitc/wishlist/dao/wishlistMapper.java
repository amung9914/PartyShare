package com.bitc.wishlist.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bitc.party.vo.PartyVO;
import com.bitc.wishlist.vo.WishlistVO;

public interface wishlistMapper {
	
	@Select("SELECT * FROM wishlist WHERE mNum = #{mNum} ORDER BY no DESC")
	public List<WishlistVO> readWishlist(int mNum) throws Exception;

	@Select("SELECT p.* FROM party p JOIN wishlist w ON p.pNum = w.pNum WHERE w.alias = #{alias}")
	public List<PartyVO> readPerWishlist(@Param("alias") String alias) throws Exception;

	@Insert("INSERT INTO wishlist (no, mNum, pNum, alias) SELECT null, #{mNum}, #{pNum}, #{alias}"
			+ " WHERE NOT EXISTS (SELECT 1 FROM wishlist WHERE mNum = #{mNum} AND pNum = #{pNum})")
	public int addWishlist(@Param("mNum") int mNum, @Param("pNum") int pNum, @Param("alias") String alias) throws Exception;

	@Delete("DELETE FROM wishlist WHERE mNum = #{mNum} AND pNum = #{pNum}")
	public int deleteWishlist(@Param("mNum") int mNum, @Param("pNum") int pNum) throws Exception;
	
	@Select("SELECT * FROM wishlist WHERE mnum=#{mnum} GROUP BY alias")
	public List<WishlistVO> getWishlist(int mnum) throws Exception;
	
	@Select("SELECT partyImage1 FROM party WHERE pnum=#{pnum}")
	public String getPartyImage1(int pnum);
}
