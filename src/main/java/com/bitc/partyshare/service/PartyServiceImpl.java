package com.bitc.partyshare.service;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.bitc.partyshare.dao.PartyDAO;
import com.bitc.partyshare.vo.MemberVO;
import com.bitc.partyshare.vo.PartyVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PartyServiceImpl implements PartyService{

	private final PartyDAO dao;
	
	// 내부적으로 사용할 수 있도록 메소드추가
	private String getResult(int result) {
		return result == 1?"SECCESS":"FAILED";
	}
	
	@Override
	public List<PartyVO> HostingList(HttpSession session) throws Exception {
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		return dao.HostingList(vo);
	}

	@Override
	public List<PartyVO> myPartyList(HttpSession session) throws Exception {
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		return dao.myPartyList(vo);
	}

	@Override
	public PartyVO read(int pnum,Model model) throws Exception {
		PartyVO vo = dao.read(pnum);
		return vo;
	}

	@Override
	public String update(PartyVO vo) throws Exception {
		return getResult(dao.update(vo));
	}

}
