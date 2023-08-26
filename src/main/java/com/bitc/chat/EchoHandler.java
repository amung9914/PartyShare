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

@Slf4j
public class EchoHandler extends TextWebSocketHandler{
	
	private static List<WebSocketSession> sessionList = new ArrayList<>();

	ObjectMapper objectMapper = new ObjectMapper();
	
	Map<String, List<WebSocketSession>> sessionMap = new HashMap<>();
	
	@Autowired
	ChatService cs;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session){
		log.info("연결됨");
		sessionList.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) {
		
		String msg = message.getPayload().replace("\"", "");
		String[] strs = msg.split(",");
		String pnum = strs[0].substring(strs[0].indexOf(":")+1);
		String mnum = strs[1].substring(strs[1].indexOf(":")+1);
		String content = strs[2].substring(strs[2].indexOf(":")+1);
		String path = strs[3].substring(strs[3].indexOf(":")+1);
		String nick = strs[4].substring(strs[4].indexOf(":")+1, strs[4].length()-1);
		
		ChatVO chat = new ChatVO(Integer.parseInt(pnum), Integer.parseInt(mnum), nick, content);
		
		if(content.equals("E!n@t#e$t$")) {
			if(sessionMap.get(pnum) == null) {
				List<WebSocketSession> list = new ArrayList<>();
				sessionMap.put(pnum, list);
			}
			if(!sessionMap.get(pnum).contains(session)) {
				sessionMap.get(pnum).add(session);
			}
			return;
		}
		
		String lastChatNum = "";
		try {
			lastChatNum += cs.insertChat(chat);
			System.out.println("cnum : " + lastChatNum);
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

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
		for(List<WebSocketSession> list : sessionMap.values()) {
			if(list.contains(session)) {
				list.remove(session);
			}
		}
		sessionList.remove(session);
	}
}
