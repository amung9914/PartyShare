package com.bitc.partyshare.service;

import java.util.List;


import com.bitc.partyshare.vo.MemberVO;

public interface FriendService {
	/**
	 * 아이디로 친구를 검색한다.
	 */
	MemberVO searchId(String target) throws Exception;
	
	/**
	 * 닉네임으로 친구를 검색한다.
	 */
	MemberVO searchNick(String target) throws Exception;
	
	
	/**
	 * 상대방이 친구요청을 보낸다.
	 */
	int create() throws Exception;
	
	/**
	 * 상대방의 아이디로 상대방의 파티 정보를 가져온다. 
	 * mnum으로 -> joinparty & party -> partyVO
	 */
	
	/**
	 * 친구 요청에 이미 요청이 있는지 없는지,
	 * 친구인지 아닌지 확인
	 */
	
	/**
	 * 상대방이 수락을 눌렀을 때 
	 * from 유저 to 유저 두명을 각각 db에 저장시킨다. 
	 * 서로서로 친구 맺기
	 */
	 
	/**
	 * 거절을 눌렀을 때 친구 요청을 삭제 시킨다.
	 *  
	 */
	
	/**
	 * 기존 친구를 삭제 시킨다.
	 */
	
	/**
	 * 내가 친구 요청을 보낸 목록을 확인
	 */
	List<MemberVO> requestList(int mnum) throws Exception;
	
	
	/**
	 * 내가 보낸 친구 요청을 취소한다.  
	 */
}
