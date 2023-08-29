package com.bitc.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bitc.admin.dao.AdminDAO;
import com.bitc.common.utils.Criteria;
import com.bitc.member.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service("as")
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
	// Admin이 관리하는 메소드들 처리
	private final AdminDAO dao;
	
	@Override
	public MemberVO selectMember(String id) throws Exception {
		return dao.selectMember(id);
	}	//asi

	@Override
	public List<MemberVO> memberList(Criteria cri) throws Exception {
		return dao.memberList(cri);
	}	//asi


	@Override
	public int blackMember(String targetId) throws Exception {
		
		return dao.blackMember(targetId);
	}

	@Override
	public List<MemberVO> memberNick(String mnick) throws Exception {
		return dao.memberNick(mnick);
	}

	@Override
	public List<MemberVO> blackId() throws Exception {
		
		return dao.blackId();
	}

	@Override
	public List<MemberVO> unblock() throws Exception {
		
		return dao.unblock();
	}	
	
	/*
	@Override
	public void sendBlackPost(String Mid, NoticeVO) throws Exception{
		dao.
	}
	*/

	




	
	
}
