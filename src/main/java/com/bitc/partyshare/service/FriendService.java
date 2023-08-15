package com.bitc.partyshare.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.bitc.partyshare.vo.FriendVO;
import com.bitc.partyshare.vo.MemberVO;

public interface FriendService {
	/**
	 * 아이디로 친구를 검색한다.
	 */
	List<MemberVO> searchId(String target) throws Exception;
	
	/**
	 * 닉네임으로 친구를 검색한다.
	 */
	List<MemberVO> searchNick(String target) throws Exception;
	
	
	/**
	 * 상대방이 친구요청을 보낸다.
	 */
	String create(FriendVO vo) throws Exception;
	
	/**
	 * 친구 요청에 이미 요청이 있는지 없는지 확인
	 */
	FriendVO confirmRequest(FriendVO vo) throws Exception;

	/**
	 * 이미 친구인지 아닌지 확인
	 */
	FriendVO confirmFriend(FriendVO vo) throws Exception;

	
	/**
	 * 상대방의 아이디로 상대방의 파티 정보를 가져온다. 
	 * mnum으로 -> joinparty & party -> partyVO
	 */
	
	
	
	/**
	 * 상대방이 수락을 눌렀을 때 
	 * from 유저 to 유저 두명을 각각 db에 저장시킨다. 
	 * 서로서로 친구 맺기
	 */
	String accept(HttpSession session, int ffrom) throws Exception;
	 
		
	/**
	 * 기존 친구를 삭제 시킨다.
	 */
	
	/**
	 * 친구목록을 불러온다
	 */
	List<FriendVO> friendList(HttpSession session) throws Exception;
	
	/**
	 * 내가 친구 요청을 보낸 목록을 확인
	 */
	List<FriendVO> requestList(HttpSession session) throws Exception;
	
	/**
	 * 내가 친구 요청받은 목록을 확인
	 */
	List<FriendVO> responseList(HttpSession session) throws Exception;
	
	/**
	 * 내가 보낸 친구 요청을 취소한다.  
	 */
	String deleteRequest(HttpSession session, int fto) throws Exception;
	
	/**
	 * 친구요청 거절.  
	 */
	String reject(HttpSession session, int ffrom) throws Exception;
}
