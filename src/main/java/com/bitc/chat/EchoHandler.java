package com.bitc.chat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.bitc.chat.service.ChatService;
import com.bitc.chat.vo.ChatVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

public class EchoHandler extends TextWebSocketHandler{
	
	// 소캣에 연결된 사용자 세션 목록 
	private static List<WebSocketSession> sessionList = new ArrayList<>();
	
	// Map<pnum, sessionList>
	// 파티 마다 다른 채팅방 생성
	private static Map<String, List<WebSocketSession>> sessionMap = new HashMap<>();
	
	ObjectMapper objectMapper = new ObjectMapper();
	
	@Autowired
	ChatService cs;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session){
		// 채팅방 입장 시 소캣에 연결된 직후 실행
		sessionList.add(session);
	}

	// 메시지를 전달하면 실행
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) {
		// 메시지를 적당히 잘 잘라서 저장
		String msg = message.getPayload().replace("\"", "");
		String[] strs = msg.split(",");
		String pnum = strs[0].substring(strs[0].indexOf(":")+1);
		String mnum = strs[1].substring(strs[1].indexOf(":")+1);
		String content = strs[2].substring(strs[2].indexOf(":")+1);
		String path = strs[3].substring(strs[3].indexOf(":")+1);
		String nick = strs[4].substring(strs[4].indexOf(":")+1, strs[4].length()-1);
		
		// db에 채팅 내역을 저장
		ChatVO chat = new ChatVO(Integer.parseInt(pnum), Integer.parseInt(mnum), nick, content);
		
		// 채팅방 입장을 알림
		if(content.equals("E!n@t#e$t$")) {
			if(sessionMap.get(pnum) == null) {
				// 현재 채팅방이 없다면 생성한 후
				List<WebSocketSession> list = new ArrayList<>();
				sessionMap.put(pnum, list);
			}
			// 채팅방 사용자 목록에 존재하지 않을 경우 추가 후 리턴 
			if(!sessionMap.get(pnum).contains(session)) {
				sessionMap.get(pnum).add(session);
			}
			return;
		}
		
		// db에 입력된 채팅 번호를 가져와 chat객체에 담은 후 
		// 채팅방에 연결된 모든 사용자에게 전달
		String lastChatNum = "";
		try {
			lastChatNum += cs.insertChat(chat);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("pnum", pnum);
		map.put("mnum", mnum);
		map.put("content", content);
		map.put("path", path);
		map.put("nick", nick);
		map.put("cnum", lastChatNum);
		
		String json = null;
		try {
			json = objectMapper.writeValueAsString(map);
		} catch (JsonProcessingException e1) {
			e1.printStackTrace();
		}
		
		// 채팅방에 연결된 사용자가 없다면 메시지를 보내지 않음 - 없는데 보내면 서버 터지는듯?
		if(sessionMap.get(pnum).size() == 0) {
			return;
		}
		
		for(WebSocketSession sess : sessionMap.get(pnum)) {
			try {
				sess.sendMessage(new TextMessage(json));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 채팅방에서 세션 연결이 끊어지면 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
		// 채팅방 목록에서 세션을 지우고
		for(List<WebSocketSession> list : sessionMap.values()) {
			if(list.contains(session)) {
				list.remove(session);
			}
		}
		// 세션리스트에서도 지움
		sessionList.remove(session);
	}
}
