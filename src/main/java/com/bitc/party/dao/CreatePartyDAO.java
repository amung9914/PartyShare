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
import com.bitc.wishlist.vo.WishlistVO;

public interface CreatePartyDAO {
	/**
	 * 파티 생성 
	 */
	@Insert("INSERT INTO party(pname, host, startDate, endDate, pcontext, description, category , sido, sigungu, address, detailAddress, partyImage1,partyImage2,partyImage3) "
			+ "VALUES(#{pname}, #{host}, #{startDate},#{endDate}, #{pcontext}, #{description}, #{category}, #{sido},#{sigungu}, #{address}, #{detailAddress}, #{partyImage1},#{partyImage2},#{partyImage3})")
	public int createParty(PartyVO vo) throws Exception;
	
	/**
	 * 파티 생성 후 pnum 가져오기
	 */
	@Select("SELECT LAST_INSERT_ID()")
	public int lastIndex() throws Exception;
	
	/**
	 * 파티 목록
	 */
	@Select("SELECT * FROM party WHERE finish = 'N' ORDER BY pnum DESC limit #{startRow}, #{perPageNum}")
	public List<PartyVO> partyList(Criteria cri) throws Exception;
	
	/**
	 * 파티 번호로 파티 검색
	 */
	@Select("SELECT * FROM party WHERE pnum=#{pnum}")
	public PartyVO selectParty(int pnum) throws Exception;
	
	/**
	 * 종료 되지 않은 파티 개수 
	 */
	@Select("SELECT count(*) FROM party WHERE finish = 'N'")
	public int totalCount() throws Exception;
	
	/**
	 * 파티 맴버 목록에 맴버 추가
	 */
	@Insert("INSERT INTO joinmember(pnum, mnum) VALUES(#{pnum}, #{mnum})")
	public int joinPartyMember(Map<String, Integer> map) throws Exception;
	
	/**
	 * 파티 설명 리스트
	 */
	@Select("SELECT description FROM partydescription")
	public List<String> getDescriptionList() throws Exception;
	
	/**
	 * 파티 카테고리 리스트
	 */
	@Select("SELECT category FROM partycategory")
	public List<String> getCategoryList() throws Exception;
	
	/**
	 * 파티 맴버 강퇴 시 맴버 목록에서 삭제
	 */
	@Delete("Delete FROM joinmember WHERE pnum=#{pnum} AND mnum=#{mnum}")
	public int partyMemberBan(Map<String, Integer> map) throws Exception;
	
	/**
	 * 파티 종료 시 파티 정보 수정 
	 */
	@Update("UPDATE party SET finish='Y' WHERE pnum=#{pnum}")
	public int setPartyFinish(int pnum) throws Exception; 
	
	/**
	 * 파티 맴버 강퇴시 강퇴 맴버 목록에 추가
	 */
	@Insert("INSERT INTO banmember(pnum, mnum) VALUES(#{pnum}, #{mnum})")
	public int insertBanMember(Map<String, Integer> map) throws Exception; 
	
	/**
	 * 파티의 위치 정보 저장
	 */
	@Insert("INSERT INTO map VALUES(null, #{pnum}, #{lat}, #{lng})")
	public int setLocation(MapVO map);
	
	/**
	 * 파티가 종료되면 채팅 내역 출력 안함
	 */
	@Update("UPDATE chat SET finish='Y' WHERE pnum=#{pnum}")
	public int setPartyChatFinish(int pnum);

	/**
	 * 현재 로그인한 회원의 위시리스트 검색
	 */
	@Select("SELECT * FROM wishlist WHERE mnum=#{mnum}")
	public List<WishlistVO> getWishlist(int mnum);
}
