package com.bitc.friend.vo;

import java.util.Date;

import lombok.Data;

@Data
public class FriendVO {
	private int ffrom;  		// 친구 추가하는사람
	private int fto; 			// 친구 요청 받는사람
	private char YN;			// 수락여부
	private Date requestTime;   // 요청 
	private String mid;			// 아이디
	private String mnick;		//닉네임
	private String profileImageName;	//프로필이미지
}
