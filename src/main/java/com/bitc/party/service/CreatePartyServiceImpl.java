package com.bitc.party.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.common.vo.AuthDTO;
import com.bitc.login.dao.JoinDAO;
import com.bitc.map.vo.MapVO;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.dao.CreatePartyDAO;
import com.bitc.party.dao.PartyDAO;
import com.bitc.party.vo.PartyVO;
import com.bitc.wishlist.vo.WishlistVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CreatePartyServiceImpl implements CreatePartyService {

	private final CreatePartyDAO dao;
	private final JoinDAO joinDAO;
	private final PartyDAO partyDAO;
	
	@Transactional
	@Override
	public int createParty(PartyVO vo, String mid) throws Exception{
		dao.createParty(vo);
		List<String> list = joinDAO.getAuthList(mid);
		if(!list.contains("ROLE_HOST")) {
			joinDAO.insertHostAuth(mid);
		}
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
	public String setPartyFinish(int pnum, MemberVO member) throws Exception{
		// 파티 종료 시 finish='y'
		if(dao.setPartyFinish(pnum) > 0) {
			// 파티 채팅 목록 출력 안함
			dao.setPartyChatFinish(pnum);
			// 파티 호스트의 현재 호스팅 목록
			List<PartyVO> list = partyDAO.HostingListNotFinish(member);
			// 호스팅이 마지막이라면 권한 회수
			if(list.size() == 0) {
				AuthDTO dto = new AuthDTO(member.getMid(), "ROLE_HOST");
				joinDAO.deleteAuth(dto);
			}
			return "파티 종료";
		}else {
			return "파티 종료 실패";
		}
	}

	@Override
	public void setLocation(MapVO map) throws Exception {
		dao.setLocation(map);
	}

	@Override
	public List<WishlistVO> getWishlist(int mnum) {
		return dao.getWishlist(mnum);
	}

	@Override
	public List<PartyVO> searchPartyList(Criteria cri, String keyword) {
		return dao.searchParty(cri, keyword);
	}

}
