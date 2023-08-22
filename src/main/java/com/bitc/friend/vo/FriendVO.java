package com.bitc.friend.vo;

import java.util.Date;

import lombok.Data;

@Data
public class FriendVO {
	private int ffrom;
	private int fto;
	private char YN;
	private Date requestTime;
	private String mid;
	private String mnick;
	private String profileImageName;
}
