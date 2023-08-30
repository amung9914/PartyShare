package com.bitc.member.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.bitc.common.utils.Criteria;
import com.bitc.member.dao.MemberDAO;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberDAO dao;
	private final PasswordEncoder passwordEncoder;
	@Override
	public MemberVO selectMember(int mnum) throws Exception{
		MemberVO member= dao.selectMember(mnum);
		return member;
	}

	@Override
	public void modifyMember(MemberVO member) throws Exception{
		// pw 암호화
		String pw = member.getMpw();
		member.setMpw(passwordEncoder.encode(pw));
		dao.modifyMember(member);
	}

	@Override
	public List<PartyVO> joinPartyList(int mnum, Criteria cri) throws Exception{
		return dao.joinPartyList(mnum, cri);
	}

	@Override
	public int joinCnt(int mnum) throws Exception{
		return dao.joinCnt(mnum);
	}

}
