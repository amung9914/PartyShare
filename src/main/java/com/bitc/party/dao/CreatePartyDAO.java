package com.bitc.party.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.common.utils.Criteria;
import com.bitc.map.vo.MapVO;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;

public interface CreatePartyDAO {
	@Insert("INSERT INTO party(pname, host, startDate, endDate, pcontext, description, category , sido, sigungu, address, detailAddress, partyImage1,partyImage2,partyImage3) "
			+ "VALUES(#{pname}, #{host}, #{startDate},#{endDate}, #{pcontext}, #{description}, #{category}, #{sido},#{sigungu}, #{address}, #{detailAddress}, #{partyImage1},#{partyImage2},#{partyImage3})")
	public int createParty(PartyVO vo) throws Exception;
	
	@Select("SELECT LAST_INSERT_ID()")
	public int lastIndex() throws Exception;
	
	@Select("SELECT * FROM party WHERE finish = 'N' ORDER BY pnum DESC limit #{startRow}, #{perPageNum}")
	public List<PartyVO> partyList(Criteria cri) throws Exception;
	
	@Select("SELECT * FROM party WHERE pnum=#{pnum}")
	public PartyVO selectParty(int pnum) throws Exception;
	
	@Select("SELECT count(*) FROM party WHERE finish = 'N'")
	public int totalCount() throws Exception;
	
	@Insert("INSERT INTO joinMember(pnum, mnum) VALUES(#{pnum}, #{mnum})")
	public int joinPartyMember(Map<String, Integer> map) throws Exception;
	
	@Select("SELECT description FROM partydescription")
	public List<String> getDescriptionList() throws Exception;
	
	@Select("SELECT category FROM partycategory")
	public List<String> getCategoryList() throws Exception;
	
	@Select("SELECT * FROM member WHERE mnum IN (SELECT mnum FROM joinmember WHERE pnum=#{pnum})")
	public List<MemberVO> getJoinPartyMember(int pnum) throws Exception;
	
	@Delete("Delete FROM joinMember WHERE pnum=#{pnum} AND mnum=#{mnum}")
	public int partyMemberBan(Map<String, Integer> map) throws Exception;
	
	@Update("UPDATE party SET finish='Y' WHERE pnum=#{pnum}")
	public int setPartyFinish(int pnum) throws Exception; 
	
	@Insert("INSERT INTO banmember(pnum, mnum) VALUES(#{pnum}, #{mnum})")
	public int insertBanMember(Map<String, Integer> map) throws Exception; 
	
	@Insert("INSERT INTO map VALUES(null, #{pnum}, #{lat}, #{lng})")
	public int setLocation(MapVO map);
	
	@Update("UPDATE chat SET finish='Y' WHERE pnum=#{pnum}")
	public int setPartyChatFinish(int pnum);
}
