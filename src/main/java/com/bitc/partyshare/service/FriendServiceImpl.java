package com.bitc.partyshare.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.bitc.partyshare.dao.FriendDAO;
import com.bitc.partyshare.vo.FriendVO;
import com.bitc.partyshare.vo.MemberVO;
import com.bitc.partyshare.vo.PartyVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Service
@RequiredArgsConstructor
public class FriendServiceImpl implements FriendService {
	
	private final FriendDAO dao;
	
	// 내부적으로 사용할 수 있도록 메소드추가
	private String getResult(int result) {
		return result == 1?"SUCCESS":"FAILED";
	}

	@Override
	public List<MemberVO> searchId(String target) throws Exception {
		return dao.searchId(target);
	}

	@Override
	public List<MemberVO> searchNick(String target) throws Exception {
		return dao.searchNick(target);
	}

	@Override
	public String create(FriendVO vo) throws Exception {
		return getResult(dao.create(vo));
	}
	
	@Override
	public FriendVO confirmRequest(FriendVO vo) throws Exception {
		return dao.confirmRequest(vo);
	}

	@Override
	public FriendVO confirmFriend(FriendVO vo) throws Exception {
		return dao.confirmRequest(vo);
	}
	
	@Override
	public List<FriendVO> requestList(HttpSession session) throws Exception {
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		return dao.requestList(vo.getMnum());
	}
	
	@Override
	public List<FriendVO> responseList(HttpSession session) throws Exception {
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		return dao.responseList(vo.getMnum());
	}
	
	@Override
	public List<FriendVO> friendList(HttpSession session) throws Exception {
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		return dao.friendList(vo.getMnum());
	}

	//mnum과 fto전달을 위해 FriendVO를 만들고 있다.
	@Override
	public String deleteRequest(HttpSession session, int fto) throws Exception {
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		FriendVO fVO = new FriendVO();
		fVO.setFfrom(vo.getMnum());
		fVO.setFto(fto);
		return getResult(dao.deleteRequest(fVO));
	}

	@Override
	public String reject(HttpSession session, int ffrom) throws Exception {
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		int fto = vo.getMnum();
		return getResult(dao.reject(ffrom, fto));
	}

	@Override
	public String accept(HttpSession session, int ffrom) throws Exception {
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		int fto = vo.getMnum();
		String resultAccept = getResult(dao.accept(ffrom, fto));
		String resultAcceptNew = getResult(dao.acceptNew(ffrom, fto));
		if(resultAccept.equals("SUCCESS")&& resultAcceptNew.equals("SUCCESS")) {
			return "SUCCESS";
		}
		
		return "FAILED";
	}

	@Override
	public List<PartyVO> ongoingParty(int mnum) throws Exception {
		return dao.ongoingParty(mnum);
	}

	@Override
	public List<PartyVO> previousParty(int mnum) throws Exception {
		return dao.previousParty(mnum);
	}

	@Override
	public String deleteFriend(HttpSession session, int mnum) throws Exception {
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		int mynum = vo.getMnum();
		String resultffrom = getResult(dao.deleteffrom(mnum, mynum));
		String resultfto = getResult(dao.deletefto(mynum,mnum));
		if(resultffrom.equals("SUCCESS")&& resultfto.equals("SUCCESS")) {
			return "SUCCESS";
		}
		
		return "FAILED";
	}

	

	

	

	

}
