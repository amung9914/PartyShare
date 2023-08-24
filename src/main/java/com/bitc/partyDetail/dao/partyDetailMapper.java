package com.bitc.partyDetail.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;
import com.bitc.partyDetail.vo.MapVO;

public interface partyDetailMapper {

	// 이미지 업로드용 테스트
	@Update("UPDATE party SET partyImage1 = #{partyImage1}, partyImage2 = #{partyImage2}, partyImage3 = #{partyImage3} WHERE pnum = #{pnum}")
	public void uploadParty(PartyVO vo) throws Exception;
	
	@Select("SELECT * FROM party WHERE pNum = #{pNum}")
	public PartyVO readParty(int pNum) throws Exception;
	
	@Select("SELECT COUNT(*) FROM joinmember WHERE pNum = #{pNum}")
	public int NumberOfJoinMember(int pNum) throws Exception;

	@Select("SELECT * FROM member WHERE mNum IN (SELECT mNum FROM joinMember WHERE pNum = #{pNum})")
	public List<MemberVO> readJoinMember(int pNum) throws Exception;

	@Select("SELECT * FROM map WHERE pNum = #{pNum}")
	public MapVO readLocation(int pNum) throws Exception;
	
	@Update("UPDATE party SET viewCnt = viewCnt + 1 WHERE pNum = #{pNum}")
	public int increaseView(int pNum) throws Exception;

	@Select("SELECT COUNT(*) FROM joinmember WHERE pNum = #{pNum} AND mNum = #{mNum}")
	public int findJoinMember(@Param("pNum") int pNum, @Param("mNum") int mNum) throws Exception;
	
	@Select("INSERT INTO joinmember VALUES (null, #{pNum}, #{mNum})")
	public int joinMember(@Param("pNum") int pNum, @Param("mNum") int mNum) throws Exception;

	@Update("UPDATE member SET mJoinCnt = mJoinCnt + 1 WHERE mNum = #{mNum}")
	public void increaseJoinCnt(int mNum) throws Exception;
	
}
