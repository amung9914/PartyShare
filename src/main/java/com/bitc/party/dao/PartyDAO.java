package com.bitc.party.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;

public interface PartyDAO {

	
	/**
	 * 내가 호스트인 파티 목록
	 */
	@Select("SELECT * FROM party WHERE host = #{mnum} ORDER BY pnum")
	List<PartyVO> HostingList(MemberVO vo) throws Exception;
	
	/**
	 * 내가 참여중인 파티 목록
	 */
	@Select("SELECT P.* FROM joinmember J, party P WHERE J.pnum = P.pnum AND J.mnum = #{mnum} ORDER BY pnum ")
	List<PartyVO> myPartyList(MemberVO vo) throws Exception;
	
	/**
	 * 파티 상세정보 출력
	 */
	@Select("SELECT * FROM party WHERE pnum = #{pnum}")
	PartyVO read(int pnum) throws Exception;
	
	/**
	 * 파티 정보 수정
	 */
	@Update("UPDATE party SET pname = #{pname}, sido = #{sido}, sigungu = #{sigungu} , "
			+" address = #{address} , detailaddress = #{detailAddress}, "
			+ "pcontext = #{pcontext}, startdate = #{startDate} , enddate = #{endDate} , "
			+ "description = #{description}, category = #{category} , "
			+ "partyImage1 = #{partyImage1}, partyImage2 = #{partyImage2} , "
			+ "partyImage3 = #{partyImage3} WHERE pnum = #{pnum}")
	int update(PartyVO vo) throws Exception;
	
	/**
	 * 파티 사진 수정
	 */
	@Update("UPDATE party SET  WHERE pnum = #{pnum}")
	int updateImage(PartyVO vo) throws Exception;
	
	
	
	/**
	 * description 목록
	 */
	@Select("SELECT description FROM partydescription")
	List<String> description() throws Exception;
	
	/**
	 * category 목록
	 */
	 @Select("SELECT category FROM partycategory")
	List<String> category() throws Exception;
	
	/**
	 * 파티 참여 맴버 목록
	 */
	@Select("SELECT * FROM member WHERE mnum IN (SELECT mnum FROM joinmember WHERE pnum=#{pnum})")
	public List<MemberVO> getJoinPartyMember(int pnum) throws Exception;
	
	/**
	 * 파티 탈퇴 
	 */
	@Delete("DELETE FROM joinmember WHERE mNum = #{mnum} AND pNum = #{pnum}")
	int withdraw(@Param("mnum")int mnum, @Param("pnum")int pnum); 
	
}
