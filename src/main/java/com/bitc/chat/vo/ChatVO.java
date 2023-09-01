package com.bitc.chat.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatVO {
	private int cnum;		// 채팅 번호
	private int pnum;		// 채팅이 작성된 파티 번호
	private int mnum;		// 채팅을 작성한 맴버 번호
	private String nick;	// 채팅을 작성한 맴버 닉네임
	private String content;	// 채팅 내용
	private String finish;	// 채팅이 작성된 파티 종료 유무
	
	public ChatVO(int pnum, int mnum, String nick, String content) {
		this.pnum = pnum;
		this.mnum = mnum;
		this.nick = nick;
		this.content = content;
	}
	
}
