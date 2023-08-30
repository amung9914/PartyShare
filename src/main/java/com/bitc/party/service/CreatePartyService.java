package com.bitc.party.service;

import java.util.List;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.map.vo.MapVO;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;
import com.bitc.wishlist.vo.WishlistVO;

public interface CreatePartyService {
	/**
	 * 파티 생성
	 */
	public int createParty(PartyVO vo, String mid) throws Exception;
	
	/**
	 * 파티 맴버 목록에 맴버 추가
	 */
	public void joinPartyMember(int pnum, int mnum) throws Exception;
	/**
	 * 파티 목록
	 */
	public List<PartyVO> partyList(Criteria cri) throws Exception;
	/**
	 * 파티 번호로 파티 검색
	 */
	public PartyVO selectParty(int pnum) throws Exception;
	/**
	 * 페이징을 위한 pageMaker생성 후 전달
	 */
	public PageMaker getPageMaker(Criteria cri) throws Exception;
	/**
	 * 파티 설명 리스트
	 */
	public List<String> getDescriptionList() throws Exception;
	/**
	 * 파티 카테고리 리스트
	 */
	public List<String> getCategoryList() throws Exception;
	/**
	 * 파티 맴버 강퇴 시 맴버 목록에서 삭제
	 */
	public String partyMemberBan(int pnum, int mnum) throws Exception;
	/**
	 * 파티 종료 시 파티 finish column 수정 
	 */
	public String setPartyFinish(int pnum, MemberVO member) throws Exception;
	/**
	 * 파티의 위치 정보 저장
	 */
	public void setLocation(MapVO map) throws Exception;
	/**
	 * 현재 로그인 한 회원의 위시리스트 검색
	 */
	public List<WishlistVO> getWishlist(int mnum);
	/**
	 * 키워드로 파티 리스트 검색
	 */
	public List<PartyVO> searchPartyList(Criteria cri, String keyword);
}
