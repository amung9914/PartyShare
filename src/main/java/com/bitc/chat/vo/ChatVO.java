package com.bitc.chat.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatVO {
	private int cnum;
	private int pnum;
	private int mnum;
	private String nick;
	private String content;
	private String finish;
	
	public ChatVO(int pnum, int mnum, String nick, String content) {
		this.pnum = pnum;
		this.mnum = mnum;
		this.nick = nick;
		this.content = content;
	}
	
}
