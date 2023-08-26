package com.bitc.chat.service;

import java.util.List;

import com.bitc.chat.vo.ChatVO;

public interface ChatService {
	
	/**
	 * 이전 채팅 목록 출력 
	 */
	List<ChatVO> selectChatList(int pnum, int endNo) throws Exception;

	/**
	 * 채팅 방 입장 시 채팅목록 출력
	 */
	List<ChatVO> selectFirstChatList(int pnum) throws Exception;

	/**
	 * 채팅 내용 저장
	 */
	int insertChat(ChatVO chat) throws Exception;
	
	/**
	 * 파티 마다 총 채팅 개수
	 */
	int getTotalCount(int pnum) throws Exception;
}
