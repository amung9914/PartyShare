package com.bitc.login.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	
	private String mId;					//아디
	private String mPw;					//비번
	private String mName;				//이름
	private String mNick;				//닉넴
	private int mAge;					//나이
	private String mGender;				//성별
	private String mEmail;				//이멜
	private String mAddr;				//주소
	private String mBlackYN;			//계정정지
	private boolean cookie;				//쿠키
	private String profileImageName;	//프로필이미지
	/*
	 * public MemberVO(String mId, String mPw) { this.mId = mId; this.mPw = mPw; }
	 */
	
}
