package com.bitc.chat.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.chat.dao.ChatDAO;
import com.bitc.chat.vo.ChatVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService {

	private final ChatDAO dao;
	
	@Override
	public List<ChatVO> selectChatList(int pnum, int endNo) throws Exception{
		return dao.getChatList(pnum, endNo);
	}

	@Override
	public List<ChatVO> selectFirstChatList(int pnum) throws Exception{
		int totalCount = dao.getTotalCount(pnum);
		System.out.println(totalCount);
		if(totalCount > 20) {
			totalCount -= 20;
		}else {
			totalCount = 0;
		}
		List<ChatVO> list = dao.getFirstChatList(pnum, totalCount);
		return list;
	}

	@Transactional
	@Override
	public int insertChat(ChatVO chat) throws Exception{
		dao.insertChat(chat);
		return dao.getLastChatNum();
	}

	@Override
	public int getTotalCount(int pnum) throws Exception {
		return dao.getTotalCount(pnum);
	}

}
