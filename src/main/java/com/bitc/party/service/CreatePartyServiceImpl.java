package com.bitc.party.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.map.vo.MapVO;
import com.bitc.party.dao.CreatePartyDAO;
import com.bitc.party.vo.PartyVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CreatePartyServiceImpl implements CreatePartyService {

	private final CreatePartyDAO dao;
	
	@Transactional
	@Override
	public int createParty(PartyVO vo) throws Exception{
		dao.createParty(vo);
		int result = dao.lastIndex();
		return result;
	}
	
	@Override
	public void joinPartyMember(int pnum, int mnum) throws Exception{
		Map<String, Integer> map = new HashMap<>();
		map.put("pnum", pnum);
		map.put("mnum", mnum);
		dao.joinPartyMember(map);
	}
	
	@Override
	public List<PartyVO> partyList(Criteria cri) throws Exception{
		return dao.partyList(cri);
	}

	@Override
	public PartyVO selectParty(int pnum) throws Exception{
		return dao.selectParty(pnum);
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) throws Exception{
		int totalCount = dao.totalCount();
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		pm.setDisplayPageNum(10);
		return pm;
	}

	@Override
	public List<String> getDescriptionList() throws Exception{
		return dao.getDescriptionList();
	}

	@Override
	public List<String> getCategoryList() throws Exception{
		return dao.getCategoryList();
	}

	@Override
	public String partyMemberBan(int pnum, int mnum) throws Exception{
		Map<String, Integer> map = new HashMap<>();
		map.put("pnum", pnum);
		map.put("mnum", mnum);
		if(dao.partyMemberBan(map) > 0) {
			dao.insertBanMember(map);
			return "삭제 성공";
		}else {
			return "삭제 실패";
		}
	}

	@Override
	public String setPartyFinish(int pnum) throws Exception{
		if(dao.setPartyFinish(pnum) > 0) {
			dao.setPartyChatFinish(pnum);
			return "파티 종료";
		}else {
			return "파티 종료 실패";
		}
	}

	@Override
	public void setLocation(MapVO map) throws Exception {
		dao.setLocation(map);
	}

}
