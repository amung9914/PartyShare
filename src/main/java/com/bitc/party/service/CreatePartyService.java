package com.bitc.party.service;

import java.util.List;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.map.vo.MapVO;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;

public interface CreatePartyService {
	
	public int createParty(PartyVO vo) throws Exception;
	
	public void joinPartyMember(int pnum, int mnum) throws Exception;
	
	public List<PartyVO> partyList(Criteria cri) throws Exception;
	
	public PartyVO selectParty(int pnum) throws Exception;
	
	public PageMaker getPageMaker(Criteria cri) throws Exception;
	
	public List<String> getDescriptionList() throws Exception;
	
	public List<String> getCategoryList() throws Exception;
	
	public String partyMemberBan(int pnum, int mnum) throws Exception;
	
	public String setPartyFinish(int pnum) throws Exception;
	
	public void setLocation(MapVO map) throws Exception;
}
