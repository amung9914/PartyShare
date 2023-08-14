package com.bitc.partyshare.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bitc.partyshare.dao.FriendDAO;
import com.bitc.partyshare.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FriendServiceImpl implements FriendService {
	
	private final FriendDAO dao;
	
	// 내부적으로 사용할 수 있도록 메소드추가
	private String getResult(int result) {
		return result == 1?"SECCESS":"FAILED";
	}

	@Override
	public MemberVO searchId(String target) throws Exception {
		return dao.searchId(target);
	}

	@Override
	public MemberVO searchNick(String target) throws Exception {
		return dao.searchNick(target);
	}

	@Override
	public int create() throws Exception {
		return 0;
	}

	@Override
	public List<MemberVO> requestList(int mnum) throws Exception {
		return null;
	}

}
